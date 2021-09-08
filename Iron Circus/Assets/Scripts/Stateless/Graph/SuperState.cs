// Decompiled with JetBrains decompiler
// Type: Stateless.Graph.SuperState
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using Stateless.Reflection;
using System.Collections.Generic;

namespace Stateless.Graph
{
  public class SuperState : State
  {
    public List<State> SubStates { get; } = new List<State>();

    internal SuperState(StateInfo stateInfo)
      : base(stateInfo)
    {
    }
  }
}
