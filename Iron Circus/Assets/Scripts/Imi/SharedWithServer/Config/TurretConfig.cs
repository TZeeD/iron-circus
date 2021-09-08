// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.TurretConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Utils;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "TurretConfig", menuName = "SteelCircus/SkillConfigs/TurretConfig")]
  public class TurretConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string skillIconName;
    public float cooldown;
    public float rangeMin;
    public float rangeMax;
    public float rangeChangePerSecond;
    [AnimationDuration]
    public float activationDuration;
    public float delayToImpact;
    [AnimationDuration]
    public float standUpDuration;
    public float stunDuration;
    public float pushDuration;
    public float pushDistance;
    public int damage;
    public AreaOfEffect aoe;
    public float cameraSpeed = 50f;
    public float cameraStickAtTargetDuration = 3f;
    public VfxPrefab impactVfxPrefab;
    public VfxPrefab muzzleFlashVfxPrefab;
    public VfxPrefab flightVfxPrefab;
    public VfxPrefab chargeUpPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState input = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("Control Camera");
      ApplyStatusMofifierToOwnerState freezeMoveState = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("Freeze Move");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("Stand up Freeze Move");
      ShowAoeState aoePreviewState = skillGraph.AddState<ShowAoeState>("AoE Preview");
      BooleanSwitchState movingTargetState = skillGraph.AddState<BooleanSwitchState>("Move Target");
      WaitState activationDurationState = skillGraph.AddState<WaitState>("Activate TurretMode");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Delay to Impact");
      WaitState waitState2 = skillGraph.AddState<WaitState>("Camera stay at target");
      PlayAnimationState playTurretAnim = skillGraph.AddState<PlayAnimationState>("Turret Anim");
      PlayAnimationState playAnimationState = skillGraph.AddState<PlayAnimationState>("StopLookingAtBall");
      PlayVfxState playChargeVfxState = skillGraph.AddState<PlayVfxState>("ChargeVfx");
      AudioState turretAimLoopAudioState = skillGraph.AddState<AudioState>("Play Aim Audio Loop");
      AudioState audioState = skillGraph.AddState<AudioState>("Shoot Audio Loop");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("Lock Other Graphs");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("cooldownState");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("WhileProgressCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("updateCooldown");
      CheckAreaOfEffectAction areaOfEffectAction1 = skillGraph.AddAction<CheckAreaOfEffectAction>("CheckHitAction");
      ApplyPushStunAction applyPushStunAction = skillGraph.AddAction<ApplyPushStunAction>("CheckHitAction");
      ModifyHealthAction modifyHealthAction = skillGraph.AddAction<ModifyHealthAction>("CheckHitAction");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      OnEventAction onEventAction5 = skillGraph.AddAction<OnEventAction>("OnMatchStateChanged");
      SpawnVfxAction spawnVfxAction1 = skillGraph.AddAction<SpawnVfxAction>("Impact Vfx");
      SpawnVfxAction spawnVfxAction2 = skillGraph.AddAction<SpawnVfxAction>("Muzzle Flash");
      SpawnVfxAction spawnVfxAction3 = skillGraph.AddAction<SpawnVfxAction>("Projectile Flight");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("PlayImpactAudio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Play Transform Audio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("Play Transform Voice Audio");
      PlayAudioAction playAudioAction4 = skillGraph.AddAction<PlayAudioAction>("Play Shoot Audio");
      ConditionAction conditionAction1 = skillGraph.AddAction<ConditionAction>("ShouldStart");
      ConditionAction conditionAction2 = skillGraph.AddAction<ConditionAction>("ShoulTrigger");
      ConditionAction conditionAction3 = skillGraph.AddAction<ConditionAction>("IsNotStunned");
      SetVar<float> resetCooldown = skillGraph.AddAction<SetVar<float>>("ResetAndStartCooldown");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("IsFiring True");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("IsFiring False");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("CanEnter False");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("MoveTarget True");
      SetVar<bool> setVar5 = skillGraph.AddAction<SetVar<bool>>("MoveTarget False");
      SetVar<bool> setVar6 = skillGraph.AddAction<SetVar<bool>>("CanFire False");
      SkillVar<bool> isCooldownOver = skillGraph.AddVar<bool>("CooldownOver");
      SkillVar<bool> canUseSkill = skillGraph.AddVar<bool>("CanUse");
      SkillVar<bool> moveTargetModeActive = skillGraph.AddVar<bool>("MoteTargetMode");
      SkillVar<bool> canEnterTurretMode = skillGraph.AddVar<bool>("CanEnterTurretMode");
      SkillVar<bool> canFire = skillGraph.AddVar<bool>("CanFire");
      SkillVar<bool> takeCameraControl = skillGraph.AddVar<bool>("ControlCamera");
      SkillVar<bool> isInactive = skillGraph.AddVar<bool>("isInactive");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<JVector> proxyPosition = skillGraph.AddVar<JVector>("ProxyPosition");
      SkillVar<JVector> cameraTarget = skillGraph.AddVar<JVector>("CameraTarget");
      SkillVar<JVector> projectileStartPos = skillGraph.AddVar<JVector>("ProjectileStartPos");
      SkillVar<UniqueId> skillVar1 = skillGraph.AddVar<UniqueId>("HitEntities", true);
      SkillVar<bool> skillVar2 = skillGraph.AddVar<bool>("IsFiring");
      currentCooldown.Set(this.cooldown);
      projectileStartPos.Expression((Func<JVector>) (() => skillGraph.GetPosition() + skillGraph.GetLookDir() * 0.3f));
      canUseSkill.Expression((Func<bool>) (() => (bool) isCooldownOver && !skillGraph.OwnerHasBall() && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked()));
      TurretConfig.TurretFlightFXParams flightParams = new TurretConfig.TurretFlightFXParams();
      spawnVfxAction1.vfxPrefab = this.impactVfxPrefab;
      spawnVfxAction1.position.Expression((Func<JVector>) (() => (JVector) proxyPosition));
      spawnVfxAction2.vfxPrefab = this.muzzleFlashVfxPrefab;
      spawnVfxAction2.position.Expression((Func<JVector>) (() => (JVector) projectileStartPos + new JVector(0.0f, 1.25f, 0.0f)));
      spawnVfxAction2.lookDir.Expression((Func<JVector>) (() => ((JVector) proxyPosition - projectileStartPos.Get()).Normalized()));
      spawnVfxAction3.vfxPrefab = this.flightVfxPrefab;
      spawnVfxAction3.position.Expression((Func<JVector>) (() => (JVector) projectileStartPos));
      spawnVfxAction3.lookDir.Expression((Func<JVector>) (() => ((JVector) proxyPosition - projectileStartPos.Get()).Normalized()));
      spawnVfxAction3.args = (Func<object>) (() => (object) flightParams);
      flightParams.duration = this.delayToImpact;
      playAudioAction2.audioResourceName.Constant("Capx02SkillTurretTransform");
      playAudioAction3.audioResourceName.Constant("Capx02VoiceTurretTransform");
      turretAimLoopAudioState.audioResourceName.Constant("Capx02SkillTurretAimLoop");
      playAudioAction4.audioResourceName.Constant("Capx02SkillTurretShoot");
      audioState.audioResourceName.Constant("Capx02SkillTurretShootLoop");
      playAudioAction1.audioResourceName.Constant("Capx02SkillTurretImpact");
      skillGraph.AddEntryState((SkillState) input);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillGraph.AddEntryState((SkillState) booleanSwitchState1);
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      skillUiState.iconName.Expression((Func<string>) (() => this.skillIconName));
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) (1.0 - (double) (float) currentCooldown / (double) this.cooldown)));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      playTurretAnim.animationType.Constant(AnimationStateType.SecondarySkill);
      input.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      input.OnButtonDown += conditionAction1.Do;
      conditionAction1.condition = (Func<bool>) (() => (bool) canUseSkill && (bool) canEnterTurretMode);
      conditionAction1.OnTrue += setVar3.Do;
      conditionAction1.OnFalse += conditionAction2.Do;
      setVar3.var = canEnterTurretMode;
      setVar3.value = (SyncableValue<bool>) false;
      SetVar<bool> setVar7 = setVar3;
      setVar7.Then = setVar7.Then + setVar4.Do;
      setVar4.var = moveTargetModeActive;
      setVar4.value = (SyncableValue<bool>) true;
      SetVar<bool> setVar8 = setVar4;
      setVar8.Then = setVar8.Then + activationDurationState.Enter;
      playChargeVfxState.vfxPrefab = this.chargeUpPrefab;
      playChargeVfxState.position = (SyncableValue<JVector>) new JVector(0.0f, 1.25f, 0.3f);
      activationDurationState.duration.Expression((Func<float>) (() => this.activationDuration));
      activationDurationState.onEnterDelegate = (Action) (() =>
      {
        if (skillGraph.IsSyncing())
          return;
        cameraTarget.Set(skillGraph.GetPosition());
        isInactive.Set(false);
        proxyPosition.Set(skillGraph.GetPosition() + skillGraph.GetLookDir() * this.rangeMin);
      });
      WaitState waitState3 = activationDurationState;
      waitState3.OnEnter = waitState3.OnEnter + lockGraphsState.Enter;
      WaitState waitState4 = activationDurationState;
      waitState4.OnEnter = waitState4.OnEnter + playTurretAnim.Enter;
      WaitState waitState5 = activationDurationState;
      waitState5.OnEnter = waitState5.OnEnter + freezeMoveState.Enter;
      WaitState waitState6 = activationDurationState;
      waitState6.OnEnter = waitState6.OnEnter + playChargeVfxState.Enter;
      WaitState waitState7 = activationDurationState;
      waitState7.OnEnter = waitState7.OnEnter + playAudioAction2.Do;
      WaitState waitState8 = activationDurationState;
      waitState8.OnEnter = waitState8.OnEnter + playAudioAction3.Do;
      WaitState waitState9 = activationDurationState;
      waitState9.OnExit = waitState9.OnExit + conditionAction3.Do;
      freezeMoveState.modifier = StatusModifier.BlockMove | StatusModifier.BlockHoldBall;
      conditionAction3.condition = (Func<bool>) (() => (bool) moveTargetModeActive);
      conditionAction3.OnTrue += movingTargetState.Enter;
      movingTargetState.condition = (Func<bool>) (() => (bool) moveTargetModeActive);
      movingTargetState.onEnterDelegate = (Action) (() =>
      {
        if (skillGraph.IsSyncing())
          return;
        canFire.Set(true);
        takeCameraControl.Set(true);
        cameraTarget.Set(skillGraph.GetPosition());
      });
      BooleanSwitchState booleanSwitchState3 = movingTargetState;
      booleanSwitchState3.OnEnter = booleanSwitchState3.OnEnter + aoePreviewState.Enter;
      BooleanSwitchState booleanSwitchState4 = movingTargetState;
      booleanSwitchState4.SubState = booleanSwitchState4.SubState + (SkillState) turretAimLoopAudioState;
      BooleanSwitchState booleanSwitchState5 = movingTargetState;
      booleanSwitchState5.SubState = booleanSwitchState5.SubState + (SkillState) playAnimationState;
      movingTargetState.whileTrueDelegate = (Action) (() =>
      {
        float num = this.rangeChangePerSecond * skillGraph.GetFixedTimeStep();
        JVector jvector1 = (JVector) proxyPosition + skillGraph.GetMovementInputDir().Normalized() * num;
        JVector position = skillGraph.GetPosition();
        JVector vector = JitterUtils.ClampLength(jvector1 - position, this.rangeMin, this.rangeMax);
        JVector jvector2 = vector + position;
        proxyPosition.Set(jvector2);
        cameraTarget.Set(jvector2);
        skillGraph.GetOwner().TransformSetLookDir(vector.Normalized());
      });
      movingTargetState.whileFalseDelegate = (Action) (() => movingTargetState.Exit_());
      BooleanSwitchState booleanSwitchState6 = movingTargetState;
      booleanSwitchState6.OnExit = booleanSwitchState6.OnExit + playChargeVfxState.Exit;
      BooleanSwitchState booleanSwitchState7 = movingTargetState;
      booleanSwitchState7.OnExit = booleanSwitchState7.OnExit + playTurretAnim.Exit;
      BooleanSwitchState booleanSwitchState8 = movingTargetState;
      booleanSwitchState8.OnExit = booleanSwitchState8.OnExit + mofifierToOwnerState.Enter;
      mofifierToOwnerState.modifier = StatusModifier.BlockMove;
      mofifierToOwnerState.duration = (SyncableValue<float>) this.standUpDuration;
      playAnimationState.animationType.Constant(AnimationStateType.DontTurnHead);
      booleanSwitchState1.condition = (Func<bool>) (() => (bool) takeCameraControl);
      booleanSwitchState1.onEnterDelegate = (Action) (() => skillGraph.GetContext().cameraTarget.position = (JVector) cameraTarget);
      booleanSwitchState1.whileTrueDelegate = (Action) (() =>
      {
        skillGraph.GetContext().cameraTarget.overrideInProgress = true;
        JVector position = skillGraph.GetContext().cameraTarget.position;
        JVector jvector3 = (JVector) cameraTarget;
        JVector jvector4 = jvector3 - position;
        float num1 = jvector4.Length();
        if ((double) num1 > 1.0 / 1000.0)
        {
          float num2 = this.cameraSpeed * skillGraph.GetFixedTimeStep();
          float num3 = (double) num2 > (double) num1 ? num1 : num2;
          jvector4.Normalize();
          JVector jvector5 = position + jvector4 * num3;
          skillGraph.GetContext().cameraTarget.position = jvector5;
        }
        else
          skillGraph.GetContext().cameraTarget.position = jvector3;
      });
      booleanSwitchState1.whileFalseDelegate = (Action) (() => skillGraph.GetContext().cameraTarget.overrideInProgress = false);
      conditionAction2.condition = (Func<bool>) (() => (bool) canUseSkill && (bool) canFire);
      conditionAction2.OnTrue += setVar6.Do;
      setVar6.var = canFire;
      setVar6.value = (SyncableValue<bool>) false;
      SetVar<bool> setVar9 = setVar6;
      setVar9.Then = setVar9.Then + setVar5.Do;
      setVar5.var = moveTargetModeActive;
      setVar5.value = (SyncableValue<bool>) false;
      SetVar<bool> setVar10 = setVar5;
      setVar10.Then = setVar10.Then + waitState1.Enter;
      SetVar<bool> setVar11 = setVar5;
      setVar11.Then = setVar11.Then + waitState2.Enter;
      waitState1.duration.Expression((Func<float>) (() => this.delayToImpact));
      waitState1.onEnterDelegate = (Action) (() =>
      {
        flightParams.distance = ((JVector) proxyPosition - projectileStartPos.Get()).Length();
        VfxManager.UpdateVfx(skillGraph, this.aoe.vfxPrefab, (object) this.delayToImpact);
      });
      WaitState waitState10 = waitState1;
      waitState10.OnEnter = waitState10.OnEnter + spawnVfxAction3.Do;
      WaitState waitState11 = waitState1;
      waitState11.OnEnter = waitState11.OnEnter + spawnVfxAction2.Do;
      WaitState waitState12 = waitState1;
      waitState12.OnEnter = waitState12.OnEnter + playAudioAction4.Do;
      WaitState waitState13 = waitState1;
      waitState13.OnEnter = waitState13.OnEnter + setVar1.Do;
      WaitState waitState14 = waitState1;
      waitState14.OnEnter = waitState14.OnEnter + resetCooldown.Do;
      WaitState waitState15 = waitState1;
      waitState15.SubState = waitState15.SubState + (SkillState) audioState;
      WaitState waitState16 = waitState1;
      waitState16.OnExit = waitState16.OnExit + freezeMoveState.Exit;
      WaitState waitState17 = waitState1;
      waitState17.OnExit = waitState17.OnExit + aoePreviewState.Exit;
      WaitState waitState18 = waitState1;
      waitState18.OnExit = waitState18.OnExit + lockGraphsState.Exit;
      WaitState waitState19 = waitState1;
      waitState19.OnExit = waitState19.OnExit + spawnVfxAction1.Do;
      WaitState waitState20 = waitState1;
      waitState20.OnExit = waitState20.OnExit + areaOfEffectAction1.Do;
      WaitState waitState21 = waitState1;
      waitState21.OnExit = waitState21.OnExit + setVar2.Do;
      setVar1.var = skillVar2;
      setVar1.value.Expression((Func<bool>) (() => true));
      setVar2.var = skillVar2;
      setVar2.value.Expression((Func<bool>) (() => false));
      waitState2.duration.Expression((Func<float>) (() => 2f * this.cameraStickAtTargetDuration));
      waitState2.onUpdate = (Action<float>) (t =>
      {
        if ((double) t <= 0.5)
          return;
        cameraTarget.Set(skillGraph.GetPosition());
      });
      WaitState waitState22 = waitState2;
      waitState22.OnExit = waitState22.OnExit + freezeMoveState.Exit;
      waitState2.onExitDelegate = (Action) (() =>
      {
        isInactive.Set(true);
        takeCameraControl.Set(false);
      });
      aoePreviewState.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      aoePreviewState.overrideOwnerPosition = true;
      aoePreviewState.position.Expression((Func<JVector>) (() => (JVector) proxyPosition));
      areaOfEffectAction1.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      areaOfEffectAction1.position.Expression((Func<JVector>) (() => (JVector) proxyPosition));
      areaOfEffectAction1.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      areaOfEffectAction1.hitEntities = skillVar1;
      areaOfEffectAction1.includeEnemies = true;
      areaOfEffectAction1.filterHit = (Func<GameEntity, bool>) (entity => entity.HasModifier(StatusModifier.Flying));
      CheckAreaOfEffectAction areaOfEffectAction2 = areaOfEffectAction1;
      areaOfEffectAction2.Then = areaOfEffectAction2.Then + playAudioAction1.Do;
      CheckAreaOfEffectAction areaOfEffectAction3 = areaOfEffectAction1;
      areaOfEffectAction3.Then = areaOfEffectAction3.Then + whileTrueState1.Enter;
      CheckAreaOfEffectAction areaOfEffectAction4 = areaOfEffectAction1;
      areaOfEffectAction4.Then = areaOfEffectAction4.Then + applyPushStunAction.Do;
      CheckAreaOfEffectAction areaOfEffectAction5 = areaOfEffectAction1;
      areaOfEffectAction5.Then = areaOfEffectAction5.Then + modifyHealthAction.Do;
      applyPushStunAction.targetEntities = skillVar1;
      applyPushStunAction.pushDistance.Expression((Func<float>) (() => this.pushDistance));
      applyPushStunAction.pushDuration.Expression((Func<float>) (() => this.pushDuration));
      applyPushStunAction.getPushDir = (Func<GameEntity, JVector>) (entity => (entity.transform.position - (JVector) proxyPosition).Normalized());
      applyPushStunAction.stunDuration.Expression((Func<float>) (() => this.stunDuration));
      modifyHealthAction.targetEntities = skillVar1;
      modifyHealthAction.value.Expression((Func<int>) (() => -this.damage));
      resetCooldown.var = currentCooldown;
      resetCooldown.value.Expression((Func<float>) (() => this.cooldown));
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 1.40129846432482E-45);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState2;
      whileTrueState1.onEnterDelegate = (Action) (() => isCooldownOver.Set(false));
      whileTrueState1.onExitDelegate = (Action) (() =>
      {
        isCooldownOver.Set(true);
        canEnterTurretMode.Set(true);
      });
      booleanSwitchState2.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState2.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState.amountPerSecond.Constant(-1f);
      Action interrupt = (Action) (() =>
      {
        input.ResetInput();
        canEnterTurretMode.Set(true);
        canFire.Set(false);
        moveTargetModeActive.Set(false);
        isInactive.Set(true);
        takeCameraControl.Set(false);
        aoePreviewState.Exit_();
        activationDurationState.Exit_();
        turretAimLoopAudioState.Exit_();
        freezeMoveState.Exit_();
        playTurretAnim.Exit_();
        playChargeVfxState.Exit_();
        lockGraphsState.Exit_();
      });
      onEventAction1.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction1.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction3.EventType = SkillGraphEvent.MatchStart;
      onEventAction3.OnTrigger += whileTrueState1.Enter;
      onEventAction5.EventType = SkillGraphEvent.MatchStateChanged;
      onEventAction5.onTriggerDelegate = (Action) (() =>
      {
        if (skillGraph.GetMatchState() == Imi.SharedWithServer.Game.MatchState.PointInProgress)
          return;
        interrupt();
      });
      onEventAction2.EventType = SkillGraphEvent.Interrupt;
      onEventAction2.onTriggerDelegate = (Action) (() =>
      {
        if (!(bool) isInactive)
          resetCooldown.PerformAction();
        interrupt();
      });
      onEventAction4.EventType = SkillGraphEvent.Overtime;
      onEventAction4.OnTrigger += resetCooldown.Do;
    }

    public class TurretFlightFXParams
    {
      public float duration;
      public float distance;
    }
  }
}
