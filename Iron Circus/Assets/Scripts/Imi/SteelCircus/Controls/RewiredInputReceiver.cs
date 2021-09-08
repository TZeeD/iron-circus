// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Controls.RewiredInputReceiver
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.JitterUnity;
using Rewired;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Controls
{
  public class RewiredInputReceiver : IInputReceiver
  {
    private Player inputMap;
    private short localPlayerIndex;
    private short controllerIndex;
    private bool keyboardMouseOnly;
    private Action<short, DigitalInput, bool, InputSource> buttonEventCallback;
    private Action<short, AnalogInput, Vector2, InputSource> analogInputEventCallback;
    private Action<InputSource> lastInputSourceChangedEventCallback;
    private Vector2 mousePosition;
    private static Dictionary<InputSource, ButtonSpriteSet> buttonSprites;

    public RewiredInputReceiver(short localPlayerIndex) => this.localPlayerIndex = localPlayerIndex;

    public void ActivateReceiver(bool keyboardMouseOnly)
    {
      this.keyboardMouseOnly = keyboardMouseOnly;
      this.inputMap = ReInput.players.GetPlayer((int) this.localPlayerIndex);
      Log.Debug("Input: Activate Rewired Receiver");
      Log.Debug("Number of joysticks found: " + (object) this.inputMap.controllers.joystickCount);
      if (keyboardMouseOnly)
      {
        Log.Debug("Remove Rewired Controller Input (use rewired mouse/keyboard only)");
        this.inputMap.controllers.ClearControllersOfType(ControllerType.Joystick);
      }
      else
      {
        bool flag = false;
        foreach (Controller controller in this.inputMap.controllers.Controllers)
        {
          Log.Debug("controller: " + controller.name);
          InputSource rewiredController = this.GetInputSourceByRewiredController(controller);
          switch (rewiredController)
          {
            case InputSource.Keyboard:
            case InputSource.Mouse:
              continue;
            default:
              Log.Debug("Initially connected controller: " + (object) rewiredController);
              this.InputSourceChanged(controller);
              flag = true;
              goto label_10;
          }
        }
label_10:
        if (!flag)
          this.InputSourceChanged((Controller) this.inputMap.controllers.Keyboard);
      }
      this.inputMap.controllers.ControllerRemovedEvent += new Action<ControllerAssignmentChangedEventArgs>(this.ControllerRemoved);
      this.inputMap.controllers.ControllerAddedEvent += new Action<ControllerAssignmentChangedEventArgs>(this.ControllerAdded);
    }

    public void DeactivateReceiver()
    {
      if (!this.keyboardMouseOnly)
      {
        this.inputMap.controllers.ControllerRemovedEvent -= new Action<ControllerAssignmentChangedEventArgs>(this.ControllerRemoved);
        this.inputMap.controllers.ControllerAddedEvent -= new Action<ControllerAssignmentChangedEventArgs>(this.ControllerAdded);
      }
      this.UnregisterAnalogInputEventCallback();
      this.UnregisterButtonEventCallback();
      this.UnregisterLastInputSourceChangedEventCallback();
    }

    public void PollInputData()
    {
    }

    public bool ButtonDown(DigitalInput button)
    {
      switch (button)
      {
        case DigitalInput.UIUp:
          return this.inputMap.GetButtonDown(InputStructures.GetButtonName(DigitalInput.UIVertical));
        case DigitalInput.UIDown:
          return this.inputMap.GetNegativeButtonDown(InputStructures.GetButtonName(DigitalInput.UIVertical));
        case DigitalInput.UILeft:
          return this.inputMap.GetNegativeButtonDown(InputStructures.GetButtonName(DigitalInput.UIHorizontal));
        case DigitalInput.UIRight:
          return this.inputMap.GetButtonDown(InputStructures.GetButtonName(DigitalInput.UIHorizontal));
        default:
          return this.inputMap.GetButtonDown(InputStructures.GetButtonName(button));
      }
    }

    public bool Button(DigitalInput button) => this.inputMap.GetButton(InputStructures.GetButtonName(button));

    public bool ButtonUp(DigitalInput button) => this.inputMap.GetButtonUp(InputStructures.GetButtonName(button));

    public void SetInputMap(InputMapCategory inputMapCategory, bool enabled)
    {
      this.inputMap.controllers.maps.SetAllMapsEnabled(false);
      this.inputMap.controllers.maps.SetMapsEnabled(enabled, "VoiceControls");
      switch (inputMapCategory)
      {
        case InputMapCategory.Champions:
          this.inputMap.controllers.maps.SetMapsEnabled(enabled, "Champions");
          break;
        case InputMapCategory.UI:
          this.inputMap.controllers.maps.SetMapsEnabled(enabled, "UI");
          break;
        case InputMapCategory.Default:
          this.inputMap.controllers.maps.SetMapsEnabled(enabled, "Default");
          break;
        case InputMapCategory.FreeroamCamera:
          this.inputMap.controllers.maps.SetMapsEnabled(enabled, "FreeroamCamera");
          break;
      }
    }

    public Vector2 GetRawAnalogInput(AnalogInput analogInput)
    {
      switch (analogInput)
      {
        case AnalogInput.Move:
          return new Vector2(this.inputMap.GetAxis("Horizontal"), this.inputMap.GetAxis("Vertical"));
        case AnalogInput.Aim:
          return new Vector2(this.inputMap.GetAxis("HorizontalAim"), this.inputMap.GetAxis("VerticalAim"));
        case AnalogInput.UIScroll:
          return new Vector2(this.inputMap.GetAxis("UIHorizontal"), this.inputMap.GetAxis("UIVertical"));
        case AnalogInput.UISecondaryScroll:
          return new Vector2(this.inputMap.GetAxis("UIHorizontal_R"), this.inputMap.GetAxis("UIVertical_R"));
        case AnalogInput.FreeroamLeftStick:
          return new Vector2(this.inputMap.GetAxis("LeftHorizontal"), this.inputMap.GetAxis("LeftVertical"));
        case AnalogInput.FreeroamRightStick:
          return new Vector2(this.inputMap.GetAxis("RightHorizontal"), this.inputMap.GetAxis("RightVertical"));
        default:
          return Vector2.zero;
      }
    }

    public Vector2 GetMousePosition() => this.inputMap.controllers.Mouse.screenPosition;

    public void KeepMousePosition()
    {
      if (!this.ButtonDown(DigitalInput.MouseMove))
        return;
      this.mousePosition = this.inputMap.controllers.Mouse.screenPosition;
    }

    private Vector3 GetMouseMoveInputTopDownScreenSpace() => Vector3.ClampMagnitude(new Vector3((float) -((double) this.inputMap.controllers.Mouse.screenPosition.y - (double) this.mousePosition.y), 0.0f, this.inputMap.controllers.Mouse.screenPosition.x - this.mousePosition.x), 1f);

    public Vector3 GetMouseMoveInputTopDownWorldSpace()
    {
      Vector3 vector3 = Contexts.sharedInstance.game.cameraTarget.position.ToVector3();
      if ((UnityEngine.Object) Camera.main == (UnityEngine.Object) null)
        return this.GetMouseMoveInputTopDownScreenSpace();
      Ray ray = Camera.main.ScreenPointToRay((Vector3) this.inputMap.controllers.Mouse.screenPosition);
      Vector3 normalized = (RewiredInputReceiver.IntersectPlane(new Vector3(), Vector3.up, ray.origin, ray.direction) - vector3).normalized;
      return new Vector3(normalized.x, 0.0f, normalized.z);
    }

    public static Vector3 IntersectPlane(
      Vector3 planeP,
      Vector3 planeN,
      Vector3 rayP,
      Vector3 rayD)
    {
      float num = (float) (-((double) Vector3.Dot(planeP, -planeN) + (double) rayP.z * (double) planeN.z + (double) rayP.y * (double) planeN.y + (double) rayP.x * (double) planeN.x) / ((double) rayD.z * (double) planeN.z + (double) rayD.y * (double) planeN.y + (double) rayD.x * (double) planeN.x));
      return rayP + num * rayD;
    }

    public void RegisterButtonEventCallback(
      Action<short, DigitalInput, bool, InputSource> callback)
    {
      if (this.buttonEventCallback != null)
      {
        Log.Warning("A button callback was already registered for this InputReceiver! Unregister first.");
      }
      else
      {
        this.buttonEventCallback = callback;
        this.inputMap.AddInputEventDelegate(new Action<InputActionEventData>(this.ButtonDownCallbackWrapper), UpdateLoopType.Update, InputActionEventType.ButtonJustPressed);
        this.inputMap.AddInputEventDelegate(new Action<InputActionEventData>(this.ButtonUpCallbackWrapper), UpdateLoopType.Update, InputActionEventType.ButtonJustReleased);
        this.inputMap.AddInputEventDelegate(new Action<InputActionEventData>(this.AxisActiveCallbackWrapper), UpdateLoopType.Update, InputActionEventType.AxisActive);
        this.inputMap.AddInputEventDelegate(new Action<InputActionEventData>(this.ButtonDownCallbackWrapper), UpdateLoopType.Update, InputActionEventType.NegativeButtonJustPressed);
        this.inputMap.AddInputEventDelegate(new Action<InputActionEventData>(this.ButtonUpCallbackWrapper), UpdateLoopType.Update, InputActionEventType.NegativeButtonJustReleased);
      }
    }

    public void UnregisterButtonEventCallback()
    {
      this.buttonEventCallback = (Action<short, DigitalInput, bool, InputSource>) null;
      this.inputMap.RemoveInputEventDelegate(new Action<InputActionEventData>(this.ButtonDownCallbackWrapper));
      this.inputMap.RemoveInputEventDelegate(new Action<InputActionEventData>(this.ButtonUpCallbackWrapper));
      this.inputMap.RemoveInputEventDelegate(new Action<InputActionEventData>(this.AxisActiveCallbackWrapper));
      this.inputMap.RemoveInputEventDelegate(new Action<InputActionEventData>(this.ButtonDownCallbackWrapper), UpdateLoopType.Update, InputActionEventType.NegativeButtonJustPressed);
      this.inputMap.RemoveInputEventDelegate(new Action<InputActionEventData>(this.ButtonUpCallbackWrapper), UpdateLoopType.Update, InputActionEventType.NegativeButtonJustReleased);
    }

    public void RegisterAnalogInputEventCallback(
      Action<short, AnalogInput, Vector2, InputSource> callback)
    {
      if (this.analogInputEventCallback != null)
        Log.Warning("A analog input callback was already registered for this InputReceiver! Unregister first.");
      else
        this.analogInputEventCallback = callback;
    }

    public void UnregisterAnalogInputEventCallback() => this.analogInputEventCallback = (Action<short, AnalogInput, Vector2, InputSource>) null;

    public void RegisterLastInputSourceChangedEventCallback(Action<InputSource> callback)
    {
      if (this.lastInputSourceChangedEventCallback != null)
        Log.Warning("A callback was already registered for this InputReceiver! Unregister first.");
      else
        this.lastInputSourceChangedEventCallback = callback;
    }

    public void UnregisterLastInputSourceChangedEventCallback() => this.lastInputSourceChangedEventCallback = (Action<InputSource>) null;

    private int GetControllerElementId(Controller controller, DigitalInput input)
    {
      ActionElementMap actionElementMap = controller == null ? this.inputMap.controllers.maps.GetFirstElementMapWithAction(ControllerType.Keyboard, this.inputMap.controllers.Keyboard.id, InputStructures.GetButtonName(input), false) : this.inputMap.controllers.maps.GetFirstElementMapWithAction(controller.type, controller.id, InputStructures.GetButtonName(input), false);
      return actionElementMap == null ? -1 : actionElementMap.elementIdentifierId;
    }

    private ButtonSprite LoadRewiredActionSprite(
      InputSource inputSource,
      Controller controller,
      DigitalInput input)
    {
      string str;
      if (controller != null && controller.type == ControllerType.Joystick)
      {
        str = InputStructures.GetRewiredGlyphPath(inputSource, this.GetControllerElementId(controller, input));
      }
      else
      {
        int controllerElementId = this.GetControllerElementId((Controller) this.inputMap.controllers.Mouse, input);
        str = controllerElementId == -1 ? InputStructures.GetRewiredGlyphPath(inputSource, this.GetControllerElementId((Controller) this.inputMap.controllers.Keyboard, input)) : InputStructures.GetRewiredGlyphPath(inputSource, controllerElementId);
      }
      return new ButtonSprite(input, Resources.Load<Sprite>(str), str);
    }

    private void LoadSprites(Controller controller, InputSource inputSource)
    {
      if (RewiredInputReceiver.buttonSprites == null)
        RewiredInputReceiver.buttonSprites = new Dictionary<InputSource, ButtonSpriteSet>();
      ButtonSpriteSet buttonSpriteSet = new ButtonSpriteSet();
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UISubmit));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UIShortcut));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UIMatchMakingLeave));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UICancel));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UINext));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UIPrevious));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.PrimarySkill));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.SecondarySkill));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.Tackle));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.Sprint));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.ThrowBall));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.VoicePushToTalk));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.VoiceMute));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UIVoicePushToTalk));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UIVoiceMute));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UILeftTrigger));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.UIRightTrigger));
      buttonSpriteSet.SetButtonSprite(this.LoadRewiredActionSprite(inputSource, controller, DigitalInput.Surrender));
      RewiredInputReceiver.buttonSprites.Add(inputSource, buttonSpriteSet);
    }

    public void ForceButtonSpriteReload() => RewiredInputReceiver.buttonSprites.Clear();

    public ButtonSpriteSet GetSpritesForInputSource(InputSource source)
    {
      if (RewiredInputReceiver.buttonSprites == null)
        RewiredInputReceiver.buttonSprites = new Dictionary<InputSource, ButtonSpriteSet>();
      if (!RewiredInputReceiver.buttonSprites.ContainsKey(source))
        this.LoadSprites(this.inputMap.controllers.GetLastActiveController(), source);
      return RewiredInputReceiver.buttonSprites[source];
    }

    private InputSource GetInputSourceByRewiredController(Controller controller)
    {
      if (controller == null)
        return InputSource.NoController;
      switch (controller.name)
      {
        case "Keyboard":
          return InputSource.Keyboard;
        case "Mouse":
          return InputSource.Mouse;
        case "Pro Controller":
          return InputSource.SwitchPro;
        case "Razer Raiju":
          return InputSource.Raiju;
        case "Sony DualShock 2":
        case "Sony DualShock 3":
        case "Sony DualShock 4":
          return InputSource.DualShock;
        case "Steam Controller":
          return InputSource.SteamController;
        case "XInput Gamepad 1":
        case "XInput Gamepad 2":
        case "XInput Gamepad 3":
        case "XInput Gamepad 4":
        case "Xbox 360 Controller":
        case "Xbox One Controller":
          return InputSource.XBox;
        default:
          return InputSource.DefaultController;
      }
    }

    public void StartRumble(float strength, float duration = 0.0f)
    {
      foreach (Joystick joystick in (IEnumerable<Joystick>) this.inputMap.controllers.Joysticks)
      {
        if (joystick.supportsVibration)
        {
          if (joystick.vibrationMotorCount > 0)
            joystick.SetVibration(0, strength, duration);
          if (joystick.vibrationMotorCount > 1)
            joystick.SetVibration(1, strength, duration);
        }
      }
    }

    public void StopRumble()
    {
      foreach (Joystick joystick in (IEnumerable<Joystick>) this.inputMap.controllers.Joysticks)
      {
        if (joystick.supportsVibration)
          joystick.StopVibration();
      }
    }

    public void ApplyKeyboardLayout(int layoutIndex)
    {
      this.inputMap.controllers.maps.layoutManager.ruleSets[0].enabled = layoutIndex == 0;
      this.inputMap.controllers.maps.layoutManager.ruleSets[1].enabled = layoutIndex == 1;
      this.inputMap.controllers.maps.layoutManager.Apply();
    }

    private void ControllerAdded(ControllerAssignmentChangedEventArgs args)
    {
      if (this.keyboardMouseOnly)
      {
        this.inputMap.controllers.ClearControllersOfType(ControllerType.Joystick);
      }
      else
      {
        Log.Debug("Added controller " + args.controller.name);
        if (this.inputMap.controllers.joystickCount <= 0)
          return;
        this.InputSourceChanged(args.controller);
      }
    }

    private void ControllerRemoved(ControllerAssignmentChangedEventArgs args)
    {
      if (this.keyboardMouseOnly)
        return;
      Log.Debug("Removed a controller");
      if (this.inputMap.controllers.joystickCount != 0)
        return;
      Log.Debug("no more connected controllers");
      this.InputSourceChanged((Controller) this.inputMap.controllers.Keyboard);
    }

    private void InputSourceChanged(Controller controller)
    {
      InputSource rewiredController = this.GetInputSourceByRewiredController(controller);
      Log.Debug("New input source: " + (object) rewiredController);
      if (RewiredInputReceiver.buttonSprites == null || !RewiredInputReceiver.buttonSprites.ContainsKey(rewiredController))
        this.LoadSprites(controller, rewiredController);
      Action<InputSource> changedEventCallback = this.lastInputSourceChangedEventCallback;
      if (changedEventCallback == null)
        return;
      changedEventCallback(rewiredController);
    }

    private void ButtonUpCallbackWrapper(InputActionEventData inputData)
    {
      DigitalInput buttonByName = InputStructures.GetButtonByName(inputData.actionName, true);
      InputSource inputSource = this.GetInputSourceByRewiredController(inputData.GetCurrentInputSources()[0].controller);
      if (inputData.IsCurrentInputSource(ControllerType.Keyboard))
        inputSource = InputSource.Keyboard;
      else if (inputData.IsCurrentInputSource(ControllerType.Mouse))
        inputSource = InputSource.Mouse;
      this.buttonEventCallback(this.localPlayerIndex, buttonByName, false, inputSource);
    }

    private void ButtonDownCallbackWrapper(InputActionEventData inputData)
    {
      DigitalInput buttonByName = InputStructures.GetButtonByName(inputData.actionName, true);
      InputSource inputSource = this.GetInputSourceByRewiredController(inputData.GetCurrentInputSources()[0].controller);
      if (inputData.IsCurrentInputSource(ControllerType.Keyboard))
        inputSource = InputSource.Keyboard;
      else if (inputData.IsCurrentInputSource(ControllerType.Mouse))
        inputSource = InputSource.Mouse;
      this.buttonEventCallback(this.localPlayerIndex, buttonByName, true, inputSource);
    }

    private void AxisActiveCallbackWrapper(InputActionEventData axisData)
    {
      AnalogInput analogInputByName = InputStructures.GetAnalogInputByName(axisData.actionName, true);
      InputSource inputSource = this.GetInputSourceByRewiredController(axisData.GetCurrentInputSources()[0].controller);
      if (axisData.IsCurrentInputSource(ControllerType.Keyboard))
        inputSource = InputSource.Keyboard;
      else if (axisData.IsCurrentInputSource(ControllerType.Mouse))
        inputSource = InputSource.Mouse;
      this.analogInputEventCallback(this.localPlayerIndex, analogInputByName, Vector2.zero, inputSource);
    }
  }
}
