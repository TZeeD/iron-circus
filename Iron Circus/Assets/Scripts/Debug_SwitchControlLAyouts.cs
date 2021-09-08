// Decompiled with JetBrains decompiler
// Type: Debug_SwitchControlLAyouts
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired;
using UnityEngine;

public class Debug_SwitchControlLAyouts : MonoBehaviour
{
  private Player input;

  private void Start() => this.input = ReInput.players.GetPlayer(0);

  private void Update()
  {
    if (Input.GetKeyDown("i"))
      this.ApplyPreset1();
    if (!Input.GetKeyDown("o"))
      return;
    this.ApplyPreset2();
  }

  public void ApplyPreset1()
  {
    Debug.Log((object) nameof (ApplyPreset1));
    this.input.controllers.maps.LoadMap(ControllerType.Keyboard, 0, "Champions", "KeyboardPreset2");
    this.input.controllers.maps.LoadMap(ControllerType.Mouse, 0, "Champions", "MousePreset2");
    this.input.controllers.maps.SetMapsEnabled(true, "Champions", "Default");
    this.input.controllers.maps.SetMapsEnabled(false, ControllerType.Keyboard, "Champions", "KeyboardPreset2");
    this.input.controllers.maps.SetMapsEnabled(false, ControllerType.Mouse, "Champions", "MousePreset2");
  }

  public void ApplyPreset2()
  {
    Debug.Log((object) nameof (ApplyPreset2));
    this.input.controllers.maps.LoadMap(ControllerType.Keyboard, 0, "Champions", "KeyboardPreset2");
    this.input.controllers.maps.LoadMap(ControllerType.Mouse, 0, "Champions", "MousePreset2");
    this.input.controllers.maps.SetMapsEnabled(false, "Champions", "Default");
    this.input.controllers.maps.SetMapsEnabled(true, ControllerType.Keyboard, "Champions", "KeyboardPreset2");
    this.input.controllers.maps.SetMapsEnabled(true, ControllerType.Mouse, "Champions", "MousePreset2");
  }
}
