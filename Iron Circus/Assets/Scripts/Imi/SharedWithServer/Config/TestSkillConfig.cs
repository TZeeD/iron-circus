// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.TestSkillConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "TestSkillConfig", menuName = "SteelCircus/SkillConfigs/TestSkill")]
  public class TestSkillConfig : SkillGraphConfig
  {
    public float cooldownDuration = 2f;
    public float stopDuration = 0.5f;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("input");
      WaitState cooldown = skillGraph.AddState<WaitState>("cooldown");
      ModVarOverTimeState modVarOverTimeState = skillGraph.AddState<ModVarOverTimeState>("modvar");
      ModifyMovementState modMoveState = skillGraph.AddState<ModifyMovementState>("modmove");
      ModifyOwnerHealth modifyOwnerHealth = skillGraph.AddAction<ModifyOwnerHealth>("modhealth");
      ConditionAction canTrigger = skillGraph.AddAction<ConditionAction>("canTrigger");
      SkillVar<float> skillVar = skillGraph.AddVar<float>("foo");
      skillGraph.AddEntryState((SkillState) buttonState);
      buttonState.buttonType.Constant(ButtonType.PrimarySkill);
      buttonState.onButtonUpDelegate = (Action) (() => canTrigger.PerformAction());
      canTrigger.condition = (Func<bool>) (() => cooldown.IsActive);
      canTrigger.onFalse = (Action) (() => modVarOverTimeState.Enter_());
      modVarOverTimeState.var = skillVar;
      modVarOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      modVarOverTimeState.amountPerSecond.Expression((Func<float>) (() => -1f / this.stopDuration));
      modVarOverTimeState.onEnterDelegate = (Action) (() => modMoveState.Enter_());
      modVarOverTimeState.onExitDelegate = (Action) (() => modMoveState.Exit_());
      modMoveState.mode.Constant(ModifyMovementState.Mode.OverrideMoveConfig);
      modMoveState.moveDir.Expression((Func<JVector>) (() => skillGraph.GetLookDir()));
      modMoveState.speed.Constant(0.0f);
      modMoveState.onExitDelegate = new Action(((SkillAction) modifyOwnerHealth).PerformAction);
      modifyOwnerHealth.value = (SyncableValue<int>) -1;
      modifyOwnerHealth.thenDelegate = (Action) (() => cooldown.Enter_());
      cooldown.duration.Expression((Func<float>) (() => this.cooldownDuration));
    }
  }
}
