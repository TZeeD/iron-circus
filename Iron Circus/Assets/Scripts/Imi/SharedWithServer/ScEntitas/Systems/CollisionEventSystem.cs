// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.CollisionEventSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Jitter.Collision;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class CollisionEventSystem : ReactiveGameSystem
  {
    public CollisionEventSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
    }

    protected override ICollector<GameEntity> GetTrigger(IContext<GameEntity> c) => c.CreateCollector<GameEntity>(GameMatcher.GamePhysics.Added<GameEntity>());

    protected override bool Filter(GameEntity entity) => entity.hasGamePhysics;

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity entity in entities)
      {
        entity.gamePhysics.world.RigidbodyCollisionDetected += new CollisionDetectedHandler(this.OnCollisionDetected);
        entity.gamePhysics.world.TriggerCollisionDetected += new CollisionDetectedHandler(this.OnTriggerDetected);
      }
    }

    private void OnTriggerDetected(
      JRigidbody body1,
      JRigidbody body2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      CollisionUtils.CreateTriggerEvent(this.gameContext, body1, body2, point1, point2, normal, penetration);
    }

    private void OnCollisionDetected(
      JRigidbody body1,
      JRigidbody body2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      CollisionUtils.CreateCollisionEvent(this.gameContext, body1, body2, point1, point2, normal, penetration);
    }
  }
}
