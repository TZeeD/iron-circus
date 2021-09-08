// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MatchFlow.TeamUiSkillState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.MatchFlow
{
  public class TeamUiSkillState : MonoBehaviour
  {
    public Image PrimarySkill;
    public Image SecondarySkill;
    [SerializeField]
    private Color skillActiveColor;
    [SerializeField]
    private Color skillInactiveColor;

    public void SetPrimarySkillStateActive() => this.PrimarySkill.color = this.skillActiveColor;

    public void SetPrimarySkillStateInactive() => this.PrimarySkill.color = this.skillInactiveColor;

    public void SetSecondarySkillStateActive() => this.SecondarySkill.color = this.skillActiveColor;

    public void SetSecondarySkillStateInactive() => this.SecondarySkill.color = this.skillInactiveColor;
  }
}
