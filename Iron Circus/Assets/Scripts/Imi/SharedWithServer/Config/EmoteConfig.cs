// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.EmoteConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.Utils;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "EmoteConfig", menuName = "SteelCircus/SkillConfigs/EmoteConfig")]
  public class EmoteConfig : SkillGraphConfig
  {
    [AnimationDuration]
    public float duration;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState1 = skillGraph.AddState<ButtonState>("Emote0");
      ButtonState buttonState2 = skillGraph.AddState<ButtonState>("Emote1");
      ButtonState buttonState3 = skillGraph.AddState<ButtonState>("Emote2");
      ButtonState buttonState4 = skillGraph.AddState<ButtonState>("Emote3");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("PlayAnim");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("StopTurnToBall");
      WaitState waitState1 = skillGraph.AddState<WaitState>("StatusEffectDuration");
      WaitState waitState2 = skillGraph.AddState<WaitState>("PlayAnimDuration");
      ApplyStatusMofifierToOwnerState mofifierToOwnerState = skillGraph.AddState<ApplyStatusMofifierToOwnerState>("BlockInputState");
      ModifyMovementAction modifyMovementAction = skillGraph.AddAction<ModifyMovementAction>("StopWhenEmoting");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("IsRunningCondtion");
      SetVar<bool> setVar1 = skillGraph.AddAction<SetVar<bool>>("SetIsRunningTrue");
      SetVar<bool> setVar2 = skillGraph.AddAction<SetVar<bool>>("SetIsRunningFalse");
      SetVar<int> setVar3 = skillGraph.AddAction<SetVar<int>>("setVariation0");
      SetVar<int> setVar4 = skillGraph.AddAction<SetVar<int>>("setVariation1");
      SetVar<int> setVar5 = skillGraph.AddAction<SetVar<int>>("setVariation2");
      SetVar<int> setVar6 = skillGraph.AddAction<SetVar<int>>("setVariation3");
      SkillVar<bool> isRunning = skillGraph.AddVar<bool>("IsRunning");
      SkillVar<int> variation = skillGraph.AddVar<int>("EmoteVariation");
      skillGraph.AddEntryState((SkillState) buttonState1);
      skillGraph.AddEntryState((SkillState) buttonState2);
      skillGraph.AddEntryState((SkillState) buttonState3);
      skillGraph.AddEntryState((SkillState) buttonState4);
      buttonState1.buttonType.Constant(ButtonType.Emote0);
      buttonState1.OnButtonDown += setVar3.Do;
      buttonState2.buttonType.Constant(ButtonType.Emote1);
      buttonState2.OnButtonDown += setVar4.Do;
      buttonState3.buttonType.Constant(ButtonType.Emote2);
      buttonState3.OnButtonDown += setVar5.Do;
      buttonState4.buttonType.Constant(ButtonType.Emote3);
      buttonState4.OnButtonDown += setVar6.Do;
      setVar3.var = variation;
      setVar3.value.Set(1);
      SetVar<int> setVar7 = setVar3;
      setVar7.Then = setVar7.Then + conditionAction.Do;
      setVar4.var = variation;
      setVar4.value.Set(2);
      SetVar<int> setVar8 = setVar4;
      setVar8.Then = setVar8.Then + conditionAction.Do;
      setVar5.var = variation;
      setVar5.value.Set(3);
      SetVar<int> setVar9 = setVar5;
      setVar9.Then = setVar9.Then + conditionAction.Do;
      setVar6.var = variation;
      setVar6.value.Set(4);
      SetVar<int> setVar10 = setVar6;
      setVar10.Then = setVar10.Then + conditionAction.Do;
      conditionAction.condition = (Func<bool>) (() => (bool) isRunning);
      conditionAction.OnFalse += setVar1.Do;
      setVar1.var = isRunning;
      setVar1.value.Set(true);
      SetVar<bool> setVar11 = setVar1;
      setVar11.Then = setVar11.Then + modifyMovementAction.Do;
      SetVar<bool> setVar12 = setVar1;
      setVar12.Then = setVar12.Then + waitState2.Enter;
      SetVar<bool> setVar13 = setVar1;
      setVar13.Then = setVar13.Then + waitState1.Enter;
      modifyMovementAction.type = ModifyMovementAction.ValueType.SetSpeed;
      modifyMovementAction.speed = (SyncableValue<float>) 0.0f;
      mofifierToOwnerState.modifier = StatusModifier.BlockMove | StatusModifier.BlockSkills | StatusModifier.BlockHoldBall;
      mofifierToOwnerState.duration.Expression((Func<float>) (() => this.duration));
      waitState1.duration.Expression((Func<float>) (() => this.duration));
      WaitState waitState3 = waitState1;
      waitState3.OnExit = waitState3.OnExit + setVar2.Do;
      setVar2.var = isRunning;
      setVar2.value.Set(false);
      waitState2.duration.Expression((Func<float>) (() => this.duration / 2f));
      WaitState waitState4 = waitState2;
      waitState4.SubState = waitState4.SubState + (SkillState) playAnimationState1;
      WaitState waitState5 = waitState2;
      waitState5.SubState = waitState5.SubState + (SkillState) playAnimationState2;
      playAnimationState1.animationType.Constant(AnimationStateType.Emote);
      playAnimationState1.variation.Expression((Func<int>) (() => (int) variation));
      playAnimationState2.animationType.Constant(AnimationStateType.DontTurnHead);
    }
  }
}
