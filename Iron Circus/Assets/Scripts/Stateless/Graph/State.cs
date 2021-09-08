// Decompiled with JetBrains decompiler
// Type: Stateless.Graph.State
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using Stateless.Reflection;
using System.Collections.Generic;

namespace Stateless.Graph
{
  public class State
  {
    public SuperState SuperState { get; set; }

    public List<Transition> Leaving { get; } = new List<Transition>();

    public List<Transition> Arriving { get; } = new List<Transition>();

    public string NodeName { get; private set; }

    public string StateName { get; private set; }

    public List<string> EntryActions { get; private set; } = new List<string>();

    public List<string> ExitActions { get; private set; } = new List<string>();

    internal State(StateInfo stateInfo)
    {
      this.NodeName = stateInfo.UnderlyingState.ToString();
      this.StateName = stateInfo.UnderlyingState.ToString();
      foreach (ActionInfo entryAction in stateInfo.EntryActions)
      {
        if (entryAction.FromTrigger == null)
          this.EntryActions.Add(entryAction.Method.Description);
      }
      foreach (InvocationInfo exitAction in stateInfo.ExitActions)
        this.ExitActions.Add(exitAction.Description);
    }

    internal State(string nodeName)
    {
      this.NodeName = nodeName;
      this.StateName = (string) null;
    }
  }
}
