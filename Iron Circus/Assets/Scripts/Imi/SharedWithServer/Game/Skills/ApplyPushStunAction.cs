// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ApplyPushStunAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ApplyPushStunAction : SkillAction
  {
    public SkillVar<UniqueId> targetEntities;
    [SyncValue]
    public SyncableValue<ulong> targetPlayerId;
    [SyncValue]
    public SyncableValue<float> stunDuration;
    [SyncValue]
    public SyncableValue<float> pushDuration;
    [SyncValue]
    public SyncableValue<float> pushDistance;
    [SyncValue]
    public SyncableValue<JVector> pushVector;
    public bool singleTarget;
    public Func<GameEntity, JVector> getPushDir;

    protected override void PerformActionInternal()
    {
      if (!this.skillGraph.IsServer())
        return;
      if (this.targetEntities != null)
      {
        for (int i = 0; i < this.targetEntities.Length; ++i)
        {
          GameEntity entityWithUniqueId = this.skillGraph.GetContext().GetFirstEntityWithUniqueId(this.targetEntities[i]);
          if (entityWithUniqueId != null && entityWithUniqueId.hasStatusEffect)
          {
            ulong ownerId = this.skillGraph.GetOwnerId();
            float duration1 = this.stunDuration.Get();
            if ((double) duration1 > 1.40129846432482E-45)
              entityWithUniqueId.AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Stun(ownerId, duration1));
            float duration2 = this.pushDuration.Get();
            JVector direction = this.pushVector.Get();
            if (this.getPushDir != null)
              direction = this.getPushDir(entityWithUniqueId);
            if ((double) duration2 > 1.40129846432482E-45 && !direction.IsNearlyZero())
            {
              float distance = this.pushDistance.Get();
              if ((double) distance <= 1.40129846432482E-45)
                distance = direction.Length();
              direction.Normalize();
              this.skillGraph.QueueApplyStatusEffect(entityWithUniqueId, StatusEffect.Push(ownerId, direction, distance, duration2));
            }
            if (this.singleTarget)
              break;
          }
        }
      }
      else
      {
        GameEntity player = this.skillGraph.GetPlayer(this.targetPlayerId.Get());
        if (player == null)
          return;
        ulong ownerId = this.skillGraph.GetOwnerId();
        float duration3 = this.stunDuration.Get();
        if ((double) duration3 > 1.40129846432482E-45)
          player.AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Stun(ownerId, duration3));
        float duration4 = this.pushDuration.Get();
        if ((double) duration4 <= 1.40129846432482E-45)
          return;
        JVector direction = this.pushVector.Get();
        if (direction.IsNearlyZero())
          return;
        float distance = direction.Length();
        direction.Normalize();
        this.skillGraph.QueueApplyStatusEffect(player, StatusEffect.Push(ownerId, direction, distance, duration4));
      }
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.targetPlayerId.Parse(serializationInfo, ref valueIndex, this.Name + ".targetPlayerId");
      this.stunDuration.Parse(serializationInfo, ref valueIndex, this.Name + ".stunDuration");
      this.pushDuration.Parse(serializationInfo, ref valueIndex, this.Name + ".pushDuration");
      this.pushDistance.Parse(serializationInfo, ref valueIndex, this.Name + ".pushDistance");
      this.pushVector.Parse(serializationInfo, ref valueIndex, this.Name + ".pushVector");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.targetPlayerId.Serialize(target, ref valueIndex);
      this.stunDuration.Serialize(target, ref valueIndex);
      this.pushDuration.Serialize(target, ref valueIndex);
      this.pushDistance.Serialize(target, ref valueIndex);
      this.pushVector.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.targetPlayerId.Deserialize(target, ref valueIndex);
      this.stunDuration.Deserialize(target, ref valueIndex);
      this.pushDuration.Deserialize(target, ref valueIndex);
      this.pushDistance.Deserialize(target, ref valueIndex);
      this.pushVector.Deserialize(target, ref valueIndex);
    }
  }
}
