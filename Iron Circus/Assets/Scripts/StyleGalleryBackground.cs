// Decompiled with JetBrains decompiler
// Type: StyleGalleryBackground
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class StyleGalleryBackground : MonoBehaviour
{
  [SerializeField]
  private TextMeshProUGUI championNameText;
  [SerializeField]
  private Image championFactionLogo;

  public void StyleChampionInfo(ChampionConfig champion)
  {
    this.championNameText.gameObject.SetActive(true);
    this.championFactionLogo.gameObject.SetActive(true);
    this.championNameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + champion.displayName).ToUpper();
    this.championFactionLogo.sprite = champion.faction.factionLogo;
  }
}
