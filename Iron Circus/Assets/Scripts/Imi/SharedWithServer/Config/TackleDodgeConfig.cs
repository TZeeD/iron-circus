// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.TackleDodgeConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay;
using Imi.SharedWithServer.Utils;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "TackleDodgeConfig", menuName = "SteelCircus/SkillConfigs/TackleDodgeConfig")]
  public class TackleDodgeConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string iconName = "icon_stomp_inverted_01_tex";
    public float cooldown = 1f;
    [Header("Dodge Settings")]
    public float dodgeDistance = 5.3f;
    [AnimationDuration]
    public float dodgeDuration = 0.5f;
    public float postDodgeSpeed = 10f;
    public float staminaCostDodge = 0.5f;
    [Header("Tackle Settings")]
    public float tackleDistance = 1f;
    [AnimationDuration]
    public float tackleDuration = 5f;
    public float postTackleSpeed = 2f;
    public float staminaCostTackle = 0.5f;
    [Header("Tackle Effects target has ball")]
    public float pushDistanceWithBall = 1f;
    public float pushDurationWithBall = 1f;
    public float stunDurationWithBall = 1f;
    public float slowDurationWithBall = 1f;
    public float slowAmountWithBall = 1f;
    [Header("Tackle Effects target no ball")]
    public float pushDistanceNoBall = 1f;
    public float pushDurationNoBall = 1f;
    public float stunDurationNoBall = 1f;
    public float slowDurationNoBall = 1f;
    public float slowAmountNoBall = 1f;
    [Header("Preview Settings")]
    public bool showPreviewOnRemoteEntities;
    public VfxPrefab tacklePreviewPrefab;
    public VfxPrefab dodgeVfxPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState input = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      ShowAoeState showAoeState = skillGraph.AddState<ShowAoeState>("Tackle Preview");
      ModifyMovementState tackle = skillGraph.AddState<ModifyMovementState>("Tackle Move");
      ModifyMovementState dodge = skillGraph.AddState<ModifyMovementState>("Dodge Move");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("Dodging Status");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("While Can Tackle");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("Tackle Anim");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("Dodge Anim");
      PlayAnimationState playAnimationState3 = skillGraph.AddState<PlayAnimationState>("DisableLookAtBall");
      P2PCollisionCheckState pcollisionCheckState = skillGraph.AddState<P2PCollisionCheckState>("Collision Check");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("Cooldown");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("Should Update Cooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("Update Cooldown");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("Block other Skills");
      ChangeCollisionLayerMaskState collisionLayerMaskState = skillGraph.AddState<ChangeCollisionLayerMaskState>("No Collision State");
      BooleanSwitchState booleanSwitchState3 = skillGraph.AddState<BooleanSwitchState>("Can Dodge Check");
      PlayVfxState playVfxState = skillGraph.AddState<PlayVfxState>("Dodge VFX");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("Tackle BaseAudio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Tackle LayerAudio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("Dodge Audio");
      ApplyPushStunAction applyHasBallStun = skillGraph.AddAction<ApplyPushStunAction>("Push/Stun HAS Ball");
      ApplyPushStunAction applyNoBallStun = skillGraph.AddAction<ApplyPushStunAction>("Push/Stun NO Ball");
      ApplySpeedModEffectAction applySpeedModHasBall = skillGraph.AddAction<ApplySpeedModEffectAction>("Speed Mod HAS Ball");
      ApplySpeedModEffectAction applySpeedModNoBall = skillGraph.AddAction<ApplySpeedModEffectAction>("Speed Mod HAS Ball");
      ModifyMovementAction modifyMovementAction1 = skillGraph.AddAction<ModifyMovementAction>("Set Post-Tackle Speed");
      ModifyMovementAction modifyMovementAction2 = skillGraph.AddAction<ModifyMovementAction>("Set Post-Dodge Speed");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("Can Tackle Check");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("On Status Effect Changed");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("On MatchStart");
      RumbleControllerAction controllerAction = skillGraph.AddAction<RumbleControllerAction>("RumbleOnHit");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("setNotTacklingFalse");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("setNotTacklingTrue");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("setDidCollideFalse");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("setRestartStamina");
      SetVar<float> setVar5 = skillGraph.AddAction<SetVar<float>>("resetCooldown");
      SetVar<float> setVar6 = skillGraph.AddAction<SetVar<float>>("subtractTackleCost");
      SetVar<float> setVar7 = skillGraph.AddAction<SetVar<float>>("subtractDodgeCost");
      SetVar<JVector> setVar8 = skillGraph.AddAction<SetVar<JVector>>("Update Aim Direction");
      SkillVar<float> stamina = skillGraph.GetVar<float>("Stamina");
      SkillVar<bool> var = skillGraph.GetVar<bool>("RestartStaminaRecharge");
      SkillVar<bool> canAffordTackle = skillGraph.AddOwnerVar<bool>("CanAffordTackle");
      SkillVar<bool> canAffordDodge = skillGraph.AddOwnerVar<bool>("CanAffordDodge");
      SkillVar<JVector> aimDir = skillGraph.AddVar<JVector>("AimDir");
      SkillVar<bool> isNotTackling = skillGraph.AddVar<bool>("NotTackling");
      SkillVar<bool> didCollide = skillGraph.AddVar<bool>("DidCollide");
      SkillVar<bool> isNotDodging = skillGraph.AddVar<bool>("NotDodging");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("isOnCooldown");
      SkillVar<bool> canUseTackleOrDodge = skillGraph.AddVar<bool>("CanUseTackleOrDodge");
      SkillVar<bool> canTackle = skillGraph.AddVar<bool>("CanTackle");
      SkillVar<bool> canDodge = skillGraph.AddVar<bool>("CanDodge");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<JVector> pushDir = skillGraph.AddVar<JVector>("PushVector");
      SkillVar<UniqueId> collisionResult = skillGraph.AddVar<UniqueId>("CollisionResult", true);
      isNotTackling.Set(true);
      isNotDodging.Expression((Func<bool>) (() => !dodge.IsActive));
      isOnCooldown.Expression((Func<bool>) (() => (double) (float) currentCooldown > 1.40129846432482E-45));
      canUseTackleOrDodge.Expression((Func<bool>) (() => !(bool) isOnCooldown && (bool) isNotTackling && (bool) isNotDodging && !skillGraph.GetOwner().HasEffect(StatusEffectType.Invisible) && !skillGraph.GetOwner().IsMoveBlocked() && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked()));
      canAffordTackle.Expression((Func<bool>) (() => (double) (float) stamina >= (double) this.staminaCostTackle));
      canAffordDodge.Expression((Func<bool>) (() => (double) (float) stamina >= (double) this.staminaCostDodge));
      canTackle.Expression((Func<bool>) (() => (bool) canUseTackleOrDodge && !skillGraph.OwnerHasBall() && (bool) canAffordTackle));
      canDodge.Expression((Func<bool>) (() => (bool) canUseTackleOrDodge && skillGraph.OwnerHasBall() && (bool) canAffordDodge));
      setVar4.var = var;
      setVar4.value = (SyncableValue<bool>) true;
      TackleDodgeConfig.DodgeFXParams dodgeFxParams = new TackleDodgeConfig.DodgeFXParams();
      dodgeFxParams.duration = this.dodgeDuration;
      dodgeFxParams.distance = this.dodgeDistance;
      playAudioAction1.audioResourceName.Constant("TackleBase");
      playAudioAction2.audioResourceName.Constant("TackleLayer");
      playAudioAction3.audioResourceName.Constant("Dodge");
      skillGraph.AddEntryState((SkillState) input);
      skillGraph.AddEntryState((SkillState) skillUiState);
      playAnimationState1.animationType.Constant(AnimationStateType.Tackle);
      playAnimationState3.animationType.Constant(AnimationStateType.DontTurnHead);
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.fillAmount.Expression((Func<float>) (() => (this.cooldown - (float) currentCooldown) / this.cooldown));
      input.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      input.buttonDownSubStates += (SkillState) booleanSwitchState1;
      input.buttonDownSubStates += (SkillState) booleanSwitchState3;
      input.OnButtonUp += setVar8.Do;
      input.OnButtonUp += conditionAction.Do;
      setVar8.var = aimDir;
      setVar8.value.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir()));
      booleanSwitchState1.condition = (Func<bool>) (() => (bool) canTackle);
      BooleanSwitchState booleanSwitchState4 = booleanSwitchState1;
      booleanSwitchState4.OnUpdate = booleanSwitchState4.OnUpdate + setVar8.Do;
      booleanSwitchState1.WhileTrueSubState += (SkillState) showAoeState;
      booleanSwitchState1.WhileTrueSubState += (SkillState) lockGraphsState;
      booleanSwitchState1.WhileTrueSubState += (SkillState) playAnimationState3;
      showAoeState.showOnlyForLocalPlayer.Constant(!this.showPreviewOnRemoteEntities);
      showAoeState.aoe.Expression((Func<AreaOfEffect>) (() =>
      {
        float colliderRadius = skillGraph.GetOwner().championConfig.value.colliderRadius;
        return new AreaOfEffect()
        {
          shape = AoeShape.Rectangle,
          rectLength = this.tackleDistance,
          rectWidth = colliderRadius * 2f,
          vfxPrefab = this.tacklePreviewPrefab
        };
      }));
      showAoeState.trackOwnerPosition = (SyncableValue<bool>) false;
      conditionAction.condition = (Func<bool>) (() => (bool) canTackle);
      conditionAction.OnTrue += setVar1.Do;
      conditionAction.OnTrue += setVar6.Do;
      setVar6.var = stamina;
      setVar6.value.Expression((Func<float>) (() => (float) stamina - this.staminaCostTackle));
      SetVar<float> setVar9 = setVar6;
      setVar9.Then = setVar9.Then + setVar4.Do;
      booleanSwitchState3.condition = (Func<bool>) (() => (bool) canDodge);
      booleanSwitchState3.OnTrue += dodge.Enter;
      booleanSwitchState3.OnTrue += setVar7.Do;
      setVar7.var = stamina;
      setVar7.value.Expression((Func<float>) (() => (float) stamina - this.staminaCostDodge));
      SetVar<float> setVar10 = setVar7;
      setVar10.Then = setVar10.Then + setVar4.Do;
      setVar1.var = isNotTackling;
      setVar1.value.Set(false);
      SetVar<bool> setVar11 = setVar1;
      setVar11.Then = setVar11.Then + setVar3.Do;
      setVar3.var = didCollide;
      setVar3.value.Set(false);
      SetVar<bool> setVar12 = setVar3;
      setVar12.Then = setVar12.Then + tackle.Enter;
      tackle.mode.Constant(ModifyMovementState.Mode.DistanceOverTime);
      tackle.moveDir.Expression((Func<JVector>) (() => aimDir.Get().Normalized()));
      tackle.distance.Expression((Func<float>) (() => this.tackleDistance));
      tackle.duration.Expression((Func<float>) (() => this.tackleDuration));
      tackle.rotateTowardsMoveDir.Set(true);
      ModifyMovementState modifyMovementState1 = tackle;
      modifyMovementState1.OnEnter = modifyMovementState1.OnEnter + playAudioAction1.Do;
      ModifyMovementState modifyMovementState2 = tackle;
      modifyMovementState2.OnEnter = modifyMovementState2.OnEnter + playAudioAction2.Do;
      ModifyMovementState modifyMovementState3 = tackle;
      modifyMovementState3.SubState = modifyMovementState3.SubState + (SkillState) pcollisionCheckState;
      ModifyMovementState modifyMovementState4 = tackle;
      modifyMovementState4.SubState = modifyMovementState4.SubState + (SkillState) lockGraphsState;
      ModifyMovementState modifyMovementState5 = tackle;
      modifyMovementState5.SubState = modifyMovementState5.SubState + (SkillState) playAnimationState1;
      ModifyMovementState modifyMovementState6 = tackle;
      modifyMovementState6.SubState = modifyMovementState6.SubState + (SkillState) collisionLayerMaskState;
      ModifyMovementState modifyMovementState7 = tackle;
      modifyMovementState7.SubState = modifyMovementState7.SubState + (SkillState) playAnimationState3;
      tackle.onEnterDelegate = (Action) (() =>
      {
        ulong ownerId = skillGraph.GetOwnerId();
        if (skillGraph.IsServer())
          skillGraph.GetContext().eventDispatcher.value.EnqueueTackleEvent(ownerId);
        StatusEffect effect = StatusEffect.Custom(ownerId, StatusModifier.BlockMove, this.tackleDuration);
        skillGraph.GetOwner().AddStatusEffect(skillGraph.GetContext(), effect);
      });
      ModifyMovementState modifyMovementState8 = tackle;
      modifyMovementState8.OnExit = modifyMovementState8.OnExit + input.Reset;
      ModifyMovementState modifyMovementState9 = tackle;
      modifyMovementState9.OnExit = modifyMovementState9.OnExit + modifyMovementAction1.Do;
      ModifyMovementState modifyMovementState10 = tackle;
      modifyMovementState10.OnExit = modifyMovementState10.OnExit + setVar2.Do;
      ModifyMovementState modifyMovementState11 = tackle;
      modifyMovementState11.OnExit = modifyMovementState11.OnExit + setVar5.Do;
      collisionLayerMaskState.targetEntityId.Set(skillGraph.GetOwner().uniqueId.id);
      collisionLayerMaskState.setToLayer = CollisionLayer.None;
      collisionLayerMaskState.setToMask = CollisionLayerUtils.GetMaskForTeam(skillGraph.GetOwner().playerTeam.value) & ~CollisionLayer.TeamA & ~CollisionLayer.TeamB;
      modifyMovementAction1.type = ModifyMovementAction.ValueType.SetSpeed;
      modifyMovementAction1.speed.Expression((Func<float>) (() => this.postTackleSpeed));
      setVar2.var = isNotTackling;
      setVar2.value.Set(true);
      pcollisionCheckState.result = collisionResult;
      pcollisionCheckState.onHitDelegate = (Action) (() =>
      {
        GameEntity owner = skillGraph.GetOwner();
        if (!skillGraph.IsServer() || (bool) didCollide || skillGraph.OwnerHasBall())
          return;
        GameEntity entity = skillGraph.GetEntity(collisionResult[0]);
        if (entity.isPlayer)
        {
          ulong ownerId = skillGraph.GetOwnerId();
          if (!entity.HasModifier(StatusModifier.ImmuneToTackle))
          {
            GameEntity ballEntity = skillGraph.GetContext().ballEntity;
            pushDir.Set((entity.transform.Position2D - owner.transform.Position2D).Normalized());
            if (ballEntity.hasBallOwner && ballEntity.ballOwner.IsOwner(entity))
            {
              GameContext context = skillGraph.GetContext();
              BallUpdateSystem.SetBallOwner(context, context.ballEntity, skillGraph.GetOwner());
              applySpeedModHasBall.targetPlayerId.Set(entity.playerId.value);
              applyHasBallStun.targetPlayerId.Set(entity.playerId.value);
              applyHasBallStun.PerformAction();
              skillGraph.GetContext().eventDispatcher.value.EnqueueBallSteal(ownerId, entity.playerId.value);
            }
            else
            {
              applySpeedModNoBall.targetPlayerId.Set(entity.playerId.value);
              applyNoBallStun.targetPlayerId.Set(entity.playerId.value);
              applyNoBallStun.PerformAction();
            }
            skillGraph.GetContext().eventDispatcher.value.EnqueueTackleHitEvent(ownerId, entity.playerId.value);
            didCollide.Set(true);
          }
        }
        if (!entity.isBall || entity.hasBallOwner)
          return;
        GameContext context1 = skillGraph.GetContext();
        BallUpdateSystem.SetBallOwner(context1, context1.ballEntity, skillGraph.GetOwner());
        didCollide.Set(true);
      });
      applyHasBallStun.stunDuration.Expression((Func<float>) (() => this.stunDurationWithBall));
      applyHasBallStun.pushDuration.Expression((Func<float>) (() => this.pushDurationWithBall));
      applyHasBallStun.pushVector.Expression((Func<JVector>) (() => pushDir.Get() * this.pushDistanceWithBall));
      ApplyPushStunAction applyPushStunAction1 = applyHasBallStun;
      applyPushStunAction1.Then = applyPushStunAction1.Then + applySpeedModHasBall.Do;
      ApplyPushStunAction applyPushStunAction2 = applyHasBallStun;
      applyPushStunAction2.Then = applyPushStunAction2.Then + controllerAction.Do;
      applySpeedModHasBall.moveSpeedModifier = (SyncableValue<float>) this.slowAmountWithBall;
      applySpeedModHasBall.duration = (SyncableValue<float>) this.slowDurationWithBall;
      applyNoBallStun.stunDuration.Expression((Func<float>) (() => this.stunDurationNoBall));
      applyNoBallStun.pushDuration.Expression((Func<float>) (() => this.pushDurationNoBall));
      applyNoBallStun.pushVector.Expression((Func<JVector>) (() => pushDir.Get() * this.pushDistanceNoBall));
      ApplyPushStunAction applyPushStunAction3 = applyNoBallStun;
      applyPushStunAction3.Then = applyPushStunAction3.Then + applySpeedModNoBall.Do;
      ApplyPushStunAction applyPushStunAction4 = applyNoBallStun;
      applyPushStunAction4.Then = applyPushStunAction4.Then + controllerAction.Do;
      applySpeedModNoBall.moveSpeedModifier = (SyncableValue<float>) this.slowAmountNoBall;
      applySpeedModNoBall.duration = (SyncableValue<float>) this.slowDurationNoBall;
      controllerAction.playerId = (SyncableValue<ulong>) skillGraph.GetOwnerId();
      controllerAction.strength = (SyncableValue<float>) 1f;
      controllerAction.duration = (SyncableValue<float>) 0.3f;
      playAnimationState2.animationType.Constant(AnimationStateType.Dodge);
      playVfxState.vfxPrefab = this.dodgeVfxPrefab;
      playVfxState.parentToOwner = false;
      playVfxState.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      playVfxState.lookDir.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir()));
      playVfxState.args = (object) dodgeFxParams;
      dodge.mode.Constant(ModifyMovementState.Mode.DistanceOverTime);
      dodge.distance.Expression((Func<float>) (() => this.dodgeDistance));
      dodge.duration.Expression((Func<float>) (() => this.dodgeDuration));
      dodge.moveDir.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir().Normalized()));
      ModifyMovementState modifyMovementState12 = dodge;
      modifyMovementState12.SubState = modifyMovementState12.SubState + (SkillState) lockGraphsState;
      ModifyMovementState modifyMovementState13 = dodge;
      modifyMovementState13.SubState = modifyMovementState13.SubState + (SkillState) playAnimationState2;
      ModifyMovementState modifyMovementState14 = dodge;
      modifyMovementState14.OnEnter = modifyMovementState14.OnEnter + playAudioAction3.Do;
      ModifyMovementState modifyMovementState15 = dodge;
      modifyMovementState15.SubState = modifyMovementState15.SubState + (SkillState) collisionLayerMaskState;
      ModifyMovementState modifyMovementState16 = dodge;
      modifyMovementState16.SubState = modifyMovementState16.SubState + (SkillState) playAnimationState3;
      dodge.onEnterDelegate = (Action) (() =>
      {
        if (!skillGraph.IsServer())
          return;
        skillGraph.GetContext().eventDispatcher.value.EnqueueDodgeEvent(skillGraph.GetOwnerId());
      });
      ModifyMovementState modifyMovementState17 = dodge;
      modifyMovementState17.OnEnter = modifyMovementState17.OnEnter + mofifierToOwnerState.Enter;
      ModifyMovementState modifyMovementState18 = dodge;
      modifyMovementState18.OnExit = modifyMovementState18.OnExit + modifyMovementAction1.Do;
      ModifyMovementState modifyMovementState19 = dodge;
      modifyMovementState19.OnExit = modifyMovementState19.OnExit + setVar5.Do;
      mofifierToOwnerState.modifier = StatusModifier.BlockMove;
      mofifierToOwnerState.duration.Expression((Func<float>) (() => this.dodgeDuration));
      modifyMovementAction2.type = ModifyMovementAction.ValueType.SetSpeed;
      modifyMovementAction2.speed.Expression((Func<float>) (() => this.postDodgeSpeed));
      onEventAction1.EventType = SkillGraphEvent.Interrupt;
      onEventAction1.onTriggerDelegate = (Action) (() =>
      {
        input.ResetInput();
        if (tackle.IsActive)
        {
          tackle.Exit_();
        }
        else
        {
          if (!dodge.IsActive)
            return;
          dodge.Exit_();
        }
      });
      setVar5.var = currentCooldown;
      setVar5.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar13 = setVar5;
      setVar13.Then = setVar13.Then + whileTrueState1.Enter;
      whileTrueState1.condition = (Func<bool>) (() => (bool) isOnCooldown);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState2;
      booleanSwitchState2.condition = (Func<bool>) (() => !skillGraph.GetOwner().IsStunned() && !skillGraph.GetOwner().IsPushed());
      booleanSwitchState2.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.amountPerSecond.Constant(-1f);
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      onEventAction2.EventType = SkillGraphEvent.MatchStart;
      onEventAction2.OnTrigger += setVar5.Do;
    }

    public class DodgeFXParams
    {
      public float duration;
      public float distance;
    }
  }
}
