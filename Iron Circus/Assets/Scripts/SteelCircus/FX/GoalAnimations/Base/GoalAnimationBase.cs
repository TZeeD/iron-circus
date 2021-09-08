// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.GoalAnimations.Base.GoalAnimationBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.FX.GoalAnimations.Base
{
  public abstract class GoalAnimationBase : MonoBehaviour
  {
    protected Team scoringTeam;
    protected string scoringPlayerName;
    protected Dictionary<Team, int> score;

    public void SetScoringTeam(Team team)
    {
      this.scoringTeam = team;
      this.SetScoringTeamInternal(team);
    }

    protected virtual void SetScoringTeamInternal(Team team)
    {
    }

    public void SetScoringPlayer(GameEntity player) => this.scoringPlayerName = player.playerUsername.username;

    public void SetScore(Dictionary<Team, int> score) => this.score = new Dictionary<Team, int>((IDictionary<Team, int>) score);

    protected string GetGoalString() => "Goal";

    protected string GetTeamString() => "Team " + (this.scoringTeam == Team.Alpha ? "Orange" : "Blue");

    protected abstract void Start();

    protected virtual void Awake()
    {
      this.score = new Dictionary<Team, int>();
      this.score[Team.Alpha] = 3;
      this.score[Team.Beta] = 1;
      this.scoringTeam = Team.Beta;
      this.scoringPlayerName = "Shmoopie";
    }
  }
}
