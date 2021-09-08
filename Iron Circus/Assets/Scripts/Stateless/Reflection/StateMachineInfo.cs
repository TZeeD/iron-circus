// Decompiled with JetBrains decompiler
// Type: Stateless.Reflection.StateMachineInfo
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System;
using System.Collections.Generic;
using System.Linq;

namespace Stateless.Reflection
{
  public class StateMachineInfo
  {
    internal StateMachineInfo(IEnumerable<StateInfo> states, Type stateType, Type triggerType)
    {
      this.States = (IEnumerable<StateInfo>) ((states != null ? states.ToList<StateInfo>() : (List<StateInfo>) null) ?? throw new ArgumentNullException(nameof (states)));
      this.StateType = stateType;
      this.TriggerType = triggerType;
    }

    public IEnumerable<StateInfo> States { get; }

    public Type StateType { get; private set; }

    public Type TriggerType { get; private set; }
  }
}
