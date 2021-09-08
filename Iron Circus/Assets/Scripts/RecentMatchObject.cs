// Decompiled with JetBrains decompiler
// Type: RecentMatchObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.Utils.Extensions;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class RecentMatchObject : MonoBehaviour
{
  [Header("UI Objects")]
  public TextMeshProUGUI scoreText;
  public TextMeshProUGUI outcomeText;
  public TextMeshProUGUI mvpText;
  public TextMeshProUGUI mapNameText;
  public Image mapImage;
  public TextMeshProUGUI awardNameText;
  public Image awardIcon;
  public GameObject mvpIcon;

  public void SetRecentMatchValues(int matchOutcomeState, string awardName, bool isMVP = false)
  {
    switch (matchOutcomeState)
    {
      case 0:
        this.outcomeText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@WIN");
        this.outcomeText.color = Color.green;
        break;
      case 1:
        this.outcomeText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@defeat");
        this.outcomeText.color = Color.red;
        break;
      default:
        this.outcomeText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@draw");
        this.outcomeText.color = Color.yellow;
        break;
    }
    if (awardName.IsNullOrEmpty())
    {
      this.awardNameText.gameObject.SetActive(false);
      this.awardIcon.gameObject.SetActive(false);
    }
    else
    {
      this.awardNameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + awardName);
      this.awardIcon.sprite = UnityEngine.Resources.Load<Sprite>("UI/matchAwardIcons/" + awardName + "_icon_ui");
      this.awardNameText.gameObject.SetActive(true);
      this.awardIcon.gameObject.SetActive(true);
    }
    if (!isMVP)
      this.mvpIcon.SetActive(false);
    else
      this.mvpIcon.SetActive(true);
  }
}
