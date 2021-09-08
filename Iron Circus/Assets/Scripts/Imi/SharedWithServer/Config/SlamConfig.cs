// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.SlamConfig
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
  [CreateAssetMenu(fileName = "SlamConfig", menuName = "SteelCircus/SkillConfigs/SlamConfig")]
  public class SlamConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string iconName = "icon_stomp_inverted_01_tex";
    public AreaOfEffect aoe;
    public float aoeOffset;
    public int damage;
    public float cooldown;
    [AnimationDuration]
    public float hopDuration;
    [AnimationDuration]
    public float postHopFreeze;
    public float stunDuration;
    public float pushDuration;
    public float pushDistance;
    public float speedModDuration;
    public float speedModAmount;
    public float pushSidewaysPercent;
    public bool showAoePreviewOnlyForLocalPlayer;
    public VfxPrefab impactVfxPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState input = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      ModifyMovementState modifyMovementState1 = skillGraph.AddState<ModifyMovementState>("HopState");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("CooldownState");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("UpdateCoodlown");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Freeze after Hop");
      ShowAoeState showAoeState = skillGraph.AddState<ShowAoeState>("Show AoE");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("Slam Anim");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("TurnToAim");
      PlayAnimationState playAnimationState3 = skillGraph.AddState<PlayAnimationState>("DontTurn");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("While ShowAoE");
      BooleanSwitchState booleanSwitchState3 = skillGraph.AddState<BooleanSwitchState>("While Button Down");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("Block other Skills");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState1 = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("FreezeMovement");
      UpdateAimDirAndMagnitude aimDirAndMagnitude = skillGraph.AddState<UpdateAimDirAndMagnitude>("UpdateAimDir");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("CheckBeforeActivating");
      CheckAreaOfEffectAction areaOfEffectAction = skillGraph.AddAction<CheckAreaOfEffectAction>("CheckHit");
      SpawnVfxAction spawnVfxAction = skillGraph.AddAction<SpawnVfxAction>("SpawnImpactVfx");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("StartAudio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("VoiceAudio");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("setShowAoe");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("setHideAoe");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("setParentAoeTrue");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("setParentAoeFalse");
      SetVar<bool> setVar5 = skillGraph.AddAction<SetVar<bool>>("SetActive");
      SetVar<float> setVar6 = skillGraph.AddAction<SetVar<float>>("ResetCooldown");
      SetVar<float> setVar7 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SetVar<JVector> setVar8 = skillGraph.AddAction<SetVar<JVector>>("setJumpStartPos");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<bool> showAoe = skillGraph.AddVar<bool>("ShowAoE");
      SkillVar<bool> skillVar = skillGraph.AddVar<bool>("ParentAoE");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> canPerformSkill = skillGraph.AddVar<bool>("CanPerformSkill");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<JVector> jumpDir = skillGraph.AddVar<JVector>("AimDir");
      SkillVar<JVector> jumpStartPos = skillGraph.AddVar<JVector>("JumpStartPos");
      SkillVar<UniqueId> hitEntities = skillGraph.AddVar<UniqueId>("Entities hit", true);
      isOnCooldown.Set(true);
      showAoe.Set(true);
      skillVar.Set(true);
      currentCooldown.Set(this.cooldown);
      canPerformSkill.Expression((Func<bool>) (() => !(bool) isOnCooldown && !(bool) isActive && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall()));
      skillGraph.AddEntryState((SkillState) input);
      skillGraph.AddEntryState((SkillState) skillUiState);
      playAudioAction1.audioResourceName.Constant("LochlanSkillSlam");
      playAudioAction2.audioResourceName.Constant("LochlanVoiceSlam");
      playAnimationState1.animationType.Constant(AnimationStateType.PrimarySkill);
      spawnVfxAction.vfxPrefab = this.impactVfxPrefab;
      spawnVfxAction.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      spawnVfxAction.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) (1.0 - (double) (float) currentCooldown / (double) this.cooldown)));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      input.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      input.buttonDownSubStates += (SkillState) booleanSwitchState3;
      input.OnButtonUp += conditionAction.Do;
      booleanSwitchState3.condition = (Func<bool>) (() => (bool) canPerformSkill);
      booleanSwitchState3.OnTrue += setVar1.Do;
      booleanSwitchState3.OnFalse += setVar2.Do;
      booleanSwitchState3.WhileTrueSubState += (SkillState) aimDirAndMagnitude;
      aimDirAndMagnitude.aimDir = jumpDir;
      aimDirAndMagnitude.dontCacheLastAim = true;
      setVar1.var = showAoe;
      setVar1.value = (SyncableValue<bool>) true;
      SetVar<bool> setVar9 = setVar1;
      setVar9.Then = setVar9.Then + setVar3.Do;
      setVar3.var = skillVar;
      setVar3.value = (SyncableValue<bool>) true;
      SetVar<bool> setVar10 = setVar3;
      setVar10.Then = setVar10.Then + booleanSwitchState2.Enter;
      booleanSwitchState2.condition = (Func<bool>) (() => (bool) showAoe);
      booleanSwitchState2.WhileTrueSubState += (SkillState) showAoeState;
      booleanSwitchState2.WhileTrueSubState += (SkillState) playAnimationState2;
      booleanSwitchState2.WhileTrueSubState += (SkillState) lockGraphsState;
      playAnimationState2.animationType.Constant(AnimationStateType.TurnHeadToAim);
      showAoeState.showOnlyForLocalPlayer.Expression((Func<bool>) (() => this.showAoePreviewOnlyForLocalPlayer));
      showAoeState.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      showAoeState.trackOwnerPosition = (SyncableValue<bool>) false;
      conditionAction.condition = (Func<bool>) (() => (bool) canPerformSkill);
      conditionAction.OnTrue += setVar5.Do;
      setVar5.var = isActive;
      setVar5.value = (SyncableValue<bool>) true;
      SetVar<bool> setVar11 = setVar5;
      setVar11.Then = setVar11.Then + setVar8.Do;
      setVar8.var = jumpStartPos;
      setVar8.value.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      SetVar<JVector> setVar12 = setVar8;
      setVar12.Then = setVar12.Then + setVar4.Do;
      setVar4.var = skillVar;
      setVar4.value = (SyncableValue<bool>) false;
      SetVar<bool> setVar13 = setVar4;
      setVar13.Then = setVar13.Then + modifyMovementState1.Enter;
      modifyMovementState1.mode.Constant(ModifyMovementState.Mode.DistanceOverTime);
      modifyMovementState1.distance.Expression((Func<float>) (() => this.aoe.deadZone + this.aoeOffset));
      modifyMovementState1.duration.Expression((Func<float>) (() => this.hopDuration));
      modifyMovementState1.moveDir.Expression((Func<JVector>) (() => jumpDir.Get()));
      modifyMovementState1.rotateTowardsMoveDir.Set(true);
      ModifyMovementState modifyMovementState2 = modifyMovementState1;
      modifyMovementState2.SubState = modifyMovementState2.SubState + (SkillState) playAnimationState1;
      ModifyMovementState modifyMovementState3 = modifyMovementState1;
      modifyMovementState3.SubState = modifyMovementState3.SubState + (SkillState) lockGraphsState;
      ModifyMovementState modifyMovementState4 = modifyMovementState1;
      modifyMovementState4.SubState = modifyMovementState4.SubState + (SkillState) playAnimationState3;
      ModifyMovementState modifyMovementState5 = modifyMovementState1;
      modifyMovementState5.OnEnter = modifyMovementState5.OnEnter + mofifierToOwnerState1.Enter;
      ModifyMovementState modifyMovementState6 = modifyMovementState1;
      modifyMovementState6.OnEnter = modifyMovementState6.OnEnter + setVar6.Do;
      ModifyMovementState modifyMovementState7 = modifyMovementState1;
      modifyMovementState7.OnEnter = modifyMovementState7.OnEnter + playAudioAction1.Do;
      ModifyMovementState modifyMovementState8 = modifyMovementState1;
      modifyMovementState8.OnEnter = modifyMovementState8.OnEnter + playAudioAction2.Do;
      ModifyMovementState modifyMovementState9 = modifyMovementState1;
      modifyMovementState9.OnExit = modifyMovementState9.OnExit + waitState1.Enter;
      ModifyMovementState modifyMovementState10 = modifyMovementState1;
      modifyMovementState10.OnExit = modifyMovementState10.OnExit + areaOfEffectAction.Do;
      ModifyMovementState modifyMovementState11 = modifyMovementState1;
      modifyMovementState11.OnExit = modifyMovementState11.OnExit + spawnVfxAction.Do;
      ModifyMovementState modifyMovementState12 = modifyMovementState1;
      modifyMovementState12.OnExit = modifyMovementState12.OnExit + setVar2.Do;
      setVar6.var = currentCooldown;
      setVar6.value.Expression((Func<float>) (() => this.cooldown));
      playAnimationState3.animationType.Constant(AnimationStateType.DontTurnHead);
      mofifierToOwnerState1.duration.Expression((Func<float>) (() => this.hopDuration + this.postHopFreeze));
      mofifierToOwnerState1.modifier = StatusModifier.BlockMove | StatusModifier.BlockHoldBall;
      ApplyStatusMofifierToOwnerState mofifierToOwnerState2 = mofifierToOwnerState1;
      mofifierToOwnerState2.SubState = mofifierToOwnerState2.SubState + (SkillState) playAnimationState3;
      setVar2.var = showAoe;
      setVar2.value = (SyncableValue<bool>) false;
      waitState1.duration.Expression((Func<float>) (() => this.postHopFreeze));
      WaitState waitState2 = waitState1;
      waitState2.OnExit = waitState2.OnExit + whileTrueState1.Enter;
      waitState1.onExitDelegate = (Action) (() => isActive.Set(false));
      areaOfEffectAction.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      areaOfEffectAction.position.Expression((Func<JVector>) (() => (JVector) jumpStartPos + jumpDir.Get() * this.aoeOffset));
      areaOfEffectAction.lookDir.Expression((Func<JVector>) (() => (JVector) jumpDir));
      areaOfEffectAction.hitEntities = hitEntities;
      areaOfEffectAction.includeEnemies = true;
      areaOfEffectAction.filterHit = (Func<GameEntity, bool>) (gameEntity => gameEntity.HasModifier(StatusModifier.Flying));
      areaOfEffectAction.thenDelegate = (Action) (() =>
      {
        if (!skillGraph.IsServer())
          return;
        GameEntity owner = skillGraph.GetOwner();
        for (int i = 0; i < hitEntities.Length; ++i)
        {
          GameEntity entity = skillGraph.GetEntity(hitEntities[i]);
          skillGraph.GetContext().eventDispatcher.value.EnqueueStunEvent(entity.playerId.value, skillGraph.GetOwnerId(), this.stunDuration);
          entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Stun(skillGraph.GetOwnerId(), this.stunDuration));
          JVector vector2 = owner.transform.Vector2DTo(entity.transform.Position2D).Normalized();
          JVector lookDir = skillGraph.GetLookDir();
          JVector jvector = JVector.Cross(JVector.Cross(lookDir, vector2), lookDir);
          JVector direction = JVector.Lerp(vector2, jvector, this.pushSidewaysPercent);
          StatusEffect effect1 = StatusEffect.Push(skillGraph.GetOwnerId(), direction, this.pushDistance, this.pushDuration);
          entity.AddStatusEffect(skillGraph.GetContext(), effect1);
          if ((double) this.speedModDuration > 0.0)
          {
            StatusEffect effect2 = StatusEffect.MovementSpeedChange(skillGraph.GetOwnerId(), this.speedModAmount, this.speedModDuration);
            entity.AddStatusEffect(skillGraph.GetContext(), effect2);
          }
        }
      });
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState1;
      whileTrueState1.onEnterDelegate = (Action) (() => isOnCooldown.Set(true));
      whileTrueState1.onExitDelegate = (Action) (() => isOnCooldown.Set(false));
      booleanSwitchState1.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState1.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState.amountPerSecond.Constant(-1f);
      onEventAction2.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction2.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction1.EventType = SkillGraphEvent.Interrupt;
      onEventAction1.onTriggerDelegate = (Action) (() =>
      {
        input.ResetInput();
        isActive.Set(false);
        showAoe.Set(false);
        lockGraphsState.Exit_();
      });
      onEventAction3.EventType = SkillGraphEvent.MatchStart;
      onEventAction3.OnTrigger += whileTrueState1.Enter;
      onEventAction4.EventType = SkillGraphEvent.Overtime;
      onEventAction4.OnTrigger += setVar7.Do;
      setVar7.var = currentCooldown;
      setVar7.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar14 = setVar7;
      setVar14.Then = setVar14.Then + whileTrueState1.Enter;
    }
  }
}
