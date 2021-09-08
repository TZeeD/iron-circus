// Decompiled with JetBrains decompiler
// Type: Stateless.Graph.IGraphStyle
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using Stateless.Reflection;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Stateless.Graph
{
  public abstract class IGraphStyle
  {
    internal abstract string GetPrefix();

    internal abstract string FormatOneState(State state);

    internal abstract string FormatOneCluster(SuperState stateInfo);

    internal abstract string FormatOneDecisionNode(string nodeName, string label);

    internal virtual List<string> FormatAllTransitions(List<Transition> transitions)
    {
      List<string> stringList = new List<string>();
      foreach (Transition transition in transitions)
      {
        string str;
        switch (transition)
        {
          case StayTransition stayTransition2:
            str = stayTransition2.ExecuteEntryExitActions ? (stayTransition2.SourceState.EntryActions.Count<string>() != 0 ? this.FormatOneTransition(stayTransition2.SourceState.NodeName, stayTransition2.Trigger.UnderlyingTrigger.ToString(), (IEnumerable<string>) stayTransition2.SourceState.EntryActions, stayTransition2.SourceState.NodeName, stayTransition2.Guards.Select<InvocationInfo, string>((Func<InvocationInfo, string>) (x => x.Description))) : this.FormatOneTransition(stayTransition2.SourceState.NodeName, stayTransition2.Trigger.UnderlyingTrigger.ToString(), (IEnumerable<string>) null, stayTransition2.SourceState.NodeName, stayTransition2.Guards.Select<InvocationInfo, string>((Func<InvocationInfo, string>) (x => x.Description)))) : this.FormatOneTransition(stayTransition2.SourceState.NodeName, stayTransition2.Trigger.UnderlyingTrigger.ToString(), (IEnumerable<string>) null, stayTransition2.SourceState.NodeName, stayTransition2.Guards.Select<InvocationInfo, string>((Func<InvocationInfo, string>) (x => x.Description)));
            break;
          case FixedTransition fixedTransition2:
            str = this.FormatOneTransition(fixedTransition2.SourceState.NodeName, fixedTransition2.Trigger.UnderlyingTrigger.ToString(), fixedTransition2.DestinationEntryActions.Select<ActionInfo, string>((Func<ActionInfo, string>) (x => x.Method.Description)), fixedTransition2.DestinationState.NodeName, fixedTransition2.Guards.Select<InvocationInfo, string>((Func<InvocationInfo, string>) (x => x.Description)));
            break;
          case DynamicTransition dynamicTransition2:
            str = this.FormatOneTransition(dynamicTransition2.SourceState.NodeName, dynamicTransition2.Trigger.UnderlyingTrigger.ToString(), dynamicTransition2.DestinationEntryActions.Select<ActionInfo, string>((Func<ActionInfo, string>) (x => x.Method.Description)), dynamicTransition2.DestinationState.NodeName, (IEnumerable<string>) new List<string>()
            {
              dynamicTransition2.Criterion
            });
            break;
          default:
            throw new ArgumentException("Unexpected transition type");
        }
        if (str != null)
          stringList.Add(str);
      }
      return stringList;
    }

    internal virtual string FormatOneTransition(
      string sourceNodeName,
      string trigger,
      IEnumerable<string> actions,
      string destinationNodeName,
      IEnumerable<string> guards)
    {
      throw new Exception("If you use IGraphStyle.FormatAllTransitions() you must implement an override of FormatOneTransition()");
    }
  }
}
