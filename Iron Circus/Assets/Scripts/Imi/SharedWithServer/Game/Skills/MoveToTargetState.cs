// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.MoveToTargetState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class MoveToTargetState : SkillState
  {
    [SyncValue]
    public SyncableValue<JVector> targetPos;
    [SyncValue]
    public SyncableValue<float> speed;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.targetPos.Parse(serializationInfo, ref valueIndex, this.Name + ".targetPos");
      this.speed.Parse(serializationInfo, ref valueIndex, this.Name + ".speed");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.targetPos.Serialize(target, ref valueIndex);
      this.speed.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.targetPos.Deserialize(target, ref valueIndex);
      this.speed.Deserialize(target, ref valueIndex);
    }

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickOnlyLocalEntity;

    protected override void TickDerived()
    {
      GameEntity owner = this.skillGraph.GetOwner();
      JVector position = owner.transform.position;
      JVector vector = this.targetPos.Get() - position;
      JVector jvector = vector.Normalized() * (this.speed.Get() * this.skillGraph.GetFixedTimeStep());
      if ((double) jvector.LengthSquared() > (double) vector.LengthSquared())
      {
        JVector newPosition = this.targetPos.Get();
        owner.TransformReplacePosition(newPosition);
        this.Exit_();
      }
      else
      {
        JVector newPosition = position + jvector;
        owner.TransformReplacePosition(newPosition);
      }
    }
  }
}
