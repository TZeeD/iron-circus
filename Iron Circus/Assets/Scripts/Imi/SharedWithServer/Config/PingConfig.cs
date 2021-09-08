// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.PingConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "PingConfig", menuName = "SteelCircus/SkillConfigs/PingConfig")]
  public class PingConfig : SkillGraphConfig
  {
    public float duration;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      WaitState effectDurationState = skillGraph.AddState<WaitState>("Effect Duration State");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Skill UI");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("CheckTeam");
      PlayAudioAction playAudioAction = new PlayAudioAction(skillGraph, "Play that awesome, not annoying Ping Sound");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("isActive");
      conditionAction.condition = (Func<bool>) (() => skillGraph.GetOwner().playerTeam.value == skillGraph.GetContext().GetFirstLocalEntity().playerTeam.value);
      conditionAction.OnTrue += playAudioAction.Do;
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      playAudioAction.audioResourceName.Constant("Ping");
      skillUiState.buttonType.Constant(ButtonType.Ping);
      skillUiState.active.Expression((Func<bool>) (() => (bool) isActive));
      buttonState.buttonType.Constant(ButtonType.Ping);
      buttonState.onButtonDownDelegate = (Action) (() =>
      {
        if ((bool) isActive)
          return;
        isActive.Set(true);
        effectDurationState.Enter_();
      });
      effectDurationState.duration.Expression((Func<float>) (() => this.duration));
      effectDurationState.onExitDelegate = (Action) (() => isActive.Set(false));
    }
  }
}
