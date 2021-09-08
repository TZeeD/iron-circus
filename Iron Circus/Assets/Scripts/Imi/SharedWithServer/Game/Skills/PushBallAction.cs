// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.PushBallAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class PushBallAction : SkillAction
  {
    public SkillVar<UniqueId> targetEntities;
    [SyncValue]
    public SyncableValue<JVector> force;

    protected override bool DoOnRepredict => true;

    protected override void PerformActionInternal()
    {
      GameContext context = this.skillGraph.GetContext();
      for (int i = 0; i < this.targetEntities.Length; ++i)
      {
        GameEntity entityWithUniqueId = context.GetFirstEntityWithUniqueId(this.targetEntities[i]);
        if (entityWithUniqueId.isBall && !entityWithUniqueId.hasBallOwner)
        {
          entityWithUniqueId.ReplaceBallImpulse((JVector) this.force);
          Events.Global.FireEventBumperBallCollision(this.skillGraph.GetOwner().uniqueId.id, entityWithUniqueId.transform.position, this.force.Get().Normalized());
        }
      }
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.force.Parse(serializationInfo, ref valueIndex, this.Name + ".force");

    public override void Serialize(byte[] target, ref int valueIndex) => this.force.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.force.Deserialize(target, ref valueIndex);
  }
}
