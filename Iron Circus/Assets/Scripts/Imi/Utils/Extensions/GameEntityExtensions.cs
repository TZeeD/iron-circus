// Decompiled with JetBrains decompiler
// Type: Imi.Utils.Extensions.GameEntityExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.Utils;
using Jitter.LinearMath;

namespace Imi.Utils.Extensions
{
  public static class GameEntityExtensions
  {
    public static TransformState ToTransformState(this GameEntity entity)
    {
      TransformState target = new TransformState();
      entity.ToTransformState(ref target);
      return target;
    }

    public static void ToTransformState(this GameEntity entity, ref TransformState target)
    {
      target.position = entity.transform.position.QuantizeVectorMM();
      target.velocity = entity.velocityOverride.value.QuantizeVectorMM();
      target.rotation = entity.transform.rotation;
    }

    public static void SetTransformState(this GameEntity entity, TransformState state)
    {
      JMatrix fromQuaternion = JMatrix.CreateFromQuaternion(state.rotation);
      entity.rigidbody.value.LinearVelocity = state.velocity;
      entity.rigidbody.value.Position = state.position;
      entity.rigidbody.value.Orientation = fromQuaternion;
      entity.ReplaceTransform(state.position, state.rotation);
      entity.velocityOverride.value = state.velocity;
    }

    public static SkillGraph[] GetAllSkillStateMachines(this GameEntity playerEntity) => playerEntity.hasSkillGraph ? playerEntity.skillGraph.skillGraphs : (SkillGraph[]) null;

    public static SkillGraphConfig[] GetAllSkillConfigs(this GameEntity playerEntity) => playerEntity.hasSkillGraph ? playerEntity.skillGraph.skillGraphConfigs : (SkillGraphConfig[]) null;

    public static SerializedSkillGraphInfo[] GetAllSkillSerializationLayouts(
      this GameEntity playerEntity)
    {
      return playerEntity.hasSkillGraph ? playerEntity.skillGraph.serializationLayout : (SerializedSkillGraphInfo[]) null;
    }

    public static void SetStatusEffectStates(
      this GameEntity playerEntity,
      SerializedStatusEffects state)
    {
      playerEntity.statusEffect.effects = state.ToList();
      playerEntity.statusEffect.UpdateModifierStack();
    }

    public static void SetAnimationStates(this GameEntity playerEntity, AnimationStates state) => state.ApplyTo(playerEntity.animationState);

    public static bool IsBallOwner(this GameEntity entity, GameContext gameContext) => gameContext.ballEntity.hasBallOwner && gameContext.ballEntity.ballOwner.IsOwner(entity);

    public static void AddMovementModifier(this GameEntity entity, MovementModifier modifier)
    {
      if (entity.hasMovement)
      {
        if (modifier.type == MovementModifierType.OverrideMovement)
        {
          for (int index = 0; index < entity.movement.modifier.Count; ++index)
          {
            if (entity.movement.modifier[index].type == MovementModifierType.OverrideMovement)
            {
              Log.Error(string.Format("Entity {0} already has MovementModifierType.OverrideMovement modifier!", (object) entity));
              return;
            }
          }
        }
        if (modifier.type == MovementModifierType.SetVelocity)
        {
          for (int index = entity.movement.modifier.Count - 1; index >= 0; --index)
          {
            if (entity.movement.modifier[index].type == MovementModifierType.SetVelocity)
            {
              Log.Error(string.Format("Entity {0} already has MovementModifierType.SetVelocity modifier! Overriding!", (object) entity));
              entity.movement.modifier.RemoveAt(index);
            }
          }
        }
        entity.movement.modifier.Add(modifier);
      }
      else
        Log.Error("Tried to assign a movement modifier to an entity without MovementComponent!");
    }
  }
}
