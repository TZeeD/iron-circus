// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.GoalCollisionSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using SharedWithServer.ScEvents;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class GoalCollisionSystem : ExecuteGameSystem
  {
    private readonly Events events;

    public GoalCollisionSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
    }

    protected override void GameExecute()
    {
      if (this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress)
        return;
      foreach (JCollision jcollision in this.gameContext.collisionEvents.triggerEnter)
      {
        if (jcollision.entity1 != null && jcollision.entity2 != null)
        {
          GameEntity gameEntity;
          if (jcollision.entity1.isBall && jcollision.entity2.hasGoal)
            gameEntity = jcollision.entity2;
          else if (jcollision.entity2.isBall && jcollision.entity1.hasGoal)
            gameEntity = jcollision.entity1;
          else
            continue;
          GameEntity entity = this.gameContext.CreateEntity();
          entity.AddSomeoneScored(this.gameContext.lastBallContactEntity.lastBallContact.playerId, gameEntity.goal.team);
          GameEntity[] entities = this.gameContext.GetGroup(GameMatcher.Bumper).GetEntities();
          Log.Debug("Removing Bumpers from World.");
          UniqueId[] bumperIds = new UniqueId[entities.Length];
          for (int index = 0; index < entities.Length; ++index)
          {
            bumperIds[index] = entities[index].uniqueId.id;
            this.gameContext.gamePhysics.world.RemoveBody(entities[index].rigidbody.value);
          }
          this.events.FireEventBumperCollisionDisable(ref bumperIds);
          if (!this.gameContext.hasLastGoalScored)
            this.gameContext.SetLastGoalScored(entity.someoneScored.playerScored, entity.someoneScored.team);
          else
            this.gameContext.lastGoalScoredEntity.ReplaceLastGoalScored(entity.someoneScored.playerScored, entity.someoneScored.team);
        }
      }
    }
  }
}
