// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Controls.SteamInputReceiver
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Steamworks;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;

namespace Imi.SteelCircus.Controls
{
  public class SteamInputReceiver : IInputReceiver
  {
    private short localPlayerIndex;
    private ControllerHandle_t[] controllerHandles;
    private List<ControllerHandle_t> activeControllerHandles;
    private ControllerActionSetHandle_t _currentActionSet;
    private InputMapCategory currentInputMapCategory;
    private ControllerHandle_t lastActiveInputHandle;
    private Action<short, DigitalInput, bool, InputSource> buttonEventCallback;
    private Action<short, AnalogInput, Vector2, InputSource> analogInputEventCallback;
    private Action<InputSource> lastInputSourceChangedEventCallback;
    private Dictionary<DigitalInput, SteamInputReceiver.SteamInputDigitalAction> _digitalActions;
    private Dictionary<AnalogInput, SteamInputReceiver.SteamInputAnalogAction> _analogActions;
    private EControllerActionOrigin[] glyphOrigins;
    private ControllerActionSetHandle_t _actionSetHandleInGame;
    private ControllerActionSetHandle_t _actionSetHandleMenu;
    private ControllerActionSetHandle_t _actionSetHandleFreeroam;
    private int glyphReloadWaitFrames = 60;
    private int glyphReloadFrameCounter;
    private static readonly string emptyString = "";
    private static ButtonSpriteSet activeButtonSpriteSet;

    public SteamInputReceiver(short localPlayerIndex) => this.localPlayerIndex = localPlayerIndex;

    public void ActivateReceiver(bool keyboardMouseOnly)
    {
      Log.Debug("Activate Steam Receiver");
      this._actionSetHandleInGame = SteamController.GetActionSetHandle("InGameControls");
      this._actionSetHandleMenu = SteamController.GetActionSetHandle("MenuControls");
      this._actionSetHandleFreeroam = SteamController.GetActionSetHandle("FreeroamCamera");
      this._currentActionSet = this._actionSetHandleMenu;
      this._digitalActions = new Dictionary<DigitalInput, SteamInputReceiver.SteamInputDigitalAction>();
      foreach (DigitalInput allButton in InputStructures.GetAllButtons())
      {
        this._digitalActions[allButton] = new SteamInputReceiver.SteamInputDigitalAction()
        {
          handle = SteamController.GetDigitalActionHandle(InputStructures.GetButtonName(allButton)),
          isPressed = false,
          justPressed = false,
          justReleased = false
        };
        Log.Debug("handle for " + (object) allButton + ": " + (object) SteamController.GetDigitalActionHandle(InputStructures.GetButtonName(allButton)));
      }
      this._analogActions = new Dictionary<AnalogInput, SteamInputReceiver.SteamInputAnalogAction>();
      foreach (AnalogInput allAnalogInput in InputStructures.GetAllAnalogInputs())
        this._analogActions[allAnalogInput] = new SteamInputReceiver.SteamInputAnalogAction()
        {
          handle = SteamController.GetAnalogActionHandle(InputStructures.GetAnalogInputName(allAnalogInput)),
          horizontal = 0.0f,
          vertical = 0.0f
        };
      this.activeControllerHandles = new List<ControllerHandle_t>();
      this.controllerHandles = new ControllerHandle_t[16];
      this.glyphOrigins = new EControllerActionOrigin[8];
      this.CheckInputSources();
    }

    public void DeactivateReceiver()
    {
      SteamController.Shutdown();
      this.UnregisterAnalogInputEventCallback();
      this.UnregisterButtonEventCallback();
      this.UnregisterLastInputSourceChangedEventCallback();
    }

    private void CheckInputSources()
    {
      int connectedControllers = SteamController.GetConnectedControllers(this.controllerHandles);
      if (connectedControllers > this.activeControllerHandles.Count)
      {
        this.ControllerAdded(connectedControllers);
      }
      else
      {
        if (connectedControllers >= this.activeControllerHandles.Count)
          return;
        this.ControllerLost(connectedControllers);
      }
    }

