// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.RampageConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Jitter.LinearMath;
using SteelCircus.GameElements;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "RampageConfig", menuName = "SteelCircus/SkillConfigs/RampageConfig")]
  public class RampageConfig : SkillGraphConfig
  {
    [Header("Basics")]
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string skillIcon;
    public float cooldown;
    public float castDuration;
    public float duration;
    [Header("Model Scale")]
    public float modelScale;
    public float scaleDuration;
    public Curve scaleCurve;
    [Header("Movement Options")]
    public float moveSpeed;
    public float accelerationFactor = 1f;
    [Range(0.0f, 1f)]
    public float thrusterFraction;
    [Header("Effects")]
    public float activateRange;
    public float range;
    public float pushDistance;
    public float pushDuration;
    public float stunDuration;
    public float ballPushForce;
    public VfxPrefab trailPrefab;
    public VfxPrefab particlesPrefab;
    public VfxPrefab aoePrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("SkillUi");
      WaitState waitState1 = skillGraph.AddState<WaitState>("StartCasting");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState1 = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("StopWhileCasting");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState2 = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("NoBallPickup");
      ModifyMovementState modifyMovementState = skillGraph.AddState<ModifyMovementState>("MoveWhileRampaging");
      WaitState waitState2 = skillGraph.AddState<WaitState>("SkillDurationState");
      CheckAreaOfEffectState areaOfEffectState = skillGraph.AddState<CheckAreaOfEffectState>("CheckHitState");
      ShowAoeState showAoeState = skillGraph.AddState<ShowAoeState>("Show Aoe Vfx");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("CooldownState");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("UpdateCooldown");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("BlockOtherSkills");
      PlayAnimationState playAnimationState = skillGraph.AddState<PlayAnimationState>("PlayAnimation");
      ScaleModelState scaleModelState = skillGraph.AddState<ScaleModelState>("ScaleModelState");
      AudioState audioState = skillGraph.AddState<AudioState>("Start Rampage Audio");
      PlayVfxState playVfxState1 = skillGraph.AddState<PlayVfxState>("Trail FX State");
      PlayVfxState playVfxState2 = skillGraph.AddState<PlayVfxState>("Particle FX State");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("CanActivateCheck");
      CheckAreaOfEffectAction areaOfEffectAction = skillGraph.AddAction<CheckAreaOfEffectAction>("CheckInitialHit");
      ApplyPushStunAction applyPushStunAction = skillGraph.AddAction<ApplyPushStunAction>("ApplyPush");
      PushBallAction pushBallAction = skillGraph.AddAction<PushBallAction>("ApplyPush");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnPickupCollected");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      SetVar<float> setVar1 = skillGraph.AddAction<SetVar<float>>("ResetCooldown");
      SetVar<float> setVar2 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("SetOnCooldownTrue");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("SetOnCooldownFalse");
      SetVar<bool> setVar5 = skillGraph.AddAction<SetVar<bool>>("SetActiveTrue");
      SetVar<bool> setVar6 = skillGraph.AddAction<SetVar<bool>>("SetActiveFalse");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("Play rampage Start Voice Audio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Play rampage End Audio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("Play rampage Hit Enemy Audio");
      PlayAudioAction playAudioAction4 = skillGraph.AddAction<PlayAudioAction>("Play rampage Hit Enemy Voice Audio");
      SkillVar<UniqueId> skillVar = skillGraph.AddVar<UniqueId>("HitEntities", true);
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<bool> canActivate = skillGraph.AddVar<bool>("CanActivate");
      currentCooldown.Set(this.cooldown);
      canActivate.Expression((Func<bool>) (() => !(bool) isOnCooldown && !(bool) isActive && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall() && !skillGraph.IsSkillUseDisabled()));
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillUiState.buttonType.Constant(this.button);
      skillUiState.iconName.Constant(this.skillIcon);
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) (1.0 - (double) (float) currentCooldown / (double) this.cooldown)));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      audioState.audioResourceName.Constant("AcridSkillRampageStart");
      playAudioAction1.audioResourceName.Constant("AcridVoiceSkillRampage");
      playAudioAction2.audioResourceName.Constant("AcridSkillRampageEnd");
      playAudioAction3.audioResourceName.Constant("AcridSkillRampageHitEnemy");
      playAudioAction3.doNotTrack.Constant(true);
      playAudioAction4.audioResourceName.Constant("AcridVoiceSkillRampageHit");
      playAudioAction4.doNotTrack.Constant(true);
      buttonState.buttonType.Constant(this.button);
      buttonState.OnButtonDown += conditionAction.Do;
      conditionAction.condition = (Func<bool>) (() => (bool) canActivate);
      conditionAction.OnTrue += waitState1.Enter;
      waitState1.duration.Expression((Func<float>) (() => this.castDuration));
      WaitState waitState3 = waitState1;
      waitState3.OnEnter = waitState3.OnEnter + setVar5.Do;
      WaitState waitState4 = waitState1;
      waitState4.OnEnter = waitState4.OnEnter + mofifierToOwnerState2.Enter;
      WaitState waitState5 = waitState1;
      waitState5.OnEnter = waitState5.OnEnter + setVar1.Do;
      WaitState waitState6 = waitState1;
      waitState6.OnEnter = waitState6.OnEnter + areaOfEffectAction.Do;
      WaitState waitState7 = waitState1;
      waitState7.OnEnter = waitState7.OnEnter + playAnimationState.Enter;
      WaitState waitState8 = waitState1;
      waitState8.OnEnter = waitState8.OnEnter + scaleModelState.Enter;
      WaitState waitState9 = waitState1;
      waitState9.OnEnter = waitState9.OnEnter + audioState.Enter;
      WaitState waitState10 = waitState1;
      waitState10.OnEnter = waitState10.OnEnter + playAudioAction1.Do;
      WaitState waitState11 = waitState1;
      waitState11.OnEnter = waitState11.OnEnter + areaOfEffectState.Enter;
      WaitState waitState12 = waitState1;
      waitState12.SubState = waitState12.SubState + (SkillState) mofifierToOwnerState1;
      WaitState waitState13 = waitState1;
      waitState13.SubState = waitState13.SubState + (SkillState) lockGraphsState;
      waitState1.OnFinish += waitState2.Enter;
      setVar5.var = isActive;
      setVar5.value = (SyncableValue<bool>) true;
      setVar1.var = currentCooldown;
      setVar1.value.Expression((Func<float>) (() => this.cooldown));
      scaleModelState.scaleTo.Expression((Func<float>) (() => this.modelScale));
      scaleModelState.scaleDuration.Expression((Func<float>) (() => this.scaleDuration));
      scaleModelState.scaleCurve.Expression((Func<Curve>) (() => this.scaleCurve));
      areaOfEffectAction.hitEntities = skillVar;
      areaOfEffectAction.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Circle,
        radius = this.activateRange
      }));
      areaOfEffectAction.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      areaOfEffectAction.filterHit = (Func<GameEntity, bool>) (entity => entity.HasEffect(StatusEffectType.Invisible) || entity.HasModifier(StatusModifier.Flying));
      areaOfEffectAction.includeEnemies = true;
      areaOfEffectAction.includeBall = true;
      areaOfEffectAction.OnHit += applyPushStunAction.Do;
      areaOfEffectAction.OnHit += pushBallAction.Do;
      mofifierToOwnerState1.modifier = StatusModifier.BlockMove;
      playAnimationState.animationType.Constant(AnimationStateType.SecondarySkill);
      waitState2.duration.Expression((Func<float>) (() => this.duration));
      WaitState waitState14 = waitState2;
      waitState14.SubState = waitState14.SubState + (SkillState) modifyMovementState;
      WaitState waitState15 = waitState2;
      waitState15.SubState = waitState15.SubState + (SkillState) showAoeState;
      WaitState waitState16 = waitState2;
      waitState16.SubState = waitState16.SubState + (SkillState) lockGraphsState;
      WaitState waitState17 = waitState2;
      waitState17.SubState = waitState17.SubState + (SkillState) playVfxState1;
      WaitState waitState18 = waitState2;
      waitState18.SubState = waitState18.SubState + (SkillState) playVfxState2;
      WaitState waitState19 = waitState2;
      waitState19.OnExit = waitState19.OnExit + areaOfEffectState.Exit;
      WaitState waitState20 = waitState2;
      waitState20.OnExit = waitState20.OnExit + whileTrueState1.Enter;
      WaitState waitState21 = waitState2;
      waitState21.OnExit = waitState21.OnExit + setVar6.Do;
      WaitState waitState22 = waitState2;
      waitState22.OnExit = waitState22.OnExit + playAnimationState.Exit;
      WaitState waitState23 = waitState2;
      waitState23.OnExit = waitState23.OnExit + scaleModelState.Exit;
      WaitState waitState24 = waitState2;
      waitState24.OnExit = waitState24.OnExit + audioState.Exit;
      WaitState waitState25 = waitState2;
      waitState25.OnExit = waitState25.OnExit + playAudioAction2.Do;
      WaitState waitState26 = waitState2;
      waitState26.OnExit = waitState26.OnExit + mofifierToOwnerState2.Exit;
      setVar6.var = isActive;
      setVar6.value = (SyncableValue<bool>) false;
      playVfxState1.vfxPrefab = this.trailPrefab;
      playVfxState1.parentToOwner = true;
      playVfxState2.vfxPrefab = this.particlesPrefab;
      playVfxState2.parentToOwner = true;
      playVfxState2.deferDestructionToEffect = true;
      modifyMovementState.mode.Constant(ModifyMovementState.Mode.OverrideMoveConfig);
      modifyMovementState.speed.Expression((Func<float>) (() => this.moveSpeed));
      modifyMovementState.accFactor.Expression((Func<float>) (() => this.accelerationFactor));
      modifyMovementState.thrustContribution.Expression((Func<float>) (() => this.thrusterFraction));
      modifyMovementState.constantForwardMovement = (SyncableValue<bool>) true;
      mofifierToOwnerState2.modifier = StatusModifier.BlockHoldBall;
      areaOfEffectState.hitEntities = skillVar;
      areaOfEffectState.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Circle,
        radius = this.range
      }));
      areaOfEffectState.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      areaOfEffectState.includeEnemies = true;
      areaOfEffectState.includeBall = true;
      areaOfEffectState.repeatedHitCooldown = 0.25f;
      areaOfEffectState.filterHit = (Func<GameEntity, bool>) (entity => entity.HasEffect(StatusEffectType.Invisible) || entity.HasModifier(StatusModifier.Flying));
      areaOfEffectState.OnHit += applyPushStunAction.Do;
      areaOfEffectState.OnHit += pushBallAction.Do;
      areaOfEffectState.OnHit += playAudioAction3.Do;
      areaOfEffectState.OnHit += playAudioAction4.Do;
      showAoeState.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Circle,
        radius = this.range,
        vfxPrefab = this.aoePrefab
      }));
      showAoeState.trackOwnerPosition = (SyncableValue<bool>) true;
      pushBallAction.targetEntities = skillVar;
      pushBallAction.force.Expression((Func<JVector>) (() => (skillGraph.GetContext().ballEntity.transform.Position2D - skillGraph.GetPosition()).Normalized() * this.ballPushForce));
      applyPushStunAction.targetEntities = skillVar;
      applyPushStunAction.pushDuration.Expression((Func<float>) (() => this.pushDuration));
      applyPushStunAction.stunDuration.Expression((Func<float>) (() => this.stunDuration));
      applyPushStunAction.pushVector.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir() * this.pushDistance));
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState1;
      booleanSwitchState1.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState1.WhileTrueSubState += (SkillState) varOverTimeState;
      BooleanSwitchState booleanSwitchState2 = booleanSwitchState1;
      booleanSwitchState2.OnEnter = booleanSwitchState2.OnEnter + setVar3.Do;
      BooleanSwitchState booleanSwitchState3 = booleanSwitchState1;
      booleanSwitchState3.OnExit = booleanSwitchState3.OnExit + setVar4.Do;
      setVar3.var = isOnCooldown;
      setVar3.value = (SyncableValue<bool>) true;
      setVar4.var = isOnCooldown;
      setVar4.value = (SyncableValue<bool>) false;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.amountPerSecond.Constant(-1f);
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      onEventAction3.EventType = SkillGraphEvent.Overtime;
      onEventAction3.OnTrigger += setVar2.Do;
      setVar2.var = currentCooldown;
      setVar2.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar7 = setVar2;
      setVar7.Then = setVar7.Then + whileTrueState1.Enter;
      onEventAction1.EventType = SkillGraphEvent.MatchStart;
      onEventAction1.OnTrigger += whileTrueState1.Enter;
      onEventAction2.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction2.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
    }
  }
}
