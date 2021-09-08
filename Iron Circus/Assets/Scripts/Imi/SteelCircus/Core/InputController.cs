// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Core.InputController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.CameraSystem;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using SteelCircus.Core.Services;
using SteelCircus.GameElements;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Core
{
  public class InputController : IInputController
  {
    private const float MovementDeadZone = 0.25f;
    private const int DefaultDelay = 3;
    private int delayInTicks = 3;
    private readonly GameContext gameContext;
    private Dictionary<ulong, GameEntity> players = new Dictionary<ulong, GameEntity>();
    private Dictionary<ulong, Imi.SharedWithServer.ScEntitas.Components.Input> inputCache = new Dictionary<ulong, Imi.SharedWithServer.ScEntitas.Components.Input>();
    private static SpraytagController spraytagController;
    private static QuickChatMessageController quickChatMessageController;
    private bool mouseActive;
    private JVector prevMovement = JVector.Zero;
    private InputService inputService;
    private SelectionWheels wheels;
    private EmoteHelper emoteHelper;

    public InputController(GameContext gameContext)
    {
      this.gameContext = gameContext;
      InputController.spraytagController = new SpraytagController(gameContext);
      InputController.quickChatMessageController = new QuickChatMessageController(gameContext);
      this.inputService = ImiServices.Instance.InputService;
    }

    private void LastInputSourceChanged(InputSource inputSource) => this.mouseActive = inputSource == InputSource.Keyboard || inputSource == InputSource.Mouse;

    public void RegisterIngamePlayerInput(ulong playerId)
    {
      this.inputService.SetInputMapCategory(InputMapCategory.Champions);
      if (this.players.ContainsKey(playerId))
        return;
      this.players[playerId] = this.gameContext.GetFirstEntityWithPlayerId(playerId);
      this.inputCache[playerId] = Imi.SharedWithServer.ScEntitas.Components.Input.Zero;
      this.inputService.buttonEvent += new Action<short, DigitalInput, bool>(this.OnButtonEvent);
      this.inputService.lastInputSourceChangedEvent += new Action<InputSource>(this.LastInputSourceChanged);
      this.LastInputSourceChanged(this.inputService.GetLastInputSource());
      this.wheels = UnityEngine.Object.FindObjectOfType<SelectionWheels>();
      this.wheels.Initialize(this.gameContext, this, playerId);
      this.emoteHelper = UnityEngine.Object.FindObjectOfType<EmoteHelper>();
      this.emoteHelper.InitializeEmoteHelper(this);
    }

    public void UnregisterIngamePlayerInput(ulong playerId)
    {
      this.inputService.SetInputMapCategory(InputMapCategory.UI);
      if (!this.players.ContainsKey(playerId))
        return;
      this.players.Remove(playerId);
      this.inputCache.Remove(playerId);
      this.inputService.buttonEvent -= new Action<short, DigitalInput, bool>(this.OnButtonEvent);
      this.inputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.LastInputSourceChanged);
      this.wheels.Cleanup();
    }

    public void SetInputDelay(int delay) => this.delayInTicks = delay;

    public bool HasInputFor(ulong playerId) => this.inputCache.ContainsKey(playerId);

    public Imi.SharedWithServer.ScEntitas.Components.Input GetInputFor(
      ulong playerId,
      int tick)
    {
      return this.inputCache[playerId];
    }

    public void Tick()
    {
      foreach (ulong key in this.players.Keys)
        this.TickInputFor(key);
    }

    private void TickInputFor(ulong playerId)
    {
      Imi.SharedWithServer.ScEntitas.Components.Input input = this.inputCache[playerId];
      this.inputService.KeepMousePosition();
      JVector movement;
      JVector aim;
      this.GetAnalogInput(out movement, out aim);
      if (this.inputService.GetButton(DigitalInput.Tackle) || this.inputService.GetButtonUp(DigitalInput.Tackle) || this.inputService.GetButtonDown(DigitalInput.Tackle))
        aim = movement;
      if (this.inputService.GetButton(DigitalInput.MoveToBall) && (this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.StartPoint || this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.GetReady || this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress))
      {
        GameEntity firstLocalEntity = this.gameContext.GetFirstLocalEntity();
        GameEntity ballEntity = this.gameContext.ballEntity;
        if (ballEntity != null && firstLocalEntity != null && firstLocalEntity.isPlayer)
          movement = !ballEntity.hasBallOwner || (long) ballEntity.ballOwner.playerId != (long) firstLocalEntity.playerId.value ? (ballEntity.transform.Position2D - firstLocalEntity.transform.Position2D).Normalized() : this.prevMovement;
      }
      this.prevMovement = movement;
      input.moveDir = movement;
      input.aimDir = aim;
      if (this.mouseActive)
        input.aimDir = this.inputService.GetMouseMoveInput().ToJVector();
      if (this.wheels.IsAnyWheelOpen())
      {
        input.moveDir = JVector.Zero;
        input.aimDir = JVector.Zero;
      }
      this.inputCache[playerId] = input;
      this.HandleSpraytagInput(playerId);
      this.HandleQuickChatInput(playerId);
      this.HandleEmoteInput(playerId);
    }

    private void HandleEmoteInput(ulong player)
    {
      if (this.inputService.GetButtonDown(DigitalInput.EmoteModifier))
      {
        this.TriggerButton(DigitalInput.Emote0, false);
        this.TriggerButton(DigitalInput.Emote1, false);
        this.TriggerButton(DigitalInput.Emote2, false);
        this.TriggerButton(DigitalInput.Emote3, false);
        this.wheels.ShowEmoteSelectionWheel();
      }
      if (!this.inputService.GetButtonUp(DigitalInput.EmoteModifier))
        return;
      this.wheels.CloseEmoteSelectionWheel();
    }

    private void HandleSpraytagInput(ulong player)
    {
      if (this.inputService.GetButtonDown(DigitalInput.SpraytagModifier))
        this.wheels.ShowSpraytagSelectionWheel();
      if (!this.inputService.GetButtonUp(DigitalInput.SpraytagModifier))
        return;
      this.wheels.CloseSpraytagSelectionWheel();
    }

    private void HandleQuickChatInput(ulong player)
    {
      if (this.inputService.GetButtonDown(DigitalInput.QuickMessageModifier))
        this.wheels.ShowQuickMessageSelectionWheel();
      if (!this.inputService.GetButtonUp(DigitalInput.QuickMessageModifier))
        return;
      this.wheels.CloseQuickMessageSelectionWheel();
    }

    private Imi.SharedWithServer.ScEntitas.Components.Input HandleButton(
      Imi.SharedWithServer.ScEntitas.Components.Input input,
      DigitalInput button)
    {
      if (this.inputService.GetButtonDown(button))
        input.downButtons = input.GetStatePlusButton(InputStructures.GetNetworkedButtonType(button));
      else if (this.inputService.GetButtonUp(button))
        input.downButtons = input.GetStateMinusButton(InputStructures.GetNetworkedButtonType(button));
      return input;
    }

    private void OnButtonEvent(short localPlayerIndex, DigitalInput button, bool btnDown)
    {
      if (!InputStructures.IsButtonNetworked(button) || button == DigitalInput.EmoteModifier || button == DigitalInput.QuickMessageModifier || button == DigitalInput.SpraytagModifier || this.wheels.IsAnyWheelOpen())
        return;
      ulong playerId = ImiServices.Instance.LoginService.GetPlayerId();
      Imi.SharedWithServer.ScEntitas.Components.Input input = this.inputCache[playerId];
      Imi.SharedWithServer.ScEntitas.Components.ButtonType networkedButtonType = InputStructures.GetNetworkedButtonType(button);
      input.downButtons = !btnDown ? input.GetStateMinusButton(networkedButtonType) : input.GetStatePlusButton(networkedButtonType);
      this.inputCache[playerId] = input;
    }

    public void TriggerButton(DigitalInput button, bool down)
    {
      Debug.Log((object) ("trigger button " + (down ? (object) nameof (down) : (object) "up") + ": " + (object) button));
      ulong playerId = ImiServices.Instance.LoginService.GetPlayerId();
      Imi.SharedWithServer.ScEntitas.Components.Input input = this.inputCache[playerId];
      Imi.SharedWithServer.ScEntitas.Components.ButtonType networkedButtonType = InputStructures.GetNetworkedButtonType(button);
      if (networkedButtonType != Imi.SharedWithServer.ScEntitas.Components.ButtonType.None)
        input.downButtons = down ? input.GetStatePlusButton(networkedButtonType) : input.GetStateMinusButton(networkedButtonType);
      this.inputCache[playerId] = input;
    }

    private void GetAnalogInput(out JVector movement, out JVector aim)
    {
      Vector3 moveDirection = this.inputService.GetMoveDirection();
      Vector3 vector3 = this.inputService.GetAimDirection();
      Camera activeCameraComponent = ImiServices.Instance.CameraManager.GetActiveCameraComponent();
      Vector3 vector = (double) moveDirection.magnitude > 0.25 ? this.ScreenSpaceDirToWorldSpace(moveDirection, this.gameContext.cameraTarget.position.ToVector3(), activeCameraComponent) : Vector3.zero;
      vector3 = (double) vector3.magnitude > 0.25 ? this.ScreenSpaceDirToWorldSpace(vector3, this.gameContext.cameraTarget.position.ToVector3(), activeCameraComponent) : Vector3.zero;
      movement = vector.ToJVector();
      aim = vector3.ToJVector();
    }

    public static bool MatchStateAllowsMovement()
    {
      if (!Contexts.sharedInstance.game.hasMatchState)
        return false;
      return Contexts.sharedInstance.game.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress || Contexts.sharedInstance.game.matchState.value == Imi.SharedWithServer.Game.MatchState.GetReady || Contexts.sharedInstance.game.matchState.value == Imi.SharedWithServer.Game.MatchState.StartPoint || Contexts.sharedInstance.game.matchState.value == Imi.SharedWithServer.Game.MatchState.Goal;
    }

    private Vector3 ScreenSpaceDirToWorldSpace(
      Vector3 topDownInput,
      Vector3 worldPositionOnPlayField,
      Camera cam)
    {
      CameraManager cameraManager = ImiServices.Instance.CameraManager;
      if ((UnityEngine.Object) cam == (UnityEngine.Object) null)
        return Vector3.zero;
      Vector3 vector3_1 = new Vector3(topDownInput.z, -topDownInput.x, 0.0f);
      Vector3 screenPoint = cam.WorldToScreenPoint(worldPositionOnPlayField);
      screenPoint.z = 0.0f;
      if (((double) screenPoint.x <= 0.0 || (double) screenPoint.y <= 0.0 || (double) screenPoint.x >= (double) Screen.width ? 0 : ((double) screenPoint.y < (double) Screen.height ? 1 : 0)) == 0 || cameraManager.GetActiveCameraType() != Imi.SteelCircus.CameraSystem.CameraType.InGameCamera)
      {
        Vector3 vector3_2 = new Vector3(vector3_1.x, 0.0f, vector3_1.y);
        Vector3 vector3_3 = Quaternion.AngleAxis(cam.transform.eulerAngles.y, Vector3.up) * vector3_2;
        vector3_3.y = 0.0f;
        vector3_3 = vector3_3.normalized * vector3_1.magnitude;
        return vector3_3;
      }
      float distance;
      new Bounds(new Vector3((float) Screen.width * 0.5f, (float) Screen.height * 0.5f, 0.0f), new Vector3((float) Screen.width, (float) Screen.height, 0.01f)).IntersectRay(new Ray(screenPoint, -vector3_1.normalized), out distance);
      float num = distance * -0.95f;
      Vector3 pos = screenPoint + vector3_1 * num;
      Ray ray = cam.ScreenPointToRay(pos);
      float enter = 0.0f;
      new Plane(Vector3.up, Vector3.zero + Vector3.up * worldPositionOnPlayField.y).Raycast(ray, out enter);
      Vector3 vector3_4 = ray.GetPoint(enter) - worldPositionOnPlayField;
      vector3_4.y = 0.0f;
      vector3_4 = vector3_4.normalized * vector3_1.magnitude;
      return vector3_4;
    }

    public int GetInputDelay() => this.delayInTicks;

    public class InputCollectedEvent
    {
      public Imi.SharedWithServer.ScEntitas.Components.Input input;
    }
  }
}