    private void ControllerAdded(int controllerCount)
    {
      foreach (ControllerHandle_t controllerHandle in this.controllerHandles)
      {
        if (controllerHandle.m_ControllerHandle != 0UL)
        {
          this.SetInputMap(this.currentInputMapCategory, true);
          if (!this.activeControllerHandles.Contains(controllerHandle))
          {
            this.activeControllerHandles.Add(controllerHandle);
            Log.Debug("found new connected controller");
            this.SetLastActiveInputHandle(controllerHandle);
          }
        }
      }
    }

    private void ControllerLost(int controllerCount)
    {
      Log.Debug("we lost a controller");
      List<ControllerHandle_t> controllerHandleTList = new List<ControllerHandle_t>();
      foreach (ControllerHandle_t controllerHandle in this.activeControllerHandles)
      {
        if (!((IEnumerable<ControllerHandle_t>) this.controllerHandles).Contains<ControllerHandle_t>(controllerHandle))
        {
          Log.Debug("we lost controller " + (object) controllerHandle);
          controllerHandleTList.Add(controllerHandle);
          Log.Debug("Disconnected active stean input controller");
        }
      }
      foreach (ControllerHandle_t controllerHandleT in controllerHandleTList)
        this.activeControllerHandles.Remove(controllerHandleT);
      if (controllerCount != 0)
        return;
      Action<InputSource> changedEventCallback = this.lastInputSourceChangedEventCallback;
      if (changedEventCallback == null)
        return;
      changedEventCallback(InputSource.NoController);
    }

    public void PollInputData()
    {
      this.CheckInputSources();
      ++this.glyphReloadFrameCounter;
      if (this.glyphReloadFrameCounter > this.glyphReloadWaitFrames)
      {
        this.ForceButtonSpriteReload();
        this.glyphReloadFrameCounter = 0;
      }
      foreach (KeyValuePair<DigitalInput, SteamInputReceiver.SteamInputDigitalAction> digitalAction in this._digitalActions)
      {
        SteamInputReceiver.SteamInputDigitalAction inputDigitalAction = digitalAction.Value;
        inputDigitalAction.justPressed = false;
        inputDigitalAction.justReleased = false;
        bool flag1 = false;
        foreach (ControllerHandle_t controllerHandle in this.activeControllerHandles)
        {
          bool flag2 = SteamController.GetDigitalActionData(controllerHandle, inputDigitalAction.handle).bState == (byte) 1;
          flag1 |= flag2;
          if (flag2)
            this.SetLastActiveInputHandle(controllerHandle);
        }
        if (flag1)
        {
          if (!inputDigitalAction.isPressed)
          {
            inputDigitalAction.justPressed = true;
            DigitalInput key = digitalAction.Key;
            if (key != DigitalInput.None)
              this.buttonEventCallback(this.localPlayerIndex, key, true, InputSource.DefaultController);
          }
          inputDigitalAction.isPressed = true;
        }
        else
        {
          if (inputDigitalAction.isPressed)
          {
            inputDigitalAction.justReleased = true;
            DigitalInput key = digitalAction.Key;
            if (key != DigitalInput.None)
              this.buttonEventCallback(this.localPlayerIndex, key, false, InputSource.DefaultController);
          }
          inputDigitalAction.isPressed = false;
        }
      }
      foreach (KeyValuePair<AnalogInput, SteamInputReceiver.SteamInputAnalogAction> analogAction in this._analogActions)
      {
        SteamInputReceiver.SteamInputAnalogAction inputAnalogAction = analogAction.Value;
        Vector2 vector2_1 = Vector2.zero;
        foreach (ControllerHandle_t controllerHandle in this.activeControllerHandles)
        {
          ControllerAnalogActionData_t analogActionData = SteamController.GetAnalogActionData(controllerHandle, inputAnalogAction.handle);
          Vector2 vector2_2 = new Vector2(analogActionData.x, analogActionData.y);
          if ((double) vector2_2.sqrMagnitude > (double) vector2_1.sqrMagnitude)
          {
            vector2_1 = vector2_2;
            if ((double) vector2_2.sqrMagnitude > 0.25)
              this.SetLastActiveInputHandle(controllerHandle);
          }
        }
        inputAnalogAction.horizontal = vector2_1.x;
        inputAnalogAction.vertical = vector2_1.y;
        if ((double) inputAnalogAction.horizontal != 0.0 || (double) inputAnalogAction.vertical != 0.0)
        {
          Action<short, AnalogInput, Vector2, InputSource> inputEventCallback = this.analogInputEventCallback;
          if (inputEventCallback != null)
            inputEventCallback(this.localPlayerIndex, analogAction.Key, new Vector2(inputAnalogAction.horizontal, inputAnalogAction.vertical), InputSource.DefaultController);
        }
      }
    }

