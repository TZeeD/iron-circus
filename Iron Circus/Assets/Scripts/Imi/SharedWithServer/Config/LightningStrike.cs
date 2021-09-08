// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.LightningStrike
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "LightningStrike", menuName = "SteelCircus/SkillConfigs/LightningStrike")]
  public class LightningStrike : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType buttonType;
    public string skillIconName;
    public float cooldown;
    [Header("Projectile")]
    public float maxThrowDist;
    public float spearCollisionHeight;
    public float spearCollisionRadius;
    public float spearSpeed;
    public JVector spawnOffset;
    [Header("Teleport")]
    public float canTeleportDelay;
    public float duration;
    public float teleportSpeed;
    [Header("Spear Hit Effects")]
    public float pushDurationOnHit;
    public float pushDistanceOnHit;
    public int damage;
    [Header("Tele Effects")]
    public AreaOfEffect aoe;
    public float pushDuration;
    public float pushDistance;
    public float stunDuration;
    public float slowAmount;
    public float slowDuration;
    [Header("Vfx")]
    public VfxPrefab spearProjectilePrefab;
    public VfxPrefab impactVfxPrefab;
    public VfxPrefab throwPreviewPrefab;
    public VfxPrefab connectionPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("whileOnCooldown");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("CooldownState");
      WaitState waitState1 = skillGraph.AddState<WaitState>("delayToCanTrigger");
      WaitState waitState2 = skillGraph.AddState<WaitState>("ActiveDurationState");
      ShowAoeState showAoeState1 = skillGraph.AddState<ShowAoeState>("Show Throw Preview");
      ShowAoeState showAoeState2 = skillGraph.AddState<ShowAoeState>("PreviewTeleportTarget");
      PlayVfxState playVfxState = skillGraph.AddState<PlayVfxState>("Show Connection");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("WhileButtonIsDown");
      ProjectileState projectileState1 = skillGraph.AddState<ProjectileState>("ThrowSpearState");
      MoveToTargetState moveToTargetState1 = skillGraph.AddState<MoveToTargetState>("Teleport");
      ChangeCollisionLayerMaskState collisionLayerMaskState = skillGraph.AddState<ChangeCollisionLayerMaskState>("NoCollisionState");
      WhileTrueState whileTrueState2 = skillGraph.AddState<WhileTrueState>("WhileCanTeleport");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("FreezeInput");
      ModFloorUiState modFloorUiState = skillGraph.AddState<ModFloorUiState>("HideFloorUi");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("PlayAnimation");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("TurnToAim");
      SetOwnerObjectVisibilityState objectVisibilityState = skillGraph.AddState<SetOwnerObjectVisibilityState>("Show Lightning Trail");
      InvisibleState invisibleState = skillGraph.AddState<InvisibleState>("ApplyInvisible");
      AudioState audioState = skillGraph.AddState<AudioState>("Spear Connect Line Audio State");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("BlockOtherSkills");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnMatchStateChanged");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction5 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      ConditionAction conditionAction1 = skillGraph.AddAction<ConditionAction>("shouldThrowCondition");
      ConditionAction conditionAction2 = skillGraph.AddAction<ConditionAction>("shouldTeleportCondition");
      ConditionAction conditionAction3 = skillGraph.AddAction<ConditionAction>("shouldDoHitCheck");
      ConditionAction conditionAction4 = skillGraph.AddAction<ConditionAction>("shouldInterrupt");
      ConditionAction conditionAction5 = skillGraph.AddAction<ConditionAction>("shouldAbortOnStateChange");
      CheckAreaOfEffectAction areaOfEffectAction1 = skillGraph.AddAction<CheckAreaOfEffectAction>("CheckHit");
      RumbleControllerAction rumbleOnHitAction = skillGraph.AddAction<RumbleControllerAction>("RumbleHit");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("Trigger spear throw Audio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Trigger spear throw Audio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("Trigger spear impact Audio");
      PlayAudioAction playAudioAction4 = skillGraph.AddAction<PlayAudioAction>("Trigger spear teleportation Audio");
      PlayAudioAction playAudioAction5 = skillGraph.AddAction<PlayAudioAction>("Trigger spear end Audio");
      SpawnVfxAction spawnVfxAction = skillGraph.AddAction<SpawnVfxAction>("SpawnImpactVfx");
      SetVar<JVector> setVar1 = skillGraph.AddAction<SetVar<JVector>>("SetThrowDir");
      SetVar<float> setVar2 = skillGraph.AddAction<SetVar<float>>("StartCooldown");
      SetVar<float> setVar3 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("setCooldownActive");
      SetVar<bool> setVar5 = skillGraph.AddAction<SetVar<bool>>("setCooldownInactive");
      SetVar<bool> setVar6 = skillGraph.AddAction<SetVar<bool>>("setShouldTrigger");
      SetVar<bool> setVar7 = skillGraph.AddAction<SetVar<bool>>("setShould NOT Trigger");
      SetVar<bool> setVar8 = skillGraph.AddAction<SetVar<bool>>("setActive");
      SetVar<bool> setVar9 = skillGraph.AddAction<SetVar<bool>>("setInactive");
      SetVar<bool> setVar10 = skillGraph.AddAction<SetVar<bool>>("setCanTeleport");
      SetVar<bool> setVar11 = skillGraph.AddAction<SetVar<bool>>("setCan NOT Teleport");
      SetVar<bool> setVar12 = skillGraph.AddAction<SetVar<bool>>("setTeleporting");
      SetVar<bool> setVar13 = skillGraph.AddAction<SetVar<bool>>("set NOT Teleporting");
      SetVar<JVector> setVar14 = skillGraph.AddAction<SetVar<JVector>>("setTeleportDir");
      GroupAction groupAction1 = skillGraph.AddAction<GroupAction>("InterruptGroup");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> shouldTrigger = skillGraph.AddVar<bool>("ShouldTrigger");
      SkillVar<bool> canTeleport = skillGraph.AddVar<bool>("CanTeleport");
      SkillVar<bool> skillVar = skillGraph.AddVar<bool>("IsTeleporting");
      SkillVar<bool> canActivate = skillGraph.AddVar<bool>("CanUse");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("Cooldown");
      SkillVar<JVector> teleportTarget = skillGraph.AddVar<JVector>("teleportTarget");
      SkillVar<JVector> throwDir = skillGraph.AddVar<JVector>("ThrowDir");
      SkillVar<JVector> teleportDir = skillGraph.AddVar<JVector>("TeleportDir");
      SkillVar<UniqueId> spearHitEntity = skillGraph.AddVar<UniqueId>("HitEntity");
      SkillVar<UniqueId> hitEntities = skillGraph.AddVar<UniqueId>("Entities hit", true);
      isOnCooldown.Set(true);
      currentCooldown.Set(this.cooldown);
      canActivate.Expression((Func<bool>) (() => !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall() && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !(bool) isOnCooldown && !(bool) isActive));
      spawnVfxAction.vfxPrefab = this.impactVfxPrefab;
      spawnVfxAction.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      spawnVfxAction.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      playVfxState.vfxPrefab = this.connectionPrefab;
      playVfxState.parentToOwner = false;
      LightningStrike.ConnectionArgs connectionArgs = new LightningStrike.ConnectionArgs();
      connectionArgs.start.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      connectionArgs.end.Expression((Func<JVector>) (() => (JVector) teleportTarget));
      playVfxState.args = (object) connectionArgs;
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillUiState.buttonType.Constant(this.buttonType);
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      skillUiState.fillAmount.Expression((Func<float>) (() => (this.cooldown - (float) currentCooldown) / this.cooldown));
      skillUiState.iconName.Expression((Func<string>) (() => this.skillIconName));
      playAudioAction1.audioResourceName.Constant("ShaniSkillSpearThrow");
      playAudioAction2.audioResourceName.Constant("ShaniVoiceSpear");
      playAudioAction3.audioResourceName.Constant("ShaniSkillSpearImpact");
      playAudioAction4.audioResourceName.Constant("ShaniSkillSpearTeleport");
      audioState.audioResourceName.Constant("ShaniSkillSpearConnectLine");
      playAudioAction5.audioResourceName.Constant("ShaniSkillSpearEnd");
      buttonState.buttonType.Constant(this.buttonType);
      buttonState.buttonDownSubStates += (SkillState) booleanSwitchState2;
      buttonState.OnButtonDown += conditionAction2.Do;
      buttonState.OnButtonUp += conditionAction1.Do;
      booleanSwitchState2.condition = (Func<bool>) (() => (bool) canActivate);
      booleanSwitchState2.OnTrue += setVar6.Do;
      booleanSwitchState2.OnFalse += setVar7.Do;
      booleanSwitchState2.WhileTrueSubState += (SkillState) showAoeState1;
      booleanSwitchState2.WhileTrueSubState += (SkillState) playAnimationState1;
      booleanSwitchState2.WhileTrueSubState += (SkillState) playAnimationState2;
      booleanSwitchState2.WhileTrueSubState += (SkillState) lockGraphsState;
      setVar6.var = shouldTrigger;
      setVar6.value = (SyncableValue<bool>) true;
      playAnimationState2.animationType.Constant(AnimationStateType.TurnHeadToAim);
      playAnimationState1.animationType.Constant(AnimationStateType.SecondarySkill);
      float num = 9f;
      showAoeState1.aoe.Constant(new AreaOfEffect()
      {
        rectWidth = 0.4f,
        rectLength = num,
        shape = AoeShape.Rectangle,
        vfxPrefab = this.throwPreviewPrefab
      });
      showAoeState1.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      showAoeState1.lookDir.Expression((Func<JVector>) (() => (JVector) throwDir));
      showAoeState1.offset = (SyncableValue<JVector>) (JVector.Forward * (num / 2f));
      ShowAoeState showAoeState3 = showAoeState1;
      showAoeState3.OnUpdate = showAoeState3.OnUpdate + setVar1.Do;
      setVar1.var = throwDir;
      setVar1.value.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir()));
      conditionAction1.condition = (Func<bool>) (() => (bool) shouldTrigger);
      conditionAction1.OnTrue += setVar7.Do;
      conditionAction1.OnTrue += setVar8.Do;
      conditionAction1.OnTrue += playAudioAction1.Do;
      conditionAction1.OnTrue += playAudioAction2.Do;
      conditionAction1.OnTrue += projectileState1.Enter;
      setVar8.var = isActive;
      setVar8.value = (SyncableValue<bool>) true;
      setVar7.var = shouldTrigger;
      setVar7.value = (SyncableValue<bool>) false;
      projectileState1.throwDir = throwDir;
      projectileState1.spawnOffset.Expression((Func<JVector>) (() => this.spawnOffset));
      projectileState1.initialSpeed.Expression((Func<float>) (() => this.spearSpeed));
      projectileState1.maxTravelDistance.Expression((Func<float>) (() => this.maxThrowDist));
      projectileState1.collisionRadius.Expression((Func<float>) (() => this.spearCollisionRadius));
      projectileState1.collisionHeight.Expression((Func<float>) (() => this.spearCollisionHeight));
      projectileState1.prefab.Constant(this.spearProjectilePrefab.value);
      projectileState1.hitEntity = spearHitEntity;
      projectileState1.projectilePosition = teleportTarget;
      ProjectileState projectileState2 = projectileState1;
      projectileState2.OnExit = projectileState2.OnExit + whileTrueState2.Enter;
      ProjectileState projectileState3 = projectileState1;
      projectileState3.OnExit = projectileState3.OnExit + playAudioAction3.Do;
      projectileState1.onImpactDelegate = (Action<ImpactParameters>) (parameters =>
      {
        if (parameters.collider == null || !parameters.collider.isPlayer)
          return;
        rumbleOnHitAction.playerId = (SyncableValue<ulong>) parameters.collider.playerId.value;
        if ((double) this.pushDistanceOnHit <= 0.0 || (double) this.pushDurationOnHit <= 0.0)
          return;
        JVector direction = skillGraph.GetOwner().transform.Vector2DTo(parameters.collider.transform.Position2D).Normalized();
        StatusEffect effect = StatusEffect.Push(skillGraph.GetOwnerId(), direction, this.pushDistanceOnHit, this.pushDurationOnHit);
        parameters.collider.AddStatusEffect(skillGraph.GetContext(), effect);
      });
      rumbleOnHitAction.duration = (SyncableValue<float>) 1f;
      rumbleOnHitAction.strength = (SyncableValue<float>) 1f;
      whileTrueState2.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled() && (bool) isActive);
      WhileTrueState whileTrueState3 = whileTrueState2;
      whileTrueState3.SubState = whileTrueState3.SubState + (SkillState) waitState2;
      WhileTrueState whileTrueState4 = whileTrueState2;
      whileTrueState4.SubState = whileTrueState4.SubState + (SkillState) audioState;
      WhileTrueState whileTrueState5 = whileTrueState2;
      whileTrueState5.SubState = whileTrueState5.SubState + (SkillState) waitState1;
      waitState1.duration.Expression((Func<float>) (() => this.canTeleportDelay));
      waitState1.OnFinish += setVar10.Do;
      waitState1.OnFinish += playVfxState.Enter;
      setVar10.var = canTeleport;
      setVar10.value = (SyncableValue<bool>) true;
      waitState2.duration.Expression((Func<float>) (() => this.duration));
      WaitState waitState3 = waitState2;
      waitState3.OnEnter = waitState3.OnEnter + setVar2.Do;
      WaitState waitState4 = waitState2;
      waitState4.OnExit = waitState4.OnExit + setVar11.Do;
      WaitState waitState5 = waitState2;
      waitState5.OnExit = waitState5.OnExit + playAudioAction5.Do;
      WaitState waitState6 = waitState2;
      waitState6.SubState = waitState6.SubState + (SkillState) showAoeState2;
      WaitState waitState7 = waitState2;
      waitState7.OnExit = waitState7.OnExit + playVfxState.Exit;
      waitState2.onUpdate = (Action<float>) (t =>
      {
        if (!((UniqueId) spearHitEntity != UniqueId.Invalid))
          return;
        GameEntity entity = skillGraph.GetEntity((UniqueId) spearHitEntity);
        if (entity == null || !entity.isPlayer)
          return;
        if (entity.HasModifier(StatusModifier.Flying) || entity.HasModifier(StatusModifier.Invisible))
          spearHitEntity.Set(UniqueId.Invalid);
        else
          teleportTarget.Set(entity.transform.position);
      });
      waitState2.OnFinish += whileTrueState1.Enter;
      setVar2.var = currentCooldown;
      setVar2.value.Expression((Func<float>) (() => this.cooldown));
      setVar11.var = canTeleport;
      setVar11.value = (SyncableValue<bool>) false;
      showAoeState2.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      showAoeState2.overrideOwnerPosition = true;
      showAoeState2.position.Expression((Func<JVector>) (() => (JVector) teleportTarget));
      conditionAction2.condition = (Func<bool>) (() => (bool) canTeleport && !skillGraph.IsGraphLocked());
      conditionAction2.OnTrue += setVar14.Do;
      setVar14.var = teleportDir;
      setVar14.value.Expression((Func<JVector>) (() => skillGraph.GetOwner().transform.Vector2DTo((JVector) teleportTarget).Normalized()));
      SetVar<JVector> setVar15 = setVar14;
      setVar15.Then = setVar15.Then + setVar12.Do;
      setVar12.var = skillVar;
      setVar12.value = (SyncableValue<bool>) true;
      SetVar<bool> setVar16 = setVar12;
      setVar16.Then = setVar16.Then + moveToTargetState1.Enter;
      moveToTargetState1.targetPos.Expression((Func<JVector>) (() => (JVector) teleportTarget));
      moveToTargetState1.speed.Expression((Func<float>) (() => this.teleportSpeed));
      MoveToTargetState moveToTargetState2 = moveToTargetState1;
      moveToTargetState2.OnEnter = moveToTargetState2.OnEnter + setVar11.Do;
      MoveToTargetState moveToTargetState3 = moveToTargetState1;
      moveToTargetState3.OnEnter = moveToTargetState3.OnEnter + invisibleState.Enter;
      MoveToTargetState moveToTargetState4 = moveToTargetState1;
      moveToTargetState4.OnExit = moveToTargetState4.OnExit + setVar13.Do;
      MoveToTargetState moveToTargetState5 = moveToTargetState1;
      moveToTargetState5.OnExit = moveToTargetState5.OnExit + conditionAction3.Do;
      MoveToTargetState moveToTargetState6 = moveToTargetState1;
      moveToTargetState6.OnExit = moveToTargetState6.OnExit + spawnVfxAction.Do;
      MoveToTargetState moveToTargetState7 = moveToTargetState1;
      moveToTargetState7.SubState = moveToTargetState7.SubState + (SkillState) collisionLayerMaskState;
      MoveToTargetState moveToTargetState8 = moveToTargetState1;
      moveToTargetState8.SubState = moveToTargetState8.SubState + (SkillState) mofifierToOwnerState;
      MoveToTargetState moveToTargetState9 = moveToTargetState1;
      moveToTargetState9.SubState = moveToTargetState9.SubState + (SkillState) lockGraphsState;
      MoveToTargetState moveToTargetState10 = moveToTargetState1;
      moveToTargetState10.SubState = moveToTargetState10.SubState + (SkillState) modFloorUiState;
      MoveToTargetState moveToTargetState11 = moveToTargetState1;
      moveToTargetState11.SubState = moveToTargetState11.SubState + (SkillState) objectVisibilityState;
      MoveToTargetState moveToTargetState12 = moveToTargetState1;
      moveToTargetState12.SubState = moveToTargetState12.SubState + (SkillState) invisibleState;
      setVar13.var = skillVar;
      setVar13.value = (SyncableValue<bool>) false;
      collisionLayerMaskState.targetEntityId = (SyncableValue<UniqueId>) skillGraph.GetOwner().uniqueId.id;
      collisionLayerMaskState.setToLayer = CollisionLayer.None;
      collisionLayerMaskState.setToMask = CollisionLayer.Ball;
      mofifierToOwnerState.modifier = StatusModifier.BlockMove | StatusModifier.ImmuneToTackle;
      conditionAction3.condition += (Func<bool>) (() => !skillGraph.GetOwner().IsDead() && !skillGraph.GetOwner().IsPushed() && !skillGraph.GetOwner().IsStunned());
      conditionAction3.OnTrue += areaOfEffectAction1.Do;
      areaOfEffectAction1.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      areaOfEffectAction1.position.Expression((Func<JVector>) (() => (JVector) teleportTarget));
      areaOfEffectAction1.hitEntities = hitEntities;
      areaOfEffectAction1.includeEnemies = true;
      areaOfEffectAction1.filterHit = (Func<GameEntity, bool>) (entity => entity.HasModifier(StatusModifier.Flying) || entity.HasModifier(StatusModifier.Invisible));
      areaOfEffectAction1.thenDelegate = (Action) (() =>
      {
        if (!skillGraph.IsServer())
          return;
        for (int i = 0; i < hitEntities.Length; ++i)
        {
          GameEntity entity = skillGraph.GetEntity(hitEntities[i]);
          if ((double) this.stunDuration > 0.0)
          {
            skillGraph.GetContext().eventDispatcher.value.EnqueueStunEvent(entity.playerId.value, skillGraph.GetOwnerId(), this.stunDuration);
            entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Stun(skillGraph.GetOwnerId(), this.stunDuration));
          }
          if ((double) this.pushDistance > 0.0 && (double) this.pushDuration > 0.0)
            entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.Push(skillGraph.GetOwnerId(), (JVector) teleportDir, this.pushDistance, this.pushDuration));
          if ((double) this.slowDuration > 0.0)
            entity.AddStatusEffect(skillGraph.GetContext(), StatusEffect.MovementSpeedChange(skillGraph.GetOwnerId(), this.slowAmount, this.slowDuration));
          int damage = this.damage;
        }
      });
      CheckAreaOfEffectAction areaOfEffectAction2 = areaOfEffectAction1;
      areaOfEffectAction2.Then = areaOfEffectAction2.Then + whileTrueState1.Enter;
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 1.40129846432482E-45);
      WhileTrueState whileTrueState6 = whileTrueState1;
      whileTrueState6.SubState = whileTrueState6.SubState + (SkillState) booleanSwitchState1;
      WhileTrueState whileTrueState7 = whileTrueState1;
      whileTrueState7.OnEnter = whileTrueState7.OnEnter + setVar9.Do;
      WhileTrueState whileTrueState8 = whileTrueState1;
      whileTrueState8.OnEnter = whileTrueState8.OnEnter + setVar4.Do;
      WhileTrueState whileTrueState9 = whileTrueState1;
      whileTrueState9.OnExit = whileTrueState9.OnExit + setVar5.Do;
      setVar9.var = isActive;
      setVar9.value = (SyncableValue<bool>) false;
      setVar4.var = isOnCooldown;
      setVar4.value = (SyncableValue<bool>) true;
      setVar5.var = isOnCooldown;
      setVar5.value = (SyncableValue<bool>) false;
      booleanSwitchState1.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState1.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.amountPerSecond.Constant(-1f);
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState.onEnterDelegate = (Action) (() => spearHitEntity.Set(UniqueId.Invalid));
      onEventAction1.EventType = SkillGraphEvent.MatchStart;
      onEventAction1.OnTrigger += whileTrueState1.Enter;
      onEventAction4.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction4.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction2.EventType = SkillGraphEvent.Interrupt;
      onEventAction2.OnTrigger += conditionAction4.Do;
      onEventAction3.EventType = SkillGraphEvent.MatchStateChanged;
      onEventAction3.OnTrigger += conditionAction5.Do;
      conditionAction5.condition = (Func<bool>) (() => skillGraph.GetMatchState() != Imi.SharedWithServer.Game.MatchState.PointInProgress);
      conditionAction5.OnTrue += conditionAction4.Do;
      conditionAction4.condition = (Func<bool>) (() => (bool) isActive);
      conditionAction4.OnTrue += groupAction1.Do;
      groupAction1.OnTrigger += setVar2.Do;
      groupAction1.OnTrigger += setVar9.Do;
      groupAction1.OnTrigger += waitState1.Exit;
      groupAction1.OnTrigger += setVar11.Do;
      GroupAction groupAction2 = groupAction1;
      groupAction2.Then = groupAction2.Then + whileTrueState1.Enter;
      onEventAction5.EventType = SkillGraphEvent.Overtime;
      onEventAction5.OnTrigger += setVar3.Do;
      setVar3.var = currentCooldown;
      setVar3.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar17 = setVar3;
      setVar17.Then = setVar17.Then + whileTrueState1.Enter;
      objectVisibilityState.objectTagName.Constant("ParticleEmission");
      objectVisibilityState.visibility.Constant(true);
    }

    public class ConnectionArgs
    {
      public SyncableValue<JVector> start;
      public SyncableValue<JVector> end;
    }
  }
}
