// Decompiled with JetBrains decompiler
// Type: ForfeitMatchUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.Core;
using SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ForfeitMatchUi : MonoBehaviour
{
  [SerializeField]
  private GameObject forfeitGo;
  [SerializeField]
  private RectTransform countDownTrans;
  [SerializeField]
  private Image forfeitBg;
  [SerializeField]
  private TextMeshProUGUI playersVotesTxt;
  [SerializeField]
  private TextMeshProUGUI countdownTxt;
  [SerializeField]
  private Button voteBtn;
  [SerializeField]
  private SimpleCountDownTextMesh countdown;
  private bool alreadyForfeited;
  private bool canForfeit;
  private bool timerStarted;
  private InputService input;

  private void Start()
  {
    this.input = ImiServices.Instance.InputService;
    Events.Global.OnEventPlayerForfeitMatch += new Events.EventPlayerForfeitMatch(this.OnPlayerForfeit);
    Events.Global.OnEventForfeitMatchOver += new Events.EventForfeitMatchOver(this.OnForfeitMatchOver);
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnMatchStateChanged);
  }

  private void OnMatchStateChanged(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    if (matchState != Imi.SharedWithServer.Game.MatchState.MatchOver && matchState != Imi.SharedWithServer.Game.MatchState.Overtime)
      return;
    this.forfeitGo.SetActive(false);
    this.StopAllCoroutines();
    this.canForfeit = false;
  }

  private void OnForfeitMatchOver(ulong playerId, Team team) => this.forfeitGo.SetActive(false);

  private void OnPlayerForfeit(ulong playerId, bool forfeit)
  {
    if (!forfeit)
      return;
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);
    GameEntity firstLocalEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
    HashSet<GameEntity> entitiesWithPlayerTeam = Contexts.sharedInstance.game.GetEntitiesWithPlayerTeam(entityWithPlayerId.playerTeam.value);
    int num = 0;
    foreach (GameEntity gameEntity in entitiesWithPlayerTeam)
    {
      if (gameEntity.hasPlayerForfeit && gameEntity.playerForfeit.hasForfeit)
        ++num;
    }
    if (firstLocalEntity.playerTeam.value != entityWithPlayerId.playerTeam.value)
      return;
    this.canForfeit = true;
    string str = string.Format(" [{0}/{1}]", (object) num, (object) entitiesWithPlayerTeam.Count);
    this.forfeitGo.SetActive(true);
    if ((long) ImiServices.Instance.LoginService.GetPlayerId() == (long) playerId)
    {
      this.playersVotesTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@AlreadyForfeitVote") + str;
      this.voteBtn.gameObject.SetActive(false);
      this.forfeitBg.fillAmount = 0.5f;
      this.countDownTrans.anchoredPosition = new Vector2(this.countDownTrans.anchoredPosition.x, -30f);
      this.alreadyForfeited = true;
    }
    else if (!firstLocalEntity.hasPlayerForfeit || firstLocalEntity.hasPlayerForfeit && !firstLocalEntity.playerForfeit.hasForfeit)
    {
      this.playersVotesTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@ForfeitVote") + str;
      this.voteBtn.gameObject.SetActive(true);
      this.forfeitBg.fillAmount = 1f;
      this.countDownTrans.anchoredPosition = new Vector2(this.countDownTrans.anchoredPosition.x, -75f);
      this.alreadyForfeited = false;
    }
    else
      this.alreadyForfeited = true;
    if (this.timerStarted)
      return;
    this.countdown.StartCountdown(StartupSetup.configProvider.matchConfig.forfeitVoteTime);
    this.StartCoroutine(this.ResetVoteForRematch(StartupSetup.configProvider.matchConfig.forfeitVoteTime));
    this.timerStarted = true;
  }

  private IEnumerator ResetVoteForRematch(float time)
  {
    yield return (object) new WaitForSeconds(time);
    this.canForfeit = false;
    this.alreadyForfeited = false;
    this.timerStarted = false;
    this.forfeitGo.SetActive(false);
    Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new PlayerForfeitMatchMessage(ImiServices.Instance.LoginService.GetPlayerId(), false));
  }

  private void Update()
  {
    if (!this.canForfeit || this.alreadyForfeited || !this.input.GetButtonDown(DigitalInput.Surrender))
      return;
    this.ForfeitMatch();
  }

  public void ForfeitMatch()
  {
    if (!this.canForfeit || this.alreadyForfeited)
      return;
    Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new PlayerForfeitMatchMessage(ImiServices.Instance.LoginService.GetPlayerId(), true));
    this.alreadyForfeited = true;
  }

  private void OnDestroy()
  {
    Events.Global.OnEventPlayerForfeitMatch -= new Events.EventPlayerForfeitMatch(this.OnPlayerForfeit);
    Events.Global.OnEventForfeitMatchOver -= new Events.EventForfeitMatchOver(this.OnForfeitMatchOver);
    Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnMatchStateChanged);
  }
}
