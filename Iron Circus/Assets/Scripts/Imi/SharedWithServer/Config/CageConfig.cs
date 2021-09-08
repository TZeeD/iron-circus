// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.CageConfig
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
  [CreateAssetMenu(fileName = "CageConfig", menuName = "SteelCircus/SkillConfigs/CageConfig")]
  public class CageConfig : SkillGraphConfig
  {
    public string iconName = "icon_stomp_inverted_01_tex";
    public float wallThickness = 0.25f;
    public float maxRadius = 8f;
    public float minRadius = 5f;
    public float shrinkDuration = 1.5f;
    public float cooldown = 30f;
    public bool showPreviewOnRemoteEntities = true;
    public float duration = 5f;
    public float aimMovementFactor = 1f;
    public JVector barrierDimensions = new JVector(5f, 2f, 5f);
    public float barrierOffset = 1.5f;
    public VfxPrefab barrierPrefab;
    public VfxPrefab aoePrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      WaitState waitState1 = skillGraph.AddState<WaitState>("CageDuration");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("While can Aim");
      ShowAoeState aimState = skillGraph.AddState<ShowAoeState>("ShowAoE");
      RoundCageActiveState roundCageActiveState = skillGraph.AddState<RoundCageActiveState>("CageActive");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("Anim");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("TurnToAim");
      AudioState audioState1 = skillGraph.AddState<AudioState>("Appearance Cage Audio");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("CooldownState");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("UpdateCooldown");
      AudioState audioState2 = skillGraph.AddState<AudioState>("cage Aim Audio Loop");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("LockGraphs");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("Can activate Check");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("Trigger Cage Audio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Trigger Cage Voice");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("End Cage Audio");
      PlayAudioAction playAudioAction4 = skillGraph.AddAction<PlayAudioAction>("Play cage aim Start Audio");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("SetSkillActive");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("SetSkillInactive");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("SetOnCooldown");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("SetOffCooldown");
      SetVar<float> setVar5 = skillGraph.AddAction<SetVar<float>>("ResetCooldown");
      SetVar<float> setVar6 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SetVar<JVector> setVar7 = skillGraph.AddAction<SetVar<JVector>>("Update Aim Direction");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("CooldownReady");
      SkillVar<bool> isCageActive = skillGraph.AddVar<bool>("IsCageActive");
      SkillVar<bool> canPerformSkill = skillGraph.AddVar<bool>("CanPerformSkill");
      SkillVar<bool> isNotInPreviewState = skillGraph.AddVar<bool>("Preview NOT Active");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<float> uiFill = skillGraph.AddVar<float>("uiFill");
      SkillVar<JVector> aimDir = skillGraph.AddVar<JVector>("AimDir");
      SkillVar<JVector> barrierPos = skillGraph.AddVar<JVector>("BarrierPos");
      isNotInPreviewState.Expression((Func<bool>) (() => !aimState.IsActive));
      canPerformSkill.Expression((Func<bool>) (() => !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall() && !(bool) isCageActive && !(bool) isOnCooldown));
      uiFill.Expression((Func<float>) (() => (this.cooldown - (float) currentCooldown) / this.cooldown));
      currentCooldown.Set(this.cooldown);
      barrierPos.Expression((Func<JVector>) (() => skillGraph.GetOwner().transform.position + aimDir.Get().Normalized() * (this.barrierOffset + this.barrierDimensions.Z / 2f)));
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillUiState.buttonType.Constant(Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill);
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) uiFill));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      audioState1.audioResourceName.Constant("EllikaSkillCageAppear");
      audioState2.audioResourceName.Constant("EllikaSkillCageAimLoop");
      playAudioAction4.audioResourceName.Constant("EllikaSkillCageAimStart");
      playAudioAction1.audioResourceName.Constant("EllikaSkillCageStart");
      playAudioAction2.audioResourceName.Constant("EllikaVoiceCage");
      playAudioAction3.audioResourceName.Constant("EllikaSkillCageEnd");
      buttonState.buttonType.Constant(Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill);
      buttonState.buttonDownSubStates += (SkillState) booleanSwitchState1;
      buttonState.OnButtonUp += conditionAction.Do;
      booleanSwitchState1.condition = (Func<bool>) (() => (bool) canPerformSkill);
      booleanSwitchState1.WhileTrueSubState += (SkillState) aimState;
      booleanSwitchState1.WhileTrueSubState += (SkillState) lockGraphsState;
      booleanSwitchState1.OnTrue += playAudioAction4.Do;
      conditionAction.condition = (Func<bool>) (() => (bool) canPerformSkill);
      conditionAction.OnTrue += waitState1.Enter;
      conditionAction.OnTrue += playAudioAction1.Do;
      conditionAction.OnTrue += playAudioAction2.Do;
      aimState.showOnlyForLocalPlayer.Constant(!this.showPreviewOnRemoteEntities);
      aimState.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Circle,
        radius = this.maxRadius,
        vfxPrefab = this.aoePrefab
      }));
      aimState.offset = (SyncableValue<JVector>) JVector.Zero;
      aimState.position.Expression((Func<JVector>) (() => skillGraph.GetPosition() + aimDir.Get() * (this.barrierOffset + this.barrierDimensions.Z / 2f)));
      aimState.trackOwnerPosition = (SyncableValue<bool>) false;
      aimState.onEnterDelegate = (Action) (() =>
      {
        if ((double) this.aimMovementFactor == 1.0)
          return;
        GameEntity owner = skillGraph.GetOwner();
        float offset = this.aimMovementFactor - 1f;
        GameContext context = skillGraph.GetContext();
        StatusEffect effect = StatusEffect.MovementSpeedChange(skillGraph.GetOwnerId(), offset, 0.0f, isNotInPreviewState);
        owner.AddStatusEffect(context, effect);
      });
      ShowAoeState showAoeState1 = aimState;
      showAoeState1.OnUpdate = showAoeState1.OnUpdate + setVar7.Do;
      ShowAoeState showAoeState2 = aimState;
      showAoeState2.SubState = showAoeState2.SubState + (SkillState) playAnimationState1;
      ShowAoeState showAoeState3 = aimState;
      showAoeState3.SubState = showAoeState3.SubState + (SkillState) playAnimationState2;
      ShowAoeState showAoeState4 = aimState;
      showAoeState4.SubState = showAoeState4.SubState + (SkillState) audioState2;
      playAnimationState1.animationType.Constant(AnimationStateType.SecondarySkill);
      playAnimationState2.animationType.Constant(AnimationStateType.TurnHeadToAim);
      setVar7.var = aimDir;
      setVar7.value.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir()));
      waitState1.duration.Expression((Func<float>) (() => this.duration));
      WaitState waitState2 = waitState1;
      waitState2.SubState = waitState2.SubState + (SkillState) roundCageActiveState;
      WaitState waitState3 = waitState1;
      waitState3.OnEnter = waitState3.OnEnter + setVar1.Do;
      WaitState waitState4 = waitState1;
      waitState4.OnEnter = waitState4.OnEnter + setVar5.Do;
      WaitState waitState5 = waitState1;
      waitState5.SubState = waitState5.SubState + (SkillState) audioState1;
      WaitState waitState6 = waitState1;
      waitState6.OnExit = waitState6.OnExit + playAudioAction3.Do;
      WaitState waitState7 = waitState1;
      waitState7.OnExit = waitState7.OnExit + setVar2.Do;
      WaitState waitState8 = waitState1;
      waitState8.OnExit = waitState8.OnExit + whileTrueState1.Enter;
      setVar5.var = currentCooldown;
      setVar5.value.Expression((Func<float>) (() => this.cooldown));
      setVar1.var = isCageActive;
      setVar1.value = (SyncableValue<bool>) true;
      setVar2.var = isCageActive;
      setVar2.value = (SyncableValue<bool>) false;
      roundCageActiveState.maxRadius.Expression((Func<float>) (() => this.maxRadius));
      roundCageActiveState.minRadius.Expression((Func<float>) (() => this.minRadius));
      roundCageActiveState.shrinkDuration.Expression((Func<float>) (() => this.shrinkDuration));
      roundCageActiveState.wallThickness.Expression((Func<float>) (() => this.wallThickness));
      roundCageActiveState.prefab.Constant(this.barrierPrefab.value);
      roundCageActiveState.position.Expression((Func<JVector>) (() => (JVector) barrierPos));
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState2;
      WhileTrueState whileTrueState3 = whileTrueState1;
      whileTrueState3.OnEnter = whileTrueState3.OnEnter + setVar3.Do;
      WhileTrueState whileTrueState4 = whileTrueState1;
      whileTrueState4.OnExit = whileTrueState4.OnExit + setVar4.Do;
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
      onEventAction3.OnTrigger += setVar6.Do;
      setVar6.var = currentCooldown;
      setVar6.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar8 = setVar6;
      setVar8.Then = setVar8.Then + whileTrueState1.Enter;
      setVar3.var = isOnCooldown;
      setVar3.value = (SyncableValue<bool>) true;
      setVar4.var = isOnCooldown;
      setVar4.value = (SyncableValue<bool>) false;
    }
  }
}
