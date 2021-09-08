// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.DemoUISlider
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine.UI;

namespace AmplifyBloom
{
  public sealed class DemoUISlider : DemoUIElement
  {
    public bool SingleStep;
    private Slider m_slider;
    private bool m_lastStep;

    private void Start() => this.m_slider = this.GetComponent<Slider>();

    public override void DoAction(DemoUIElementAction action, params object[] vars)
    {
      if (!this.m_slider.IsInteractable() || action != DemoUIElementAction.Slide)
        return;
      float var = (float) vars[0];
      if (this.SingleStep)
      {
        if (this.m_lastStep)
          return;
        this.m_lastStep = true;
      }
      if (this.m_slider.wholeNumbers)
      {
        if ((double) var > 0.0)
        {
          ++this.m_slider.value;
        }
        else
        {
          if ((double) var >= 0.0)
            return;
          --this.m_slider.value;
        }
      }
      else
        this.m_slider.value += var;
    }

    public override void Idle() => this.m_lastStep = false;
  }
}
