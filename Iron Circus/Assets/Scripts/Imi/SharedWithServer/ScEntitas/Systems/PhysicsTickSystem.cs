// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.PhysicsTickSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.Utils;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class PhysicsTickSystem : ExecuteGameSystem
  {
    private PhysicsEngineConfig physicsConfig;
    private readonly IGroup<GameEntity> velocities;
    private IGroup<GameEntity> entities;

    public PhysicsTickSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.entities = this.gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.Rigidbody, GameMatcher.Transform));
      this.velocities = this.gameContext.GetGroup(GameMatcher.VelocityOverride);
      this.physicsConfig = entitasSetup.ConfigProvider.physicsEngineConfig;
    }

    protected override void GameExecute()
    {
      float num = this.physicsConfig.minVelocity * this.physicsConfig.minVelocity;
      foreach (GameEntity velocity in this.velocities)
      {
        if (!velocity.rigidbody.value.IsStatic)
        {
          if ((double) velocity.velocityOverride.value.LengthSquared() < (double) num)
            velocity.velocityOverride.value = JVector.Zero;
          JVector jvector = velocity.velocityOverride.value;
          if (velocity.hasMovement)
          {
            List<MovementModifier> modifier = velocity.movement.modifier;
            for (int index = 0; index < modifier.Count; ++index)
            {
              MovementModifier movementModifier = modifier[index];
              if (movementModifier.type == MovementModifierType.AddVelocity)
                jvector += movementModifier.velocity;
            }
          }
          velocity.rigidbody.value.LinearVelocity = jvector;
        }
      }
      foreach (GameEntity entity in this.entities)
      {
        JRigidbody jrigidbody = entity.rigidbody.value;
        if (!jrigidbody.IsStatic)
        {
          jrigidbody.AngularVelocity = JVector.Zero;
          JVector pos = entity.transform.position - entity.rigidbody.offset;
          jrigidbody.SetPositionAndRotation(pos, entity.transform.rotation);
        }
      }
      float timestep = this.gameContext.globalTime.fixedSimTimeStep / 2f;
      this.gameContext.gamePhysics.world.Step(timestep, false);
      this.gameContext.gamePhysics.world.Step(timestep, false);
      foreach (GameEntity entity in this.entities)
      {
        JRigidbody jrigidbody = entity.rigidbody.value;
        if (!jrigidbody.IsStatic)
        {
          JVector jvector = jrigidbody.Position.QuantizeVectorMM();
          entity.TransformReplacePosition(jvector + entity.rigidbody.offset);
          if (entity.hasVelocityOverride)
            entity.rigidbody.value.LinearVelocity = entity.velocityOverride.value;
          if (entity.hasMovement)
            entity.movement.modifier.Clear();
        }
      }
      CollisionUtils.SetDeferredCollisionsActive(this.gameContext);
    }
  }
}
