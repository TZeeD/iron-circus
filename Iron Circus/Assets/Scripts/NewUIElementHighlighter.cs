// Decompiled with JetBrains decompiler
// Type: NewUIElementHighlighter
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class NewUIElementHighlighter : MonoBehaviour
{
  public GameObject highlighterImage;
  public string playerPrefsButtonName;
  public Button button;

  private void Start()
  {
    if (!PlayerPrefs.HasKey(this.playerPrefsButtonName))
    {
      PlayerPrefs.SetInt(this.playerPrefsButtonName, 1);
      this.highlighterImage.SetActive(true);
      if (!((Object) this.button != (Object) null))
        return;
      this.button.onClick.AddListener((UnityAction) (() => this.highlighterImage.SetActive(false)));
    }
    else
      this.highlighterImage.SetActive(false);
  }
}
