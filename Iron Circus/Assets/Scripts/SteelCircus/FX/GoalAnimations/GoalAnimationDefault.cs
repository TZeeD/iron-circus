// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.GoalAnimations.GoalAnimationDefault
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.FX.GoalAnimations.Base;
using TMPro;
using UnityEngine;

namespace SteelCircus.FX.GoalAnimations
{
  public class GoalAnimationDefault : GoalAnimationWithCustomTeamColors
  {
    [SerializeField]
    private TextMeshPro[] tfGoal;
    [SerializeField]
    private TextMeshPro[] tfTeam;

    protected override void Start()
    {
      string goalString = this.GetGoalString();
      foreach (TMP_Text tmpText in this.tfGoal)
        tmpText.text = goalString;
      string teamString = this.GetTeamString();
      foreach (TMP_Text tmpText in this.tfTeam)
        tmpText.text = teamString;
    }
  }
}
