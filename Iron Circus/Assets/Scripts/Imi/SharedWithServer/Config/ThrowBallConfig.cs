// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.ThrowBallConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.Utils;
using Jitter.LinearMath;
using SteelCircus.GameElements;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "ThrowBallConfig", menuName = "SteelCircus/SkillConfigs/ThrowBallConfig")]
  public class ThrowBallConfig : SkillGraphConfig
  {
    public float chargeDuration;
    public float prechargeTimeout;
    public Curve chargeCurve;
    public float turnSnapAngle;
    public float turnSpeed;
    public float ballHitVelocityMin;
    public float ballHitVelocityMax;
    [AnimationDuration]
    public float throwAnimDuration = 0.25f;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState input = skillGraph.AddState<ButtonState>("Input");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("While Can Throw");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("ShouldPlayChargeAnim");
      ModVarOverTimeState varOverTimeState1 = skillGraph.AddState<ModVarOverTimeState>("Charge Throw");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Pre-Charge Expire");
      WaitState ballthrowDelay = skillGraph.AddState<WaitState>("BallthrowDelay");
      PlayAnimationState playAnimationState = skillGraph.AddState<PlayAnimationState>("Throw Anim");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Skill UI");
      SubgraphState subgraphState1 = skillGraph.AddState<SubgraphState>("ChargeSubgraph");
      ShootBallAction shootBallAction1 = new ShootBallAction(skillGraph, "ShootBall");
      ConditionAction conditionAction1 = skillGraph.AddAction<ConditionAction>("ShouldThrow");
      ConditionAction conditionAction2 = skillGraph.AddAction<ConditionAction>("IsPrecharging");
      ConditionAction conditionAction3 = skillGraph.AddAction<ConditionAction>("ShouldPrechargeExpire");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnDeath");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("SetThrowTrue");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("SetThrowFalse");
      SetVar<float> setVar3 = skillGraph.AddAction<SetVar<float>>("ResetThrowCharge");
      ConditionAction conditionAction4 = skillGraph.AddAction<ConditionAction>("ShouldResetInpu");
      PlayRazerAnimation playRazerAnimation1 = skillGraph.AddAction<PlayRazerAnimation>("PlayChargeThrowRazer");
      PlayRazerAnimation playRazerAnimation2 = skillGraph.AddAction<PlayRazerAnimation>("PlayBallCarryRazer");
      PlayRazerAnimation playRazerAnimation3 = skillGraph.AddAction<PlayRazerAnimation>("ResetRazer");
      SetVar<JVector> setVar4 = skillGraph.AddAction<SetVar<JVector>>("set throw dir");
      SetVar<JVector> setVar5 = skillGraph.AddAction<SetVar<JVector>>("set aim dir");
      SkillVar<float> throwCharge = skillGraph.AddVar<float>("Charge Amount");
      SkillVar<bool> canCharge = skillGraph.AddVar<bool>("CanCharge");
      SkillVar<bool> throwBall = skillGraph.AddVar<bool>("ThrowBall");
      SkillVar<JVector> throwDir = skillGraph.AddVar<JVector>("ThrowDir");
      SkillVar<JVector> aimDir = skillGraph.AddVar<JVector>("AimDir");
      canCharge.Expression((Func<bool>) (() => !skillGraph.GetOwner().IsPushed() && !skillGraph.GetOwner().IsStunned() && !skillGraph.GetOwner().IsDead() && skillGraph.IsPointInProgress() && !ballthrowDelay.IsActive && !skillGraph.IsGraphLocked()));
      setVar4.var = throwDir;
      setVar4.value.Expression((Func<JVector>) (() =>
      {
        if ((!skillGraph.IsClient() || !skillGraph.GetOwner().isLocalEntity) && !skillGraph.IsServer())
          return (JVector) throwDir;
        JVector jvector = skillGraph.GetAimInputOrLookDir();
        if ((double) jvector.LengthSquared() == 0.0)
          jvector = skillGraph.GetLookDir();
        jvector.Normalize();
        return jvector;
      }));
      setVar5.var = aimDir;
      setVar5.value.Expression((Func<JVector>) (() =>
      {
        if ((!skillGraph.IsClient() || !skillGraph.GetOwner().isLocalEntity) && !skillGraph.IsServer())
          return (JVector) aimDir;
        JVector jvector = skillGraph.GetAimInputOrLookDir();
        if ((double) jvector.LengthSquared() == 0.0)
          jvector = skillGraph.GetLookDir();
        jvector.Normalize();
        return jvector;
      }));
      skillGraph.AddEntryState((SkillState) input);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillUiState.buttonType.Constant(ButtonType.ThrowBall);
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) throwCharge));
      playAnimationState.animationType.Constant(AnimationStateType.ChargeThrowBall);
      playAnimationState.normalizedProgress.Expression((Func<float>) (() => this.chargeCurve.Evaluate((float) throwCharge)));
      input.buttonType.Constant(ButtonType.ThrowBall);
      input.buttonDownSubStates += (SkillState) booleanSwitchState1;
      input.OnButtonUp += conditionAction1.Do;
      ButtonState buttonState = input;
      buttonState.OnUpdate = buttonState.OnUpdate + setVar5.Do;
      booleanSwitchState1.condition = (Func<bool>) (() => (bool) canCharge);
      booleanSwitchState1.OnTrue += setVar1.Do;
      booleanSwitchState1.WhileTrueSubState += (SkillState) booleanSwitchState2;
      booleanSwitchState1.WhileTrueSubState += (SkillState) subgraphState1;
      booleanSwitchState1.OnFalse += setVar2.Do;
      booleanSwitchState1.OnFalse += setVar3.Do;
      BooleanSwitchState booleanSwitchState3 = booleanSwitchState1;
      booleanSwitchState3.OnUpdate = booleanSwitchState3.OnUpdate + setVar4.Do;
      booleanSwitchState2.condition = (Func<bool>) (() => skillGraph.OwnerHasBall());
      booleanSwitchState2.WhileTrueSubState += (SkillState) playAnimationState;
      SubgraphState subgraphState2 = subgraphState1;
      subgraphState2.OnEnter = subgraphState2.OnEnter + varOverTimeState1.Enter;
      SubgraphState subgraphState3 = subgraphState1;
      subgraphState3.OnEnter = subgraphState3.OnEnter + playRazerAnimation1.Do;
      subgraphState1.memberStates += (SkillState) varOverTimeState1;
      subgraphState1.memberStates += (SkillState) waitState1;
      playRazerAnimation2.razerAnimType = RazerAnimType.Ball;
      playRazerAnimation2.animationIndex = 0;
      playRazerAnimation1.razerAnimType = RazerAnimType.Ball;
      playRazerAnimation1.animationIndex = 1;
      playRazerAnimation3.razerAnimType = RazerAnimType.Team;
      setVar1.var = throwBall;
      setVar1.value = (SyncableValue<bool>) true;
      setVar2.var = throwBall;
      setVar2.value = (SyncableValue<bool>) false;
      setVar3.var = throwCharge;
      setVar3.value = (SyncableValue<float>) 0.0f;
      varOverTimeState1.var = throwCharge;
      varOverTimeState1.amountPerSecond.Expression((Func<float>) (() => 1f / this.chargeDuration));
      varOverTimeState1.targetValue = (SyncableValue<float>) 1f;
      ModVarOverTimeState varOverTimeState2 = varOverTimeState1;
      varOverTimeState2.OnExit = varOverTimeState2.OnExit + conditionAction2.Do;
      conditionAction2.condition = (Func<bool>) (() => !skillGraph.OwnerHasBall());
      conditionAction2.OnTrue += waitState1.Enter;
      waitState1.duration.Expression((Func<float>) (() => this.prechargeTimeout));
      WaitState waitState2 = waitState1;
      waitState2.OnExit = waitState2.OnExit + conditionAction3.Do;
      WaitState waitState3 = waitState1;
      waitState3.OnExit = waitState3.OnExit + conditionAction4.Do;
      conditionAction4.condition = (Func<bool>) (() => !skillGraph.OwnerHasBall());
      conditionAction4.OnTrue += input.Reset;
      conditionAction3.condition = (Func<bool>) (() => !skillGraph.OwnerHasBall());
      conditionAction3.OnTrue += setVar2.Do;
      conditionAction3.OnTrue += setVar3.Do;
      conditionAction3.OnTrue += playRazerAnimation2.Do;
      conditionAction1.condition = (Func<bool>) (() => (bool) throwBall);
      conditionAction1.OnTrue += setVar4.Do;
      conditionAction1.OnTrue += ballthrowDelay.Enter;
      conditionAction1.OnTrue += setVar2.Do;
      conditionAction1.OnTrue += playRazerAnimation3.Do;
      ballthrowDelay.duration.Expression((Func<float>) (() => this.throwAnimDuration));
      ballthrowDelay.OnFinish += shootBallAction1.Do;
      shootBallAction1.throwDirVar = throwDir;
      shootBallAction1.normalizedStrength.Expression((Func<float>) (() => this.chargeCurve.Evaluate((float) throwCharge)));
      shootBallAction1.ballHitVelocityMin.Expression((Func<float>) (() => this.ballHitVelocityMin));
      shootBallAction1.ballHitVelocityMax.Expression((Func<float>) (() => this.ballHitVelocityMax));
      ShootBallAction shootBallAction2 = shootBallAction1;
      shootBallAction2.Then = shootBallAction2.Then + setVar3.Do;
      onEventAction1.EventType = SkillGraphEvent.StunOrPush;
      onEventAction1.onTriggerDelegate = (Action) (() => input.ResetInput());
      onEventAction1.OnTrigger += setVar2.Do;
      onEventAction1.OnTrigger += setVar3.Do;
      onEventAction2.EventType = SkillGraphEvent.Dead;
      onEventAction2.onTriggerDelegate = (Action) (() => input.ResetInput());
      onEventAction2.OnTrigger += setVar2.Do;
      onEventAction2.OnTrigger += setVar3.Do;
    }
  }
}
