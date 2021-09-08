// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.LightningPathConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Jitter.LinearMath;
using System;

namespace Imi.SharedWithServer.Config
{
  public class LightningPathConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType buttonType;
    public string skillIconName;
    public float cooldown;
    public float duration;
    public float reapplyDuration;
    public float moveSpeedModifierAllies;
    public AreaOfEffect aoe;
    public float spawnOffset;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      ModVarOverTimeState varOverTimeState1 = skillGraph.AddState<ModVarOverTimeState>("CooldownState");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("WhileShowPreview");
      WaitState waitState1 = skillGraph.AddState<WaitState>("ActiveDurationState");
      ShowAoeState showAoeState1 = skillGraph.AddState<ShowAoeState>("Show AoE Preview");
      ShowAoeState showAoeState2 = skillGraph.AddState<ShowAoeState>("Show AoE Effect");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("BlockOtherSkills");
      CheckAreaOfEffectState areaOfEffectState = skillGraph.AddState<CheckAreaOfEffectState>("CheckAffectedEntities");
      TriggerState triggerState = skillGraph.AddState<TriggerState>("Trigger unparent Preview");
      ConditionAction conditionAction1 = skillGraph.AddAction<ConditionAction>("CanUseAction");
      ConditionAction conditionAction2 = skillGraph.AddAction<ConditionAction>("shouldTriggerAction");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnPickup");
      onEventAction1.EventType = SkillGraphEvent.MatchStart;
      onEventAction2.EventType = SkillGraphEvent.Interrupt;
      onEventAction3.EventType = SkillGraphEvent.SkillPickupCollected;
      ApplySpeedModEffectAction applyAllySpeedMod = new ApplySpeedModEffectAction(skillGraph, "ApplyTeamMateSpeedMod");
      SetVar<float> setVar1 = skillGraph.AddAction<SetVar<float>>("StartCooldown");
      SetVar<float> setVar2 = skillGraph.AddAction<SetVar<float>>("SetCooldownZero");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("setCooldownActive");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("setCooldownInactive");
      SetVar<bool> setVar5 = skillGraph.AddAction<SetVar<bool>>("setShouldTrigger");
      SetVar<bool> setVar6 = skillGraph.AddAction<SetVar<bool>>("setShould NOT Trigger");
      SetVar<bool> setVar7 = skillGraph.AddAction<SetVar<bool>>("setActive");
      SetVar<bool> setVar8 = skillGraph.AddAction<SetVar<bool>>("setInactive");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> shouldTrigger = skillGraph.AddVar<bool>("ShouldTrigger");
      SkillVar<bool> canUse = skillGraph.AddVar<bool>("CanUse");
      SkillVar<JVector> aoePosition = skillGraph.AddVar<JVector>("AoEPosition");
      SkillVar<JVector> aoeLookDir = skillGraph.AddVar<JVector>("AoELookDir");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("Cooldown");
      SkillVar<float> currentReapplyDuration = skillGraph.AddVar<float>("CurrentReapplyDuration");
      SkillVar<UniqueId> skillVar = skillGraph.AddVar<UniqueId>("Affected Entities", true);
      isOnCooldown.Set(true);
      currentCooldown.Set(this.cooldown);
      canUse.Expression((Func<bool>) (() => !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall() && !skillGraph.IsSkillUseDisabled() && !(bool) isOnCooldown && !(bool) isActive));
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillGraph.AddEntryState((SkillState) triggerState);
      skillUiState.buttonType.Constant(this.buttonType);
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      skillUiState.fillAmount.Expression((Func<float>) (() => (this.cooldown - (float) currentCooldown) / this.cooldown));
      skillUiState.iconName.Expression((Func<string>) (() => this.skillIconName));
      buttonState.buttonType.Constant(this.buttonType);
      buttonState.buttonDownSubStates += (SkillState) whileTrueState1;
      buttonState.OnButtonDown += conditionAction1.Do;
      buttonState.OnButtonUp += conditionAction2.Do;
      conditionAction1.condition = (Func<bool>) (() => (bool) canUse);
      conditionAction1.OnTrue += setVar5.Do;
      whileTrueState1.condition = (Func<bool>) (() => (bool) canUse);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) showAoeState1;
      WhileTrueState whileTrueState3 = whileTrueState1;
      whileTrueState3.SubState = whileTrueState3.SubState + (SkillState) lockGraphsState;
      setVar5.var = shouldTrigger;
      setVar5.value = (SyncableValue<bool>) true;
      SetVar<bool> setVar9 = setVar5;
      setVar9.Then = setVar9.Then + showAoeState1.Enter;
      showAoeState1.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      showAoeState1.trackOwnerPosition = (SyncableValue<bool>) true;
      showAoeState1.offset.Set(JVector.Forward * this.spawnOffset);
      showAoeState1.lookDir.Set(JVector.Forward);
      conditionAction2.condition = (Func<bool>) (() => (bool) shouldTrigger);
      conditionAction2.onTrue = (Action) (() =>
      {
        aoeLookDir.Set(skillGraph.GetLookDir());
        aoePosition.Set(skillGraph.GetPosition() + skillGraph.GetLookDir() * this.spawnOffset);
      });
      conditionAction2.OnTrue += waitState1.Enter;
      conditionAction2.OnTrue += triggerState.Enter;
      conditionAction2.OnTrue += setVar6.Do;
      waitState1.duration.Expression((Func<float>) (() => this.duration));
      WaitState waitState2 = waitState1;
      waitState2.OnEnter = waitState2.OnEnter + setVar7.Do;
      WaitState waitState3 = waitState1;
      waitState3.OnEnter = waitState3.OnEnter + setVar1.Do;
      WaitState waitState4 = waitState1;
      waitState4.SubState = waitState4.SubState + (SkillState) showAoeState2;
      WaitState waitState5 = waitState1;
      waitState5.SubState = waitState5.SubState + (SkillState) areaOfEffectState;
      WaitState waitState6 = waitState1;
      waitState6.OnExit = waitState6.OnExit + setVar8.Do;
      WaitState waitState7 = waitState1;
      waitState7.OnExit = waitState7.OnExit + varOverTimeState1.Enter;
      waitState1.onUpdate = (Action<float>) (t =>
      {
        if ((double) (float) currentReapplyDuration > (double) this.reapplyDuration - 0.100000001490116)
        {
          currentReapplyDuration.Set(0.0f);
          applyAllySpeedMod.PerformAction();
        }
        currentReapplyDuration.Set((float) currentReapplyDuration + skillGraph.GetContext().globalTime.fixedSimTimeStep);
      });
      areaOfEffectState.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      areaOfEffectState.lookDir.Expression((Func<JVector>) (() => (JVector) aoeLookDir));
      areaOfEffectState.position.Expression((Func<JVector>) (() => (JVector) aoePosition));
      areaOfEffectState.hitEntities = skillVar;
      applyAllySpeedMod.targetEntities = skillVar;
      applyAllySpeedMod.filter = (Func<GameEntity, bool>) (entity => entity != null && entity.hasPlayerTeam && entity.playerTeam.value == skillGraph.GetOwner().playerTeam.value);
      applyAllySpeedMod.moveSpeedModifier.Expression((Func<float>) (() => this.moveSpeedModifierAllies));
      applyAllySpeedMod.duration.Expression((Func<float>) (() => this.reapplyDuration));
      showAoeState2.aoe.Expression((Func<AreaOfEffect>) (() => this.aoe));
      showAoeState2.lookDir.Expression((Func<JVector>) (() => (JVector) aoeLookDir));
      showAoeState2.position.Expression((Func<JVector>) (() => (JVector) aoePosition));
      setVar7.var = isActive;
      setVar7.value = (SyncableValue<bool>) true;
      setVar8.var = isActive;
      setVar8.value = (SyncableValue<bool>) false;
      setVar1.var = currentCooldown;
      setVar1.value.Expression((Func<float>) (() => this.cooldown));
      setVar2.var = currentCooldown;
      setVar2.value = (SyncableValue<float>) 0.0f;
      varOverTimeState1.var = currentCooldown;
      varOverTimeState1.amountPerSecond.Constant(-1f);
      varOverTimeState1.targetValue = (SyncableValue<float>) 0.0f;
      ModVarOverTimeState varOverTimeState2 = varOverTimeState1;
      varOverTimeState2.OnEnter = varOverTimeState2.OnEnter + setVar3.Do;
      ModVarOverTimeState varOverTimeState3 = varOverTimeState1;
      varOverTimeState3.OnExit = varOverTimeState3.OnExit + setVar4.Do;
      setVar3.var = isOnCooldown;
      setVar3.value = (SyncableValue<bool>) true;
      setVar4.var = isOnCooldown;
      setVar4.value = (SyncableValue<bool>) false;
      onEventAction1.OnTrigger += varOverTimeState1.Enter;
      onEventAction2.OnTrigger += setVar6.Do;
      onEventAction3.OnTrigger += setVar2.Do;
      setVar6.var = shouldTrigger;
      setVar6.value = (SyncableValue<bool>) false;
    }
  }
}
