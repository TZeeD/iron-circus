// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MatchFlow.ParticipatingPlayer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.MatchFlow
{
  public class ParticipatingPlayer : MonoBehaviour
  {
    [SerializeField]
    private GameObject skillIconsPrefabTeamAlpha;
    [SerializeField]
    private GameObject skillIconsPrefabTeamBeta;
    [SerializeField]
    private Sprite playerIconBackGroundAlpha;
    [SerializeField]
    private Sprite playerIconBackGroundBeta;
    [SerializeField]
    private Image playerIcon;
    [SerializeField]
    private Material grayscaleMat;
    [SerializeField]
    private SimpleCountDownTextMesh countDown;
    private TeamUiSkillState skillState;
    private Team playerTeam;
    private bool resetedDeath = true;
    private float endTime;
    private readonly string avatarIconsPath = "UI/Avatars/";

    public void InitializePlayerUi(Team team, ChampionConfig config, Team localTeam)
    {
      Image component = this.GetComponent<Image>();
      component.sprite = team == Team.Alpha ? this.playerIconBackGroundAlpha : this.playerIconBackGroundBeta;
      component.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(team);
      this.playerIcon.sprite = UnityEngine.Resources.Load<Sprite>(this.avatarIconsPath + "avatar_" + team.ToString().ToLower() + "_" + config.championType.ToString().ToLower() + "_ui");
      this.playerIcon.material = new Material(this.grayscaleMat);
      this.playerIcon.material.SetFloat("_EffectAmount", 0.0f);
      this.playerTeam = team;
      if (team != localTeam)
        return;
      this.CreateSkillUi(team);
    }

    private void CreateSkillUi(Team team)
    {
      if (team == Team.Alpha)
      {
        GameObject gameObject = Object.Instantiate<GameObject>(this.skillIconsPrefabTeamAlpha);
        gameObject.transform.SetParent(this.playerIcon.transform);
        gameObject.GetComponent<RectTransform>().localPosition = new Vector3(4.5f, -22.5f, 0.0f);
        this.skillState = gameObject.GetComponent<TeamUiSkillState>();
      }
      else
      {
        if (team != Team.Beta)
          return;
        GameObject gameObject = Object.Instantiate<GameObject>(this.skillIconsPrefabTeamBeta);
        gameObject.transform.SetParent(this.playerIcon.transform);
        gameObject.GetComponent<RectTransform>().localPosition = new Vector3(-4.5f, -22.5f, 0.0f);
        this.skillState = gameObject.GetComponent<TeamUiSkillState>();
      }
    }

    private void Update()
    {
      if (this.resetedDeath || (double) Time.time <= (double) this.endTime)
        return;
      this.MarkPlayerAlive();
      this.resetedDeath = true;
    }

    public void MarkPlayerDead(float deathDuration)
    {
      this.playerIcon.material.SetFloat("_EffectAmount", 1f);
      this.GetComponent<Image>().color = Color.black;
      this.countDown.gameObject.SetActive(true);
      this.countDown.StartCountdown(deathDuration);
      this.endTime = Time.time + deathDuration;
      this.resetedDeath = false;
      Log.Debug("Start Timer for Death.");
    }

    public void MarkPlayerAlive()
    {
      this.playerIcon.material.SetFloat("_EffectAmount", 0.0f);
      this.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(this.playerTeam);
      this.countDown.StopCountDown();
      this.countDown.gameObject.SetActive(false);
      Log.Debug("End Timer for Death.");
    }

    public void SetPrimarySkillState(bool usable)
    {
      if (usable)
        this.skillState.SetPrimarySkillStateActive();
      else
        this.skillState.SetPrimarySkillStateInactive();
    }

    public void SetSecondarySkillState(bool usable)
    {
      if (usable)
        this.skillState.SetSecondarySkillStateActive();
      else
        this.skillState.SetSecondarySkillStateInactive();
    }
  }
}
