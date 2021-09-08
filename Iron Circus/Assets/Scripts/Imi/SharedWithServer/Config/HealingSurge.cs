// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.HealingSurge
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "HealingSurge", menuName = "SteelCircus/SkillConfigs/HealingSurge")]
  public class HealingSurge : SkillGraphConfig
  {
    public ButtonType button;
    public string uiIconName;
    public float minRadius;
    public float maxRadius;
    public float chargeDuration;
    public int heal;
    public float cooldown;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState inputState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      ModVarOverTimeState varOverTimeState1 = skillGraph.AddState<ModVarOverTimeState>("ChargeRadius");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("WhileButtonDown");
      SubgraphState whileButtonDownSubgraph = skillGraph.AddState<SubgraphState>("ButtonDownSubgraph");
      ShowAoeState showAoeState = skillGraph.AddState<ShowAoeState>("ShowHealingArea");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("CooldownState");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      ModVarOverTimeState varOverTimeState2 = skillGraph.AddState<ModVarOverTimeState>("UpdateCooldown");
      ConditionAction conditionAction1 = skillGraph.AddAction<ConditionAction>("CanStart");
      ConditionAction conditionAction2 = skillGraph.AddAction<ConditionAction>("Trigger");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      onEventAction1.EventType = SkillGraphEvent.MatchStart;
      onEventAction2.EventType = SkillGraphEvent.Interrupt;
      onEventAction3.EventType = SkillGraphEvent.SkillPickupCollected;
      CheckAreaOfEffectAction areaOfEffectAction1 = skillGraph.AddAction<CheckAreaOfEffectAction>("CheckAoE");
      SetVar<float> setVar1 = skillGraph.AddAction<SetVar<float>>("ResetRadius");
      SetVar<float> resetAndStartCooldown = skillGraph.AddAction<SetVar<float>>("ResetAndStartCooldown");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("SetTrigger");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("SetDontTrigger");
      ModifyHealthAction modifyHealthAction = skillGraph.AddAction<ModifyHealthAction>("ApplyHeal");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<bool> shouldTrigger = skillGraph.AddVar<bool>("shouldTrigger");
      SkillVar<float> currentRadius = skillGraph.AddVar<float>("CurrentRadius");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<UniqueId> skillVar = skillGraph.AddVar<UniqueId>("AffectedEntities", true);
      currentRadius.Set(this.minRadius);
      currentCooldown.Set(this.cooldown);
      skillGraph.AddEntryState((SkillState) inputState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillUiState.buttonType.Constant(this.button);
      skillUiState.iconName.Constant(this.uiIconName);
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) (1.0 - (double) (float) currentCooldown / (double) this.cooldown)));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      inputState.buttonType.Constant(this.button);
      inputState.buttonDownSubStates += (SkillState) booleanSwitchState1;
      inputState.OnButtonUp += conditionAction2.Do;
      booleanSwitchState1.condition = (Func<bool>) (() => !(bool) isOnCooldown && !skillGraph.IsSkillUseDisabled() && !skillGraph.OwnerHasBall());
      booleanSwitchState1.WhileTrueSubState += (SkillState) whileButtonDownSubgraph;
      booleanSwitchState1.OnFalse += setVar3.Do;
      whileButtonDownSubgraph.memberStates += (SkillState) varOverTimeState1;
      whileButtonDownSubgraph.memberStates += (SkillState) showAoeState;
      SubgraphState subgraphState = whileButtonDownSubgraph;
      subgraphState.OnEnter = subgraphState.OnEnter + conditionAction1.Do;
      conditionAction1.condition = (Func<bool>) (() => !(bool) isOnCooldown && !skillGraph.IsSkillUseDisabled() && !skillGraph.OwnerHasBall());
      conditionAction1.OnTrue += setVar2.Do;
      setVar2.var = shouldTrigger;
      setVar2.value = (SyncableValue<bool>) true;
      SetVar<bool> setVar4 = setVar2;
      setVar4.Then = setVar4.Then + setVar1.Do;
      setVar1.var = currentRadius;
      setVar1.value.Expression((Func<float>) (() => this.minRadius));
      SetVar<float> setVar5 = setVar1;
      setVar5.Then = setVar5.Then + varOverTimeState1.Enter;
      SetVar<float> setVar6 = setVar1;
      setVar6.Then = setVar6.Then + showAoeState.Enter;
      varOverTimeState1.var = currentRadius;
      varOverTimeState1.targetValue.Expression((Func<float>) (() => this.maxRadius));
      varOverTimeState1.amountPerSecond.Expression((Func<float>) (() => (this.maxRadius - this.minRadius) / this.chargeDuration));
      showAoeState.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Circle,
        radius = (float) currentRadius
      }));
      showAoeState.updateAoE = true;
      showAoeState.trackOwnerPosition = (SyncableValue<bool>) true;
      conditionAction2.condition = (Func<bool>) (() => (bool) shouldTrigger);
      conditionAction2.OnTrue += areaOfEffectAction1.Do;
      areaOfEffectAction1.hitEntities = skillVar;
      areaOfEffectAction1.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Circle,
        radius = (float) currentRadius
      }));
      areaOfEffectAction1.includeOwner = true;
      areaOfEffectAction1.includeTeammates = true;
      areaOfEffectAction1.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      CheckAreaOfEffectAction areaOfEffectAction2 = areaOfEffectAction1;
      areaOfEffectAction2.Then = areaOfEffectAction2.Then + modifyHealthAction.Do;
      CheckAreaOfEffectAction areaOfEffectAction3 = areaOfEffectAction1;
      areaOfEffectAction3.Then = areaOfEffectAction3.Then + resetAndStartCooldown.Do;
      modifyHealthAction.targetEntities = skillVar;
      modifyHealthAction.value.Expression((Func<int>) (() => this.heal));
      resetAndStartCooldown.var = currentCooldown;
      resetAndStartCooldown.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar7 = resetAndStartCooldown;
      setVar7.Then = setVar7.Then + setVar3.Do;
      SetVar<float> setVar8 = resetAndStartCooldown;
      setVar8.Then = setVar8.Then + whileTrueState1.Enter;
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState2;
      booleanSwitchState2.condition = (Func<bool>) (() => !skillGraph.GetOwner().IsSkillUseBlocked());
      booleanSwitchState2.WhileTrueSubState += (SkillState) varOverTimeState2;
      varOverTimeState2.var = currentCooldown;
      varOverTimeState2.onEnterDelegate = (Action) (() => isOnCooldown.Set(true));
      varOverTimeState2.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState2.amountPerSecond.Constant(-1f);
      varOverTimeState2.onExitDelegate = (Action) (() => isOnCooldown.Set(false));
      setVar3.var = shouldTrigger;
      setVar3.value = (SyncableValue<bool>) false;
      onEventAction1.OnTrigger += resetAndStartCooldown.Do;
      onEventAction3.onTriggerDelegate = (Action) (() => currentCooldown.Set(0.0f));
      onEventAction2.onTriggerDelegate = (Action) (() =>
      {
        if (whileButtonDownSubgraph.IsActive)
          resetAndStartCooldown.PerformAction();
        inputState.ResetInput();
      });
    }
  }
}
