// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.AfterBurner
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using SteelCircus.Core;
using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "AfterBurner", menuName = "SteelCircus/SkillConfigs/AfterBurner")]
  public class AfterBurner : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string iconName = "icon_stomp_inverted_01_tex";
    public float cooldown = 1f;
    [Header("Dash")]
    [FormerlySerializedAs("tacklePreviewPrefab")]
    public VfxPrefab dashPreviewPrefab;
    public float dashDistance = 10f;
    public float dashDuration = 0.75f;
    public float postDashSpeed = 12f;
    [Header("Dash Effects")]
    public float pushBallForce = 10f;
    public float stunDuration = 1f;
    public float pushDuration = 1f;
    public float pushDistance = 1f;
    public float slowAmount = 1f;
    public float slowDuration = 1f;
    [Header("Fire Effects")]
    [Range(2f, 16f)]
    public int numAoes = 10;
    public float fireWidth = 1f;
    public float fireDuration = 4f;
    public int fireDamage = 1;
    public float reapplyInterval = 2f;
    public VfxPrefab fireTrailPrefab;
    public VfxPrefab smokePrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      ShowAoeState showAoeState = skillGraph.AddState<ShowAoeState>("DashPreview");
      PlayVfxState playVfxState1 = skillGraph.AddState<PlayVfxState>("FireVFX");
      PlayVfxState playVfxState2 = skillGraph.AddState<PlayVfxState>("SmokeVFX");
      ModifyMovementState modifyMovementState1 = skillGraph.AddState<ModifyMovementState>("DashMove");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("While Can Dash");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("Tackle Anim");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("DisableLookAtBall");
      CheckAreaOfEffectState areaOfEffectState = skillGraph.AddState<CheckAreaOfEffectState>("DashCollisionCheck");
      MultiAoeState multiAoeState1 = skillGraph.AddState<MultiAoeState>("CheckMultiFireAoeS");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("WhileFireActive");
      WhileTrueState whileTrueState2 = skillGraph.AddState<WhileTrueState>("Cooldown");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("Should Update Cooldown");
      ModVarOverTimeState varOverTimeState1 = skillGraph.AddState<ModVarOverTimeState>("Update Cooldown");
      ModVarOverTimeState varOverTimeState2 = skillGraph.AddState<ModVarOverTimeState>("UpdateDashProgress");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("Block other Skills");
      ChangeCollisionLayerMaskState collisionLayerMaskState = skillGraph.AddState<ChangeCollisionLayerMaskState>("No Collision State");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("BlockMoveDuringDash");
      WaitState waitState1 = skillGraph.AddState<WaitState>("FireDurationState");
      ApplyPushStunAction applyPushStunAction1 = skillGraph.AddAction<ApplyPushStunAction>("applyPushStun");
      ApplySpeedModEffectAction speedModEffectAction = skillGraph.AddAction<ApplySpeedModEffectAction>("applyDashSlow");
      ModifyMovementAction modifyMovementAction = skillGraph.AddAction<ModifyMovementAction>("setPostDashSpeed");
      ConditionAction conditionAction1 = skillGraph.AddAction<ConditionAction>("canDashCheck");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      OnEventAction onEventAction5 = skillGraph.AddAction<OnEventAction>("OnMatchStateChanged");
      ConditionAction conditionAction2 = skillGraph.AddAction<ConditionAction>("ShouldAbort");
      RumbleControllerAction controllerAction = skillGraph.AddAction<RumbleControllerAction>("RumbleOnHit");
      PushBallAction pushBallAction = skillGraph.AddAction<PushBallAction>("PushBall");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("setNotTacklingFalse");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("setNotTacklingTrue");
      SetVar<float> setVar3 = skillGraph.AddAction<SetVar<float>>("resetCooldown");
      SetVar<float> setVar4 = skillGraph.AddAction<SetVar<float>>("restartCooldown");
      SetVar<float> setVar5 = skillGraph.AddAction<SetVar<float>>("resetDashProgress");
      SetVar<JVector> setVar6 = skillGraph.AddAction<SetVar<JVector>>("Update Aim Direction");
      SetVar<JVector> setVar7 = skillGraph.AddAction<SetVar<JVector>>("setDashStartPos");
      ModifyHealthAction modifyHealthAction = skillGraph.AddAction<ModifyHealthAction>("ApplyDashDamage");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("Start Start Skill Audio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Start Fire Audio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("Start Voice Skill Audio");
      SkillVar<JVector> aimDir = skillGraph.AddVar<JVector>("AimDir");
      SkillVar<JVector> skillVar1 = skillGraph.AddVar<JVector>("dashStartPos");
      SkillVar<JVector> fireAoePositions = skillGraph.AddVar<JVector>("FireAoePositions", true);
      SkillVar<JVector> fireAoeLookDirs = skillGraph.AddVar<JVector>("FireAoeLookDirs", true);
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("isOnCooldown");
      SkillVar<bool> canDash = skillGraph.AddVar<bool>("canDash");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<float> skillVar2 = skillGraph.AddVar<float>("DashProgress");
      SkillVar<UniqueId> skillVar3 = skillGraph.AddVar<UniqueId>("DashHits", true);
      SkillVar<UniqueId> skillVar4 = skillGraph.AddVar<UniqueId>("FireHits", true);
      isActive.Set(false);
      isOnCooldown.Expression((Func<bool>) (() => (double) (float) currentCooldown > 1.40129846432482E-45));
      canDash.Expression((Func<bool>) (() => !(bool) isOnCooldown && !(bool) isActive && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall()));
      TimelineVector positionRecord = new TimelineVector();
      positionRecord.postInfinity = TimelineInfinity.Extrapolate;
      int startTick = 0;
      float currentDuration = 0.0f;
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      playAnimationState1.animationType.Constant(AnimationStateType.PrimarySkill);
      playAnimationState2.animationType.Constant(AnimationStateType.DontTurnHead);
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.fillAmount.Expression((Func<float>) (() => (this.cooldown - (float) currentCooldown) / this.cooldown));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      buttonState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      buttonState.buttonDownSubStates += (SkillState) booleanSwitchState1;
      buttonState.OnButtonUp += conditionAction1.Do;
      playAudioAction1.audioResourceName.Constant("KennySkillAfterburnerStart");
      playAudioAction2.audioResourceName.Constant("KennySkillAfterburnerFire");
      playAudioAction3.audioResourceName.Constant("KennyVoiceSkillAfterburner");
      booleanSwitchState1.condition = (Func<bool>) (() => (bool) canDash);
      booleanSwitchState1.WhileTrueSubState += (SkillState) showAoeState;
      booleanSwitchState1.WhileTrueSubState += (SkillState) lockGraphsState;
      booleanSwitchState1.WhileTrueSubState += (SkillState) playAnimationState2;
      showAoeState.onUpdateDelegate = (Action) (() => aimDir.Set(skillGraph.GetAimInputOrLookDir().Normalized()));
      showAoeState.showOnlyForLocalPlayer.Constant(false);
      showAoeState.trackOwnerPosition = (SyncableValue<bool>) false;
      showAoeState.aoe.Expression((Func<AreaOfEffect>) (() =>
      {
        float colliderRadius = skillGraph.GetOwner().championConfig.value.colliderRadius;
        return new AreaOfEffect()
        {
          shape = AoeShape.Rectangle,
          rectLength = this.dashDistance,
          rectWidth = colliderRadius * 2f,
          vfxPrefab = this.dashPreviewPrefab
        };
      }));
      conditionAction1.condition = (Func<bool>) (() => (bool) canDash);
      conditionAction1.OnTrue += setVar1.Do;
      conditionAction1.onTrue = (Action) (() =>
      {
        if (skillGraph.IsRepredicting())
          return;
        fireAoePositions.Clear();
        fireAoeLookDirs.Clear();
        currentDuration = 0.0f;
        startTick = skillGraph.GetTick();
      });
      setVar1.var = isActive;
      setVar1.value.Set(true);
      SetVar<bool> setVar8 = setVar1;
      setVar8.Then = setVar8.Then + setVar6.Do;
      setVar6.var = aimDir;
      setVar6.value.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir().Normalized()));
      SetVar<JVector> setVar9 = setVar6;
      setVar9.Then = setVar9.Then + setVar7.Do;
      setVar7.var = skillVar1;
      setVar7.value.Expression(new Func<JVector>(skillGraph.GetPosition));
      SetVar<JVector> setVar10 = setVar7;
      setVar10.Then = setVar10.Then + modifyMovementState1.Enter;
      modifyMovementState1.mode.Constant(ModifyMovementState.Mode.DistanceOverTime);
      modifyMovementState1.moveDir.Expression((Func<JVector>) (() => aimDir.Get().Normalized()));
      modifyMovementState1.distance.Expression((Func<float>) (() => this.dashDistance));
      modifyMovementState1.duration.Expression((Func<float>) (() => this.dashDuration));
      modifyMovementState1.rotateTowardsMoveDir.Set(true);
      ModifyMovementState modifyMovementState2 = modifyMovementState1;
      modifyMovementState2.OnEnter = modifyMovementState2.OnEnter + playAudioAction1.Do;
      ModifyMovementState modifyMovementState3 = modifyMovementState1;
      modifyMovementState3.OnEnter = modifyMovementState3.OnEnter + playAudioAction2.Do;
      ModifyMovementState modifyMovementState4 = modifyMovementState1;
      modifyMovementState4.OnEnter = modifyMovementState4.OnEnter + playAudioAction3.Do;
      ModifyMovementState modifyMovementState5 = modifyMovementState1;
      modifyMovementState5.OnEnter = modifyMovementState5.OnEnter + setVar5.Do;
      ModifyMovementState modifyMovementState6 = modifyMovementState1;
      modifyMovementState6.OnEnter = modifyMovementState6.OnEnter + setVar3.Do;
      ModifyMovementState modifyMovementState7 = modifyMovementState1;
      modifyMovementState7.OnEnter = modifyMovementState7.OnEnter + mofifierToOwnerState.Enter;
      ModifyMovementState modifyMovementState8 = modifyMovementState1;
      modifyMovementState8.OnEnter = modifyMovementState8.OnEnter + multiAoeState1.Enter;
      ModifyMovementState modifyMovementState9 = modifyMovementState1;
      modifyMovementState9.SubState = modifyMovementState9.SubState + (SkillState) areaOfEffectState;
      ModifyMovementState modifyMovementState10 = modifyMovementState1;
      modifyMovementState10.SubState = modifyMovementState10.SubState + (SkillState) lockGraphsState;
      ModifyMovementState modifyMovementState11 = modifyMovementState1;
      modifyMovementState11.SubState = modifyMovementState11.SubState + (SkillState) playAnimationState1;
      ModifyMovementState modifyMovementState12 = modifyMovementState1;
      modifyMovementState12.SubState = modifyMovementState12.SubState + (SkillState) collisionLayerMaskState;
      ModifyMovementState modifyMovementState13 = modifyMovementState1;
      modifyMovementState13.SubState = modifyMovementState13.SubState + (SkillState) playAnimationState2;
      ModifyMovementState modifyMovementState14 = modifyMovementState1;
      modifyMovementState14.SubState = modifyMovementState14.SubState + (SkillState) playVfxState2;
      ModifyMovementState modifyMovementState15 = modifyMovementState1;
      modifyMovementState15.OnExit = modifyMovementState15.OnExit + buttonState.Reset;
      ModifyMovementState modifyMovementState16 = modifyMovementState1;
      modifyMovementState16.OnExit = modifyMovementState16.OnExit + modifyMovementAction.Do;
      ModifyMovementState modifyMovementState17 = modifyMovementState1;
      modifyMovementState17.OnExit = modifyMovementState17.OnExit + whileTrueState1.Enter;
      modifyMovementState1.onBeforeUpdateDelegate = (Action) (() =>
      {
        if (skillGraph.IsRepredicting())
          return;
        float fixedTimeStep = skillGraph.GetFixedTimeStep();
        positionRecord.Add(ScTime.TicksToMillis(skillGraph.GetTick(), fixedTimeStep), skillGraph.GetPosition());
        float num = this.dashDuration / (float) this.numAoes;
        while ((double) fireAoePositions.Length * (double) num <= (double) currentDuration)
        {
          fireAoePositions.Add(positionRecord.ValueAt(ScTime.TicksToMillis(startTick, fixedTimeStep) + (float) ((double) fireAoePositions.Length * (double) num * 1000.0)));
          fireAoeLookDirs.Add(skillGraph.GetLookDir());
        }
        currentDuration += fixedTimeStep;
      });
      areaOfEffectState.position.Expression(new Func<JVector>(skillGraph.GetPosition));
      areaOfEffectState.includeBall = true;
      areaOfEffectState.includeEnemies = true;
      areaOfEffectState.singleHitPerEntity = true;
      areaOfEffectState.filterHit = (Func<GameEntity, bool>) (entity => entity.HasModifier(StatusModifier.Flying));
      areaOfEffectState.aoe.Expression((Func<AreaOfEffect>) (() =>
      {
        float colliderRadius = skillGraph.GetOwner().championConfig.value.colliderRadius;
        return new AreaOfEffect()
        {
          shape = AoeShape.Circle,
          radius = colliderRadius
        };
      }));
      areaOfEffectState.hitEntities = skillVar3;
      areaOfEffectState.OnHit += applyPushStunAction1.Do;
      areaOfEffectState.OnHit += pushBallAction.Do;
      whileTrueState1.condition = (Func<bool>) (() => (bool) isActive);
      WhileTrueState whileTrueState3 = whileTrueState1;
      whileTrueState3.SubState = whileTrueState3.SubState + (SkillState) waitState1;
      waitState1.duration.Expression((Func<float>) (() => this.fireDuration));
      WaitState waitState2 = waitState1;
      waitState2.OnExit = waitState2.OnExit + multiAoeState1.Exit;
      WaitState waitState3 = waitState1;
      waitState3.OnExit = waitState3.OnExit + whileTrueState2.Enter;
      setVar5.var = skillVar2;
      setVar5.value = (SyncableValue<float>) 0.0f;
      SetVar<float> setVar11 = setVar5;
      setVar11.Then = setVar11.Then + varOverTimeState2.Enter;
      varOverTimeState2.var = skillVar2;
      varOverTimeState2.targetValue = (SyncableValue<float>) 1f;
      varOverTimeState2.amountPerSecond.Expression((Func<float>) (() => 1f / this.dashDuration));
      playVfxState1.args = (object) new AfterBurner.FireArgs()
      {
        positions = fireAoePositions,
        lookDirs = fireAoeLookDirs,
        radius = (this.fireWidth * 0.5f)
      };
      playVfxState1.vfxPrefab = this.fireTrailPrefab;
      playVfxState2.vfxPrefab = this.smokePrefab;
      playVfxState2.parentToOwner = true;
      playVfxState2.deferDestructionToEffect = true;
      multiAoeState1.hitEntities = skillVar4;
      multiAoeState1.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Circle,
        radius = this.fireWidth * 0.5f
      }));
      multiAoeState1.position = fireAoePositions;
      multiAoeState1.lookDir = fireAoeLookDirs;
      multiAoeState1.OnHit += modifyHealthAction.Do;
      multiAoeState1.includeEnemies = true;
      multiAoeState1.filterHit = (Func<GameEntity, bool>) (entity => entity.HasEffect(StatusEffectType.Invisible) || entity.HasModifier(StatusModifier.Flying));
      multiAoeState1.repeatedHitCooldown.Expression((Func<float>) (() => this.reapplyInterval));
      MultiAoeState multiAoeState2 = multiAoeState1;
      multiAoeState2.SubState = multiAoeState2.SubState + (SkillState) playVfxState1;
      multiAoeState1.onExitDelegate = (Action) (() =>
      {
        if (skillGraph.IsRepredicting())
          return;
        fireAoePositions.Clear();
        fireAoeLookDirs.Clear();
        currentDuration = 0.0f;
      });
      modifyHealthAction.targetEntities = skillVar4;
      modifyHealthAction.value.Expression((Func<int>) (() => -this.fireDamage));
      mofifierToOwnerState.modifier = StatusModifier.BlockMove;
      mofifierToOwnerState.duration.Expression((Func<float>) (() => this.dashDuration));
      collisionLayerMaskState.targetEntityId.Set(skillGraph.GetOwner().uniqueId.id);
      collisionLayerMaskState.setToLayer = CollisionLayer.None;
      collisionLayerMaskState.setToMask = CollisionLayer.Default | CollisionLayer.LvlBorder | CollisionLayer.Pickups | CollisionLayer.Bumper | CollisionLayer.Ball | CollisionLayer.Forcefield | CollisionLayer.Barrier;
      modifyMovementAction.type = ModifyMovementAction.ValueType.SetSpeed;
      modifyMovementAction.speed.Expression((Func<float>) (() => this.postDashSpeed));
      setVar2.var = isActive;
      setVar2.value.Set(false);
      applyPushStunAction1.targetEntities = skillVar3;
      applyPushStunAction1.stunDuration.Expression((Func<float>) (() => this.stunDuration));
      applyPushStunAction1.pushDuration.Expression((Func<float>) (() => this.pushDuration));
      applyPushStunAction1.getPushDir = (Func<GameEntity, JVector>) (collisionE => JVector.Cross(JVector.Cross((JVector) aimDir, collisionE.transform.Position2D - skillGraph.GetPosition()), (JVector) aimDir).Normalized());
      applyPushStunAction1.pushDistance.Expression((Func<float>) (() => this.pushDistance));
      ApplyPushStunAction applyPushStunAction2 = applyPushStunAction1;
      applyPushStunAction2.Then = applyPushStunAction2.Then + speedModEffectAction.Do;
      ApplyPushStunAction applyPushStunAction3 = applyPushStunAction1;
      applyPushStunAction3.Then = applyPushStunAction3.Then + controllerAction.Do;
      speedModEffectAction.moveSpeedModifier = (SyncableValue<float>) this.slowAmount;
      speedModEffectAction.duration = (SyncableValue<float>) this.slowDuration;
      pushBallAction.targetEntities = skillVar3;
      pushBallAction.force.Expression((Func<JVector>) (() => JVector.Cross(JVector.Cross((JVector) aimDir, skillGraph.GetContext().ballEntity.transform.Position2D - skillGraph.GetPosition()), (JVector) aimDir).Normalized() * this.pushBallForce));
      controllerAction.playerId = (SyncableValue<ulong>) skillGraph.GetOwnerId();
      controllerAction.strength = (SyncableValue<float>) 1f;
      controllerAction.duration = (SyncableValue<float>) 0.3f;
      setVar3.var = currentCooldown;
      setVar3.value.Expression((Func<float>) (() => this.cooldown));
      setVar4.var = currentCooldown;
      setVar4.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar12 = setVar4;
      setVar12.Then = setVar12.Then + whileTrueState2.Enter;
      whileTrueState2.condition = (Func<bool>) (() => (bool) isOnCooldown);
      WhileTrueState whileTrueState4 = whileTrueState2;
      whileTrueState4.OnEnter = whileTrueState4.OnEnter + setVar2.Do;
      WhileTrueState whileTrueState5 = whileTrueState2;
      whileTrueState5.SubState = whileTrueState5.SubState + (SkillState) booleanSwitchState2;
      booleanSwitchState2.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState2.WhileTrueSubState += (SkillState) varOverTimeState1;
      varOverTimeState1.var = currentCooldown;
      varOverTimeState1.amountPerSecond.Constant(-1f);
      varOverTimeState1.targetValue = (SyncableValue<float>) 0.0f;
      onEventAction2.EventType = SkillGraphEvent.Interrupt;
      onEventAction2.OnTrigger += modifyMovementState1.Exit;
      onEventAction5.EventType = SkillGraphEvent.MatchStateChanged;
      onEventAction5.OnTrigger += conditionAction2.Do;
      conditionAction2.condition = (Func<bool>) (() => (bool) isActive && skillGraph.GetContext().matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress);
      conditionAction2.OnTrue += modifyMovementState1.Exit;
      conditionAction2.OnTrue += setVar2.Do;
      onEventAction1.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction1.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction3.EventType = SkillGraphEvent.MatchStart;
      onEventAction3.OnTrigger += setVar4.Do;
      onEventAction4.EventType = SkillGraphEvent.Overtime;
      onEventAction4.OnTrigger += setVar4.Do;
    }

    public class FireArgs
    {
      public float radius;
      public SkillVar<JVector> positions;
      public SkillVar<JVector> lookDirs;
    }
  }
}