    private void SetLastActiveInputHandle(ControllerHandle_t newLastActiveInputHandle)
    {
      if (!(this.lastActiveInputHandle != newLastActiveInputHandle))
        return;
      this.lastActiveInputHandle = newLastActiveInputHandle;
      this.LoadSprites(InputSource.DefaultController);
      this.lastInputSourceChangedEventCallback(InputSource.DefaultController);
    }

    public void SetInputMap(InputMapCategory inputMap, bool enabled)
    {
      this.currentInputMapCategory = inputMap;
      switch (inputMap)
      {
        case InputMapCategory.Champions:
          this._currentActionSet = this._actionSetHandleInGame;
          break;
        case InputMapCategory.UI:
          this._currentActionSet = this._actionSetHandleMenu;
          break;
        case InputMapCategory.Default:
          this._currentActionSet = this._actionSetHandleMenu;
          break;
        case InputMapCategory.FreeroamCamera:
          this._currentActionSet = this._actionSetHandleFreeroam;
          break;
      }
      foreach (ControllerHandle_t controllerHandle in this.activeControllerHandles)
        SteamController.ActivateActionSet(controllerHandle, this._currentActionSet);
      Log.Debug("New action set: " + (object) SteamController.GetCurrentActionSet(this.lastActiveInputHandle));
      this.LoadSprites(InputSource.DefaultController);
    }

    public bool ButtonDown(DigitalInput button) => this._digitalActions[button].justPressed;

    public bool Button(DigitalInput button) => this._digitalActions[button].isPressed;

    public bool ButtonUp(DigitalInput button) => this._digitalActions[button].justReleased;

    public Vector2 GetRawAnalogInput(AnalogInput analogInput)
    {
      if (this._analogActions.ContainsKey(analogInput))
        return analogInput == AnalogInput.Aim || analogInput == AnalogInput.Move ? new Vector2(this._analogActions[analogInput].horizontal, -this._analogActions[analogInput].vertical) : new Vector2(this._analogActions[analogInput].horizontal, this._analogActions[analogInput].vertical);
      Log.Error("Analog Input not polled in SteamInputReceiver");
      return Vector2.zero;
    }

    public void RegisterButtonEventCallback(
      Action<short, DigitalInput, bool, InputSource> callback)
    {
      if (this.buttonEventCallback != null)
        Log.Error("A button callback was already registered for this InputReceiver! Unregister first.");
      else
        this.buttonEventCallback = callback;
    }

    public void UnregisterButtonEventCallback() => this.buttonEventCallback = (Action<short, DigitalInput, bool, InputSource>) null;

    public void RegisterAnalogInputEventCallback(
      Action<short, AnalogInput, Vector2, InputSource> callback)
    {
      if (this.analogInputEventCallback != null)
        Log.Error("A analog input callback was already registered for this InputReceiver! Unregister first.");
      else
        this.analogInputEventCallback = callback;
    }

