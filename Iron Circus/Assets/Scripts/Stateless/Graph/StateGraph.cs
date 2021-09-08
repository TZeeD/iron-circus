// Decompiled with JetBrains decompiler
// Type: Stateless.Graph.StateGraph
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using Stateless.Reflection;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Stateless.Graph
{
  internal class StateGraph
  {
    public Dictionary<string, State> States { get; private set; } = new Dictionary<string, State>();

    public List<Transition> Transitions { get; private set; } = new List<Transition>();

    public List<Decision> Decisions { get; private set; } = new List<Decision>();

    public StateGraph(StateMachineInfo machineInfo)
    {
      this.AddSuperstates(machineInfo);
      this.AddSingleStates(machineInfo);
      this.AddTransitions(machineInfo);
      this.ProcessOnEntryFrom(machineInfo);
    }

    public string ToGraph(IGraphStyle style)
    {
      string str = style.GetPrefix().Replace("\n", Environment.NewLine);
      foreach (State state in this.States.Values.Where<State>((Func<State, bool>) (x => x is SuperState)))
        str += style.FormatOneCluster((SuperState) state).Replace("\n", Environment.NewLine);
      foreach (State state in this.States.Values)
      {
        if (!(state is SuperState) && !(state is Decision) && state.SuperState == null)
          str += style.FormatOneState(state).Replace("\n", Environment.NewLine);
      }
      foreach (Decision decision in this.Decisions)
        str += style.FormatOneDecisionNode(decision.NodeName, decision.Method.Description).Replace("\n", Environment.NewLine);
      foreach (string formatAllTransition in style.FormatAllTransitions(this.Transitions))
        str = str + Environment.NewLine + formatAllTransition;
      return str + Environment.NewLine + "}";
    }

    private void ProcessOnEntryFrom(StateMachineInfo machineInfo)
    {
      foreach (StateInfo state1 in machineInfo.States)
      {
        State state2 = this.States[state1.UnderlyingState.ToString()];
        foreach (ActionInfo entryAction in state1.EntryActions)
        {
          if (entryAction.FromTrigger != null)
          {
            foreach (Transition transition in state2.Arriving)
            {
              if (transition.ExecuteEntryExitActions && transition.Trigger.UnderlyingTrigger.ToString() == entryAction.FromTrigger)
                transition.DestinationEntryActions.Add(entryAction);
            }
          }
        }
      }
    }

    private void AddTransitions(StateMachineInfo machineInfo)
    {
      foreach (StateInfo state1 in machineInfo.States)
      {
        State state2 = this.States[state1.UnderlyingState.ToString()];
        foreach (FixedTransitionInfo fixedTransition1 in state1.FixedTransitions)
        {
          State state3 = this.States[fixedTransition1.DestinationState.UnderlyingState.ToString()];
          if (state2 == state3)
          {
            StayTransition stayTransition = new StayTransition(state2, fixedTransition1.Trigger, fixedTransition1.GuardConditionsMethodDescriptions, true);
            this.Transitions.Add((Transition) stayTransition);
            state2.Leaving.Add((Transition) stayTransition);
            state2.Arriving.Add((Transition) stayTransition);
          }
          else
          {
            FixedTransition fixedTransition2 = new FixedTransition(state2, state3, fixedTransition1.Trigger, fixedTransition1.GuardConditionsMethodDescriptions);
            this.Transitions.Add((Transition) fixedTransition2);
            state2.Leaving.Add((Transition) fixedTransition2);
            state3.Arriving.Add((Transition) fixedTransition2);
          }
        }
        foreach (DynamicTransitionInfo dynamicTransition1 in state1.DynamicTransitions)
        {
          Decision decision = new Decision(dynamicTransition1.DestinationStateSelectorDescription, this.Decisions.Count + 1);
          this.Decisions.Add(decision);
          FixedTransition fixedTransition = new FixedTransition(state2, (State) decision, dynamicTransition1.Trigger, dynamicTransition1.GuardConditionsMethodDescriptions);
          this.Transitions.Add((Transition) fixedTransition);
          state2.Leaving.Add((Transition) fixedTransition);
          decision.Arriving.Add((Transition) fixedTransition);
          if (dynamicTransition1.PossibleDestinationStates != null)
          {
            foreach (DynamicStateInfo destinationState1 in (List<DynamicStateInfo>) dynamicTransition1.PossibleDestinationStates)
            {
              State destinationState2 = (State) null;
              this.States.TryGetValue(destinationState1.DestinationState, out destinationState2);
              if (destinationState2 != null)
              {
                DynamicTransition dynamicTransition2 = new DynamicTransition((State) decision, destinationState2, dynamicTransition1.Trigger, destinationState1.Criterion);
                this.Transitions.Add((Transition) dynamicTransition2);
                decision.Leaving.Add((Transition) dynamicTransition2);
                destinationState2.Arriving.Add((Transition) dynamicTransition2);
              }
            }
          }
        }
        foreach (IgnoredTransitionInfo ignoredTrigger in state1.IgnoredTriggers)
        {
          StayTransition stayTransition = new StayTransition(state2, ignoredTrigger.Trigger, ignoredTrigger.GuardConditionsMethodDescriptions, false);
          this.Transitions.Add((Transition) stayTransition);
          state2.Leaving.Add((Transition) stayTransition);
          state2.Arriving.Add((Transition) stayTransition);
        }
      }
    }

    private void AddSingleStates(StateMachineInfo machineInfo)
    {
      foreach (StateInfo state in machineInfo.States)
      {
        if (!this.States.ContainsKey(state.UnderlyingState.ToString()))
          this.States[state.UnderlyingState.ToString()] = new State(state);
      }
    }

    private void AddSuperstates(StateMachineInfo machineInfo)
    {
      foreach (StateInfo stateInfo in machineInfo.States.Where<StateInfo>((Func<StateInfo, bool>) (sc =>
      {
        IEnumerable<StateInfo> substates = sc.Substates;
        return (substates != null ? (substates.Count<StateInfo>() > 0 ? 1 : 0) : 0) != 0 && sc.Superstate == null;
      })))
      {
        SuperState superState = new SuperState(stateInfo);
        this.States[stateInfo.UnderlyingState.ToString()] = (State) superState;
        this.AddSubstates(superState, stateInfo.Substates);
      }
    }

    private void AddSubstates(SuperState superState, IEnumerable<StateInfo> substates)
    {
      foreach (StateInfo substate in substates)
      {
        if (!this.States.ContainsKey(substate.UnderlyingState.ToString()))
        {
          if (substate.Substates.Count<StateInfo>() > 0)
          {
            SuperState superState1 = new SuperState(substate);
            this.States[substate.UnderlyingState.ToString()] = (State) superState1;
            superState.SubStates.Add((State) superState1);
            superState1.SuperState = superState;
            this.AddSubstates(superState1, substate.Substates);
          }
          else
          {
            State state = new State(substate);
            this.States[substate.UnderlyingState.ToString()] = state;
            superState.SubStates.Add(state);
            state.SuperState = superState;
          }
        }
      }
    }
  }
}
