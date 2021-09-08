// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ApplySpeedModEffectAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ApplySpeedModEffectAction : SkillAction
  {
    public SkillVar<UniqueId> targetEntities;
    public Func<GameEntity, bool> filter;
    [SyncValue]
    public SyncableValue<ulong> targetPlayerId;
    [SyncValue]
    public SyncableValue<float> moveSpeedModifier;
    [SyncValue]
    public SyncableValue<float> duration;

    public ApplySpeedModEffectAction(SkillGraph skillGraph, string name)
      : base(skillGraph, name)
    {
    }

    public ApplySpeedModEffectAction()
    {
    }

    protected override void PerformActionInternal()
    {
      if (!this.skillGraph.IsServer())
        return;
      if (this.targetEntities != null)
      {
        for (int i = 0; i < this.targetEntities.Length; ++i)
        {
          GameEntity entity = this.skillGraph.GetEntity(this.targetEntities[i]);
          if (entity != null && (this.filter == null || this.filter(entity)))
            entity.AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.MovementSpeedChange(this.skillGraph.GetOwnerId(), this.moveSpeedModifier.Get(), this.duration.Get()));
        }
      }
      else
        this.skillGraph.GetPlayer(this.targetPlayerId.Get())?.AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.MovementSpeedChange(this.skillGraph.GetOwnerId(), this.moveSpeedModifier.Get(), this.duration.Get()));
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.targetPlayerId.Parse(serializationInfo, ref valueIndex, this.Name + ".targetPlayerId");
      this.moveSpeedModifier.Parse(serializationInfo, ref valueIndex, this.Name + ".moveSpeedModifier");
      this.duration.Parse(serializationInfo, ref valueIndex, this.Name + ".duration");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.targetPlayerId.Serialize(target, ref valueIndex);
      this.moveSpeedModifier.Serialize(target, ref valueIndex);
      this.duration.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.targetPlayerId.Deserialize(target, ref valueIndex);
      this.moveSpeedModifier.Deserialize(target, ref valueIndex);
      this.duration.Deserialize(target, ref valueIndex);
    }
  }
}
