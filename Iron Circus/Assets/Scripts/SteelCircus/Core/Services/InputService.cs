// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.InputService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using Rewired;
using Steamworks;
using SteelCircus.UI.OptionsUI;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class InputService
  {
    private Dictionary<short, List<IInputReceiver>> playerInputSources;
    private ControllerInputSourceType controllerInputSourceType;
    private RewiredInputReceiver mouseInputSource;
    private Imi.SteelCircus.Controls.InputMapCategory currentInputMap;
    private Imi.SteelCircus.Controls.InputSource lastInputSource = Imi.SteelCircus.Controls.InputSource.DefaultController;
    private bool debugConstrainDir;
    public Action<short, DigitalInput, bool> buttonEvent;
    public Action<Imi.SteelCircus.Controls.InputSource> lastInputSourceChangedEvent;
    private MonoBehaviour coroutineRunner;
    private AnalogInputSmoothing movementSmoothing;
    private AnalogInputSmoothing aimSmoothing;
    private AimInputProcessor aimInputProcessor;

    public void Initialize(short localPlayerIndex, MonoBehaviour coroutineRunner)
    {
      this.movementSmoothing = new AnalogInputSmoothing();
      this.aimSmoothing = new AnalogInputSmoothing();
      this.aimInputProcessor = new AimInputProcessor();
      this.coroutineRunner = coroutineRunner;
      this.playerInputSources = new Dictionary<short, List<IInputReceiver>>();
      this.playerInputSources[localPlayerIndex] = new List<IInputReceiver>();
      if (ReInput.isReady)
        this.RewiredIsReady();
      else
        ReInput.InitializedEvent += new Action(this.DeferredRewiredIsReady);
    }

    private void DeferredRewiredIsReady()
    {
      ReInput.InitializedEvent -= new Action(this.DeferredRewiredIsReady);
      this.RewiredIsReady();
    }

    private void RewiredIsReady()
    {
      Log.Debug("Rewired is ready");
      Log.Debug("Is steam running? " + SteamAPI.IsSteamRunning().ToString());
      this.coroutineRunner.StartCoroutine(this.WaitForSteamworks());
    }

    private IEnumerator WaitForSteamworks()
    {
      yield return (object) new WaitForSeconds(1f);
      int numberOfAttempts = 3;
      int attempts = 0;
      while (!SteamManager.Initialized && attempts < numberOfAttempts)
      {
        ++attempts;
        yield return (object) new WaitForSeconds(0.5f);
      }
      this.InitializeControllerInputSource((short) 0);
    }

    private int GetActiveSteamControllers()
    {
      ControllerHandle_t[] handlesOut = new ControllerHandle_t[16];
      SteamController.RunFrame();
      int connectedControllers = SteamController.GetConnectedControllers(handlesOut);
      Log.Debug("Connected controllers via steam input: " + (object) connectedControllers);
      return connectedControllers;
    }

    private void DeferredInitializeControllerInputSource()
    {
      ReInput.InitializedEvent -= new Action(this.DeferredInitializeControllerInputSource);
      this.InitializeControllerInputSource((short) 0);
    }

    private void InitializeControllerInputSource(short localPlayerIndex)
    {
      int num = 0;
      if (SteamManager.Initialized)
      {
        SteamController.Init();
        num = this.GetActiveSteamControllers();
      }
      if (num > 0)
      {
        this.SetControllerInputSource(localPlayerIndex, ControllerInputSourceType.ControllerSteamInput);
      }
      else
      {
        this.SetControllerInputSource(localPlayerIndex, ControllerInputSourceType.ControllerRewiredInput);
        if (SteamManager.Initialized)
          SteamController.Shutdown();
      }
      this.SetInputMapCategory(Imi.SteelCircus.Controls.InputMapCategory.UI);
    }

    public void SetControllerInputSource(
      short localPlayerIndex,
      ControllerInputSourceType controllerInputSource)
    {
      this.controllerInputSourceType = controllerInputSource;
      if (this.controllerInputSourceType == ControllerInputSourceType.ControllerRewiredInput)
      {
        RewiredInputReceiver rewiredInputReceiver = new RewiredInputReceiver(localPlayerIndex);
        this.playerInputSources[localPlayerIndex].Add((IInputReceiver) rewiredInputReceiver);
        rewiredInputReceiver.RegisterLastInputSourceChangedEventCallback(new Action<Imi.SteelCircus.Controls.InputSource>(this.LastInputSourceChanged));
        rewiredInputReceiver.ActivateReceiver(false);
        rewiredInputReceiver.RegisterButtonEventCallback(new Action<short, DigitalInput, bool, Imi.SteelCircus.Controls.InputSource>(this.ButtonEvent));
        rewiredInputReceiver.RegisterAnalogInputEventCallback(new Action<short, AnalogInput, Vector2, Imi.SteelCircus.Controls.InputSource>(this.AnalogInputEvent));
        this.mouseInputSource = rewiredInputReceiver;
      }
      else
      {
        if (this.controllerInputSourceType != ControllerInputSourceType.ControllerSteamInput)
          return;
        SteamInputReceiver steamInputReceiver = new SteamInputReceiver(localPlayerIndex);
        this.playerInputSources[localPlayerIndex].Add((IInputReceiver) steamInputReceiver);
        steamInputReceiver.RegisterLastInputSourceChangedEventCallback(new Action<Imi.SteelCircus.Controls.InputSource>(this.LastInputSourceChanged));
        steamInputReceiver.ActivateReceiver(false);
        steamInputReceiver.RegisterButtonEventCallback(new Action<short, DigitalInput, bool, Imi.SteelCircus.Controls.InputSource>(this.ButtonEvent));
        steamInputReceiver.RegisterAnalogInputEventCallback(new Action<short, AnalogInput, Vector2, Imi.SteelCircus.Controls.InputSource>(this.AnalogInputEvent));
        RewiredInputReceiver rewiredInputReceiver = new RewiredInputReceiver(localPlayerIndex);
        this.playerInputSources[localPlayerIndex].Add((IInputReceiver) rewiredInputReceiver);
        rewiredInputReceiver.ActivateReceiver(true);
        rewiredInputReceiver.RegisterButtonEventCallback(new Action<short, DigitalInput, bool, Imi.SteelCircus.Controls.InputSource>(this.ButtonEvent));
        rewiredInputReceiver.RegisterAnalogInputEventCallback(new Action<short, AnalogInput, Vector2, Imi.SteelCircus.Controls.InputSource>(this.AnalogInputEvent));
        this.mouseInputSource = rewiredInputReceiver;
      }
    }

    public void SetInputMapCategory(Imi.SteelCircus.Controls.InputMapCategory inputMap)
    {
      Log.Debug("Set input map category to " + (object) inputMap);
      if (this.currentInputMap != inputMap)
      {
        foreach (List<IInputReceiver> inputReceiverList in this.playerInputSources.Values)
        {
          foreach (IInputReceiver inputReceiver in inputReceiverList)
            inputReceiver.SetInputMap(inputMap, true);
        }
      }
      this.currentInputMap = inputMap;
    }

    public void PollInputData()
    {
      foreach (List<IInputReceiver> inputReceiverList in this.playerInputSources.Values)
      {
        foreach (IInputReceiver inputReceiver in inputReceiverList)
          inputReceiver.PollInputData();
      }
    }

    public bool GetButtonDown(DigitalInput button, short playerId = 0)
    {
      foreach (IInputReceiver inputReceiver in this.playerInputSources[playerId])
      {
        if (inputReceiver.ButtonDown(button) && Application.isFocused)
          return true;
      }
      return false;
    }

    public bool GetButtonUp(DigitalInput button, short playerId = 0)
    {
      foreach (IInputReceiver inputReceiver in this.playerInputSources[playerId])
      {
        if (inputReceiver.ButtonUp(button) && Application.isFocused)
          return true;
      }
      return false;
    }

    public bool GetButton(DigitalInput button, short playerId = 0)
    {
      foreach (IInputReceiver inputReceiver in this.playerInputSources[playerId])
      {
        if (inputReceiver.Button(button) && Application.isFocused)
          return true;
      }
      return false;
    }

    public bool GetAnyButtonDown()
    {
      foreach (DigitalInput allButton in InputStructures.GetAllButtons())
      {
        if (this.GetButtonDown(allButton) && Application.isFocused)
          return true;
      }
      return false;
    }

    public Vector2 GetAnalogInput(AnalogInput analogInputType, short playerId = 0)
    {
      Vector2 vector2 = (Vector2) Vector3.zero;
      foreach (IInputReceiver inputReceiver in this.playerInputSources[playerId])
      {
        Vector2 rawAnalogInput = inputReceiver.GetRawAnalogInput(analogInputType);
        if ((double) rawAnalogInput.sqrMagnitude > (double) vector2.sqrMagnitude && Application.isFocused)
          vector2 = rawAnalogInput;
      }
      return vector2;
    }

    public Vector3 GetMoveDirection(short playerId = 0)
    {
      Vector2 analogInput = this.GetAnalogInput(AnalogInput.Move);
      Vector3 result = new Vector3(analogInput.y, 0.0f, analogInput.x);
      this.ProcessAnalogInput(ref result);
      return this.movementSmoothing.SmoothAnalogInput(result);
    }

    public Vector3 GetAimDirection(short playerId = 0)
    {
      Vector2 analogInput = this.GetAnalogInput(AnalogInput.Aim);
      Vector3 result = new Vector3(analogInput.y, 0.0f, analogInput.x);
      this.ProcessAnalogInput(ref result);
      return this.aimInputProcessor.Process(this.aimSmoothing.SmoothAnalogInput(result));
    }

    private void ProcessAnalogInput(ref Vector3 result)
    {
      if ((double) result.sqrMagnitude <= 1.0)
        return;
      result.Normalize();
    }

    public Imi.SteelCircus.Controls.InputSource GetLastInputSource() => this.lastInputSource;

    public void KeepMousePosition() => this.mouseInputSource.KeepMousePosition();

    public Vector3 GetMouseMoveInput() => this.mouseInputSource.GetMouseMoveInputTopDownWorldSpace();

    public ButtonSpriteSet GetButtonSprites(short playerId = 0) => this.controllerInputSourceType == ControllerInputSourceType.ControllerSteamInput && (this.lastInputSource == Imi.SteelCircus.Controls.InputSource.NoController || this.lastInputSource == Imi.SteelCircus.Controls.InputSource.Keyboard || this.lastInputSource == Imi.SteelCircus.Controls.InputSource.Mouse) ? (this.mouseInputSource == null ? new ButtonSpriteSet() : this.mouseInputSource.GetSpritesForInputSource(Imi.SteelCircus.Controls.InputSource.Mouse)) : (!this.playerInputSources.ContainsKey(playerId) || this.playerInputSources[playerId].Count == 0 ? new ButtonSpriteSet() : this.playerInputSources[playerId][0].GetSpritesForInputSource(this.lastInputSource));

    public Sprite GetButtonSprite(DigitalInput button, short playerId = 0) => this.GetButtonSprites(playerId).GetButtonSprite(button);

    public void StartRumble(float strength, float duration = 0.0f, short localPlayerIndex = 0)
    {
      if (RumbleSettings.RumbleSetting != RumbleSettings.RumbleStates.RumbleOn)
        return;
      foreach (IInputReceiver inputReceiver in this.playerInputSources[localPlayerIndex])
      {
        if ((double) duration > 0.0 && this.IsUsingSteamInput())
        {
          this.coroutineRunner.StopCoroutine(this.WaitForRumbleStop((float) localPlayerIndex));
          this.coroutineRunner.StartCoroutine(this.WaitForRumbleStop(duration, localPlayerIndex));
        }
        double num1 = (double) strength;
        double num2 = (double) duration;
        inputReceiver.StartRumble((float) num1, (float) num2);
      }
    }

    public void StopRumble(short localPlayerIndex = 0)
    {
      foreach (IInputReceiver inputReceiver in this.playerInputSources[localPlayerIndex])
        inputReceiver.StopRumble();
    }

    private IEnumerator WaitForRumbleStop(float duration, short localPlayerIndex = 0)
    {
      yield return (object) new WaitForSeconds(duration);
      this.StopRumble(localPlayerIndex);
    }

    public void ShowSteamBindingPanel()
    {
      foreach (IInputReceiver inputReceiver in this.playerInputSources[(short) 0])
      {
        if (inputReceiver is SteamInputReceiver)
          ((SteamInputReceiver) inputReceiver).ShowBindingPanel();
      }
    }

    public bool IsUsingSteamInput() => this.controllerInputSourceType == ControllerInputSourceType.ControllerSteamInput;

    public void Cleanup()
    {
      foreach (List<IInputReceiver> inputReceiverList in this.playerInputSources.Values)
      {
        foreach (IInputReceiver inputReceiver in inputReceiverList)
          inputReceiver.DeactivateReceiver();
      }
      this.playerInputSources = new Dictionary<short, List<IInputReceiver>>();
    }

    public void ApplyKeyboardLayout(int layoutIndex) => this.mouseInputSource.ApplyKeyboardLayout(layoutIndex);

    public void ForceButtonSpriteReload()
    {
      foreach (List<IInputReceiver> inputReceiverList in this.playerInputSources.Values)
      {
        foreach (IInputReceiver inputReceiver in inputReceiverList)
          inputReceiver.ForceButtonSpriteReload();
      }
      this.LastInputSourceChanged(this.lastInputSource);
    }

    public Vector2 GetMousePosition() => this.mouseInputSource.GetMousePosition();

    private void ButtonEvent(
      short playerId,
      DigitalInput button,
      bool buttonDown,
      Imi.SteelCircus.Controls.InputSource inputSource)
    {
      if (button != DigitalInput.None)
      {
        Action<short, DigitalInput, bool> buttonEvent = this.buttonEvent;
        if (buttonEvent != null)
          buttonEvent(playerId, button, buttonDown);
      }
      if (this.lastInputSource == inputSource)
        return;
      Log.Debug("Changed last input source to " + (object) inputSource + " by event " + (object) button);
      this.lastInputSource = inputSource;
      Action<Imi.SteelCircus.Controls.InputSource> sourceChangedEvent = this.lastInputSourceChangedEvent;
      if (sourceChangedEvent == null)
        return;
      sourceChangedEvent(inputSource);
    }

    private void AnalogInputEvent(
      short playerId,
      AnalogInput analogInput,
      Vector2 value,
      Imi.SteelCircus.Controls.InputSource inputSource)
    {
      if (this.lastInputSource == inputSource || (double) value.sqrMagnitude <= 0.25)
        return;
      this.lastInputSource = inputSource;
      Log.Debug("Changed last input source to " + (object) inputSource + " by event " + (object) analogInput);
      Action<Imi.SteelCircus.Controls.InputSource> sourceChangedEvent = this.lastInputSourceChangedEvent;
      if (sourceChangedEvent == null)
        return;
      sourceChangedEvent(inputSource);
    }

    private void LastInputSourceChanged(Imi.SteelCircus.Controls.InputSource inputSource)
    {
      Log.Debug("last input source changed to " + (object) inputSource);
      this.lastInputSource = inputSource;
      Action<Imi.SteelCircus.Controls.InputSource> sourceChangedEvent = this.lastInputSourceChangedEvent;
      if (sourceChangedEvent == null)
        return;
      sourceChangedEvent(inputSource);
    }
  }
}
