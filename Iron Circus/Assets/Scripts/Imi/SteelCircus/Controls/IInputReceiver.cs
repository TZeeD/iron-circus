// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Controls.IInputReceiver
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace Imi.SteelCircus.Controls
{
  public interface IInputReceiver
  {
    void ActivateReceiver(bool keyboardMouseOnly);

    void DeactivateReceiver();

    bool ButtonDown(DigitalInput button);

    bool Button(DigitalInput button);

    bool ButtonUp(DigitalInput button);

    Vector2 GetRawAnalogInput(AnalogInput analogInput);

    void PollInputData();

    void SetInputMap(InputMapCategory inputMap, bool enabled);

    void RegisterButtonEventCallback(
      Action<short, DigitalInput, bool, InputSource> callback);

    void UnregisterButtonEventCallback();

    void RegisterAnalogInputEventCallback(
      Action<short, AnalogInput, Vector2, InputSource> callback);

    void UnregisterAnalogInputEventCallback();

    void RegisterLastInputSourceChangedEventCallback(Action<InputSource> callback);

    void UnregisterLastInputSourceChangedEventCallback();

    ButtonSpriteSet GetSpritesForInputSource(InputSource source);

    void ForceButtonSpriteReload();

    void StartRumble(float strength, float duration);

    void StopRumble();
  }
}
