// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.VirtualStrikeConfig
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
  [CreateAssetMenu(fileName = "VirtualStrike", menuName = "SteelCircus/SkillConfigs/VirtualStrike")]
  public class VirtualStrikeConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button = Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill;
    public string iconName = "icon_mine_inverted_01_tex";
    public float cooldown = 30f;
    public AreaOfEffect aoeExit;
    public float aoeDisplayDuration = 0.5f;
    public float disappearDuration = 0.5f;
    public float hitAppearDuration = 0.5f;
    public float timeUntilFloorEffect = 0.5f;
    public float maxInvisibleDuration = 5f;
    public int damage = 1;
    public float initialFloorSpeed = 6f;
    public float moveSpeedModifier = 0.25f;
    public float appearSpeedModifier = -0.9f;
    public float appearSpeedModifierDuration = 0.5f;
    public float stunDuration = 1.5f;
    public float pushDuration = 0.25f;
    public float pushDistance = 3f;
    public float minHopDistance = 2f;
    public float hopDuration = 0.5f;
    public VfxPrefab strikeVfxPrefab;
    public VfxPrefab floorVfxPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      WaitState disappearingState = skillGraph.AddState<WaitState>("Disappear State");
      WaitState invisibleState = skillGraph.AddState<WaitState>("Invisible");
      InvisibleState invisibleState1 = skillGraph.AddState<InvisibleState>("InvisibleStatus");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Appear State");
      WaitState waitState2 = skillGraph.AddState<WaitState>("Appear Aoe Duration State");
      ShowAoeState showAoeState = skillGraph.AddState<ShowAoeState>("Appear Aoe Vfx");
      ModifyMovementState modifyMovementState1 = skillGraph.AddState<ModifyMovementState>("Move faster State");
      ModFloorUiState hideChampUi = skillGraph.AddState<ModFloorUiState>("HideChampUi");
      ModFloorUiState modFloorUiState = skillGraph.AddState<ModFloorUiState>("HideChampUi");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("While Active");
      ChangeCollisionLayerMaskState collisionLayerMaskState = skillGraph.AddState<ChangeCollisionLayerMaskState>("NoCollisionState");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("Block other Skills");
      WhileTrueState cooldownState = skillGraph.AddState<WhileTrueState>("CooldownState");
      BooleanSwitchState booleanSwitchState = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("UpdateCooldown");
      PlayAnimationState skillAnimation = skillGraph.AddState<PlayAnimationState>("Disappear Anim");
      AudioState audioState = skillGraph.AddState<AudioState>("Play Move Audio");
      PlayVfxState playVfxState = skillGraph.AddState<PlayVfxState>("Play Vfx State");
      WhileTrueState whileTrueState2 = skillGraph.AddState<WhileTrueState>("WhileInvisible");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("ReappearFreeze");
      CheckAreaOfEffectAction areaOfEffectAction1 = skillGraph.AddAction<CheckAreaOfEffectAction>("CheckHitAction");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      SpawnAoeVfxAction spawnAoeVfxAction = skillGraph.AddAction<SpawnAoeVfxAction>("StrikeAoeVfxAction");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("IfNotStunned");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("PlayMotionStartAudio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("PlayMotionStart2Audio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("PlayStartVoiceAudio");
      PlayAudioAction playAudioAction4 = skillGraph.AddAction<PlayAudioAction>("PlayStartVoice2Audio");
      PlayAudioAction playAudioAction5 = skillGraph.AddAction<PlayAudioAction>("PlayDiveAudio");
      PlayAudioAction playAudioAction6 = skillGraph.AddAction<PlayAudioAction>("Impact Audio");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("SetCanHoldBall");
      SetVar<float> setVar2 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      ModifyMovementAction modifyMovementAction1 = skillGraph.AddAction<ModifyMovementAction>("SetInitialFloorSpeed");
      ModifyMovementAction modifyMovementAction2 = skillGraph.AddAction<ModifyMovementAction>("SetSpeedZero");
      SkillVar<bool> cooldownOver = skillGraph.AddVar<bool>("CooldownOver");
      SkillVar<bool> canDive = skillGraph.AddVar<bool>("canDive");
      SkillVar<bool> canTrigger = skillGraph.AddVar<bool>("canTrigger");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> stopInvisibleSE = skillGraph.AddVar<bool>("StopInvisibleStatus");
      SkillVar<bool> canHoldBall = skillGraph.AddVar<bool>("CanHoldBall");
      SkillVar<bool> canUseSkill = skillGraph.AddVar<bool>("CanUseSkill");
      SkillVar<float> startSpeed = skillGraph.AddVar<float>("StartSpeed");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<UniqueId> hitEntities = skillGraph.AddVar<UniqueId>("TouchedEntities", true);
      cooldownOver.Set(true);
      canDive.Set(true);
      currentCooldown.Set(this.cooldown);
      canUseSkill.Expression((Func<bool>) (() => (bool) cooldownOver && (bool) canDive && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall()));
      spawnAoeVfxAction.vfxPrefab = this.strikeVfxPrefab;
      spawnAoeVfxAction.aoe.Expression((Func<AreaOfEffect>) (() => this.aoeExit));
      spawnAoeVfxAction.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      spawnAoeVfxAction.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      playAudioAction1.audioResourceName.Constant("SchroederSkillMotion");
      playAudioAction3.audioResourceName.Constant("SchroederVoiceMotion");
      audioState.audioResourceName.Constant("SchroederSkillMotionGlitchLoop");
      playAudioAction6.audioResourceName.Constant("SchroederSkillMotionImpact");
      playAudioAction5.audioResourceName.Constant("SchroederSkillMotionDiveImpact");
      playAudioAction2.audioResourceName.Constant("SchroederSkillMotionPart2");
      playAudioAction4.audioResourceName.Constant("SchroederVoiceMotionPart2");
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      playVfxState.vfxPrefab = this.floorVfxPrefab;
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) (1.0 - (double) (float) currentCooldown / (double) this.cooldown)));
      buttonState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      buttonState.onButtonDownDelegate = (Action) (() =>
      {
        if ((bool) canTrigger)
        {
          canTrigger.Set(false);
          invisibleState.Exit_();
        }
        else
        {
          if (!(bool) canUseSkill)
            return;
          canDive.Set(false);
          disappearingState.Enter_();
        }
      });
      disappearingState.duration.Expression((Func<float>) (() => this.disappearDuration));
      disappearingState.onEnterDelegate = (Action) (() =>
      {
        if (skillGraph.IsSyncing())
          return;
        isActive.Set(true);
        currentCooldown.Set(this.cooldown);
        stopInvisibleSE.Set(false);
        canHoldBall.Set(false);
        GameEntity owner = skillGraph.GetOwner();
        startSpeed.Set(owner.velocityOverride.value.Length());
        owner.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Custom(owner.playerId.value, StatusModifier.BlockHoldBall, this.maxInvisibleDuration + this.disappearDuration, canHoldBall));
      });
      WaitState waitState3 = disappearingState;
      waitState3.OnEnter = waitState3.OnEnter + hideChampUi.Enter;
      WaitState waitState4 = disappearingState;
      waitState4.OnEnter = waitState4.OnEnter + playAudioAction1.Do;
      WaitState waitState5 = disappearingState;
      waitState5.OnEnter = waitState5.OnEnter + playAudioAction3.Do;
      WaitState waitState6 = disappearingState;
      waitState6.OnEnter = waitState6.OnEnter + playAudioAction5.Do;
      WaitState waitState7 = disappearingState;
      waitState7.OnEnter = waitState7.OnEnter + whileTrueState1.Enter;
      WaitState waitState8 = disappearingState;
      waitState8.OnEnter = waitState8.OnEnter + modifyMovementState1.Enter;
      WaitState waitState9 = disappearingState;
      waitState9.OnExit = waitState9.OnExit + whileTrueState2.Enter;
      WaitState waitState10 = disappearingState;
      waitState10.SubState = waitState10.SubState + (SkillState) hideChampUi;
      hideChampUi.state = FloorUiVisibilityState.Hidden;
      whileTrueState1.condition = (Func<bool>) (() => (bool) isActive);
      WhileTrueState whileTrueState3 = whileTrueState1;
      whileTrueState3.SubState = whileTrueState3.SubState + (SkillState) lockGraphsState;
      skillAnimation.animationType.Constant(AnimationStateType.SecondarySkill);
      modifyMovementState1.mode.Constant(ModifyMovementState.Mode.DistanceOverTime);
      modifyMovementState1.distance.Expression((Func<float>) (() =>
      {
        float num = (float) startSpeed * this.hopDuration;
        if ((double) num < (double) this.minHopDistance)
          num = this.minHopDistance;
        return num;
      }));
      modifyMovementState1.duration.Expression((Func<float>) (() => this.hopDuration));
      modifyMovementState1.moveDir.Expression((Func<JVector>) (() => skillGraph.GetOwner().transform.Forward));
      modifyMovementState1.onEnterDelegate = (Action) (() =>
      {
        if (skillGraph.IsSyncing())
          return;
        GameEntity owner = skillGraph.GetOwner();
        owner.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Custom(owner.playerId.value, StatusModifier.BlockMove, this.disappearDuration));
      });
      ModifyMovementState modifyMovementState2 = modifyMovementState1;
      modifyMovementState2.OnEnter = modifyMovementState2.OnEnter + skillAnimation.Enter;
      ModifyMovementState modifyMovementState3 = modifyMovementState1;
      modifyMovementState3.OnExit = modifyMovementState3.OnExit + modifyMovementAction1.Do;
      modifyMovementAction1.type = ModifyMovementAction.ValueType.SetSpeed;
      modifyMovementAction1.speed.Expression((Func<float>) (() => this.initialFloorSpeed));
      whileTrueState2.condition = (Func<bool>) (() => (bool) isActive && !skillGraph.IsSkillUseDisabled());
      WhileTrueState whileTrueState4 = whileTrueState2;
      whileTrueState4.SubState = whileTrueState4.SubState + (SkillState) invisibleState;
      invisibleState.duration.Expression((Func<float>) (() => this.maxInvisibleDuration));
      WaitState waitState11 = invisibleState;
      waitState11.SubState = waitState11.SubState + (SkillState) playVfxState;
      WaitState waitState12 = invisibleState;
      waitState12.SubState = waitState12.SubState + (SkillState) audioState;
      WaitState waitState13 = invisibleState;
      waitState13.SubState = waitState13.SubState + (SkillState) invisibleState1;
      invisibleState.onEnterDelegate = (Action) (() =>
      {
        if (skillGraph.IsSyncing())
          return;
        canTrigger.Set(true);
        GameEntity owner = skillGraph.GetOwner();
        owner.AddStatusEffect(skillGraph.GetContext(), StatusEffect.MovementSpeedChange(skillGraph.GetOwnerId(), this.moveSpeedModifier, this.maxInvisibleDuration, stopInvisibleSE));
        owner.velocityOverride.value = owner.transform.Forward * (float) startSpeed;
      });
      invisibleState.onExitDelegate = (Action) (() =>
      {
        if (skillGraph.IsSyncing())
          return;
        skillGraph.GetOwner().AddStatusEffect(skillGraph.GetContext(), StatusEffect.MovementSpeedChange(skillGraph.GetOwnerId(), this.appearSpeedModifier, this.appearSpeedModifierDuration));
        stopInvisibleSE.Set(true);
        skillAnimation.Exit_();
        hideChampUi.Exit_();
      });
      WaitState waitState14 = invisibleState;
      waitState14.OnExit = waitState14.OnExit + conditionAction.Do;
      WaitState waitState15 = invisibleState;
      waitState15.SubState = waitState15.SubState + (SkillState) collisionLayerMaskState;
      WaitState waitState16 = invisibleState;
      waitState16.SubState = waitState16.SubState + (SkillState) modFloorUiState;
      modFloorUiState.state = FloorUiVisibilityState.Minimized;
      collisionLayerMaskState.targetEntityId = (SyncableValue<UniqueId>) skillGraph.GetOwner().uniqueId.id;
      collisionLayerMaskState.setToLayer = CollisionLayer.None;
      collisionLayerMaskState.setToMask = CollisionLayer.LvlBorder;
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("SetInactive");
      setVar3.var = isActive;
      setVar3.value = (SyncableValue<bool>) false;
      conditionAction.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      conditionAction.OnTrue += waitState1.Enter;
      conditionAction.OnFalse += setVar3.Do;
      conditionAction.OnFalse += cooldownState.Enter;
      waitState1.duration.Expression((Func<float>) (() => this.hitAppearDuration));
      WaitState waitState17 = waitState1;
      waitState17.OnEnter = waitState17.OnEnter + spawnAoeVfxAction.Do;
      WaitState waitState18 = waitState1;
      waitState18.OnEnter = waitState18.OnEnter + modifyMovementAction2.Do;
      WaitState waitState19 = waitState1;
      waitState19.OnEnter = waitState19.OnEnter + waitState2.Enter;
      WaitState waitState20 = waitState1;
      waitState20.OnEnter = waitState20.OnEnter + playAudioAction2.Do;
      WaitState waitState21 = waitState1;
      waitState21.OnEnter = waitState21.OnEnter + playAudioAction4.Do;
      WaitState waitState22 = waitState1;
      waitState22.SubState = waitState22.SubState + (SkillState) mofifierToOwnerState;
      WaitState waitState23 = waitState1;
      waitState23.OnExit = waitState23.OnExit + areaOfEffectAction1.Do;
      WaitState waitState24 = waitState1;
      waitState24.OnExit = waitState24.OnExit + setVar1.Do;
      WaitState waitState25 = waitState1;
      waitState25.OnExit = waitState25.OnExit + cooldownState.Enter;
      modifyMovementAction2.speed = (SyncableValue<float>) 0.0f;
      modifyMovementAction2.type = ModifyMovementAction.ValueType.SetSpeed;
      mofifierToOwnerState.modifier = StatusModifier.BlockMove;
      setVar1.var = canHoldBall;
      setVar1.value = (SyncableValue<bool>) true;
      waitState2.duration.Expression((Func<float>) (() => this.aoeDisplayDuration));
      WaitState waitState26 = waitState2;
      waitState26.SubState = waitState26.SubState + (SkillState) showAoeState;
      waitState2.onExitDelegate = (Action) (() => isActive.Set(false));
      showAoeState.aoe.Expression((Func<AreaOfEffect>) (() => this.aoeExit));
      showAoeState.trackOwnerPosition = (SyncableValue<bool>) true;
      areaOfEffectAction1.aoe.Expression((Func<AreaOfEffect>) (() => this.aoeExit));
      areaOfEffectAction1.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      areaOfEffectAction1.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      areaOfEffectAction1.hitEntities = hitEntities;
      areaOfEffectAction1.filterHit = (Func<GameEntity, bool>) (entity => entity.HasModifier(StatusModifier.Flying));
      areaOfEffectAction1.includeEnemies = true;
      areaOfEffectAction1.thenDelegate = (Action) (() =>
      {
        if (!skillGraph.IsServer())
          return;
        GameEntity owner = skillGraph.GetOwner();
        for (int i = 0; i < hitEntities.Length; ++i)
        {
          GameEntity entity = skillGraph.GetEntity(hitEntities[i]);
          entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Stun(skillGraph.GetOwnerId(), this.stunDuration));
          entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Push(skillGraph.GetOwnerId(), owner.transform.Vector2DTo(entity.transform.Position2D).Normalized(), this.pushDistance, this.pushDuration));
        }
      });
      CheckAreaOfEffectAction areaOfEffectAction2 = areaOfEffectAction1;
      areaOfEffectAction2.Then = areaOfEffectAction2.Then + playAudioAction6.Do;
      cooldownState.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState5 = cooldownState;
      whileTrueState5.SubState = whileTrueState5.SubState + (SkillState) booleanSwitchState;
      cooldownState.onEnterDelegate = (Action) (() =>
      {
        canTrigger.Set(false);
        cooldownOver.Set(false);
      });
      cooldownState.onExitDelegate = (Action) (() =>
      {
        canDive.Set(true);
        cooldownOver.Set(true);
      });
      booleanSwitchState.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState.amountPerSecond.Constant(-1f);
      onEventAction1.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction1.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction3.EventType = SkillGraphEvent.MatchStart;
      onEventAction3.OnTrigger += cooldownState.Enter;
      onEventAction2.EventType = SkillGraphEvent.Interrupt;
      onEventAction2.onTriggerDelegate = (Action) (() =>
      {
        if (invisibleState.IsActive)
        {
          invisibleState.Exit_();
          cooldownState.Enter_();
        }
        isActive.Set(false);
        canDive.Set(true);
        canHoldBall.Set(true);
        canTrigger.Set(false);
        lockGraphsState.Exit_();
      });
      onEventAction4.EventType = SkillGraphEvent.Overtime;
      onEventAction4.OnTrigger += setVar2.Do;
      setVar2.var = currentCooldown;
      setVar2.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar4 = setVar2;
      setVar4.Then = setVar4.Then + cooldownState.Enter;
    }
  }
}