    public void UnregisterAnalogInputEventCallback() => this.analogInputEventCallback = (Action<short, AnalogInput, Vector2, InputSource>) null;

    public void RegisterLastInputSourceChangedEventCallback(Action<InputSource> callback)
    {
      if (this.lastInputSourceChangedEventCallback != null)
        Log.Error("A callback was already registered for this InputReceiver! Unregister first.");
      else
        this.lastInputSourceChangedEventCallback = callback;
    }

    public void UnregisterLastInputSourceChangedEventCallback() => this.lastInputSourceChangedEventCallback = (Action<InputSource>) null;

    private string GetButtonGlyphPath(DigitalInput button) => SteamController.GetDigitalActionOrigins(this.lastActiveInputHandle, this._currentActionSet, this._digitalActions[button].handle, this.glyphOrigins) > 0 ? SteamController.GetGlyphForActionOrigin(this.glyphOrigins[0]) : SteamInputReceiver.emptyString;

    private ButtonSprite LoadSprite(DigitalInput button, string path)
    {
      Texture2D texture2D = new Texture2D(256, 256);
      Log.Debug("load steam sprite from " + path);
      if (!string.IsNullOrEmpty(path))
      {
        byte[] data = File.ReadAllBytes(path);
        if (!texture2D.LoadImage(data))
          Log.Debug("Could not load button sprite for " + (object) button);
      }
      return new ButtonSprite(button, Sprite.Create(texture2D, new Rect(0.0f, 0.0f, (float) texture2D.width, (float) texture2D.height), Vector2.zero, 100f), path);
    }

    private void LoadSprites(InputSource inputSource)
    {
      bool flag1 = false;
      bool flag2 = false;
      if (SteamInputReceiver.activeButtonSpriteSet == null)
        SteamInputReceiver.activeButtonSpriteSet = new ButtonSpriteSet();
      foreach (DigitalInput allButton in InputStructures.GetAllButtons())
      {
        string buttonGlyphPath = this.GetButtonGlyphPath(allButton);
        if (!SteamInputReceiver.activeButtonSpriteSet.GetButtonSpritePath(allButton).Equals(buttonGlyphPath))
        {
          if (!string.IsNullOrEmpty(SteamInputReceiver.activeButtonSpriteSet.GetButtonSpritePath(allButton)) && string.IsNullOrEmpty(buttonGlyphPath))
            flag2 = true;
          else
            flag1 = true;
          SteamInputReceiver.activeButtonSpriteSet.SetButtonSprite(this.LoadSprite(allButton, buttonGlyphPath));
        }
      }
      if (flag1)
        this.lastInputSourceChangedEventCallback(InputSource.DefaultController);
      if (!flag2)
        return;
      this.lastInputSourceChangedEventCallback(InputSource.NoController);
    }

    public void ForceButtonSpriteReload() => this.LoadSprites(InputSource.DefaultController);

    public ButtonSpriteSet GetSpritesForInputSource(InputSource source)
    {
      if (SteamInputReceiver.activeButtonSpriteSet == null)
        this.LoadSprites(source);
      return SteamInputReceiver.activeButtonSpriteSet;
    }

    public void StartRumble(float strength, float duration = 0.0f) => SteamController.TriggerVibration(this.lastActiveInputHandle, (ushort) (10000.0 * (double) strength), (ushort) (1000.0 * (double) strength));

    public void StopRumble() => SteamController.TriggerVibration(this.lastActiveInputHandle, (ushort) 0, (ushort) 0);

    public void ShowBindingPanel()
    {
      Log.Debug("Show binding panel");
      SteamController.ShowBindingPanel(this.lastActiveInputHandle);
    }

    private class SteamInputDigitalAction
    {
      public ControllerDigitalActionHandle_t handle;
      public bool isPressed;
      public bool justPressed;
      public bool justReleased;
    }

    private class SteamInputAnalogAction
    {
      public ControllerAnalogActionHandle_t handle;
      public float horizontal;
      public float vertical;
    }
  }
}
