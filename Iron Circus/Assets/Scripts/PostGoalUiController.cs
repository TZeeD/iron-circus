// Decompiled with JetBrains decompiler
// Type: PostGoalUiController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.ScEvents;
using Imi.ScGameStats;
using Imi.SharedWithServer.ScEntitas;
using SharedWithServer.ScEvents;
using System.Collections;
using UnityEngine;

public class PostGoalUiController : MonoBehaviour
{
  [SerializeField]
  private PostGoalTile alphaTile;
  [SerializeField]
  private PostGoalTile betaTile;

  private void Start()
  {
    Events.Global.OnEventTrackingEvent += new Events.EventTrackingEvent(this.OnTrackingEvent);
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
  }

  private void OnTrackingEvent(TrackingEvent e)
  {
    switch (e.statistics)
    {
      case Statistics.OwnGoalsScored:
        this.alphaTile.SetupEventText("@OwnGoal");
        this.betaTile.SetupEventText("@OwnGoal");
        break;
      case Statistics.GoalAssist:
        this.alphaTile.SetupEventText("@Goal");
        this.betaTile.SetupEventText("@Goal");
        this.alphaTile.SetupGoalAssist(e.playerId);
        this.betaTile.SetupGoalAssist(e.playerId);
        break;
      case Statistics.GoalsTouchdown:
        this.alphaTile.SetupEventText("@Touchdown");
        this.betaTile.SetupEventText("@Touchdown");
        break;
      case Statistics.GoalsGeometry:
        this.alphaTile.SetupEventText("@GeometryGoal");
        this.betaTile.SetupEventText("@GeometryGoal");
        break;
    }
  }

  public void DisplayPlayerThatScored()
  {
    Team lastTeamThatScored = Contexts.sharedInstance.game.score.lastTeamThatScored;
    ulong playerScored = Contexts.sharedInstance.game.score.playerScored;
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerScored);
    Team team = entityWithPlayerId.playerTeam.value;
    switch (team)
    {
      case Team.Alpha:
        this.alphaTile.SetupTileForPlayer(entityWithPlayerId);
        this.alphaTile.gameObject.SetActive(true);
        this.alphaTile.GetComponent<Animator>().SetTrigger("enter");
        break;
      case Team.Beta:
        this.betaTile.SetupTileForPlayer(entityWithPlayerId);
        this.betaTile.gameObject.SetActive(true);
        this.betaTile.GetComponent<Animator>().SetTrigger("enter");
        break;
    }
    Log.Debug("TeamThatScored: " + (object) lastTeamThatScored + " PlayerScored: " + (object) playerScored + " Team: " + (object) team);
  }

  public void HidePostGoalTiles()
  {
    this.alphaTile.GetComponent<Animator>().SetTrigger("exit");
    this.betaTile.GetComponent<Animator>().SetTrigger("exit");
    this.StartCoroutine(this.DeactivateObjects());
  }

  private IEnumerator DeactivateObjects()
  {
    yield return (object) new WaitForSeconds(2f);
    this.alphaTile.SetupEventText("@Goal");
    this.betaTile.SetupEventText("@Goal");
    this.alphaTile.gameObject.SetActive(false);
    this.betaTile.gameObject.SetActive(false);
  }

  private void OnDestroy()
  {
    Events.Global.OnEventTrackingEvent -= new Events.EventTrackingEvent(this.OnTrackingEvent);
    Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
  }

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    if (matchState != Imi.SharedWithServer.Game.MatchState.MatchOver)
      return;
    this.HidePostGoalTiles();
  }
}
