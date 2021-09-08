// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ModifyMovementAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.Utils.Extensions;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ModifyMovementAction : SkillAction
  {
    public ModifyMovementAction.ValueType type;
    [SyncValue]
    public SyncableValue<JVector> lookDir;
    [SyncValue]
    public SyncableValue<float> speed;
    [SyncValue]
    public SyncableValue<float> turnSpeed;

    protected override bool DoOnRepredict => true;

    protected override void PerformActionInternal()
    {
      GameEntity owner = this.skillGraph.GetOwner();
      switch (this.type)
      {
        case ModifyMovementAction.ValueType.SetVelocity:
          owner.AddMovementModifier(MovementModifier.SetVelocity(this.lookDir.Get() * this.speed.Get()));
          break;
        case ModifyMovementAction.ValueType.SetSpeed:
          JVector vector = owner.velocityOverride.value;
          JVector velocity = (vector.IsZero() ? owner.transform.Forward : vector.Normalized()) * this.speed.Get();
          owner.AddMovementModifier(MovementModifier.SetVelocity(velocity));
          break;
        case ModifyMovementAction.ValueType.SetLookDir:
          owner.TransformSetLookDir(this.lookDir.Get());
          break;
        case ModifyMovementAction.ValueType.TurnToward:
          JVector targetLookDir = this.lookDir.Get();
          JVector lookDir1 = this.skillGraph.GetLookDir();
          JVector lookDir2 = targetLookDir.IsNearlyZero() ? lookDir1 : lookDir1.RotateTowards(targetLookDir, this.turnSpeed.Get() * this.skillGraph.GetFixedTimeStep());
          owner.TransformSetLookDir(lookDir2);
          break;
      }
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.lookDir.Parse(serializationInfo, ref valueIndex, this.Name + ".lookDir");
      this.speed.Parse(serializationInfo, ref valueIndex, this.Name + ".speed");
      this.turnSpeed.Parse(serializationInfo, ref valueIndex, this.Name + ".turnSpeed");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.lookDir.Serialize(target, ref valueIndex);
      this.speed.Serialize(target, ref valueIndex);
      this.turnSpeed.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.lookDir.Deserialize(target, ref valueIndex);
      this.speed.Deserialize(target, ref valueIndex);
      this.turnSpeed.Deserialize(target, ref valueIndex);
    }

    public enum ValueType
    {
      SetVelocity,
      SetSpeed,
      SetLookDir,
      TurnToward,
    }
  }
}
