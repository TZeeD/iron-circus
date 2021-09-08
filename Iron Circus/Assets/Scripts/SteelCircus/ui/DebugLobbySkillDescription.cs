// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.DebugLobbySkillDescription
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class DebugLobbySkillDescription : MonoBehaviour
  {
    [SerializeField]
    private Animator anim;
    [Header("Champion Avatar and Description UI")]
    [SerializeField]
    private Image championAvatar;
    [SerializeField]
    private TextMeshProUGUI championNameTxt;
    [SerializeField]
    private TextMeshProUGUI championDescriptionTxt;
    [Header("Champion Skills UI")]
    [SerializeField]
    private TextMeshProUGUI skill1NameTxt;
    [SerializeField]
    private TextMeshProUGUI skill1DescriptionTxt;
    [SerializeField]
    private Image skill1Icon;
    [SerializeField]
    private Image skill1ButtonIcon;
    [SerializeField]
    private TextMeshProUGUI skill2NameTxt;
    [SerializeField]
    private TextMeshProUGUI skill2DescriptionTxt;
    [SerializeField]
    private Image skill2Icon;
    [SerializeField]
    private Image skill2ButtonIcon;
    [SerializeField]
    private GameObject healthGroup;
    [SerializeField]
    private GameObject speedGroup;
    [SerializeField]
    private GameObject throwingPowerGroup;
    [SerializeField]
    private GameObject sprintGroup;
    [SerializeField]
    private ThrowBallConfig[] throwBallConfigs;
    [SerializeField]
    private SprintConfig[] sprintConfigs;
    [Header("Class Sprites")]
    [SerializeField]
    private Sprite enforcerSprite;
    [SerializeField]
    private Sprite specialistSprite;
    [SerializeField]
    private Sprite strikerSprite;
    private InputService input;
    private bool show;
    private readonly string championSkillIconPath = "UI/SkillUI/Skill Icons/";
    private readonly string championAvatarIconPath = "UI/Avatars/";

    private void Start()
    {
      this.input = ImiServices.Instance.InputService;
      this.anim = this.GetComponent<Animator>();
      Object.FindObjectOfType<SimplePromptSwitch>().InitializeCurrentDebugLobbySkillDescription(this);
    }

    private void Update()
    {
      if (!this.input.GetButtonDown(DigitalInput.UIShortcut))
        return;
      Debug.Log((object) "Got Button Prompt: UIShortcut");
      this.ToggleAnimation();
    }

    public void ToggleAnimation()
    {
      this.show = !this.show;
      this.anim.SetBool("show", this.show);
      if (this.show)
        AudioController.Play("GalleryPopIn");
      else
        AudioController.Play("GalleryPopOut");
    }

    public void SetButtonSprites(Sprite primaryButton, Sprite secondaryButton)
    {
      this.skill1ButtonIcon.sprite = primaryButton;
      this.skill2ButtonIcon.sprite = secondaryButton;
    }

    public void FillSkillData(ChampionConfig championConfig)
    {
      this.championNameTxt.text = championConfig.displayName;
      this.championDescriptionTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + "Description");
      this.skill1DescriptionTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill.ToString() + "Description");
      this.skill1NameTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill.ToString() + "Name");
      this.skill2NameTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill.ToString() + "Name");
      this.skill2DescriptionTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + championConfig.championType.ToString().ToLower() + Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill.ToString() + "Description");
      Sprite sprite1 = UnityEngine.Resources.Load<Sprite>(this.championAvatarIconPath + "avatar_" + championConfig.championType.ToString().ToLower() + "_ui");
      Sprite sprite2 = UnityEngine.Resources.Load<Sprite>(this.championSkillIconPath + championConfig.championType.ToString().ToLower() + "_" + Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill.ToString().ToLower() + "_ui");
      Sprite sprite3 = UnityEngine.Resources.Load<Sprite>(this.championSkillIconPath + championConfig.championType.ToString().ToLower() + "_" + Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill.ToString().ToLower() + "_ui");
      if ((Object) sprite1 != (Object) null)
        this.championAvatar.sprite = sprite1;
      if ((Object) sprite2 != (Object) null)
        this.skill1Icon.sprite = sprite2;
      if ((Object) sprite3 != (Object) null)
        this.skill2Icon.sprite = sprite3;
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
      int championThrowingPower = ChampionDescriptions.GetChampionThrowingPower(championConfig, this.throwBallConfigs);
      for (int index = 0; index < this.throwingPowerGroup.transform.childCount; ++index)
      {
        if (index < championThrowingPower)
          this.throwingPowerGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
        else
          this.throwingPowerGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = new Color(1f, 1f, 1f, 0.3f);
      }
      int championSprintPower = ChampionDescriptions.GetChampionSprintPower(championConfig, this.sprintConfigs);
      for (int index = 0; index < this.sprintGroup.transform.childCount; ++index)
      {
        if (index < championSprintPower)
          this.sprintGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
        else
          this.sprintGroup.transform.GetChild(index).gameObject.GetComponent<Image>().color = new Color(1f, 1f, 1f, 0.3f);
      }
    }

    private static int MapChampionSpeed(ChampionConfig championConfig) => (double) championConfig.maxSpeed > 5.75 ? ((double) championConfig.maxSpeed <= 5.75 || (double) championConfig.maxSpeed > 6.0 ? ((double) championConfig.maxSpeed <= 6.0 || (double) championConfig.maxSpeed > 6.09999990463257 ? ((double) championConfig.maxSpeed <= 6.09999990463257 || (double) championConfig.maxSpeed > 6.5 ? 5 : 4) : 3) : 2) : 1;
  }
}
