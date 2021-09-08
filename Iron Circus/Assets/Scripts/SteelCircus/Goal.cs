// Decompiled with JetBrains decompiler
// Type: SteelCircus.Goal
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using UnityEngine;

namespace SteelCircus
{
  public class Goal : MonoBehaviour, IConvertableToEntitas
  {
    public Team team;

    public IComponent ConvertToEntitasComponent() => (IComponent) new GoalComponent()
    {
      team = this.team
    };
  }
}
