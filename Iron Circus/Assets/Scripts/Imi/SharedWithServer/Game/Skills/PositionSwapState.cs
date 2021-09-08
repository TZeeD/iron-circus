// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.PositionSwapState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class PositionSwapState : SkillState
  {
    public ConfigValue<float> duration;
    [SyncValue]
    public SyncableValue<JVector> startPos;
    [SyncValue]
    public SyncableValue<JVector> endPos;
    [SyncValue]
    public SyncableValue<UniqueId> movedEntityId;
    [SyncValue]
    private SyncableValue<float> timeSinceEnter;
    public Action<float> onUpdate;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.startPos.Parse(serializationInfo, ref valueIndex, this.Name + ".startPos");
      this.endPos.Parse(serializationInfo, ref valueIndex, this.Name + ".endPos");
      this.movedEntityId.Parse(serializationInfo, ref valueIndex, this.Name + ".movedEntityId");
      this.timeSinceEnter.Parse(serializationInfo, ref valueIndex, this.Name + ".timeSinceEnter");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.startPos.Serialize(target, ref valueIndex);
      this.endPos.Serialize(target, ref valueIndex);
      this.movedEntityId.Serialize(target, ref valueIndex);
      this.timeSinceEnter.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.startPos.Deserialize(target, ref valueIndex);
      this.endPos.Deserialize(target, ref valueIndex);
      this.movedEntityId.Deserialize(target, ref valueIndex);
      this.timeSinceEnter.Deserialize(target, ref valueIndex);
    }

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    private GameEntity GetGameEntity()
    {
      UniqueId uniqueId = this.movedEntityId.Get();
      return uniqueId == UniqueId.Invalid ? this.skillGraph.GetOwner() : this.skillGraph.GetEntity(uniqueId);
    }

    protected override void EnterDerived()
    {
      GameEntity gameEntity = this.GetGameEntity();
      this.timeSinceEnter.Set(0.0f);
      gameEntity.velocityOverride.value = JVector.Zero;
      gameEntity.rigidbody.value.LinearVelocity = JVector.Zero;
      gameEntity.AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Custom(this.skillGraph.GetOwnerId(), StatusModifier.BlockSkills | StatusModifier.BlockHoldBall, this.duration.Get()));
    }

    protected override void TickDerived()
    {
      this.timeSinceEnter.Set(this.timeSinceEnter.Get() + this.skillGraph.GetFixedTimeStep());
      GameEntity gameEntity = this.GetGameEntity();
      float num = Math.Min(1f, this.timeSinceEnter.Get() / this.duration.Get());
      JVector position = gameEntity.transform.position;
      JVector newPosition;
      if ((double) num < 0.25)
        newPosition = this.startPos.Get();
      else if ((double) num > 0.75)
      {
        newPosition = this.endPos.Get();
      }
      else
      {
        float t = (float) (((double) num - 0.25) / 0.5);
        newPosition = JVector.Lerp(this.startPos.Get(), this.endPos.Get(), t);
      }
      newPosition.Y = position.Y;
      gameEntity.TransformReplacePosition(newPosition);
      if (this.onUpdate != null)
        this.onUpdate(num);
      if ((double) num < 1.0)
        return;
      this.Exit_();
    }
  }
}
