// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.ElectrobaticsConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Utils;
using Imi.SharedWithServer.Utils.Extensions;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "Electrobatics", menuName = "SteelCircus/SkillConfigs/Electrobatics")]
  public class ElectrobaticsConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public float cooldown;
    [AnimationDuration]
    public float hopDuration;
    [AnimationDuration]
    public float postHopFreeze;
    public float hopDistanceMin;
    public float hopDistanceMax;
    public float hopDistanceChargeDuration;
    public AreaOfEffect aoe;
    public bool showAoePreviewForOtherPlayers;
    public float stunDuration;
    public float pushDuration;
    public float pushDistance;
    public float slowAmount;
    public float slowDuration;
    public int damage;
    public VfxPrefab impactVfxPrefab;
    public VfxPrefab lightningTrailVfxPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("WhileButtonDown");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("Cooldown");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("Should Update Cooldown");
      ModVarOverTimeState varOverTimeState1 = skillGraph.AddState<ModVarOverTimeState>("Update Cooldown");
      ModVarOverTimeState varOverTimeState2 = skillGraph.AddState<ModVarOverTimeState>("Charge Hop");
      ModifyMovementState modifyMovementState1 = skillGraph.AddState<ModifyMovementState>("Hop");
      ShowAoeState showAoeState1 = skillGraph.AddState<ShowAoeState>("Show AoE");
      ChangeCollisionLayerMaskState collisionLayerMaskState = skillGraph.AddState<ChangeCollisionLayerMaskState>("Change Collision State");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("Block other Skills");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("LookForward");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("TurnInAimDir");
      PlayAnimationState playAnimationState3 = skillGraph.AddState<PlayAnimationState>("PlayAnim");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState1 = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("BlockMoveAndHoldBall");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState2 = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("ImmuneToTackle");
      BooleanSwitchState booleanSwitchState3 = skillGraph.AddState<BooleanSwitchState>("WhileShowAoe");
      PlayVfxState playVfxState = skillGraph.AddState<PlayVfxState>("Show Lightning Trail");
      UpdateAimDirAndMagnitude aimDirAndMagnitude = skillGraph.AddState<UpdateAimDirAndMagnitude>("UpdateAim");
      AudioState audioState = skillGraph.AddState<AudioState>("electrobatics Aim Audio Loop");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("CanStartSkill");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      CheckAreaOfEffectAction areaOfEffectAction1 = skillGraph.AddAction<CheckAreaOfEffectAction>("CheckHit");
      RumbleControllerAction controllerAction = skillGraph.AddAction<RumbleControllerAction>("RumbleOnImpact");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("Trigger meteor dive start Audio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Trigger meteor dive voice Audio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("Trigger meteor dive land Audio");
      SpawnVfxAction spawnVfxAction = skillGraph.AddAction<SpawnVfxAction>("SpawnImpactVfx");
      ModifyMovementAction modifyMovementAction = skillGraph.AddAction<ModifyMovementAction>("SpawnImpactVfx");
      SetVar<float> setVar1 = skillGraph.AddAction<SetVar<float>>("Reset Cooldown");
      SetVar<float> setVar2 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SetVar<float> setVar3 = skillGraph.AddAction<SetVar<float>>("ResetHopCharge");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("SetActive");
      SetVar<bool> setVar5 = skillGraph.AddAction<SetVar<bool>>("SetNotActive");
      SetVar<bool> setVar6 = skillGraph.AddAction<SetVar<bool>>("SetOnCooldown");
      SetVar<bool> setVar7 = skillGraph.AddAction<SetVar<bool>>("SetNotOnCooldown");
      SetVar<bool> setVar8 = skillGraph.AddAction<SetVar<bool>>("SetShowAoeTrue");
      SetVar<bool> setVar9 = skillGraph.AddAction<SetVar<bool>>("SetShowAoeFalse");
      SetVar<bool> setVar10 = skillGraph.AddAction<SetVar<bool>>("setParentAoeTrue");
      SetVar<bool> setVar11 = skillGraph.AddAction<SetVar<bool>>("setParentAoeFalse");
      SetVar<JVector> setVar12 = skillGraph.AddAction<SetVar<JVector>>("setJumpStartPos");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<float> jumpCharge = skillGraph.AddVar<float>("HopCharge");
      SkillVar<float> jumpDistance = skillGraph.AddVar<float>("HopDistance");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> showAoe = skillGraph.AddVar<bool>("ShowAoe");
      SkillVar<bool> parentAoe = skillGraph.AddVar<bool>("ParentAoe");
      SkillVar<bool> canStartSkill = skillGraph.AddVar<bool>("CanStartSkill");
      SkillVar<UniqueId> hitEntities = skillGraph.AddVar<UniqueId>("Entities hit", true);
      SkillVar<JVector> jumpStartPos = skillGraph.AddVar<JVector>("JumpStartPos");
      SkillVar<JVector> jumpDir = skillGraph.AddVar<JVector>("JumpDir");
      currentCooldown.Set(this.cooldown);
      parentAoe.Set(true);
      jumpDistance.Expression((Func<float>) (() => MathExtensions.Interpolate(this.hopDistanceMin, this.hopDistanceMax, (float) jumpCharge)));
      canStartSkill.Expression((Func<bool>) (() => !(bool) isOnCooldown && !(bool) isActive && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall()));
      spawnVfxAction.vfxPrefab = this.impactVfxPrefab;
      spawnVfxAction.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      spawnVfxAction.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillUiState.buttonType.Constant(this.button);
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      skillUiState.fillAmount.Expression((Func<float>) (() => (this.cooldown - (float) currentCooldown) / this.cooldown));
      audioState.audioResourceName.Constant("ShaniSkillElectrobaticsAimLoop");
      playAudioAction1.audioResourceName.Constant("ShaniSkillElectrobaticsLeap");
      playAudioAction2.audioResourceName.Constant("ShaniVoiceElectrobatics");
      playAudioAction3.audioResourceName.Constant("ShaniSkillElectrobaticsImpact");
      buttonState.buttonType.Constant(this.button);
      buttonState.buttonDownSubStates += (SkillState) booleanSwitchState1;
      buttonState.OnButtonUp += conditionAction.Do;
      booleanSwitchState1.condition = (Func<bool>) (() => (bool) canStartSkill);
      BooleanSwitchState booleanSwitchState4 = booleanSwitchState1;
      booleanSwitchState4.OnEnter = booleanSwitchState4.OnEnter + setVar3.Do;
      booleanSwitchState1.OnTrue += setVar8.Do;
      booleanSwitchState1.OnFalse += setVar9.Do;
      booleanSwitchState1.WhileTrueSubState += (SkillState) varOverTimeState2;
      booleanSwitchState1.WhileTrueSubState += (SkillState) playAnimationState2;
      setVar3.var = jumpCharge;
      setVar3.value.Set(0.0f);
      playAnimationState2.animationType.Constant(AnimationStateType.TurnHeadToAim);
      varOverTimeState2.var = jumpCharge;
      varOverTimeState2.targetValue = (SyncableValue<float>) 1f;
      varOverTimeState2.amountPerSecond.Expression((Func<float>) (() => (double) this.hopDistanceChargeDuration <= 0.0 ? 1f : 1f / this.hopDistanceChargeDuration));
      conditionAction.condition = (Func<bool>) (() => (bool) canStartSkill);
      conditionAction.OnTrue += setVar11.Do;
      conditionAction.OnFalse += setVar9.Do;
      setVar11.var = parentAoe;
      setVar11.value.Set(false);
      SetVar<bool> setVar13 = setVar11;
      setVar13.Then = setVar13.Then + setVar12.Do;
      setVar12.var = jumpStartPos;
      setVar12.value.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      SetVar<JVector> setVar14 = setVar12;
      setVar14.Then = setVar14.Then + modifyMovementState1.Enter;
      SetVar<JVector> setVar15 = setVar12;
      setVar15.Then = setVar15.Then + mofifierToOwnerState1.Enter;
      SetVar<JVector> setVar16 = setVar12;
      setVar16.Then = setVar16.Then + aimDirAndMagnitude.Exit;
      setVar8.var = showAoe;
      setVar8.value.Set(true);
      SetVar<bool> setVar17 = setVar8;
      setVar17.Then = setVar17.Then + setVar10.Do;
      SetVar<bool> setVar18 = setVar8;
      setVar18.Then = setVar18.Then + aimDirAndMagnitude.Enter;
      setVar10.var = parentAoe;
      setVar10.value.Set(true);
      SetVar<bool> setVar19 = setVar10;
      setVar19.Then = setVar19.Then + booleanSwitchState3.Enter;
      booleanSwitchState3.condition = (Func<bool>) (() => (bool) showAoe);
      booleanSwitchState3.WhileTrueSubState += (SkillState) showAoeState1;
      showAoeState1.showOnlyForLocalPlayer.Constant(!this.showAoePreviewForOtherPlayers);
      showAoeState1.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      showAoeState1.trackOwnerPosition = (SyncableValue<bool>) false;
      showAoeState1.position.Expression((Func<JVector>) (() => !parentAoe.Get() ? (JVector) jumpStartPos + (JVector) jumpDir * (float) jumpDistance : skillGraph.GetPosition() + (JVector) jumpDir * (float) jumpDistance));
      showAoeState1.lookDir.Expression((Func<JVector>) (() => (JVector) jumpDir));
      showAoeState1.onUnparentPosition.Expression((Func<JVector>) (() => (JVector) jumpStartPos));
      ShowAoeState showAoeState2 = showAoeState1;
      showAoeState2.SubState = showAoeState2.SubState + (SkillState) lockGraphsState;
      ShowAoeState showAoeState3 = showAoeState1;
      showAoeState3.SubState = showAoeState3.SubState + (SkillState) audioState;
      aimDirAndMagnitude.aimDir = jumpDir;
      aimDirAndMagnitude.aimMagnitude = jumpCharge;
      modifyMovementState1.mode.Constant(ModifyMovementState.Mode.DistanceOverTime);
      modifyMovementState1.distance.Expression((Func<float>) (() => (float) jumpDistance));
      modifyMovementState1.moveDir.Expression((Func<JVector>) (() => (JVector) jumpDir));
      modifyMovementState1.duration.Expression((Func<float>) (() => this.hopDuration));
      ModifyMovementState modifyMovementState2 = modifyMovementState1;
      modifyMovementState2.OnEnter = modifyMovementState2.OnEnter + setVar4.Do;
      ModifyMovementState modifyMovementState3 = modifyMovementState1;
      modifyMovementState3.OnEnter = modifyMovementState3.OnEnter + setVar1.Do;
      ModifyMovementState modifyMovementState4 = modifyMovementState1;
      modifyMovementState4.OnEnter = modifyMovementState4.OnEnter + playAudioAction1.Do;
      ModifyMovementState modifyMovementState5 = modifyMovementState1;
      modifyMovementState5.OnEnter = modifyMovementState5.OnEnter + playAudioAction2.Do;
      ModifyMovementState modifyMovementState6 = modifyMovementState1;
      modifyMovementState6.OnEnter = modifyMovementState6.OnEnter + playVfxState.Enter;
      ModifyMovementState modifyMovementState7 = modifyMovementState1;
      modifyMovementState7.OnExit = modifyMovementState7.OnExit + playVfxState.Exit;
      ModifyMovementState modifyMovementState8 = modifyMovementState1;
      modifyMovementState8.OnExit = modifyMovementState8.OnExit + areaOfEffectAction1.Do;
      ModifyMovementState modifyMovementState9 = modifyMovementState1;
      modifyMovementState9.OnExit = modifyMovementState9.OnExit + controllerAction.Do;
      ModifyMovementState modifyMovementState10 = modifyMovementState1;
      modifyMovementState10.OnExit = modifyMovementState10.OnExit + spawnVfxAction.Do;
      ModifyMovementState modifyMovementState11 = modifyMovementState1;
      modifyMovementState11.OnExit = modifyMovementState11.OnExit + setVar9.Do;
      ModifyMovementState modifyMovementState12 = modifyMovementState1;
      modifyMovementState12.OnExit = modifyMovementState12.OnExit + modifyMovementAction.Do;
      ModifyMovementState modifyMovementState13 = modifyMovementState1;
      modifyMovementState13.SubState = modifyMovementState13.SubState + (SkillState) lockGraphsState;
      ModifyMovementState modifyMovementState14 = modifyMovementState1;
      modifyMovementState14.SubState = modifyMovementState14.SubState + (SkillState) collisionLayerMaskState;
      ModifyMovementState modifyMovementState15 = modifyMovementState1;
      modifyMovementState15.SubState = modifyMovementState15.SubState + (SkillState) playAnimationState3;
      ModifyMovementState modifyMovementState16 = modifyMovementState1;
      modifyMovementState16.SubState = modifyMovementState16.SubState + (SkillState) playAnimationState1;
      ModifyMovementState modifyMovementState17 = modifyMovementState1;
      modifyMovementState17.SubState = modifyMovementState17.SubState + (SkillState) mofifierToOwnerState2;
      setVar1.var = currentCooldown;
      setVar1.value.Expression((Func<float>) (() => this.cooldown));
      setVar4.var = isActive;
      setVar4.value.Set(true);
      modifyMovementAction.type = ModifyMovementAction.ValueType.SetSpeed;
      modifyMovementAction.speed = (SyncableValue<float>) 0.0f;
      controllerAction.playerId = (SyncableValue<ulong>) skillGraph.GetOwnerId();
      controllerAction.strength = (SyncableValue<float>) 1f;
      controllerAction.duration = (SyncableValue<float>) 1f;
      mofifierToOwnerState1.modifier = StatusModifier.BlockMove | StatusModifier.BlockHoldBall;
      mofifierToOwnerState1.duration.Expression((Func<float>) (() => this.hopDuration + this.postHopFreeze));
      mofifierToOwnerState2.modifier = StatusModifier.ImmuneToTackle;
      setVar9.var = showAoe;
      setVar9.value.Set(false);
      playAnimationState3.animationType.Constant(AnimationStateType.PrimarySkill);
      playAnimationState3.variation = (SyncableValue<int>) 0;
      playAnimationState1.animationType.Constant(AnimationStateType.DontTurnHead);
      collisionLayerMaskState.targetEntityId = (SyncableValue<UniqueId>) skillGraph.GetOwner().uniqueId.id;
      collisionLayerMaskState.setToLayer = CollisionLayer.None;
      collisionLayerMaskState.setToMask = CollisionLayer.LvlBorder;
      areaOfEffectAction1.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      areaOfEffectAction1.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      areaOfEffectAction1.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      areaOfEffectAction1.hitEntities = hitEntities;
      areaOfEffectAction1.includeEnemies = true;
      areaOfEffectAction1.filterHit = (Func<GameEntity, bool>) (entity => entity.HasModifier(StatusModifier.Flying));
      areaOfEffectAction1.thenDelegate = (Action) (() =>
      {
        if (!skillGraph.IsServer())
          return;
        GameEntity owner = skillGraph.GetOwner();
        for (int i = 0; i < hitEntities.Length; ++i)
        {
          GameEntity entity = skillGraph.GetEntity(hitEntities[i]);
          skillGraph.GetContext().eventDispatcher.value.EnqueueStunEvent(entity.playerId.value, skillGraph.GetOwnerId(), this.stunDuration);
          if ((double) this.stunDuration > 0.0)
            entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Stun(skillGraph.GetOwnerId(), this.stunDuration));
          if ((double) this.pushDistance > 0.0 && (double) this.pushDuration > 0.0)
            entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Push(skillGraph.GetOwnerId(), owner.transform.Vector2DTo(entity.transform.Position2D).Normalized(), this.pushDistance, this.pushDuration));
          if ((double) this.slowDuration > 0.0)
            entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.MovementSpeedChange(skillGraph.GetOwnerId(), this.slowAmount, this.slowDuration));
          int damage = this.damage;
        }
      });
      CheckAreaOfEffectAction areaOfEffectAction2 = areaOfEffectAction1;
      areaOfEffectAction2.Then = areaOfEffectAction2.Then + whileTrueState1.Enter;
      CheckAreaOfEffectAction areaOfEffectAction3 = areaOfEffectAction1;
      areaOfEffectAction3.Then = areaOfEffectAction3.Then + setVar5.Do;
      CheckAreaOfEffectAction areaOfEffectAction4 = areaOfEffectAction1;
      areaOfEffectAction4.Then = areaOfEffectAction4.Then + playAudioAction3.Do;
      setVar5.var = isActive;
      setVar5.value.Set(false);
      playVfxState.vfxPrefab = this.lightningTrailVfxPrefab;
      playVfxState.parentToOwner = false;
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 1.40129846432482E-45);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState2;
      WhileTrueState whileTrueState3 = whileTrueState1;
      whileTrueState3.OnEnter = whileTrueState3.OnEnter + setVar6.Do;
      WhileTrueState whileTrueState4 = whileTrueState1;
      whileTrueState4.OnExit = whileTrueState4.OnExit + setVar7.Do;
      setVar6.var = isOnCooldown;
      setVar6.value.Set(true);
      setVar7.var = isOnCooldown;
      setVar7.value.Set(false);
      booleanSwitchState2.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState2.WhileTrueSubState += (SkillState) varOverTimeState1;
      varOverTimeState1.var = currentCooldown;
      varOverTimeState1.amountPerSecond.Constant(-1f);
      varOverTimeState1.targetValue = (SyncableValue<float>) 0.0f;
      onEventAction1.EventType = SkillGraphEvent.MatchStart;
      onEventAction1.OnTrigger += whileTrueState1.Enter;
      onEventAction2.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction2.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction3.EventType = SkillGraphEvent.Interrupt;
      onEventAction3.OnTrigger += buttonState.Reset;
      onEventAction3.OnTrigger += setVar9.Do;
      onEventAction4.EventType = SkillGraphEvent.Overtime;
      onEventAction4.OnTrigger += setVar2.Do;
      setVar2.var = currentCooldown;
      setVar2.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar20 = setVar2;
      setVar20.Then = setVar20.Then + whileTrueState1.Enter;
    }
  }
}
