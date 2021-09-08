// Decompiled with JetBrains decompiler
// Type: Stateless.Graph.FixedTransition
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using Stateless.Reflection;
using System.Collections.Generic;

namespace Stateless.Graph
{
  internal class FixedTransition : Transition
  {
    public State DestinationState { get; private set; }

    public IEnumerable<InvocationInfo> Guards { get; private set; }

    public FixedTransition(
      State sourceState,
      State destinationState,
      TriggerInfo trigger,
      IEnumerable<InvocationInfo> guards)
      : base(sourceState, trigger)
    {
      this.DestinationState = destinationState;
      this.Guards = guards;
    }
  }
}
