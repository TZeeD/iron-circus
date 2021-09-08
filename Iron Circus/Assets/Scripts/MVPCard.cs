// Decompiled with JetBrains decompiler
// Type: MVPCard
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class MVPCard : MonoBehaviour
{
  [SerializeField]
  private GameObject cardFront;
  [SerializeField]
  private GameObject cardBack;
  [Header("Card UI Elements")]
  [SerializeField]
  private GameObject mvpBorderRectangles;
  [SerializeField]
  private GameObject mvpIconTeamAlpha;
  [SerializeField]
  private GameObject mvpIconTeamBeta;
  [SerializeField]
  private Image champIcon;
  [SerializeField]
  private Image innerBorder;
  [SerializeField]
  private Image innerBorderBack;
  [SerializeField]
  private Image outerBorder;
  [SerializeField]
  private Image mvpColorBG;
  [SerializeField]
  private Image mvpFogEffect;
  [Header("Vote UI")]
  [SerializeField]
  private GameObject votePraiseParentObject;
  [SerializeField]
  private Image votePraiseBorderObject;
  [SerializeField]
  private TextMeshProUGUI votePraiseText;
  [SerializeField]
  private Image voteButtonBackground;
  [SerializeField]
  private MvpVoteButton MvpVoteButton;
  [SerializeField]
  private Image MvpVoteIcon;
  [SerializeField]
  private Image MvpVoteIconGlow;
  [Header("Effect UI")]
  [SerializeField]
  private ParticleSystem particleEffectTop;
  [SerializeField]
  private ParticleSystem particleEffectBottom;
  [SerializeField]
  private ParticleSystem particleEffectUpgrade;
  [SerializeField]
  private ParticleSystem particleEffectUpgradeSubtle;
  [SerializeField]
  private Animator mvpGlowAnimator;
  [Header("TextContent")]
  [SerializeField]
  private TextMeshProUGUI usernameTxt;
  [SerializeField]
  private TextMeshProUGUI awardNameText;
  [SerializeField]
  private TextMeshProUGUI cardScoreText;
  [SerializeField]
  private RectTransform textLayoutParent;
  public Action voteAction;
  private ulong playerId;
  public string awardNameString;
  private string username;
  private int score;
  private bool showScore;
  private string scoreUnit;
  private Team team;
  private ChampionType championType;
  private int votes;
  private int cardIndex;
  private int mvpPlayerCount;
  private MVPPlayerAvatar playerAvatar;

  public ulong PlayerId => this.playerId;

  public string AwardNameString => this.awardNameString;

  public Team Team => this.team;

  public int Votes
  {
    get => this.votes;
    set => this.votes = value;
  }

  public void StyleVoteButtonsAfterVote() => this.MvpVoteButton.StyleVoteButtonsAfterVote();

  public void SetEntry(
    ulong playerId,
    string username,
    Team team,
    ChampionType championType,
    string awardName,
    int score = 0,
    string scoreUnit = "",
    bool showScore = false)
  {
    this.awardNameString = awardName;
    this.playerId = playerId;
    this.username = username;
    this.score = score;
    this.scoreUnit = scoreUnit;
    this.showScore = showScore;
    this.team = team;
    this.championType = championType;
    this.UpdateUi();
  }

  public void SetVoteUi(int votes) => this.MvpVoteButton.SetUi(votes, this.team);

  public void SetCardIndex(int i, int mvpPlayers)
  {
    this.cardIndex = i;
    this.mvpPlayerCount = mvpPlayers;
  }

  public void SetMvpPlayerAvatar(MVPPlayerAvatar avatar) => this.playerAvatar = avatar;

  private void UpdateUi()
  {
    this.voteButtonBackground.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(this.team);
    this.StyleCard(this.team, (long) this.playerId == (long) ImiServices.Instance.LoginService.GetPlayerId());
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.playerId);
    ItemDefinition itemDefinition;
    if (entityWithPlayerId == null || !entityWithPlayerId.hasPlayerLoadout)
    {
      Log.Warning("No User Found with id " + (object) this.playerId);
      itemDefinition = SingletonScriptableObject<ItemsConfig>.Instance.GetMainSkinForChampion(this.championType);
    }
    else
      itemDefinition = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(entityWithPlayerId.playerLoadout.itemLoadouts[this.championType].skin);
    if (itemDefinition != null)
      this.champIcon.sprite = itemDefinition.icon;
    else
      Log.Error("No ItemDefinition icon for: " + (object) this.championType);
    Vector3 shopIconTranslation = (Vector3) SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(this.championType).shopIconTranslation;
    Vector3 vector3 = new Vector3(shopIconTranslation.x, shopIconTranslation.y + 120f, 0.0f);
    this.champIcon.GetComponent<RectTransform>().transform.localPosition = vector3;
    float num = SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(this.championType).shopIconScale * 2.5f;
    this.champIcon.GetComponent<RectTransform>().transform.localScale = new Vector3(num, num, 1f);
    this.usernameTxt.text = this.username;
    if (this.showScore)
    {
      this.cardScoreText.gameObject.SetActive(true);
      this.cardScoreText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + this.scoreUnit) + " " + (object) this.score;
    }
    else
      this.cardScoreText.gameObject.SetActive(false);
    this.awardNameText.gameObject.SetActive(false);
    this.cardScoreText.gameObject.SetActive(false);
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.textLayoutParent);
  }

  public void ShowAwards()
  {
    if (!string.IsNullOrEmpty(this.awardNameString))
    {
      this.awardNameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + this.awardNameString);
      this.awardNameText.gameObject.SetActive(true);
    }
    if (!this.showScore)
      return;
    this.cardScoreText.gameObject.SetActive(true);
    this.cardScoreText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + this.scoreUnit) + " " + (object) this.score;
  }

  public void StartMVPParticleEffects()
  {
    this.particleEffectTop.Play();
    this.particleEffectBottom.Play();
  }

  private void StyleCard(Team team, bool ownPlayer = false)
  {
    if (team == Team.Alpha)
    {
      this.mvpIconTeamAlpha.SetActive(true);
      this.mvpIconTeamBeta.SetActive(false);
      foreach (Graphic componentsInChild in this.mvpBorderRectangles.transform.GetComponentsInChildren<Image>())
        componentsInChild.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.innerBorder.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.innerBorderBack.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.outerBorder.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.mvpColorBG.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight.WithAlpha(0.3f);
      this.awardNameText.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.usernameTxt.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.cardScoreText.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.cardScoreText.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.mvpFogEffect.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight.WithAlpha(0.4f);
      this.votePraiseParentObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorDark;
      this.votePraiseBorderObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.MvpVoteButton.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorDark.WithAlpha(0.7f);
      this.MvpVoteIcon.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      this.MvpVoteIconGlow.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
    }
    else
    {
      foreach (Graphic componentsInChild in this.mvpBorderRectangles.transform.GetComponentsInChildren<Image>())
        componentsInChild.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.mvpIconTeamAlpha.SetActive(false);
      this.mvpIconTeamBeta.SetActive(true);
      this.innerBorder.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.innerBorderBack.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.outerBorder.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.mvpColorBG.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight.WithAlpha(0.4f);
      this.awardNameText.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.usernameTxt.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.cardScoreText.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.votePraiseParentObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorDark;
      this.votePraiseBorderObject.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.mvpFogEffect.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight.WithAlpha(0.4f);
      this.MvpVoteButton.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorDark.WithAlpha(0.7f);
      this.MvpVoteIcon.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
      this.MvpVoteIconGlow.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
    }
    if (!ownPlayer)
      return;
    this.awardNameText.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
    this.usernameTxt.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
    this.cardScoreText.faceColor = (Color32) SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
  }

  public void FlipCardContents()
  {
    this.cardBack.SetActive(false);
    this.cardFront.SetActive(true);
    this.MvpVoteButton.gameObject.SetActive(true);
    this.MvpVoteButton.EnableVoteUi();
  }

  public void ShowVoteUi()
  {
    this.MvpVoteButton.gameObject.SetActive(true);
    this.MvpVoteButton.EnableVoteUi();
  }

  public void TriggerPlayerAvatarParticles()
  {
    ParticleSystem.MainModule main1 = this.particleEffectTop.main;
    ParticleSystem.MainModule main2 = this.particleEffectBottom.main;
    if (this.team == Team.Alpha)
    {
      main1.startColor = (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight.WithAlpha(0.5f);
      main2.startColor = (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight.WithAlpha(0.5f);
    }
    else
    {
      main1.startColor = (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight.WithAlpha(0.5f);
      main2.startColor = (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight.WithAlpha(0.5f);
    }
    this.particleEffectTop.gameObject.SetActive(true);
    this.particleEffectBottom.gameObject.SetActive(true);
    this.particleEffectTop.Play();
    this.particleEffectBottom.Play();
  }

  public void TriggerMvpGlow() => this.mvpGlowAnimator.SetTrigger("startGlow");

  public void TriggerMVPSound() => AudioController.Play("MvpReward");

  public void TriggerUpgradeParticles()
  {
    this.particleEffectUpgrade.main.startColor = this.team != Team.Alpha ? (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight : (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
    this.particleEffectUpgrade.gameObject.SetActive(true);
    this.particleEffectUpgrade.Play();
  }

  public void TriggerUpgradeParticlesSubtle()
  {
    this.particleEffectUpgradeSubtle.main.startColor = this.team != Team.Alpha ? (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight : (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
    this.particleEffectUpgradeSubtle.gameObject.SetActive(true);
    this.particleEffectUpgradeSubtle.Play();
  }

  public void VoteForPlayer()
  {
    Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new VoteForMvpMessage(ImiServices.Instance.LoginService.GetPlayerId(), this.playerId));
    Action voteAction = this.voteAction;
    if (voteAction == null)
      return;
    voteAction();
  }
}
