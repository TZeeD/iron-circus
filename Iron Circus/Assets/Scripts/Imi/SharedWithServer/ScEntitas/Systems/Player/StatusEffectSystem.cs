// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Player.StatusEffectSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Utils.Extensions;
using Imi.Utils;
using Jitter.LinearMath;
using SharedWithServer.ScEntitas.Systems.Gameplay;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems.Player
{
  public class StatusEffectSystem : ExecuteGameSystem
  {
    private IGroup<GameEntity> entitiesWithStatusEffect;

    public StatusEffectSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.entitiesWithStatusEffect = this.gameContext.GetGroup(GameMatcher.StatusEffect);
    }

    protected override void GameExecute()
    {
      foreach (GameEntity champion in this.entitiesWithStatusEffect)
      {
        if (champion.isLocalEntity)
        {
          List<StatusEffect> effects = champion.statusEffect.effects;
          for (int index = effects.Count - 1; index >= 0; --index)
          {
            StatusEffect effect = effects[index];
            this.Update(champion, ref effect, this.gameContext.globalTime.fixedSimTimeStep);
            if (effect.isDone.Get())
            {
              this.OnDone(champion, ref effect);
              effects.RemoveAt(index);
            }
          }
          champion.statusEffect.UpdateModifierStack();
          int currentTick = this.gameContext.globalTime.currentTick;
          if (champion.hasSkillGraph)
          {
            StatusEffectType statusEffect = StatusEffectType.None;
            if (champion.statusEffect.WasAdded(currentTick, StatusEffectType.Dead))
              statusEffect |= StatusEffectType.Dead;
            if (champion.statusEffect.WasAdded(currentTick, StatusEffectType.Stun))
              statusEffect |= StatusEffectType.Stun;
            if (champion.statusEffect.WasAdded(currentTick, StatusEffectType.Push))
              statusEffect |= StatusEffectType.Push;
            if (champion.statusEffect.WasAdded(currentTick, StatusEffectType.Scrambled))
              statusEffect |= StatusEffectType.Scrambled;
            if (champion.statusEffect.WasAdded(currentTick, StatusEffectType.Custom))
              statusEffect |= StatusEffectType.Custom;
            foreach (SkillGraph skillGraph in champion.skillGraph.skillGraphs)
              skillGraph.OnStatusEffectsAdded(statusEffect);
          }
        }
      }
    }

    public static void Initialize(GameEntity champion, ref StatusEffect effect, int startTick)
    {
      effect.appliedInTick = (SyncableValue<int>) startTick;
      switch (effect.type.Get())
      {
        case StatusEffectType.Custom:
        case StatusEffectType.DamageOverTime:
          break;
        case StatusEffectType.Push:
          break;
        case StatusEffectType.Stun:
          break;
        case StatusEffectType.Invisible:
          break;
        case StatusEffectType.ModMoveSpeed:
          break;
        case StatusEffectType.Dead:
          break;
        case StatusEffectType.Scrambled:
          break;
        default:
          throw new Exception(string.Format("ChampionStatus '{0}' not implemented in StatusEffect.Initialize()", (object) effect.type));
      }
    }

    public void Update(GameEntity champion, ref StatusEffect effect, float deltaT)
    {
      float num1 = (float) (this.gameContext.globalTime.currentTick - effect.appliedInTick.Get()) * deltaT;
      switch (effect.type.Get())
      {
        case StatusEffectType.Custom:
        case StatusEffectType.Stun:
        case StatusEffectType.ModMoveSpeed:
        case StatusEffectType.Scrambled:
          if ((double) effect.duration.Get() > 0.0)
            effect.isDone = (SyncableValue<bool>) ((double) num1 >= (double) effect.duration.Get() || effect.isDone.Get());
          if (effect.HasDoneCondition)
          {
            effect.isDone = (SyncableValue<bool>) (effect.EvalDoneCondition(this.gameContext) || effect.isDone.Get());
            break;
          }
          if ((double) effect.duration.Get() != 0.0)
            break;
          Log.Error(string.Format("There is a status effect we can't remove. Type: {0}, Effects: {1}", (object) effect.type.Get(), (object) effect.modifierStack.Get()));
          break;
        case StatusEffectType.Push:
          champion.ReplaceVelocityOverride(JVector.Zero);
          float t = num1 / effect.duration.Get();
          float v0 = 0.9f;
          float num2 = 1f + MathExtensions.Interpolate(v0, -v0, t);
          float length = effect.floatValue.Get() * (deltaT / effect.duration.Get()) * num2;
          JVector direction = effect.vectorValue.Get().Normalized();
          JVector position = champion.transform.position;
          int collisionMask = 3331;
          SphereCastResult sphereCastResult = ContinuousPhysicsUtils.SphereCast(this.gameContext, position, direction, length, champion.championConfig.value.colliderRadius, champion.rigidbody.value.CollisionLayer, collisionMask);
          if (sphereCastResult.collided)
            champion.TransformReplacePosition(sphereCastResult.contactPosition);
          JVector jvector = ContinuousPhysicsUtils.GlideAgainstObjects(this.gameContext, champion, direction * length, collisionMask);
          champion.TransformReplacePosition(champion.transform.position + jvector);
          goto case StatusEffectType.Custom;
        case StatusEffectType.Invisible:
          effect.isDone = (SyncableValue<bool>) (champion.IsStunned() || champion.IsDead() || champion.IsPushed());
          goto case StatusEffectType.Custom;
        case StatusEffectType.Dead:
          if ((double) num1 / (double) effect.duration.Get() > 0.5)
          {
            SpawnPointUtils.ResetPlayer(this.gameContext, champion);
            goto case StatusEffectType.Custom;
          }
          else
            goto case StatusEffectType.Custom;
        default:
          throw new Exception(string.Format("ChampionStatus '{0}' not implemented in StatusEffect.Update()", (object) effect.type.Get()));
      }
    }

    public void OnDone(GameEntity champion, ref StatusEffect effect)
    {
      switch (effect.type.Get())
      {
        case StatusEffectType.Custom:
          break;
        case StatusEffectType.Push:
          break;
        case StatusEffectType.Stun:
          break;
        case StatusEffectType.Invisible:
          break;
        case StatusEffectType.ModMoveSpeed:
          break;
        case StatusEffectType.Dead:
          champion.isPlayerRespawning = true;
          break;
        case StatusEffectType.Scrambled:
          break;
        default:
          throw new Exception(string.Format("ChampionStatus '{0}' not implemented in StatusEffect.OnDone()", (object) effect.type.Get()));
      }
    }
  }
}
