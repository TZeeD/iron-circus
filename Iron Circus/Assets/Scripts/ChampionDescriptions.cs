// Decompiled with JetBrains decompiler
// Type: ChampionDescriptions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ChampionDescriptions : MonoBehaviour
{
  public ChampionConfig activeChampion;
  [SerializeField]
  private GameObject weeklyRotationTextObject;
  [Header("Champion Description UI")]
  [SerializeField]
  private TextMeshProUGUI championNameTxt;
  [SerializeField]
  private TextMeshProUGUI championStoryTxt;
  [SerializeField]
  private TextMeshProUGUI championTrivia1;
  [SerializeField]
  private TextMeshProUGUI championTrivia2;
  [SerializeField]
  private TextMeshProUGUI championTrivia3;
  [Header("Champion Skills UI")]
  [SerializeField]
  private TextMeshProUGUI skill1NameTxt;
  [SerializeField]
  private TextMeshProUGUI skill1DescriptionTxt;
  [SerializeField]
  private Image skill1Icon;
  [SerializeField]
  private TextMeshProUGUI skill2NameTxt;
  [SerializeField]
  private TextMeshProUGUI skill2DescriptionTxt;
  [SerializeField]
  private Image skill2Icon;
  [SerializeField]
  private GameObject throwingPowerGroup;
  [SerializeField]
  private GameObject healthGroup;
  [SerializeField]
  private GameObject speedGroup;
  [SerializeField]
  private GameObject sprintGroup;
  [SerializeField]
  private GameObject staminaGroup;
  [SerializeField]
  private ThrowBallConfig[] throwBallConfigs;
  [SerializeField]
  private SprintConfig[] sprintConfigs;
  [SerializeField]
  private StaminaConfig[] staminaConfigs;
  [Header("Champion Faction UI")]
  [SerializeField]
  private TextMeshProUGUI factionNameText;
  [SerializeField]
  private Image factionLogoImage;
  private readonly string championSkillIconPath = "UI/SkillUI/Skill Icons HighRes/";

  private void Start()
  {
  }

  public void SetWeeklyRotationInfo(ChampionConfig champion)
  {
    MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
    if (singleEntity.hasMetaChampionsUnlocked)
      this.weeklyRotationTextObject.SetActive(singleEntity.metaChampionsUnlocked.championRotationStateDict[champion.championType]);
    else
      this.weeklyRotationTextObject.SetActive(false);
  }

  public void FillSkillData(ChampionConfig championConfig)
  {
    this.championNameTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.displayName);
    this.FillSkillDescriptions(championConfig);
    this.FillTriviaPage(championConfig);
    this.FillFactionInfo(championConfig);
    Sprite sprite1 = UnityEngine.Resources.Load<Sprite>(this.championSkillIconPath + championConfig.championType.ToString().ToLower() + "_" + Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill.ToString().ToLower() + "_ui");
    Sprite sprite2 = UnityEngine.Resources.Load<Sprite>(this.championSkillIconPath + championConfig.championType.ToString().ToLower() + "_" + Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill.ToString().ToLower() + "_ui");
    if ((Object) sprite1 != (Object) null)
      this.skill1Icon.sprite = sprite1;
    if ((Object) sprite2 != (Object) null)
      this.skill2Icon.sprite = sprite2;
    for (int index = 0; index < this.healthGroup.transform.childCount; ++index)
    {
      if (index < championConfig.maxHealth)
        this.healthGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      else
        this.healthGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = new Color(1f, 1f, 1f, 0.3f);
    }
    int uiDisplaySpeed = championConfig.uiDisplaySpeed;
    for (int index = 0; index < this.speedGroup.transform.childCount; ++index)
    {
      if (index < uiDisplaySpeed)
        this.speedGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      else
        this.speedGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = new Color(1f, 1f, 1f, 0.3f);
    }
    int championThrowingPower = ChampionDescriptions.GetChampionThrowingPower(this.activeChampion, this.throwBallConfigs);
    for (int index = 0; index < this.throwingPowerGroup.transform.childCount; ++index)
    {
      if (index < championThrowingPower)
        this.throwingPowerGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      else
        this.throwingPowerGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = new Color(1f, 1f, 1f, 0.3f);
    }
    int championSprintPower = ChampionDescriptions.GetChampionSprintPower(this.activeChampion, this.sprintConfigs);
    for (int index = 0; index < this.sprintGroup.transform.childCount; ++index)
    {
      if (index < championSprintPower)
        this.sprintGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      else
        this.sprintGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = new Color(1f, 1f, 1f, 0.3f);
    }
    int championStamina = ChampionDescriptions.GetChampionStamina(this.activeChampion, this.staminaConfigs);
    for (int index = 0; index < this.staminaGroup.transform.childCount; ++index)
    {
      if (index < championStamina)
        this.staminaGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      else
        this.staminaGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = new Color(1f, 1f, 1f, 0.3f);
    }
  }

  private void FillSkillDescriptions(ChampionConfig championConfig)
  {
    this.skill1DescriptionTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill.ToString() + "Description");
    this.skill1NameTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill.ToString() + "Name");
    this.skill2NameTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill.ToString() + "Name");
    this.skill2DescriptionTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill.ToString() + "Description");
  }

  private void FillFactionInfo(ChampionConfig championConfig)
  {
    this.factionNameText.text = ImiServices.Instance.LocaService.GetLocalizedValue(championConfig.faction.factionLocaString);
    this.factionLogoImage.sprite = championConfig.faction.factionLogo;
  }

  private void FillTriviaPage(ChampionConfig championConfig)
  {
    this.championStoryTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + "Bio");
    this.championTrivia1.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + "Trivia1");
    this.championTrivia2.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + "Trivia2");
    this.championTrivia3.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + "Trivia3");
  }

  public static int GetChampionSprintPower(ChampionConfig champion, SprintConfig[] sprintConfigs)
  {
    int num = 0;
    for (int index = 0; index < sprintConfigs.Length; ++index)
    {
      bool flag = false;
      foreach (SkillGraphConfig playerSkillGraph in champion.playerSkillGraphs)
      {
        if ((Object) sprintConfigs[index] == (Object) playerSkillGraph)
        {
          num = index + 1;
          flag = true;
          break;
        }
      }
      if (flag)
        break;
    }
    return num;
  }

  public static int GetChampionStamina(ChampionConfig champion, StaminaConfig[] staminaConfigs)
  {
    for (int index = 0; index < staminaConfigs.Length; ++index)
    {
      if ((Object) champion.stamina == (Object) staminaConfigs[index])
      {
        int num;
        return num = index + 1;
      }
    }
    return 1;
  }

  public static int GetChampionThrowingPower(
    ChampionConfig champion,
    ThrowBallConfig[] sprintConfigs)
  {
    int num = 0;
    for (int index = 0; index < sprintConfigs.Length; ++index)
    {
      bool flag = false;
      foreach (SkillGraphConfig playerSkillGraph in champion.playerSkillGraphs)
      {
        if ((Object) sprintConfigs[index] == (Object) playerSkillGraph)
        {
          num = index + 1;
          flag = true;
          break;
        }
      }
      if (flag)
        break;
    }
    return num;
  }
}
