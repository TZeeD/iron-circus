// Decompiled with JetBrains decompiler
// Type: StatsPageEntry
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class StatsPageEntry : MonoBehaviour
{
  public Image statsSymbol;
  public TextMeshProUGUI statName;
  public TextMeshProUGUI statValue;

  public void SetStatValues(string statName, string statValue, Sprite statSprite = null)
  {
    if ((Object) statSprite == (Object) null)
    {
      if ((Object) this.statsSymbol != (Object) null)
        this.statsSymbol.enabled = false;
    }
    else
      this.statsSymbol.sprite = statSprite;
    this.statName.text = statName;
    this.statValue.text = statValue;
  }
}
