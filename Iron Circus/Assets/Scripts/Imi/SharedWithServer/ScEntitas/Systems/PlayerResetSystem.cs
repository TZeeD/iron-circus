// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.PlayerResetSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Game;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class PlayerResetSystem : ReactiveGameSystem
  {
    public PlayerResetSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.PlayerRespawning.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity) => entity.isPlayerRespawning;

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity entity in entities)
      {
        entity.rigidbody.value.IsActive = true;
        this.gameContext.gamePhysics.world.AddBody(entity.rigidbody.value);
        entity.ReplaceVelocityOverride(JVector.Zero);
        entity.isPlayerRespawning = false;
        if (entity.hasDeath)
          entity.RemoveDeath();
        entity.AddStatusEffect(this.gameContext, StatusEffect.Custom(entity.playerId.value, StatusModifier.BlockMove, 1f));
      }
    }
  }
}
