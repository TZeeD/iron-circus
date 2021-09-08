// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ShootBallAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ShootBallAction : SkillAction
  {
    public ConfigValue<float> ballHitVelocityMin;
    public ConfigValue<float> ballHitVelocityMax;
    [SyncValue]
    public SyncableValue<float> normalizedStrength;
    public SkillVar<JVector> throwDirVar;

    protected override bool DoOnRepredict => true;

    public ShootBallAction(SkillGraph skillGraph, string name = "unnamed")
      : base(skillGraph, name)
    {
    }

    protected override void PerformActionInternal()
    {
      GameEntity owner = this.skillGraph.GetOwner();
      GameContext context = this.skillGraph.GetContext();
      GameEntity ballEntity = context.ballEntity;
      if (!ballEntity.hasBallOwner)
        Log.Debug(string.Format("{0} [{1}] BALL HAS NO OWNER", context.globalTime.isReprediction ? (object) "X" : (object) "", (object) context.globalTime.currentTick));
      else if ((long) ballEntity.ballOwner.playerId != (long) owner.playerId.value)
      {
        Log.Debug(string.Format("{0} [{1}] BALL IS NOT OWNED BY THIS PLAYER", context.globalTime.isReprediction ? (object) "X" : (object) "", (object) context.globalTime.currentTick));
      }
      else
      {
        JVector aimInputOrLookDir = this.skillGraph.GetAimInputOrLookDir();
        SkillVar<JVector> throwDirVar = this.throwDirVar;
        JVector jvector = throwDirVar != null ? throwDirVar.Get() : aimInputOrLookDir;
        jvector.Y = 0.0f;
        float num = JMath.Lerp(this.ballHitVelocityMin.Get(), this.ballHitVelocityMax.Get(), this.normalizedStrength.Get());
        JVector velocity = jvector * num;
        BallUpdateSystem.ThrowBall(this.skillGraph.GetEvents(), context, owner, velocity);
      }
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.normalizedStrength.Parse(serializationInfo, ref valueIndex, this.Name + ".normalizedStrength");

    public override void Serialize(byte[] target, ref int valueIndex) => this.normalizedStrength.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.normalizedStrength.Deserialize(target, ref valueIndex);
  }
}
