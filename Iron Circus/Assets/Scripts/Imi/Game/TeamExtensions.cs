// Decompiled with JetBrains decompiler
// Type: Imi.Game.TeamExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEvents.StatEvents;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Imi.Game
{
  public static class TeamExtensions
  {
    [MethodImpl((MethodImplOptions) 256)]
    public static Dictionary<Team, int> TeamWithIntegers() => new Dictionary<Team, int>()
    {
      {
        Team.None,
        0
      },
      {
        Team.Alpha,
        0
      },
      {
        Team.Beta,
        0
      }
    };

    [MethodImpl((MethodImplOptions) 256)]
    public static Dictionary<Team, List<ulong>> TeamWithPlayerList() => new Dictionary<Team, List<ulong>>()
    {
      {
        Team.None,
        new List<ulong>(6)
      },
      {
        Team.Alpha,
        new List<ulong>(6)
      },
      {
        Team.Beta,
        new List<ulong>(6)
      }
    };

    [MethodImpl((MethodImplOptions) 256)]
    public static int GetScore(Dictionary<Team, int> score, Team team) => score.ContainsKey(team) ? score[team] : 0;

    [MethodImpl((MethodImplOptions) 256)]
    public static Team GetWinningTeam(Dictionary<Team, int> score)
    {
      int score1 = TeamExtensions.GetScore(score, Team.Alpha);
      int score2 = TeamExtensions.GetScore(score, Team.Beta);
      return score1 <= score2 ? (score2 <= score1 ? Team.None : Team.Beta) : Team.Alpha;
    }

    public static int GetScore(Team team) => Contexts.sharedInstance.game.hasScore ? TeamExtensions.GetScore(Contexts.sharedInstance.game.score.score, team) : 0;

    [MethodImpl((MethodImplOptions) 256)]
    public static Team GetWinningTeam()
    {
      int score1 = TeamExtensions.GetScore(Team.Alpha);
      int score2 = TeamExtensions.GetScore(Team.Beta);
      return score1 <= score2 ? (score2 <= score1 ? Team.None : Team.Beta) : Team.Alpha;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public static bool HasTeamForfeited(Team team)
    {
      HashSet<GameEntity> entitiesWithPlayerTeam = Contexts.sharedInstance.game.GetEntitiesWithPlayerTeam(team);
      bool flag1 = true;
      bool flag2 = true;
      foreach (GameEntity gameEntity in entitiesWithPlayerTeam)
      {
        if (!gameEntity.isFakePlayer)
        {
          flag2 = false;
          if (!gameEntity.hasPlayerForfeit || gameEntity.hasPlayerForfeit && !gameEntity.playerForfeit.hasForfeit)
            flag1 = false;
        }
      }
      return flag1 && !flag2;
    }

    public static Team GetForfeitedTeam()
    {
      int num = TeamExtensions.HasTeamForfeited(Team.Alpha) ? 1 : 0;
      bool flag = TeamExtensions.HasTeamForfeited(Team.Beta);
      if (num != 0)
        return Team.Alpha;
      return flag ? Team.Beta : Team.None;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public static MatchOutcome GetMatchOutcomeForTeam(Team team)
    {
      if (TeamExtensions.HasTeamForfeited(Team.Alpha))
        return team == Team.Alpha ? MatchOutcome.Loose : MatchOutcome.Win;
      if (TeamExtensions.HasTeamForfeited(Team.Beta))
        return team == Team.Beta ? MatchOutcome.Loose : MatchOutcome.Win;
      Team winningTeam = TeamExtensions.GetWinningTeam();
      if (winningTeam == Team.None)
        return MatchOutcome.Draw;
      return team != winningTeam ? MatchOutcome.Loose : MatchOutcome.Win;
    }

    public static Team GetOpponents(this Team team) => team != Team.Alpha ? Team.Alpha : Team.Beta;
  }
}
