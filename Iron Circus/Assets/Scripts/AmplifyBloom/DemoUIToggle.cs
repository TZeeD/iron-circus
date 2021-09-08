// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.DemoUIToggle
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine.UI;

namespace AmplifyBloom
{
  public sealed class DemoUIToggle : DemoUIElement
  {
    private Toggle m_toggle;

    private void Start() => this.m_toggle = this.GetComponent<Toggle>();

    public override void DoAction(DemoUIElementAction action, params object[] vars)
    {
      if (!this.m_toggle.IsInteractable() || action != DemoUIElementAction.Press)
        return;
      this.m_toggle.isOn = !this.m_toggle.isOn;
    }
  }
}
