// Decompiled with JetBrains decompiler
// Type: AchievementPanelUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class AchievementPanelUI : MonoBehaviour
{
  [SerializeField]
  private Image achievementIconImage;
  [SerializeField]
  private TextMeshProUGUI achievementNameText;
  [SerializeField]
  private TextMeshProUGUI achievementStat1Text;
  [SerializeField]
  private TextMeshProUGUI achievementStat2Text;
  [SerializeField]
  private TextMeshProUGUI achievementXPText;
  [SerializeField]
  private TextMeshProUGUI achievementDescriptionText;

  public void StyleAchievementDescription(string description, Color color)
  {
    this.achievementNameText.gameObject.SetActive(false);
    this.achievementStat1Text.gameObject.SetActive(false);
    this.achievementStat2Text.gameObject.SetActive(false);
    this.achievementDescriptionText.gameObject.SetActive(true);
    this.achievementDescriptionText.text = ImiServices.Instance.LocaService.GetLocalizedValue(description);
    this.achievementDescriptionText.color = color;
  }

  public void HideXP() => this.achievementXPText.gameObject.SetActive(false);

  public GameObject StyleAchievementPanel(
    Sprite iconSprite,
    string achievementName,
    int achievementXP,
    string achievementStat1Name = null,
    int achievementStat1Amount = 0,
    string achievementStat2Name = null,
    int achievementStat2Amount = 0)
  {
    if ((Object) iconSprite != (Object) null)
      this.achievementIconImage.sprite = iconSprite;
    else
      this.achievementIconImage.enabled = false;
    this.achievementIconImage.preserveAspect = true;
    this.achievementNameText.text = achievementName;
    this.achievementXPText.text = achievementXP.ToString() + ImiServices.Instance.LocaService.GetLocalizedValue("@XP");
    if (achievementStat1Name != null)
    {
      this.achievementStat1Text.gameObject.SetActive(true);
      this.achievementStat1Text.text = "<b>" + achievementStat1Amount.ToString() + "</b> " + achievementStat1Name;
    }
    else
      this.achievementStat1Text.gameObject.SetActive(false);
    if (achievementStat2Name != null)
    {
      this.achievementStat2Text.gameObject.SetActive(true);
      this.achievementStat2Text.text = "<b>" + achievementStat2Amount.ToString() + "</b> " + achievementStat2Name;
    }
    else
      this.achievementStat2Text.gameObject.SetActive(false);
    return this.gameObject;
  }
}
