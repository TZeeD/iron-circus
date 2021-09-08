// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.WarsongConfig
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
  [CreateAssetMenu(fileName = "WarsongConfig", menuName = "SteelCircus/SkillConfigs/WarsongConfig")]
  public class WarsongConfig : SkillGraphConfig
  {
    [Header("Button Settings")]
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string iconName = "icon_warsong_inverted_01_tex";
    public float cooldown = 1f;
    [Header("Effect Settings")]
    public float reapplyDuration = 0.5f;
    public float moveSpeedModifierEnemies = -0.5f;
    public float moveSpeedModifierAllies = 0.5f;
    public float moveSpeedModifierOwn = 0.5f;
    public float castDuration = 0.5f;
    public float effectDuration = 10f;
    public AreaOfEffect aoe;
    public VfxPrefab vfxPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Intro");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      WaitState waitState2 = skillGraph.AddState<WaitState>("ActiveState");
      ShowAoeState showAoeState = skillGraph.AddState<ShowAoeState>("ShowAoE");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("PlayAnim");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("StopLookingAtBall");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("CooldownState");
      BooleanSwitchState booleanSwitchState = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("UpdateCooldown");
      AudioState audioState1 = skillGraph.AddState<AudioState>("StartAudio");
      AudioState audioState2 = skillGraph.AddState<AudioState>("StartMusic");
      CheckAreaOfEffectState areaOfEffectState = skillGraph.AddState<CheckAreaOfEffectState>("CheckAffectedEntities");
      ApplySpeedModToOwnerState speedModToOwnerState = skillGraph.AddState<ApplySpeedModToOwnerState>("SpeedModState");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("CastDurationBlockMove");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("LockGraphs");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("IfCanCast");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnSkillUseBlocked");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnDeath");
      OnEventAction onEventAction5 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("PlayVoice");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("PlayStopAudio");
      ApplySpeedModEffectAction speedModEffectAction1 = skillGraph.AddAction<ApplySpeedModEffectAction>("ApplySpeedBuff");
      ApplySpeedModEffectAction speedModEffectAction2 = skillGraph.AddAction<ApplySpeedModEffectAction>("ApplySpeedDeBuff");
      SetVar<float> setVar1 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SkillVar<bool> cooldownOver = skillGraph.AddVar<bool>("CooldownOver");
      SkillVar<bool> isSkillActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> canCast = skillGraph.AddVar<bool>("CanCast");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<float> uiFillAmount = skillGraph.AddVar<float>("uiFill");
      SkillVar<UniqueId> skillVar = skillGraph.AddVar<UniqueId>("Affected Entities", true);
      currentCooldown.Set(this.cooldown);
      uiFillAmount.Expression((Func<float>) (() => (this.cooldown - (float) currentCooldown) / this.cooldown));
      cooldownOver.Set(true);
      canCast.Expression((Func<bool>) (() => (bool) cooldownOver && !(bool) isSkillActive && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall()));
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      audioState1.audioResourceName.Constant("LochlanSkillWarsongBegin");
      audioState2.audioResourceName.Constant("LochlanSkillWarsongBeginBagpipe");
      playAudioAction1.audioResourceName.Constant("LochlanVoiceWarsong");
      playAudioAction2.audioResourceName.Constant("LochlanSkillWarsongEnd");
      playAudioAction2.doNotTrack.Constant(true);
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) uiFillAmount));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      buttonState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      buttonState.OnButtonUp += conditionAction.Do;
      conditionAction.condition = (Func<bool>) (() => (bool) canCast);
      conditionAction.OnTrue += waitState1.Enter;
      WaitState waitState3 = waitState1;
      waitState3.OnEnter = waitState3.OnEnter + playAudioAction1.Do;
      waitState1.onEnterDelegate = (Action) (() =>
      {
        currentCooldown.Set(this.cooldown);
        isSkillActive.Set(true);
      });
      waitState1.duration.Expression((Func<float>) (() => this.castDuration));
      WaitState waitState4 = waitState1;
      waitState4.SubState = waitState4.SubState + (SkillState) mofifierToOwnerState;
      WaitState waitState5 = waitState1;
      waitState5.SubState = waitState5.SubState + (SkillState) lockGraphsState;
      WaitState waitState6 = waitState1;
      waitState6.OnExit = waitState6.OnExit + waitState2.Enter;
      mofifierToOwnerState.modifier = StatusModifier.BlockMove;
      waitState2.duration.Expression((Func<float>) (() => this.effectDuration));
      WaitState waitState7 = waitState2;
      waitState7.SubState = waitState7.SubState + (SkillState) areaOfEffectState;
      WaitState waitState8 = waitState2;
      waitState8.SubState = waitState8.SubState + (SkillState) showAoeState;
      WaitState waitState9 = waitState2;
      waitState9.SubState = waitState9.SubState + (SkillState) playAnimationState2;
      WaitState waitState10 = waitState2;
      waitState10.SubState = waitState10.SubState + (SkillState) playAnimationState1;
      WaitState waitState11 = waitState2;
      waitState11.SubState = waitState11.SubState + (SkillState) speedModToOwnerState;
      waitState2.onExitDelegate = (Action) (() =>
      {
        if (skillGraph.IsSyncing())
          return;
        isSkillActive.Set(false);
      });
      WaitState waitState12 = waitState2;
      waitState12.SubState = waitState12.SubState + (SkillState) audioState1;
      WaitState waitState13 = waitState2;
      waitState13.SubState = waitState13.SubState + (SkillState) audioState2;
      WaitState waitState14 = waitState2;
      waitState14.OnExit = waitState14.OnExit + playAudioAction2.Do;
      WaitState waitState15 = waitState2;
      waitState15.OnExit = waitState15.OnExit + whileTrueState1.Enter;
      areaOfEffectState.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      areaOfEffectState.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      areaOfEffectState.lookDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      areaOfEffectState.hitEntities = skillVar;
      areaOfEffectState.filterHit = (Func<GameEntity, bool>) (entity => entity.HasModifier(StatusModifier.Flying) || entity.HasModifier(StatusModifier.Invisible));
      areaOfEffectState.includeEnemies = true;
      areaOfEffectState.includeTeammates = true;
      areaOfEffectState.repeatedHitCooldown = this.reapplyDuration;
      areaOfEffectState.OnHit += speedModEffectAction1.Do;
      areaOfEffectState.OnHit += speedModEffectAction2.Do;
      speedModEffectAction1.duration.Expression((Func<float>) (() => this.reapplyDuration));
      speedModEffectAction1.targetEntities = skillVar;
      speedModEffectAction1.filter = (Func<GameEntity, bool>) (entity => entity.playerTeam.value == skillGraph.GetOwner().playerTeam.value);
      speedModEffectAction1.moveSpeedModifier.Expression((Func<float>) (() => this.moveSpeedModifierAllies));
      speedModEffectAction2.duration.Expression((Func<float>) (() => this.reapplyDuration));
      speedModEffectAction2.targetEntities = skillVar;
      speedModEffectAction2.filter = (Func<GameEntity, bool>) (entity => entity.playerTeam.value != skillGraph.GetOwner().playerTeam.value);
      speedModEffectAction2.moveSpeedModifier.Expression((Func<float>) (() => this.moveSpeedModifierEnemies));
      speedModToOwnerState.modifier.Expression((Func<float>) (() => this.moveSpeedModifierOwn));
      showAoeState.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      showAoeState.trackOwnerPosition = (SyncableValue<bool>) true;
      showAoeState.onEnterDelegate = (Action) (() => VfxManager.StartAoeVfx(skillGraph, this.vfxPrefab, this.aoe, JVector.Zero, JVector.Forward));
      showAoeState.onExitDelegate = (Action) (() => VfxManager.StopVfx(skillGraph, this.vfxPrefab));
      playAnimationState1.animationType.Constant(AnimationStateType.SecondarySkill);
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState;
      booleanSwitchState.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.amountPerSecond.Constant(-1f);
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState.onEnterDelegate = (Action) (() => cooldownOver.Set(false));
      varOverTimeState.onExitDelegate = (Action) (() => cooldownOver.Set(true));
      onEventAction1.EventType = SkillGraphEvent.MatchStart;
      onEventAction1.OnTrigger += whileTrueState1.Enter;
      onEventAction2.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction2.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction3.EventType = SkillGraphEvent.Scrambled;
      onEventAction3.OnTrigger += waitState2.Exit;
      onEventAction4.EventType = SkillGraphEvent.Dead;
      onEventAction4.OnTrigger += waitState2.Exit;
      onEventAction5.EventType = SkillGraphEvent.Overtime;
      onEventAction5.OnTrigger += setVar1.Do;
      setVar1.var = currentCooldown;
      setVar1.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar2 = setVar1;
      setVar2.Then = setVar2.Then + whileTrueState1.Enter;
    }
  }
}
