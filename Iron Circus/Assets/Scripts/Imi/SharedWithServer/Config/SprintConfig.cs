// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.SprintConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Jitter.LinearMath;
using System;

namespace Imi.SharedWithServer.Config
{
  public class SprintConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string iconName = "icon_boost_inverted_01_tex";
    public float cooldownDuration = 4.5f;
    public float speed = 12.5f;
    public float accelerationFactor = 1.5f;
    public float thrustContribution = 0.75f;
    public float delayBeforeRecharge = 0.5f;
    public VfxPrefab sprintVfxPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ChampionConfig champConfig = skillGraph.GetOwner().championConfig.value;
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("WhileRecharge");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("CheckForRestartRecharge");
      SubgraphState subgraphState1 = skillGraph.AddState<SubgraphState>("RechargeSubgraph");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Delay to Recharge");
      ModVarOverTimeState varOverTimeState1 = skillGraph.AddState<ModVarOverTimeState>("Recharge");
      ModVarOverTimeState varOverTimeState2 = skillGraph.AddState<ModVarOverTimeState>("Decrease Charge");
      ModifyMovementState handleSprint = skillGraph.AddState<ModifyMovementState>("Sprint Move");
      BooleanSwitchState booleanSwitchState3 = skillGraph.AddState<BooleanSwitchState>("WhileCanUse");
      PlayVfxState playVfxState = skillGraph.AddState<PlayVfxState>("Sprint Vfx");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      AudioState audioState1 = skillGraph.AddState<AudioState>("Sprint Audio");
      AudioState audioState2 = skillGraph.AddState<AudioState>("Sprint Audio Loop");
      PlayAnimationState playAnimationState = skillGraph.AddState<PlayAnimationState>("StopLookingAtBall");
      OnEventAction onEventAction = skillGraph.AddAction<OnEventAction>("OnSprintPickup");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("SetRecharging");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("setRestartRecharging");
      SkillVar<float> stamina = skillGraph.GetVar<float>("Stamina");
      SkillVar<bool> restartStaminaRecharge = skillGraph.GetVar<bool>("RestartStaminaRecharge");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      isActive.Expression((Func<bool>) (() => handleSprint.IsActive));
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillGraph.AddEntryState((SkillState) booleanSwitchState1);
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) stamina / champConfig.stamina.amount));
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      skillUiState.active.Expression((Func<bool>) (() => handleSprint.IsActive));
      buttonState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      buttonState.buttonDownSubStates += (SkillState) booleanSwitchState3;
      setVar2.var = restartStaminaRecharge;
      setVar2.value = (SyncableValue<bool>) true;
      playVfxState.vfxPrefab = this.sprintVfxPrefab;
      playVfxState.position = (SyncableValue<JVector>) (JVector.Up * 0.86f);
      playVfxState.lookDir = (SyncableValue<JVector>) JVector.Backward;
      booleanSwitchState3.condition = (Func<bool>) (() => (double) (float) stamina > 0.0 && !skillGraph.OwnerHasBall() && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.GetOwner().IsMoveBlocked() && !skillGraph.GetOwner().HasEffect(StatusEffectType.Invisible));
      booleanSwitchState3.WhileTrueSubState += (SkillState) handleSprint;
      varOverTimeState2.var = stamina;
      varOverTimeState2.amountPerSecond.Constant(-1f);
      varOverTimeState2.targetValue = (SyncableValue<float>) 0.0f;
      audioState1.audioResourceName.Constant("Sprint");
      audioState2.audioResourceName.Constant("SprintLoop");
      handleSprint.mode.Constant(ModifyMovementState.Mode.OverrideMoveConfig);
      handleSprint.speed.Expression((Func<float>) (() => this.speed));
      handleSprint.accFactor.Expression((Func<float>) (() => this.accelerationFactor));
      handleSprint.thrustContribution.Expression((Func<float>) (() => this.thrustContribution));
      ModifyMovementState modifyMovementState1 = handleSprint;
      modifyMovementState1.SubState = modifyMovementState1.SubState + (SkillState) playVfxState;
      ModifyMovementState modifyMovementState2 = handleSprint;
      modifyMovementState2.SubState = modifyMovementState2.SubState + (SkillState) varOverTimeState2;
      ModifyMovementState modifyMovementState3 = handleSprint;
      modifyMovementState3.SubState = modifyMovementState3.SubState + (SkillState) audioState1;
      ModifyMovementState modifyMovementState4 = handleSprint;
      modifyMovementState4.SubState = modifyMovementState4.SubState + (SkillState) audioState2;
      ModifyMovementState modifyMovementState5 = handleSprint;
      modifyMovementState5.SubState = modifyMovementState5.SubState + (SkillState) playAnimationState;
      playAnimationState.animationType.Constant(AnimationStateType.DontTurnHead);
      booleanSwitchState1.condition = (Func<bool>) (() => !(bool) isActive && (double) (float) stamina < (double) champConfig.stamina.amount);
      booleanSwitchState1.WhileTrueSubState += (SkillState) booleanSwitchState2;
      booleanSwitchState2.condition = (Func<bool>) (() => (bool) restartStaminaRecharge);
      booleanSwitchState2.WhileFalseSubState += (SkillState) subgraphState1;
      booleanSwitchState2.OnTrue += setVar1.Do;
      setVar1.var = restartStaminaRecharge;
      setVar1.value = (SyncableValue<bool>) false;
      SubgraphState subgraphState2 = subgraphState1;
      subgraphState2.OnEnter = subgraphState2.OnEnter + waitState1.Enter;
      subgraphState1.memberStates += (SkillState) waitState1;
      subgraphState1.memberStates += (SkillState) varOverTimeState1;
      waitState1.duration.Expression((Func<float>) (() => this.delayBeforeRecharge));
      WaitState waitState2 = waitState1;
      waitState2.OnExit = waitState2.OnExit + varOverTimeState1.Enter;
      varOverTimeState1.var = stamina;
      varOverTimeState1.amountPerSecond.Expression((Func<float>) (() => champConfig.stamina.amount / this.cooldownDuration));
      varOverTimeState1.targetValue.Expression((Func<float>) (() => champConfig.stamina.amount));
      onEventAction.EventType = SkillGraphEvent.SprintPickupCollected;
      onEventAction.onTriggerDelegate = (Action) (() => stamina.Set(SkillGraph.CalculateSprintCooldown(stamina.Get(), champConfig.stamina.amount)));
    }
  }
}
