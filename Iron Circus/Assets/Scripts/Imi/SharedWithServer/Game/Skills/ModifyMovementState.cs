// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ModifyMovementState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.Utils.Extensions;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ModifyMovementState : SkillState
  {
    public ConfigValue<ModifyMovementState.Mode> mode;
    public ConfigValue<float> duration;
    public ConfigValue<float> speed;
    public ConfigValue<float> distance;
    public ConfigValue<float> accFactor;
    public ConfigValue<float> thrustContribution;
    public SyncableValue<bool> rotateTowardsMoveDir;
    public SyncableValue<bool> constantForwardMovement;
    [SyncValue]
    public SyncableValue<JVector> moveDir;
    [SyncValue]
    private SyncableValue<int> startTick;
    [SyncValue]
    private SyncableValue<float> speedOnActivate;
    [SyncValue]
    private SyncableValue<JVector> cachedMoveDir;
    [SyncValue]
    private SyncableValue<float> cachedDistance;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.moveDir.Parse(serializationInfo, ref valueIndex, this.Name + ".moveDir");
      this.startTick.Parse(serializationInfo, ref valueIndex, this.Name + ".startTick");
      this.speedOnActivate.Parse(serializationInfo, ref valueIndex, this.Name + ".speedOnActivate");
      this.cachedMoveDir.Parse(serializationInfo, ref valueIndex, this.Name + ".cachedMoveDir");
      this.cachedDistance.Parse(serializationInfo, ref valueIndex, this.Name + ".cachedDistance");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.moveDir.Serialize(target, ref valueIndex);
      this.startTick.Serialize(target, ref valueIndex);
      this.speedOnActivate.Serialize(target, ref valueIndex);
      this.cachedMoveDir.Serialize(target, ref valueIndex);
      this.cachedDistance.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.moveDir.Deserialize(target, ref valueIndex);
      this.startTick.Deserialize(target, ref valueIndex);
      this.speedOnActivate.Deserialize(target, ref valueIndex);
      this.cachedMoveDir.Deserialize(target, ref valueIndex);
      this.cachedDistance.Deserialize(target, ref valueIndex);
    }

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickOnlyLocalEntity;

    public ModifyMovementState()
    {
      this.thrustContribution.Constant(-1f);
      this.moveDir = (SyncableValue<JVector>) JVector.MaxValue;
      this.accFactor.Constant(1f);
    }

    protected override void EnterDerived()
    {
      GameEntity owner = this.skillGraph.GetOwner();
      this.startTick.Set(this.skillGraph.GetTick());
      this.speedOnActivate.Set(owner.velocityOverride.value.Length());
      if (this.mode.Get() == ModifyMovementState.Mode.DistanceOverTime)
      {
        this.cachedDistance.Set(this.distance.Get());
        this.cachedMoveDir.Set(this.moveDir.Get());
      }
    }

    protected override void TickDerived()
    {
      float fixedTimeStep = this.skillGraph.GetFixedTimeStep();
      GameEntity owner = this.skillGraph.GetOwner();
      if ((bool) this.constantForwardMovement)
        owner.AddMovementModifier(MovementModifier.OverrideMoveDir(this.skillGraph.GetMovementInputOrLookDir()));
      switch (this.mode.Get())
      {
        case ModifyMovementState.Mode.DistanceOverTime:
          int num1 = this.skillGraph.GetTick() - (int) this.startTick;
          int num2 = (int) ((double) this.duration.Get() / (double) fixedTimeStep);
          int num3 = num2;
          if (num1 >= num3)
          {
            this.skillGraph.EnqueuExit((SkillState) this);
            return;
          }
          JVector velocity = this.cachedMoveDir.Get() * (this.cachedDistance.Get() / ((float) num2 * fixedTimeStep));
          owner.AddMovementModifier(MovementModifier.SetVelocity(velocity));
          break;
        case ModifyMovementState.Mode.OverrideMoveConfig:
          ChampionConfig championConfig = owner.championConfig.value;
          float thrustPercent = (double) this.thrustContribution.Get() < 0.0 ? championConfig.controlsThrusterContribution : this.thrustContribution.Get();
          float acceleration = championConfig.acceleration * this.accFactor.Get();
          float deceleration = championConfig.deceleration * this.accFactor.Get();
          owner.AddMovementModifier(MovementModifier.Override(this.speed.Get(), acceleration, deceleration, thrustPercent));
          break;
      }
      if (!this.rotateTowardsMoveDir.Get())
        return;
      if (this.moveDir.Get().IsNearlyZero())
        Log.Warning("LOG [" + this.skillGraph.GetConfig().name + "][" + this.name + "].moveDir.Length was zero!");
      owner.TransformRotateTowards(this.moveDir.Get());
    }

    public enum Mode
    {
      DistanceOverTime,
      OverrideMoveConfig,
    }
  }
}
