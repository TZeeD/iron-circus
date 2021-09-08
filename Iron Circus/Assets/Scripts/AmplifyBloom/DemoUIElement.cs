// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.DemoUIElement
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace AmplifyBloom
{
  public class DemoUIElement : MonoBehaviour
  {
    private bool m_isSelected;
    private Text m_text;
    private Color m_selectedColor = new Color(1f, 1f, 1f);
    private Color m_unselectedColor;

    public void Init()
    {
      this.m_text = this.transform.GetComponentInChildren<Text>();
      this.m_unselectedColor = this.m_text.color;
    }

    public virtual void DoAction(DemoUIElementAction action, params object[] vars)
    {
    }

    public virtual void Idle()
    {
    }

    public bool Select
    {
      get => this.m_isSelected;
      set
      {
        this.m_isSelected = value;
        this.m_text.color = value ? this.m_selectedColor : this.m_unselectedColor;
      }
    }
  }
}
