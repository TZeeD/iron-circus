// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Player.SkillGraphSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Game.Skills;
using SharedWithServer.ScEvents;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems.Player
{
  public class SkillGraphSystem : ExecuteGameSystem, ITearDownSystem, ISystem
  {
    private readonly IGroup<GameEntity> players;
    private bool isFirstPoint = true;
    private Events events;
    private List<Imi.SharedWithServer.Game.MatchState> newMatchStates = new List<Imi.SharedWithServer.Game.MatchState>();

    public SkillGraphSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.players = this.gameContext.GetGroup(GameMatcher.SkillGraph);
      this.events = entitasSetup.Events;
      this.events.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnMatchStateChanged);
    }

    public void TearDown() => this.events.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnMatchStateChanged);

    private void OnMatchStateChanged(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      this.newMatchStates.Add(matchState);
    }

    protected override void GameExecute()
    {
      int currentTick = this.gameContext.globalTime.currentTick;
      foreach (GameEntity player in this.players)
      {
        if (!player.isLocalEntity)
        {
          if (!this.gameContext.globalTime.isReprediction)
          {
            foreach (SkillGraph skillGraph in player.skillGraph.skillGraphs)
              skillGraph.Tick(this.gameContext.globalTime.currentTick);
          }
        }
        else
        {
          bool flag1 = false;
          bool flag2 = false;
          bool flag3 = this.newMatchStates.Count > 0;
          for (int index = 0; index < this.newMatchStates.Count; ++index)
          {
            if (this.newMatchStates[index] == Imi.SharedWithServer.Game.MatchState.Overtime)
              flag2 = true;
            if (this.isFirstPoint && this.newMatchStates[index] == Imi.SharedWithServer.Game.MatchState.GetReady)
              flag1 = true;
          }
          foreach (SkillGraph skillGraph in player.skillGraph.skillGraphs)
          {
            if (flag1)
              skillGraph.TriggerEvent(SkillGraphEvent.MatchStart);
            if (flag2)
              skillGraph.TriggerEvent(SkillGraphEvent.Overtime);
            if (flag3)
              skillGraph.TriggerEvent(SkillGraphEvent.MatchStateChanged);
            skillGraph.Tick(this.gameContext.globalTime.currentTick);
          }
        }
      }
      foreach (GameEntity player in this.players)
      {
        if (player.isLocalEntity)
        {
          foreach (SkillGraph skillGraph in player.skillGraph.skillGraphs)
            skillGraph.ProcessApplyStatusEffectQueue();
        }
      }
      this.newMatchStates.Clear();
      if (this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress || !this.isFirstPoint)
        return;
      this.isFirstPoint = false;
    }
  }
}
