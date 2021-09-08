// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.StatusEffect
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas;
using Imi.Utils.Extensions;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game
{
  public class StatusEffect : IEquatable<StatusEffect>, ISerDesAble
  {
    public SyncableValue<int> appliedInTick;
    public SyncableValue<ulong> instigatorPlayerId;
    public SyncableValue<StatusEffectType> type;
    public SyncableValue<StatusModifier> modifierStack;
    public SyncableValue<float> duration;
    public SyncableValue<int> intValue;
    public SyncableValue<float> floatValue;
    public SyncableValue<JVector> vectorValue;
    public SyncableValue<bool> isDone;
    public SyncableValue<UniqueId> doneConditionVarOwner = (SyncableValue<UniqueId>) UniqueId.Invalid;
    public SyncableValue<byte> doneConditionSMIndex = (SyncableValue<byte>) byte.MaxValue;
    public SyncableValue<byte> doneConditionVarIndex = (SyncableValue<byte>) byte.MaxValue;

    public override string ToString() => string.Format("{0}, t: {1}, d: {2}", (object) this.type.Get(), (object) this.appliedInTick.Get(), (object) this.duration.Get());

    public static bool IsDurationOver(StatusEffect effect, int currentTick, float fixedDeltaT)
    {
      int num = (int) ((double) (float) effect.duration / (double) fixedDeltaT);
      return (double) (float) effect.duration > 0.0 && (int) effect.appliedInTick + num >= currentTick;
    }

    public StatusEffect(StatusEffect other)
    {
      this.appliedInTick = other.appliedInTick;
      this.instigatorPlayerId = other.instigatorPlayerId;
      this.type = other.type;
      this.modifierStack = other.modifierStack;
      this.duration = other.duration;
      this.intValue = other.intValue;
      this.floatValue = other.floatValue;
      this.vectorValue = other.vectorValue;
      this.isDone = other.isDone;
      this.doneConditionVarOwner = other.doneConditionVarOwner;
      this.doneConditionSMIndex = other.doneConditionSMIndex;
      this.doneConditionVarIndex = other.doneConditionVarIndex;
    }

    private StatusEffect()
    {
    }

    public bool HasDoneCondition => this.doneConditionVarOwner.Get() != UniqueId.Invalid && this.doneConditionVarIndex.Get() != byte.MaxValue && this.doneConditionSMIndex.Get() != byte.MaxValue;

    public bool EvalDoneCondition(GameContext gameContext)
    {
      GameEntity entityWithUniqueId = gameContext.GetFirstEntityWithUniqueId(this.doneConditionVarOwner.Get());
      SkillGraph[] skillStateMachines = entityWithUniqueId.GetAllSkillStateMachines();
      byte num = this.doneConditionSMIndex.Get();
      return ((SkillVar<bool>) (num != byte.MaxValue ? skillStateMachines[(int) num].skillVars : entityWithUniqueId.skillGraph.ownerVars.skillVars)[(int) this.doneConditionVarIndex.Get()]).Get();
    }

    public static StatusEffect MovementSpeedChange(
      ulong instigatorPlayerId,
      float offset,
      float duration,
      SkillVar<bool> doneCondition = null)
    {
      return new StatusEffect()
      {
        instigatorPlayerId = (SyncableValue<ulong>) instigatorPlayerId,
        type = (SyncableValue<StatusEffectType>) StatusEffectType.ModMoveSpeed,
        floatValue = (SyncableValue<float>) offset,
        duration = (SyncableValue<float>) duration,
        doneConditionVarOwner = (SyncableValue<UniqueId>) (doneCondition != null ? doneCondition.OwnerId : UniqueId.Invalid),
        doneConditionSMIndex = (SyncableValue<byte>) (doneCondition != null ? doneCondition.StateMachineIndex : byte.MaxValue),
        doneConditionVarIndex = (SyncableValue<byte>) (doneCondition != null ? doneCondition.VarIndex : byte.MaxValue),
        modifierStack = (SyncableValue<StatusModifier>) StatusModifier.SpeedMod
      };
    }

    public static StatusEffect DamageOverTime(
      ulong instigatorPlayerId,
      float dmgPerSecond,
      float duration)
    {
      return new StatusEffect()
      {
        instigatorPlayerId = (SyncableValue<ulong>) instigatorPlayerId,
        type = (SyncableValue<StatusEffectType>) StatusEffectType.DamageOverTime,
        floatValue = (SyncableValue<float>) dmgPerSecond,
        duration = (SyncableValue<float>) duration,
        modifierStack = (SyncableValue<StatusModifier>) StatusModifier.DamageOverTime
      };
    }

    public static StatusEffect Push(
      ulong instigatorPlayerId,
      JVector direction,
      float distance,
      float duration)
    {
      return new StatusEffect()
      {
        instigatorPlayerId = (SyncableValue<ulong>) instigatorPlayerId,
        type = (SyncableValue<StatusEffectType>) StatusEffectType.Push,
        vectorValue = (SyncableValue<JVector>) direction,
        floatValue = (SyncableValue<float>) distance,
        duration = (SyncableValue<float>) duration,
        modifierStack = (SyncableValue<StatusModifier>) (StatusModifier.BlockMove | StatusModifier.BlockSkills | StatusModifier.BlockHoldBall)
      };
    }

    public static StatusEffect Stun(ulong instigatorPlayerId, float duration) => new StatusEffect()
    {
      instigatorPlayerId = (SyncableValue<ulong>) instigatorPlayerId,
      type = (SyncableValue<StatusEffectType>) StatusEffectType.Stun,
      duration = (SyncableValue<float>) duration,
      modifierStack = (SyncableValue<StatusModifier>) (StatusModifier.BlockMove | StatusModifier.BlockSkills | StatusModifier.BlockHoldBall)
    };

    public static StatusEffect Dead(ulong instigatorPlayerId, float duration) => new StatusEffect()
    {
      instigatorPlayerId = (SyncableValue<ulong>) instigatorPlayerId,
      type = (SyncableValue<StatusEffectType>) StatusEffectType.Dead,
      duration = (SyncableValue<float>) duration,
      modifierStack = (SyncableValue<StatusModifier>) (StatusModifier.BlockMove | StatusModifier.BlockSkills | StatusModifier.BlockHoldBall)
    };

    public static StatusEffect Invisible(float duration, SkillVar<bool> doneCondition = null) => new StatusEffect()
    {
      type = (SyncableValue<StatusEffectType>) StatusEffectType.Invisible,
      duration = (SyncableValue<float>) duration,
      doneConditionVarOwner = (SyncableValue<UniqueId>) (doneCondition != null ? doneCondition.OwnerId : UniqueId.Invalid),
      doneConditionSMIndex = (SyncableValue<byte>) (doneCondition != null ? doneCondition.StateMachineIndex : byte.MaxValue),
      doneConditionVarIndex = (SyncableValue<byte>) (doneCondition != null ? doneCondition.VarIndex : byte.MaxValue),
      modifierStack = (SyncableValue<StatusModifier>) (StatusModifier.ImmuneToTackle | StatusModifier.Invisible)
    };

    public static StatusEffect Scramble(ulong instigatorPlayerId, float duration) => new StatusEffect()
    {
      instigatorPlayerId = (SyncableValue<ulong>) instigatorPlayerId,
      type = (SyncableValue<StatusEffectType>) StatusEffectType.Scrambled,
      duration = (SyncableValue<float>) duration,
      modifierStack = (SyncableValue<StatusModifier>) StatusModifier.BlockSkills
    };

    public static StatusEffect Custom(
      ulong instigator,
      StatusModifier modifier,
      float duration,
      SkillVar<bool> doneCondition = null)
    {
      return new StatusEffect()
      {
        instigatorPlayerId = (SyncableValue<ulong>) instigator,
        type = (SyncableValue<StatusEffectType>) StatusEffectType.Custom,
        duration = (SyncableValue<float>) duration,
        doneConditionVarOwner = (SyncableValue<UniqueId>) (doneCondition != null ? doneCondition.OwnerId : UniqueId.Invalid),
        doneConditionSMIndex = (SyncableValue<byte>) (doneCondition != null ? doneCondition.StateMachineIndex : byte.MaxValue),
        doneConditionVarIndex = (SyncableValue<byte>) (doneCondition != null ? doneCondition.VarIndex : byte.MaxValue),
        modifierStack = (SyncableValue<StatusModifier>) modifier
      };
    }

    public void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      this.appliedInTick.SerializeOrDeserialize(messageSerDes);
      this.instigatorPlayerId.SerializeOrDeserialize(messageSerDes);
      this.type.SerializeOrDeserialize(messageSerDes);
      this.modifierStack.SerializeOrDeserialize(messageSerDes);
      this.duration.SerializeOrDeserialize(messageSerDes);
      this.intValue.SerializeOrDeserialize(messageSerDes);
      this.floatValue.SerializeOrDeserialize(messageSerDes);
      this.vectorValue.SerializeOrDeserialize(messageSerDes);
      this.isDone.SerializeOrDeserialize(messageSerDes);
      this.doneConditionVarOwner.SerializeOrDeserialize(messageSerDes);
      this.doneConditionSMIndex.SerializeOrDeserialize(messageSerDes);
      this.doneConditionVarIndex.SerializeOrDeserialize(messageSerDes);
    }

    public static StatusEffect Deserialize(IMessageSerDes messageSerDes)
    {
      StatusEffect statusEffect = new StatusEffect();
      statusEffect.SerializeOrDeserialize(messageSerDes);
      return statusEffect;
    }

    public bool Equals(StatusEffect other)
    {
      if (other == null)
        return false;
      if (this == other)
        return true;
      return this.appliedInTick == other.appliedInTick && this.instigatorPlayerId == other.instigatorPlayerId && this.type == other.type && this.modifierStack == other.modifierStack && this.duration.Equals((object) other.duration) && this.intValue == other.intValue && this.floatValue.Equals((object) other.floatValue) && this.vectorValue.Equals((object) other.vectorValue) && this.isDone.Equals((object) other.isDone) && this.doneConditionVarOwner == other.doneConditionVarOwner && this.doneConditionSMIndex == other.doneConditionSMIndex && this.doneConditionVarIndex == other.doneConditionVarIndex;
    }

    public override bool Equals(object obj)
    {
      if (obj == null)
        return false;
      if (this == obj)
        return true;
      return !(obj.GetType() != this.GetType()) && this.Equals((StatusEffect) obj);
    }

    public override int GetHashCode() => ((((int) ((StatusModifier) ((int) ((StatusEffectType) ((this.appliedInTick.Get() * 397 ^ this.instigatorPlayerId.Get().GetHashCode()) * 397) ^ this.type.Get()) * 397) ^ this.modifierStack.Get()) * 397 ^ this.duration.Get().GetHashCode()) * 397 ^ this.intValue.Get()) * 397 ^ this.floatValue.Get().GetHashCode()) * 397 ^ this.vectorValue.Get().GetHashCode();

    public static bool HasChanged(
      StatusEffectType test,
      StatusEffectType prev,
      StatusEffectType current)
    {
      return StatusEffect.IsSet(test, prev) != StatusEffect.IsSet(test, current);
    }

    public static bool IsSet(StatusEffectType mask, StatusEffectType current) => (current & mask) > StatusEffectType.None;

    public bool IsModifierSet(StatusModifier mask) => (this.modifierStack.Get() & mask) > StatusModifier.None;

    public static void CalcModifierStack(
      IEnumerable<StatusEffect> effects,
      out StatusEffectType effectStack,
      out StatusModifier modifierStack)
    {
      StatusEffectType statusEffectType = StatusEffectType.None;
      StatusModifier statusModifier = StatusModifier.None;
      foreach (StatusEffect effect in effects)
      {
        statusModifier |= effect.modifierStack.Get();
        statusEffectType |= effect.type.Get();
      }
      modifierStack = statusModifier;
      effectStack = statusEffectType;
    }
  }
}
