// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.VirtualSwapConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay;
using Imi.Utils.Extensions;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "VirtualSwapConfig", menuName = "SteelCircus/SkillConfigs/VirtualSwapConfig")]
  public class VirtualSwapConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button = Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill;
    public string iconName = "icon_mine_inverted_01_tex";
    public float cooldown = 30f;
    public AreaOfEffect aoeEnter;
    public float disappearDuration = 0.75f;
    public float hitAppearDuration = 0.5f;
    public float beamingDuration = 0.2f;
    public float maxInvisibleDuration = 3f;
    public float moveSpeedModifier = 0.25f;
    public AreaOfEffect aoeTouch;
    public float swapYOffset = -2f;
    public float enemyStunDuration = 1f;
    public VfxPrefab floorLineVfx;
    public VfxPrefab floorExitVfx;
    public VfxPrefab floorSwapVfx;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      VirtualSwapConfig.FloorSwapFxArgs floorSwapFxArgs = new VirtualSwapConfig.FloorSwapFxArgs();
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Disappear duration");
      WaitState floorDurationState = skillGraph.AddState<WaitState>("Invisible duration");
      WaitState waitState2 = skillGraph.AddState<WaitState>("Appear duration");
      CheckAreaOfEffectState areaOfEffectState = skillGraph.AddState<CheckAreaOfEffectState>("CheckTouchState");
      PositionSwapState swapBackTouchedState = skillGraph.AddState<PositionSwapState>("Swap Back State");
      PositionSwapState positionSwapState1 = skillGraph.AddState<PositionSwapState>("Swap Back State");
      ModifyYPositionState modifyYpositionState = skillGraph.AddState<ModifyYPositionState>("Keep inside Floor");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("WhileActive");
      WhileTrueState whileTrueState2 = skillGraph.AddState<WhileTrueState>("WhileInvisible");
      ChangeCollisionLayerMaskState collisionLayerMaskState = skillGraph.AddState<ChangeCollisionLayerMaskState>("NoCollisionState");
      ModFloorUiState modFloorUiState = skillGraph.AddState<ModFloorUiState>("HideChampUi");
      PlayAnimationState playAnimationState = skillGraph.AddState<PlayAnimationState>("Animation");
      ShowAoeState showAoeState = skillGraph.AddState<ShowAoeState>("Portal AoE");
      PlayVfxState playVfxState = skillGraph.AddState<PlayVfxState>("Line Vfx");
      AudioState audioState = skillGraph.AddState<AudioState>("Glitch Audio State");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("Block other Skills");
      WhileTrueState whileTrueState3 = skillGraph.AddState<WhileTrueState>("ShowPortalState");
      WhileTrueState cooldownState = skillGraph.AddState<WhileTrueState>("Cooldown");
      BooleanSwitchState booleanSwitchState = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("UpdateCooldown");
      InvisibleState invisibleState = skillGraph.AddState<InvisibleState>("InvisibleState");
      SpawnVfxAction spawnVfxAction1 = skillGraph.AddAction<SpawnVfxAction>("Floor exit Vfx");
      SpawnVfxAction spawnVfxAction2 = skillGraph.AddAction<SpawnVfxAction>("Trigger Swap Vfx");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("PlaySwapStartAudio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("PlayVoiceStartAudio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("PlayDiveAudio");
      PlayAudioAction playAudioAction4 = skillGraph.AddAction<PlayAudioAction>("PlayTeleportAudio");
      PlayAudioAction playAudioAction5 = skillGraph.AddAction<PlayAudioAction>("PlaySwapStart2 Audio");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnSkillPickup");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      ConditionAction conditionAction1 = skillGraph.AddAction<ConditionAction>("OnButtonDownCheck");
      ConditionAction conditionAction2 = skillGraph.AddAction<ConditionAction>("OnButtonDownCheck");
      ConditionAction conditionAction3 = skillGraph.AddAction<ConditionAction>("IsNotStunned");
      ApplyPushStunAction applyPushStunAction1 = skillGraph.AddAction<ApplyPushStunAction>("ApplyStunToTouched");
      SetVar<JVector> setVar1 = skillGraph.AddAction<SetVar<JVector>>("SetStartPos");
      SetVar<float> setVar2 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("SetAbortInvisibility");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("SetActive");
      SetVar<UniqueId> setVar5 = skillGraph.AddAction<SetVar<UniqueId>>("SetActive");
      SkillVar<bool> cooldownOver = skillGraph.AddVar<bool>("IsCooldownOver");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> stopInvisible = skillGraph.AddVar<bool>("StopInvisibleStatus");
      SkillVar<bool> invisAborted = skillGraph.AddVar<bool>("TouchedEnemy");
      SkillVar<bool> successfulSwap = skillGraph.AddVar<bool>("WasSwapSuccessful");
      SkillVar<bool> canUseSkill = skillGraph.AddVar<bool>("CanUse");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<JVector> startPos = skillGraph.AddVar<JVector>("StartPosition");
      SkillVar<UniqueId> touchedEntities = skillGraph.AddVar<UniqueId>("TouchedEntities", true);
      SkillVar<UniqueId> touchedEntity = skillGraph.AddVar<UniqueId>("TouchedEntity");
      currentCooldown.Set(this.cooldown);
      cooldownOver.Set(true);
      successfulSwap.Expression((Func<bool>) (() => (UniqueId) touchedEntity != UniqueId.Invalid));
      canUseSkill.Expression((Func<bool>) (() => (bool) cooldownOver && !(bool) isActive && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall()));
      audioState.audioResourceName.Constant("SchroederSkillSwapGlitchLoop");
      playAudioAction1.audioResourceName.Constant("SchroederSkillSwap");
      playAudioAction2.audioResourceName.Constant("SchroederVoiceSwap");
      playAudioAction3.audioResourceName.Constant("SchroederSkillSwapDiveImpact");
      playAudioAction4.audioResourceName.Constant("SchroederSkillSwapTeleport");
      playAudioAction5.audioResourceName.Constant("SchroederSkillSwapPart2");
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) (1.0 - (double) (float) currentCooldown / (double) this.cooldown)));
      spawnVfxAction1.vfxPrefab = this.floorExitVfx;
      spawnVfxAction1.position.Expression((Func<JVector>) (() => swapBackTouchedState.endPos.Get()));
      spawnVfxAction1.args = (Func<object>) (() => (object) successfulSwap.Get());
      buttonState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      buttonState.OnButtonDown += conditionAction2.Do;
      conditionAction2.condition = (Func<bool>) (() => (bool) canUseSkill);
      conditionAction2.OnTrue += setVar4.Do;
      conditionAction2.OnFalse += conditionAction1.Do;
      conditionAction1.condition = (Func<bool>) (() => floorDurationState.IsActive);
      conditionAction1.OnTrue += setVar3.Do;
      setVar3.var = invisAborted;
      setVar3.value = (SyncableValue<bool>) true;
      playAnimationState.animationType.Constant(AnimationStateType.PrimarySkill);
      setVar4.var = isActive;
      setVar4.value = (SyncableValue<bool>) true;
      SetVar<bool> setVar6 = setVar4;
      setVar6.Then = setVar6.Then + whileTrueState1.Enter;
      SetVar<bool> setVar7 = setVar4;
      setVar7.Then = setVar7.Then + waitState1.Enter;
      whileTrueState1.condition = (Func<bool>) (() => (bool) isActive);
      WhileTrueState whileTrueState4 = whileTrueState1;
      whileTrueState4.SubState = whileTrueState4.SubState + (SkillState) modFloorUiState;
      modFloorUiState.state = FloorUiVisibilityState.Normal;
      modFloorUiState.showOverheadUi = false;
      waitState1.duration.Expression((Func<float>) (() => this.disappearDuration));
      waitState1.onEnterDelegate = (Action) (() =>
      {
        currentCooldown.Set(this.cooldown);
        invisAborted.Set(false);
        stopInvisible.Set(false);
        touchedEntities.Clear();
        touchedEntity.Set(UniqueId.Invalid);
      });
      WaitState waitState3 = waitState1;
      waitState3.OnEnter = waitState3.OnEnter + lockGraphsState.Enter;
      WaitState waitState4 = waitState1;
      waitState4.OnEnter = waitState4.OnEnter + playAudioAction1.Do;
      WaitState waitState5 = waitState1;
      waitState5.OnEnter = waitState5.OnEnter + playAudioAction2.Do;
      WaitState waitState6 = waitState1;
      waitState6.OnEnter = waitState6.OnEnter + playAudioAction3.Do;
      WaitState waitState7 = waitState1;
      waitState7.OnEnter = waitState7.OnEnter + playAnimationState.Enter;
      WaitState waitState8 = waitState1;
      waitState8.OnEnter = waitState8.OnEnter + setVar1.Do;
      WaitState waitState9 = waitState1;
      waitState9.OnExit = waitState9.OnExit + whileTrueState2.Enter;
      setVar1.var = startPos;
      setVar1.value.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      whileTrueState2.condition = (Func<bool>) (() => floorDurationState.IsActive && !(bool) successfulSwap && !(bool) invisAborted && !skillGraph.IsSkillUseDisabled());
      WhileTrueState whileTrueState5 = whileTrueState2;
      whileTrueState5.SubState = whileTrueState5.SubState + (SkillState) floorDurationState;
      floorDurationState.duration.Expression((Func<float>) (() => this.maxInvisibleDuration));
      WaitState waitState10 = floorDurationState;
      waitState10.OnEnter = waitState10.OnEnter + invisibleState.Enter;
      floorDurationState.onEnterDelegate = (Action) (() =>
      {
        StatusEffect effect = StatusEffect.MovementSpeedChange(skillGraph.GetOwnerId(), this.moveSpeedModifier, this.maxInvisibleDuration, stopInvisible);
        skillGraph.GetOwner().AddStatusEffect(skillGraph.GetContext(), effect);
      });
      WaitState waitState11 = floorDurationState;
      waitState11.SubState = waitState11.SubState + (SkillState) whileTrueState3;
      WaitState waitState12 = floorDurationState;
      waitState12.SubState = waitState12.SubState + (SkillState) audioState;
      WaitState waitState13 = floorDurationState;
      waitState13.SubState = waitState13.SubState + (SkillState) areaOfEffectState;
      WaitState waitState14 = floorDurationState;
      waitState14.SubState = waitState14.SubState + (SkillState) collisionLayerMaskState;
      WaitState waitState15 = floorDurationState;
      waitState15.OnExit = waitState15.OnExit + conditionAction3.Do;
      conditionAction3.condition = (Func<bool>) (() => !(bool) successfulSwap && !skillGraph.GetOwner().IsStunned() && !skillGraph.GetOwner().IsPushed());
      conditionAction3.OnTrue += positionSwapState1.Enter;
      whileTrueState3.condition = (Func<bool>) (() => (bool) isActive);
      WhileTrueState whileTrueState6 = whileTrueState3;
      whileTrueState6.SubState = whileTrueState6.SubState + (SkillState) showAoeState;
      WhileTrueState whileTrueState7 = whileTrueState3;
      whileTrueState7.SubState = whileTrueState7.SubState + (SkillState) playVfxState;
      showAoeState.aoe.Expression((Func<AreaOfEffect>) (() => this.aoeEnter));
      showAoeState.position.Expression((Func<JVector>) (() => (JVector) startPos));
      showAoeState.onEnterDelegate = (Action) (() => floorSwapFxArgs.endPos = skillGraph.GetPosition());
      playVfxState.position.Expression((Func<JVector>) (() => (JVector) startPos));
      playVfxState.vfxPrefab = this.floorLineVfx;
      playVfxState.parentToOwner = false;
      playVfxState.args = (object) (Func<float>) (() => floorDurationState.NormalizedProgress);
      collisionLayerMaskState.targetEntityId = (SyncableValue<UniqueId>) skillGraph.GetOwner().uniqueId.id;
      collisionLayerMaskState.setToLayer = CollisionLayer.None;
      collisionLayerMaskState.setToMask = CollisionLayer.LvlBorder;
      areaOfEffectState.aoe.Expression((Func<AreaOfEffect>) (() => this.aoeTouch));
      areaOfEffectState.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      areaOfEffectState.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      areaOfEffectState.filterHit = (Func<GameEntity, bool>) (entity => entity.HasModifier(StatusModifier.Flying));
      areaOfEffectState.hitEntities = touchedEntities;
      areaOfEffectState.includeEnemies = true;
      areaOfEffectState.OnHit += setVar5.Do;
      setVar5.var = touchedEntity;
      setVar5.value.Expression((Func<UniqueId>) (() => touchedEntities[0]));
      SetVar<UniqueId> setVar8 = setVar5;
      setVar8.Then = setVar8.Then + applyPushStunAction1.Do;
      applyPushStunAction1.targetEntities = touchedEntities;
      applyPushStunAction1.singleTarget = true;
      applyPushStunAction1.stunDuration.Expression((Func<float>) (() => this.beamingDuration + this.enemyStunDuration));
      ApplyPushStunAction applyPushStunAction2 = applyPushStunAction1;
      applyPushStunAction2.Then = applyPushStunAction2.Then + waitState2.Enter;
      ApplyPushStunAction applyPushStunAction3 = applyPushStunAction1;
      applyPushStunAction3.Then = applyPushStunAction3.Then + swapBackTouchedState.Enter;
      swapBackTouchedState.movedEntityId.Expression((Func<UniqueId>) (() => (UniqueId) touchedEntity));
      swapBackTouchedState.startPos.Expression((Func<JVector>) (() =>
      {
        GameEntity entity = skillGraph.GetEntity((UniqueId) touchedEntity);
        return entity == null ? JVector.Zero : entity.transform.position;
      }));
      swapBackTouchedState.endPos.Expression((Func<JVector>) (() => (JVector) startPos));
      swapBackTouchedState.duration.Expression((Func<float>) (() => this.beamingDuration));
      PositionSwapState positionSwapState2 = swapBackTouchedState;
      positionSwapState2.OnEnter = positionSwapState2.OnEnter + spawnVfxAction2.Do;
      PositionSwapState positionSwapState3 = swapBackTouchedState;
      positionSwapState3.OnEnter = positionSwapState3.OnEnter + playAudioAction4.Do;
      PositionSwapState positionSwapState4 = swapBackTouchedState;
      positionSwapState4.OnEnter = positionSwapState4.OnEnter + playAudioAction5.Do;
      swapBackTouchedState.onEnterDelegate = (Action) (() =>
      {
        GameEntity entity = skillGraph.GetEntity((UniqueId) touchedEntity);
        GameContext context = skillGraph.GetContext();
        GameContext gameContext = context;
        if (entity.IsBallOwner(gameContext))
          BallUpdateSystem.SetBallOwner(context, skillGraph.GetContext().ballEntity, skillGraph.GetOwner());
        floorSwapFxArgs.startPos = skillGraph.GetPosition();
        floorSwapFxArgs.duration = this.beamingDuration;
      });
      PositionSwapState positionSwapState5 = swapBackTouchedState;
      positionSwapState5.SubState = positionSwapState5.SubState + (SkillState) modifyYpositionState;
      PositionSwapState positionSwapState6 = swapBackTouchedState;
      positionSwapState6.OnExit = positionSwapState6.OnExit + spawnVfxAction1.Do;
      positionSwapState1.movedEntityId.Expression((Func<UniqueId>) (() => (UniqueId) touchedEntity));
      positionSwapState1.startPos.Expression(new Func<JVector>(skillGraph.GetPosition));
      positionSwapState1.endPos.Expression((Func<JVector>) (() => (JVector) startPos));
      positionSwapState1.duration.Expression((Func<float>) (() => this.beamingDuration));
      PositionSwapState positionSwapState7 = positionSwapState1;
      positionSwapState7.OnEnter = positionSwapState7.OnEnter + spawnVfxAction2.Do;
      positionSwapState1.onEnterDelegate = (Action) (() =>
      {
        floorSwapFxArgs.startPos = skillGraph.GetPosition();
        floorSwapFxArgs.duration = this.beamingDuration;
      });
      PositionSwapState positionSwapState8 = positionSwapState1;
      positionSwapState8.OnExit = positionSwapState8.OnExit + waitState2.Enter;
      PositionSwapState positionSwapState9 = positionSwapState1;
      positionSwapState9.OnExit = positionSwapState9.OnExit + spawnVfxAction1.Do;
      modifyYpositionState.movedEntityId.Expression((Func<UniqueId>) (() => (UniqueId) touchedEntity));
      modifyYpositionState.duration.Expression((Func<float>) (() => this.beamingDuration));
      modifyYpositionState.yOffset.Expression((Func<float>) (() => !(bool) successfulSwap ? 0.0f : this.swapYOffset));
      spawnVfxAction2.vfxPrefab = this.floorSwapVfx;
      spawnVfxAction2.args = (Func<object>) (() => (object) floorSwapFxArgs);
      spawnVfxAction2.position.Constant(JVector.Zero);
      spawnVfxAction2.lookDir.Constant(JVector.Forward);
      waitState2.duration.Expression((Func<float>) (() => this.hitAppearDuration));
      WaitState waitState16 = waitState2;
      waitState16.OnEnter = waitState16.OnEnter + playAnimationState.Exit;
      waitState2.onEnterDelegate = (Action) (() => stopInvisible.Set(true));
      WaitState waitState17 = waitState2;
      waitState17.OnExit = waitState17.OnExit + invisibleState.Exit;
      WaitState waitState18 = waitState2;
      waitState18.OnExit = waitState18.OnExit + showAoeState.Exit;
      WaitState waitState19 = waitState2;
      waitState19.OnExit = waitState19.OnExit + lockGraphsState.Exit;
      WaitState waitState20 = waitState2;
      waitState20.OnExit = waitState20.OnExit + cooldownState.Enter;
      waitState2.onExitDelegate = (Action) (() => isActive.Set(false));
      cooldownState.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState8 = cooldownState;
      whileTrueState8.SubState = whileTrueState8.SubState + (SkillState) booleanSwitchState;
      cooldownState.onEnterDelegate = (Action) (() => cooldownOver.Set(false));
      cooldownState.onExitDelegate = (Action) (() => cooldownOver.Set(true));
      booleanSwitchState.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState.amountPerSecond.Constant(-1f);
      onEventAction1.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction1.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction2.EventType = SkillGraphEvent.StunOrPush;
      onEventAction2.OnTrigger += invisibleState.Exit;
      onEventAction2.OnTrigger += playAnimationState.Exit;
      onEventAction2.OnTrigger += lockGraphsState.Exit;
      onEventAction2.onTriggerDelegate = (Action) (() =>
      {
        if (!(bool) isActive)
          return;
        isActive.Set(false);
        cooldownState.Enter_();
        currentCooldown.Set(this.cooldown);
      });
      onEventAction3.EventType = SkillGraphEvent.MatchStart;
      onEventAction3.OnTrigger += setVar2.Do;
      onEventAction4.EventType = SkillGraphEvent.Overtime;
      onEventAction4.OnTrigger += setVar2.Do;
      setVar2.var = currentCooldown;
      setVar2.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar9 = setVar2;
      setVar9.Then = setVar9.Then + cooldownState.Restart;
    }

    public class FloorSwapFxArgs
    {
      public JVector startPos;
      public JVector endPos;
      public float duration;
    }
  }
}
