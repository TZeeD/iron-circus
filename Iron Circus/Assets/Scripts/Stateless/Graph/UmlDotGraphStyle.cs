// Decompiled with JetBrains decompiler
// Type: Stateless.Graph.UmlDotGraphStyle
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Stateless.Graph
{
  public class UmlDotGraphStyle : IGraphStyle
  {
    internal override string GetPrefix() => "digraph {\ncompound=true;\nnode [shape=Mrecord]\nrankdir=\"LR\"\n";

    internal override string FormatOneCluster(SuperState stateInfo)
    {
      StringBuilder stringBuilder = new StringBuilder(stateInfo.StateName);
      if (stateInfo.EntryActions.Count > 0 || stateInfo.ExitActions.Count > 0)
      {
        stringBuilder.Append("\\n----------");
        stringBuilder.Append(string.Concat(stateInfo.EntryActions.Select<string, string>((Func<string, string>) (act => "\\nentry / " + act))));
        stringBuilder.Append(string.Concat(stateInfo.ExitActions.Select<string, string>((Func<string, string>) (act => "\\nexit / " + act))));
      }
      string str = "\n" + string.Format("subgraph cluster{0}", (object) stateInfo.NodeName) + "\n\t{\n" + string.Format("\tlabel = \"{0}\"", (object) stringBuilder.ToString()) + "\n";
      foreach (State subState in stateInfo.SubStates)
        str += this.FormatOneState(subState);
      return str + "}\n";
    }

    internal override string FormatOneState(State state)
    {
      if (state.EntryActions.Count == 0 && state.ExitActions.Count == 0)
        return state.StateName + " [label=\"" + state.StateName + "\"];\n";
      string str1 = state.StateName + " [label=\"" + state.StateName + "|";
      List<string> stringList = new List<string>();
      stringList.AddRange(state.EntryActions.Select<string, string>((Func<string, string>) (act => "entry / " + act)));
      stringList.AddRange(state.ExitActions.Select<string, string>((Func<string, string>) (act => "exit / " + act)));
      string str2 = string.Join("\\n", (IEnumerable<string>) stringList);
      return str1 + str2 + "\"];\n";
    }

    internal override string FormatOneTransition(
      string sourceNodeName,
      string trigger,
      IEnumerable<string> actions,
      string destinationNodeName,
      IEnumerable<string> guards)
    {
      string label = trigger ?? "";
      if (actions != null && actions.Count<string>() > 0)
        label = label + " / " + string.Join(", ", actions);
      if (guards.Count<string>() > 0)
      {
        foreach (string guard in guards)
        {
          if (label.Length > 0)
            label += " ";
          label = label + "[" + guard + "]";
        }
      }
      return this.FormatOneLine(sourceNodeName, destinationNodeName, label);
    }

    internal override string FormatOneDecisionNode(string nodeName, string label) => nodeName + " [shape = \"diamond\", label = \"" + label + "\"];\n";

    internal string FormatOneLine(string fromNodeName, string toNodeName, string label) => fromNodeName + " -> " + toNodeName + " [style=\"solid\", label=\"" + label + "\"];";
  }
}
