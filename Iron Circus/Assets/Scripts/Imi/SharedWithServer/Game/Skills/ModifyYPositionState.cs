// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ModifyYPositionState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ModifyYPositionState : SkillState
  {
    public ConfigValue<float> duration;
    [SyncValue]
    public SyncableValue<float> yOffset;
    public SyncableValue<UniqueId> movedEntityId;
    private SyncableValue<float> timeSinceEnter;
    public Action<float> onUpdate;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.yOffset.Parse(serializationInfo, ref valueIndex, this.Name + ".yOffset");

    public override void Serialize(byte[] target, ref int valueIndex) => this.yOffset.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.yOffset.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    private GameEntity GetGameEntity()
    {
      UniqueId uniqueId = this.movedEntityId.Get();
      return uniqueId == UniqueId.Invalid ? this.skillGraph.GetOwner() : this.skillGraph.GetEntity(uniqueId);
    }

    protected override void EnterDerived() => this.timeSinceEnter.Set(0.0f);

    protected override void TickDerived()
    {
      this.timeSinceEnter.Set(this.timeSinceEnter.Get() + this.skillGraph.GetFixedTimeStep());
      GameEntity gameEntity = this.GetGameEntity();
      float num1 = Math.Min(1f, this.timeSinceEnter.Get() / this.duration.Get());
      JVector position = gameEntity.transform.position;
      float num2 = this.yOffset.Get();
      if ((double) num2 != 0.0)
      {
        if ((double) num1 < 0.25)
        {
          float num3 = num1 / 0.25f;
          position.Y = num2 * num3;
        }
        else if ((double) num1 > 0.75)
        {
          float num4 = Math.Min(1f, (float) (1.0 - ((double) num1 - 0.75) / 0.25));
          position.Y = num2 * num4;
        }
        else
          position.Y = num2;
        gameEntity.TransformReplacePosition(position);
      }
      if (this.onUpdate != null)
        this.onUpdate(num1);
      if ((double) num1 < 1.0)
        return;
      this.Exit_();
    }
  }
}
