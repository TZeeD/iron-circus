// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.OnTeamSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using SharedWithServer.ScEvents;
using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
  public class OnTeamSelected : MonoBehaviour
  {
    public void SelectTeamAlpha() => Events.Global.FireEventSelectTeam(Team.Alpha);

    public void SelectTeamBeta() => Events.Global.FireEventSelectTeam(Team.Beta);

    public void SelectTeamNone() => Events.Global.FireEventSelectTeam(Team.None);
  }
}
