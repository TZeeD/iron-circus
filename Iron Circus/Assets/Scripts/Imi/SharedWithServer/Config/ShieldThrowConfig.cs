// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.ShieldThrowConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "ShieldThrowConfig", menuName = "SteelCircus/SkillConfigs/ShieldThrowConfig")]
  public class ShieldThrowConfig : SkillGraphConfig
  {
    [Header("General Settings")]
    public string iconName = "icon_stomp_inverted_01_tex";
    public AreaOfEffect shape;
    public float cooldown = 30f;
    public bool showPreviewOnRemoteEntities = true;
    public float maxAirTimeFallback = 30f;
    public float durationUntilHideShield = 0.25f;
    public float aimMovementFactor = 0.25f;
    public string shieldInChampionName = "char_hildegard_shield_model";
    [Header("Shield Kinetics")]
    public float shieldSpeed = 6f;
    public float shieldRotationSpeed = 10f;
    public JVector spawnOffset = new JVector(0.0f, 1.2f, 0.5f);
    public float shieldCollisionRadius = 1f;
    public float shieldCollisionHeight = 0.4f;
    [Header("Impact")]
    public int damage = 1;
    public float pushDistance = 1f;
    public float stunDuration;
    public float pushDuration;
    public int destroyAfterImpactCount = 3;
    public float minDistanceBetweenImpactCount = 1f;
    public float maxTravelDistanceUntilImpact = 30f;
    public VfxPrefab shieldPrefab;
    public VfxPrefab impactVfxPrefab;
    public VfxPrefab dissolveVfxPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      ShowAoeState aimState = skillGraph.AddState<ShowAoeState>("Aim Preview");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("Throw Animation");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("TurnToAimAnimation");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Delay Throw");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("While skill can be Performed");
      ProjectileState projectileState = skillGraph.AddState<ProjectileState>("Projectile State");
      SetOwnerObjectVisibilityState objectVisibilityState = skillGraph.AddState<SetOwnerObjectVisibilityState>("Hide Shield");
      AudioState audioState = skillGraph.AddState<AudioState>("Play Shield fly Audio");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("CooldownState");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("UpdateCooldown");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("LockGraphsState");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnSkillPickup");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("Trigger Toss Audio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Trigger Toss Voice");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("End Toss Audio");
      PlayAudioAction playAudioAction4 = skillGraph.AddAction<PlayAudioAction>("Shield Hit Audio");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("CanThrow");
      SpawnVfxAction spawnVfxAction1 = skillGraph.AddAction<SpawnVfxAction>("impact vfx");
      SpawnVfxAction spawnVfxAction2 = skillGraph.AddAction<SpawnVfxAction>("dissolve vfx");
      SetVar<JVector> setVar1 = skillGraph.AddAction<SetVar<JVector>>("Update Aim Direction");
      SetVar<float> setVar2 = skillGraph.AddAction<SetVar<float>>("ResetCooldown");
      SetVar<float> setVar3 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SkillVar<JVector> skillVar = skillGraph.AddVar<JVector>("AimDir");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<bool> isNotInPreviewState = skillGraph.AddVar<bool>("IsNotPreviewing");
      SkillVar<bool> canPerformSkill = skillGraph.AddVar<bool>("CanActivateSkill");
      SkillVar<bool> isAiming = skillGraph.AddVar<bool>("IsAiming");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      currentCooldown.Set(this.cooldown);
      isOnCooldown.Set(true);
      isNotInPreviewState.Expression((Func<bool>) (() => !aimState.IsActive));
      canPerformSkill.Expression((Func<bool>) (() => !skillGraph.IsSkillUseDisabled() && !skillGraph.OwnerHasBall() && !skillGraph.IsGraphLocked() && !projectileState.IsActive && !(bool) isOnCooldown));
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      spawnVfxAction1.vfxPrefab = this.impactVfxPrefab;
      spawnVfxAction2.vfxPrefab = this.dissolveVfxPrefab;
      skillUiState.buttonType.Constant(Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill);
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.fillAmount.Expression((Func<float>) (() => (this.cooldown - (float) currentCooldown) / this.cooldown));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      playAnimationState1.animationType.Constant(AnimationStateType.PrimarySkill);
      audioState.audioResourceName.Constant("EllikaSkillShieldTossLoop");
      playAudioAction1.audioResourceName.Constant("EllikaSkillShieldTossBegin");
      playAudioAction2.audioResourceName.Constant("EllikaVoiceShieldToss");
      playAudioAction3.audioResourceName.Constant("EllikaSkillShieldTossEnd");
      playAudioAction4.audioResourceName.Constant("EllikaSkillShieldTossHit");
      playAudioAction4.doNotTrack.Constant(true);
      buttonState.buttonType.Constant(Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill);
      buttonState.buttonDownSubStates += (SkillState) booleanSwitchState1;
      buttonState.OnButtonUp += conditionAction.Do;
      booleanSwitchState1.condition = (Func<bool>) (() => (bool) canPerformSkill);
      booleanSwitchState1.WhileTrueSubState += (SkillState) aimState;
      booleanSwitchState1.WhileTrueSubState += (SkillState) playAnimationState1;
      booleanSwitchState1.WhileTrueSubState += (SkillState) playAnimationState2;
      booleanSwitchState1.WhileTrueSubState += (SkillState) lockGraphsState;
      playAnimationState2.animationType.Constant(AnimationStateType.TurnHeadToAim);
      conditionAction.condition = (Func<bool>) (() => (bool) canPerformSkill && !(bool) isOnCooldown && (bool) isAiming);
      conditionAction.OnTrue += playAudioAction1.Do;
      conditionAction.OnTrue += playAudioAction2.Do;
      conditionAction.OnTrue += waitState1.Enter;
      conditionAction.OnTrue += setVar2.Do;
      conditionAction.onTrue = (Action) (() => isAiming.Set(false));
      setVar2.var = currentCooldown;
      setVar2.value.Expression((Func<float>) (() => this.cooldown));
      aimState.showOnlyForLocalPlayer.Constant(!this.showPreviewOnRemoteEntities);
      aimState.aoe.Expression((Func<AreaOfEffect>) (() => this.shape));
      aimState.onEnterDelegate = (Action) (() =>
      {
        isAiming.Set(true);
        GameEntity owner = skillGraph.GetOwner();
        float offset = this.aimMovementFactor - 1f;
        GameContext context = skillGraph.GetContext();
        StatusEffect effect = StatusEffect.MovementSpeedChange(skillGraph.GetOwnerId(), offset, 0.0f, isNotInPreviewState);
        owner.AddStatusEffect(context, effect);
      });
      aimState.trackOwnerPosition = (SyncableValue<bool>) false;
      ShowAoeState showAoeState = aimState;
      showAoeState.OnUpdate = showAoeState.OnUpdate + setVar1.Do;
      setVar1.var = skillVar;
      setVar1.value.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir()));
      waitState1.duration.Expression((Func<float>) (() => this.durationUntilHideShield));
      WaitState waitState2 = waitState1;
      waitState2.OnExit = waitState2.OnExit + projectileState.Enter;
      projectileState.throwDir = skillVar;
      projectileState.spawnOffset.Expression((Func<JVector>) (() => this.spawnOffset));
      projectileState.initialSpeed.Expression((Func<float>) (() => this.shieldSpeed));
      projectileState.maxLifeTime.Expression((Func<float>) (() => this.maxAirTimeFallback));
      projectileState.maxTravelDistance.Expression((Func<float>) (() => this.maxTravelDistanceUntilImpact));
      projectileState.numBounces.Expression((Func<int>) (() => this.destroyAfterImpactCount));
      projectileState.impactDamage.Expression((Func<int>) (() => this.damage));
      projectileState.pushDistance.Expression((Func<float>) (() => this.pushDistance));
      projectileState.pushDuration.Expression((Func<float>) (() => this.pushDuration));
      projectileState.stunDuration.Expression((Func<float>) (() => this.stunDuration));
      projectileState.collisionRadius.Expression((Func<float>) (() => this.shieldCollisionRadius));
      projectileState.collisionHeight.Expression((Func<float>) (() => this.shieldCollisionHeight));
      projectileState.rotationSpeed.Expression((Func<float>) (() => this.shieldRotationSpeed));
      projectileState.prefab.Constant(this.shieldPrefab.value);
      projectileState.OnImpact += playAudioAction4.Do;
      projectileState.OnImpact += spawnVfxAction1.Do;
      ProjectileState projectileState1 = projectileState;
      projectileState1.OnExit = projectileState1.OnExit + playAudioAction3.Do;
      ProjectileState projectileState2 = projectileState;
      projectileState2.OnExit = projectileState2.OnExit + spawnVfxAction2.Do;
      ProjectileState projectileState3 = projectileState;
      projectileState3.OnExit = projectileState3.OnExit + whileTrueState1.Enter;
      ProjectileState projectileState4 = projectileState;
      projectileState4.SubState = projectileState4.SubState + (SkillState) objectVisibilityState;
      ProjectileState projectileState5 = projectileState;
      projectileState5.SubState = projectileState5.SubState + (SkillState) audioState;
      spawnVfxAction1.position.Expression((Func<JVector>) (() => projectileState.serverPosition.Get()));
      spawnVfxAction2.position.Expression((Func<JVector>) (() => projectileState.serverPosition.Get()));
      objectVisibilityState.objectTagName.Constant("shield");
      objectVisibilityState.visibility.Constant(false);
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState2;
      whileTrueState1.onEnterDelegate = (Action) (() => isOnCooldown.Set(true));
      whileTrueState1.onExitDelegate = (Action) (() => isOnCooldown.Set(false));
      booleanSwitchState2.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState2.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState.amountPerSecond.Constant(-1f);
      onEventAction1.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction1.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction2.EventType = SkillGraphEvent.MatchStart;
      onEventAction2.OnTrigger += whileTrueState1.Enter;
      onEventAction3.EventType = SkillGraphEvent.Overtime;
      onEventAction3.OnTrigger += setVar3.Do;
      setVar3.var = currentCooldown;
      setVar3.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar4 = setVar3;
      setVar4.Then = setVar4.Then + whileTrueState1.Enter;
    }
  }
}
