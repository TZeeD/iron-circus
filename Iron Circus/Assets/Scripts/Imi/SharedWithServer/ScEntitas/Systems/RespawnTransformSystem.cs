// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.RespawnTransformSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class RespawnTransformSystem : ReactiveGameSystem
  {
    private readonly Events events;

    public RespawnTransformSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
    }

    protected override ICollector<GameEntity> GetTrigger(IContext<GameEntity> c) => c.CreateCollector<GameEntity>(GameMatcher.RespawnRigidbody);

    protected override bool Filter(GameEntity entity) => entity.hasRespawnRigidbody;

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity entity in entities)
      {
        JVector position = entity.respawnRigidbody.position;
        JQuaternion rotation = entity.respawnRigidbody.rotation;
        JMatrix fromQuaternion = JMatrix.CreateFromQuaternion(rotation);
        entity.RemoveRespawnRigidbody();
        entity.ReplaceTransform(position, rotation);
        if (entity.hasRigidbody)
        {
          entity.rigidbody.value.Position = position;
          entity.rigidbody.value.Orientation = fromQuaternion;
        }
        if (entity.hasVelocityOverride)
          entity.ReplaceVelocityOverride(JVector.Zero);
        JRigidbody jrigidbody = entity.rigidbody.value;
        if (this.gameContext.ballEntity.hasBallOwner && this.gameContext.ballEntity.ballOwner.IsOwner(entity))
          this.gameContext.ballEntity.RemoveBallOwner();
        if (entity.isPlayer)
          this.events.FireEventPlayerRespawn(entity.playerId.value, jrigidbody.Position, JQuaternion.CreateFromMatrix(jrigidbody.Orientation));
      }
    }
  }
}
