// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MVPScreen
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEvents.StatEvents;
using SharedWithServer.ScEvents;
using SharedWithServer.Utils.Extensions;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class MVPScreen : MonoBehaviour
  {
    [Header("UiElements")]
    [SerializeField]
    private GameObject MvpPanel;
    [SerializeField]
    private GameObject cardPrefab;
    [SerializeField]
    private Transform cardContainerTransform;
    [SerializeField]
    private MatchEndScreen endScreenManager;
    [Header("Data")]
    public bool animFinished;
    public List<MVPScreen.mvpStats> allAwards;
    [SerializeField]
    private MVPPlayerAvatar[] mvpAvatars;
    private List<GameStatMatchFinishedEvent.MatchResult> matchresultList;
    private Dictionary<ulong, int> playerVotes;
    private Dictionary<ulong, MVPCard> playerMvpCards;
    public ulong mvpID;
    public bool allowVoteUpdates;
    private bool allowVoting;
    private Coroutine mvpScreenProgressCoroutine;

    public bool AllowVoteUpdates
    {
      get => this.allowVoteUpdates;
      set => this.allowVoteUpdates = value;
    }

    public bool AllowVoting => this.allowVoting;

    public void Uninitialize()
    {
      this.allowVoting = false;
      this.allowVoteUpdates = false;
    }

    public void SkipAnimations()
    {
      if (this.animFinished)
        return;
      if (this.mvpScreenProgressCoroutine != null)
        this.StopCoroutine(this.mvpScreenProgressCoroutine);
      foreach (KeyValuePair<ulong, MVPCard> playerMvpCard in this.playerMvpCards)
      {
        playerMvpCard.Value.gameObject.GetComponent<Animator>().SetTrigger("flip");
        if (!playerMvpCard.Value.awardNameString.IsNullOrEmpty())
          playerMvpCard.Value.gameObject.GetComponent<Animator>().SetTrigger("highlightAward");
      }
      this.StartCoroutine(this.ShowMVP(0.1f, true));
      this.StartCoroutine(this.ShowVoteButtons(0.1f, 0.08f));
      this.animFinished = true;
    }

    private void Start()
    {
      Events.Global.OnEventPlayersVoteUpdate += new Events.EventPlayersVoteUpdate(this.OnVoteUpdate);
      this.matchresultList = new List<GameStatMatchFinishedEvent.MatchResult>();
      this.allAwards = new List<MVPScreen.mvpStats>();
    }

    private void OnDestroy() => Events.Global.OnEventPlayersVoteUpdate -= new Events.EventPlayersVoteUpdate(this.OnVoteUpdate);

    private void OnVoteUpdate(Dictionary<ulong, int> playerVotes)
    {
      if (this.allowVoteUpdates)
      {
        AudioController.Play("Ping");
        foreach (KeyValuePair<ulong, int> playerVote in playerVotes)
        {
          Log.Debug(string.Format("Player {0} has {1} votes.", (object) playerVote.Key, (object) playerVote.Value));
          MVPCard cardWithPlayerId = this.GetCardWithPlayerId(playerVote.Key);
          if ((UnityEngine.Object) cardWithPlayerId != (UnityEngine.Object) null)
            cardWithPlayerId.SetVoteUi(playerVote.Value);
        }
      }
      if (this.playerVotes == null)
      {
        this.playerVotes = playerVotes;
      }
      else
      {
        foreach (KeyValuePair<ulong, int> playerVote in playerVotes)
        {
          if (this.playerVotes.ContainsKey(playerVote.Key))
            this.playerVotes[playerVote.Key] = playerVote.Value;
          else if (playerVotes.ContainsKey(playerVote.Key))
            this.playerVotes.Add(playerVote.Key, playerVote.Value);
        }
      }
    }

    private void Update()
    {
    }

    private void DebugVotePlayerInput()
    {
    }

    private void DebugVoteForPlayer(ulong playerId)
    {
    }

    private MVPCard GetCardWithPlayerId(ulong playerId)
    {
      if (this.playerMvpCards.ContainsKey(playerId))
        return this.playerMvpCards[playerId];
      Log.Error("Card with player id " + (object) playerId + " not found!");
      return (MVPCard) null;
    }

    private IEnumerator FlipCards(float startDelay, float dTime)
    {
      yield return (object) new WaitForSeconds(startDelay);
      if (!this.animFinished)
      {
        AudioController.GetAudioItem("FlipCard").ResetSequence();
        AudioController.Play("PlayerSpawn");
        foreach (Component component1 in this.cardContainerTransform)
        {
          MVPCard component2 = component1.GetComponent<MVPCard>();
          if ((UnityEngine.Object) component2 != (UnityEngine.Object) null)
          {
            component2.gameObject.GetComponent<Animator>().SetTrigger("flip");
            yield return (object) new WaitForSeconds(dTime);
          }
        }
      }
    }

    private IEnumerator ShowAwards(float startDelay, float dTime)
    {
      yield return (object) new WaitForSeconds(startDelay);
      if (!this.animFinished)
      {
        foreach (KeyValuePair<ulong, MVPCard> playerMvpCard in this.playerMvpCards)
        {
          if (!playerMvpCard.Value.AwardNameString.IsNullOrEmpty())
          {
            playerMvpCard.Value.gameObject.GetComponent<Animator>().SetTrigger("highlightAward");
            playerMvpCard.Value.ShowAwards();
            AudioController.Play("FlipCard");
            yield return (object) new WaitForSeconds(dTime);
          }
        }
      }
    }

    private IEnumerator ShowVoteButtons(float startDelay, float dTime)
    {
      yield return (object) new WaitForSeconds(startDelay);
      this.allowVoting = true;
      this.animFinished = true;
      this.allowVoteUpdates = true;
      foreach (Component component in this.cardContainerTransform)
      {
        MVPCard card = component.GetComponent<MVPCard>();
        if ((UnityEngine.Object) card != (UnityEngine.Object) null)
        {
          yield return (object) new WaitForSeconds(dTime);
          card.SetVoteUi(this.playerVotes[card.PlayerId]);
          AudioController.Play("Hover");
          card.ShowVoteUi();
        }
        else
          Log.Error("MVP Card Component not found in game object.");
        card = (MVPCard) null;
      }
      (this.mvpID != 0UL ? (Component) this.playerMvpCards[this.mvpID].transform : (Component) this.cardContainerTransform.GetChild(0)).GetComponentInChildren<Button>().Select();
    }

    private IEnumerator ShowCards(float startDelay, float dTime)
    {
      yield return (object) new WaitForSeconds(startDelay);
      if (!this.animFinished)
      {
        AudioController.GetAudioItem("ShowCard").ResetSequence();
        foreach (Component component1 in this.cardContainerTransform)
        {
          MVPCard component2 = component1.GetComponent<MVPCard>();
          if ((UnityEngine.Object) component2 != (UnityEngine.Object) null)
          {
            component2.SetVoteUi(0);
            component2.gameObject.GetComponent<Animator>().SetTrigger("show");
            AudioController.Play("Hover");
            yield return (object) new WaitForSeconds(dTime);
          }
        }
      }
    }

    private IEnumerator ShowMVP(float startDelay, bool force = false)
    {
      yield return (object) new WaitForSeconds(startDelay);
      if (!this.animFinished | force)
      {
        if (this.mvpID != 0UL)
        {
          MVPCard cardWithPlayerId = this.GetCardWithPlayerId(this.mvpID);
          if ((UnityEngine.Object) cardWithPlayerId != (UnityEngine.Object) null && !cardWithPlayerId.GetComponent<Animator>().GetCurrentAnimatorStateInfo(0).IsName("mvp_glow_anim"))
          {
            if (!force)
            {
              cardWithPlayerId.GetComponent<Animator>().SetTrigger("highlightMVP");
            }
            else
            {
              cardWithPlayerId.TriggerUpgradeParticles();
              cardWithPlayerId.GetComponent<Animator>().Play("card_promote_mvp_anim");
            }
          }
          else
            Log.Debug("Mvp Anim not played.");
        }
        else
          Log.Error("No mvpID set");
      }
    }

    public void PopulateCardsWithPlayers(bool debug = false)
    {
      if (!debug)
      {
        this.playerVotes = new Dictionary<ulong, int>();
        GameEntity[] entities = Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities();
        this.playerMvpCards = new Dictionary<ulong, MVPCard>();
        for (int i = 0; i < entities.Length; ++i)
        {
          if (!entities[i].isFakePlayer)
          {
            MatchEndScreen.tempPlayerInfo playerInfo = this.endScreenManager.GetPlayerInfo(entities[i].playerId.value);
            MVPCard mvpCard = this.CreateMvpCard(playerInfo);
            this.playerVotes.Add(playerInfo.playerId, 0);
            mvpCard.SetEntry(entities[i].playerId.value, playerInfo.playerName, playerInfo.team, playerInfo.champion, "");
            foreach (MVPScreen.mvpStats allAward in this.allAwards)
            {
              if ((long) allAward.playerId == (long) mvpCard.PlayerId)
              {
                int score = allAward.score;
                mvpCard.SetEntry(allAward.playerId, playerInfo.playerName, playerInfo.team, playerInfo.champion, allAward.awardId, score, allAward.awardId + "_scoreUnit", allAward.showStats);
              }
            }
            this.playerMvpCards.Add(entities[i].playerId.value, mvpCard);
            mvpCard.SetCardIndex(i, entities.Length);
            mvpCard.SetMvpPlayerAvatar(this.GetPlayerAvatar(playerInfo.playerId));
          }
        }
      }
      else
      {
        this.playerVotes = new Dictionary<ulong, int>();
        this.playerMvpCards = new Dictionary<ulong, MVPCard>();
        for (int i = 0; i < 6; ++i)
        {
          MatchEndScreen.tempPlayerInfo playerInfo = new MatchEndScreen.tempPlayerInfo();
          playerInfo.team = (Team) (i % 2 + 1);
          playerInfo.champion = ChampionType.Galena;
          playerInfo.playerId = (ulong) (1000 + i);
          playerInfo.playerName = "player" + (object) i;
          this.playerVotes.Add(playerInfo.playerId, 0);
          MVPCard mvpCard = this.CreateMvpCard(playerInfo);
          mvpCard.SetEntry(playerInfo.playerId, playerInfo.playerName, playerInfo.team, playerInfo.champion, "");
          foreach (MVPScreen.mvpStats allAward in this.allAwards)
          {
            if ((long) allAward.playerId == (long) mvpCard.PlayerId)
            {
              int score = allAward.score;
              mvpCard.SetEntry(allAward.playerId, playerInfo.playerName, playerInfo.team, playerInfo.champion, allAward.awardId, score, allAward.awardId + "_scoreUnit", allAward.showStats);
            }
          }
          this.playerMvpCards.Add(playerInfo.playerId, mvpCard);
          mvpCard.SetCardIndex(i, 6);
          mvpCard.SetMvpPlayerAvatar(this.GetPlayerAvatar(playerInfo.playerId));
        }
      }
      this.ShuffleCardsToTeams();
    }

    private MVPCard CreateMvpCard(MatchEndScreen.tempPlayerInfo playerInfo)
    {
      GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.cardPrefab);
      gameObject.name = playerInfo.playerName + "_Card";
      gameObject.transform.SetParent(this.cardContainerTransform);
      MVPCard component = gameObject.GetComponent<MVPCard>();
      component.voteAction = new Action(this.VoteAction);
      return component;
    }

    private void VoteAction()
    {
      foreach (KeyValuePair<ulong, MVPCard> playerMvpCard in this.playerMvpCards)
        playerMvpCard.Value.StyleVoteButtonsAfterVote();
      this.StartCoroutine(this.DelayedStopAllowVoting());
    }

    private IEnumerator DelayedStopAllowVoting()
    {
      yield return (object) null;
      this.allowVoting = false;
    }

    private void ShuffleCardsToTeams()
    {
      List<GameObject> gameObjectList1 = new List<GameObject>();
      List<GameObject> gameObjectList2 = new List<GameObject>();
      int num = 0;
      foreach (KeyValuePair<ulong, MVPCard> playerMvpCard in this.playerMvpCards)
      {
        GameObject gameObject;
        (gameObject = playerMvpCard.Value.gameObject).transform.SetParent((Transform) null);
        if (playerMvpCard.Value.Team == Team.Alpha)
          gameObjectList1.Add(gameObject);
        if (playerMvpCard.Value.Team == Team.Beta)
          gameObjectList2.Add(gameObject);
        ++num;
      }
      GameObject[] array1 = gameObjectList1.ToArray();
      GameObject[] array2 = gameObjectList2.ToArray();
      array1.Shuffle<GameObject>();
      array2.Shuffle<GameObject>();
      foreach (GameObject gameObject in array1)
      {
        gameObject.gameObject.transform.SetParent(this.cardContainerTransform);
        gameObject.GetComponent<RectTransform>().localScale = new Vector3(1f, 1f, 1f);
      }
      foreach (GameObject gameObject in array2)
      {
        gameObject.gameObject.transform.SetParent(this.cardContainerTransform);
        gameObject.GetComponent<RectTransform>().localScale = new Vector3(1f, 1f, 1f);
      }
    }

    private MVPPlayerAvatar GetPlayerAvatar(ulong playerId)
    {
      foreach (MVPPlayerAvatar mvpAvatar in this.mvpAvatars)
      {
        if ((long) mvpAvatar.PlayerId == (long) playerId)
          return mvpAvatar;
      }
      return (MVPPlayerAvatar) null;
    }

    public void TriggerMVPScreen()
    {
      this.MvpPanel.SetActive(true);
      foreach (GameEntity gameEntity in Contexts.sharedInstance.game.GetGroup(GameMatcher.Player))
      {
        if (gameEntity.hasAnimationState)
          gameEntity.animationState.RemoveState(AnimationStateType.VictoryPose);
      }
      this.mvpScreenProgressCoroutine = this.StartCoroutine(this.mvpScreenProgress());
    }

    private IEnumerator mvpScreenProgress()
    {
      MVPScreen mvpScreen = this;
      yield return (object) mvpScreen.StartCoroutine(mvpScreen.FlipCards(0.2f, 0.1f));
      yield return (object) mvpScreen.StartCoroutine(mvpScreen.ShowAwards(1.5f, 0.45f));
      yield return (object) mvpScreen.StartCoroutine(mvpScreen.ShowMVP(2f));
      mvpScreen.StartCoroutine(mvpScreen.ShowVoteButtons(3.5f, 0.08f));
    }

    public struct mvpStats
    {
      public string awardId;
      public ulong playerId;
      public int score;
      public bool showStats;
    }
  }
}
