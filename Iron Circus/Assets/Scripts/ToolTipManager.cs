// Decompiled with JetBrains decompiler
// Type: ToolTipManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

public class ToolTipManager : MonoBehaviour
{
  public Text tooltipText;
  private static ToolTipManager instance;

  public bool IsActive => this.gameObject.activeSelf;

  private void Awake()
  {
    ToolTipManager.instance = this;
    this.HideTooltip();
  }

  public void ShowTooltip(string text, Vector3 pos)
  {
    if (this.tooltipText.text != text)
      this.tooltipText.text = text;
    this.transform.position = pos;
    this.gameObject.SetActive(true);
  }

  public void HideTooltip() => this.gameObject.SetActive(false);

  public static ToolTipManager Instance
  {
    get
    {
      if ((Object) ToolTipManager.instance == (Object) null)
        ToolTipManager.instance = Object.FindObjectOfType<ToolTipManager>();
      return ToolTipManager.instance;
    }
  }
}
