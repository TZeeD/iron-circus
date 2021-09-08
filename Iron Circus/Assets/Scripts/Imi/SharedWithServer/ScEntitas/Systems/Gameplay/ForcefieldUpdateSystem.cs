// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.ForcefieldUpdateSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class ForcefieldUpdateSystem : ReactiveGameSystem
  {
    public ForcefieldUpdateSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.MatchState.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity)
    {
      if (!entity.hasMatchState)
        return false;
      return entity.matchState.value == Imi.SharedWithServer.Game.MatchState.StartPoint || entity.matchState.value == Imi.SharedWithServer.Game.MatchState.GetReady || entity.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress;
    }

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity entity in entities)
        this.UpdateForcefield(entity);
    }

    private void UpdateForcefield(GameEntity matchStateEntity)
    {
      GameEntity[] entities = this.gameContext.GetGroup(GameMatcher.Forcefield).GetEntities();
      if (matchStateEntity.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress)
      {
        foreach (GameEntity gameEntity in entities)
        {
          if (gameEntity.forcefield.deactivateDuringPoint)
            this.gameContext.gamePhysics.world.RemoveBody(gameEntity.rigidbody.value);
        }
      }
      else
      {
        foreach (GameEntity gameEntity in entities)
        {
          if (gameEntity.forcefield.deactivateDuringPoint)
            this.gameContext.gamePhysics.world.AddBody(gameEntity.rigidbody.value);
        }
      }
    }
  }
}
