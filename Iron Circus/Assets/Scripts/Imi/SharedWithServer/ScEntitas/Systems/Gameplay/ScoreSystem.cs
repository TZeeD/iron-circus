// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.ScoreSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using SharedWithServer.ScEvents;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class ScoreSystem : ReactiveGameSystem, ICleanupSystem, ISystem
  {
    private readonly Events events;

    public ScoreSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.SomeoneScored.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity) => entity.hasSomeoneScored || entity.hasMatchStateTransitionEvent;

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity entity1 in entities)
      {
        if (entity1.hasSomeoneScored)
        {
          ScoreComponent score = this.gameContext.score;
          Team team = entity1.someoneScored.team;
          GameEntity entityWithPlayerId = this.gameContext.GetFirstEntityWithPlayerId(entity1.someoneScored.playerScored);
          bool ownGoal = entityWithPlayerId.playerTeam.value != team;
          GameEntity gameEntity1 = (GameEntity) null;
          score.score[team]++;
          this.gameContext.ReplaceScore(team, entity1.someoneScored.playerScored, score.score);
          this.gameContext.ReplaceMatchStateTransitionEvent(TransitionEvent.GoalShot);
          this.events.FireEventNewScore(team, ref score.score, entity1.someoneScored.playerScored);
          foreach (GameEntity entity2 in this.gameContext.GetGroup(GameMatcher.Goal).GetEntities())
          {
            if (entity2.goal.team == team)
              gameEntity1 = entity2;
          }
          float distanceToGoal = (float) Math.Round((double) entityWithPlayerId.transform.Distance2D(gameEntity1.rigidbody.value.Position) * 100.0) / 100f;
          HashSet<GameEntity> entitiesWithPlayerTeam = this.gameContext.GetEntitiesWithPlayerTeam(team.GetOpponents());
          bool someoneDeadOpponents = false;
          foreach (GameEntity gameEntity2 in entitiesWithPlayerTeam)
          {
            if (gameEntity2.IsDead())
              someoneDeadOpponents = true;
          }
          this.gameContext.eventDispatcher.value.EnqueueScoreEvent(entity1.someoneScored.playerScored, team, this.gameContext.ballEntity.hasBallOwner, ownGoal, distanceToGoal, someoneDeadOpponents);
        }
      }
      foreach (GameEntity entity in entities)
      {
        if (entity.hasSomeoneScored)
          entity.Destroy();
      }
    }

    public void Cleanup()
    {
    }
  }
}
