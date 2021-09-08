// Decompiled with JetBrains decompiler
// Type: Stateless.Reflection.StateInfo
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System;
using System.Collections.Generic;
using System.Linq;

namespace Stateless.Reflection
{
  public class StateInfo
  {
    internal static StateInfo CreateStateInfo<TState, TTrigger>(
      StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation)
    {
      if (stateRepresentation == null)
        throw new ArgumentException(nameof (stateRepresentation));
      List<IgnoredTransitionInfo> ignoredTransitionInfoList = new List<IgnoredTransitionInfo>();
      foreach (KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>> triggerBehaviour1 in (IEnumerable<KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>>) stateRepresentation.TriggerBehaviours)
      {
        foreach (StateMachine<TState, TTrigger>.TriggerBehaviour triggerBehaviour2 in (IEnumerable<StateMachine<TState, TTrigger>.TriggerBehaviour>) triggerBehaviour1.Value)
        {
          if (triggerBehaviour2 is StateMachine<TState, TTrigger>.IgnoredTriggerBehaviour)
            ignoredTransitionInfoList.Add(IgnoredTransitionInfo.Create<TState, TTrigger>((StateMachine<TState, TTrigger>.IgnoredTriggerBehaviour) triggerBehaviour2));
        }
      }
      return new StateInfo((object) stateRepresentation.UnderlyingState, (IEnumerable<IgnoredTransitionInfo>) ignoredTransitionInfoList, (IEnumerable<ActionInfo>) stateRepresentation.EntryActions.Select<StateMachine<TState, TTrigger>.EntryActionBehavior, ActionInfo>((Func<StateMachine<TState, TTrigger>.EntryActionBehavior, ActionInfo>) (e => ActionInfo.Create<TState, TTrigger>(e))).ToList<ActionInfo>(), (IEnumerable<InvocationInfo>) stateRepresentation.ActivateActions.Select<StateMachine<TState, TTrigger>.ActivateActionBehaviour, InvocationInfo>((Func<StateMachine<TState, TTrigger>.ActivateActionBehaviour, InvocationInfo>) (e => e.Description)).ToList<InvocationInfo>(), (IEnumerable<InvocationInfo>) stateRepresentation.DeactivateActions.Select<StateMachine<TState, TTrigger>.DeactivateActionBehaviour, InvocationInfo>((Func<StateMachine<TState, TTrigger>.DeactivateActionBehaviour, InvocationInfo>) (e => e.Description)).ToList<InvocationInfo>(), (IEnumerable<InvocationInfo>) stateRepresentation.ExitActions.Select<StateMachine<TState, TTrigger>.ExitActionBehavior, InvocationInfo>((Func<StateMachine<TState, TTrigger>.ExitActionBehavior, InvocationInfo>) (e => e.Description)).ToList<InvocationInfo>());
    }

    internal static void AddRelationships<TState, TTrigger>(
      StateInfo info,
      StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation,
      Func<TState, StateInfo> lookupState)
    {
      if (lookupState == null)
        throw new ArgumentNullException(nameof (lookupState));
      List<StateInfo> list = stateRepresentation.GetSubstates().Select<StateMachine<TState, TTrigger>.StateRepresentation, StateInfo>((Func<StateMachine<TState, TTrigger>.StateRepresentation, StateInfo>) (s => lookupState(s.UnderlyingState))).ToList<StateInfo>();
      StateInfo superstate = (StateInfo) null;
      if (stateRepresentation.Superstate != null)
        superstate = lookupState(stateRepresentation.Superstate.UnderlyingState);
      List<FixedTransitionInfo> fixedTransitionInfoList = new List<FixedTransitionInfo>();
      List<DynamicTransitionInfo> dynamicTransitionInfoList = new List<DynamicTransitionInfo>();
      foreach (KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>> triggerBehaviour1 in (IEnumerable<KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>>) stateRepresentation.TriggerBehaviours)
      {
        foreach (StateMachine<TState, TTrigger>.TriggerBehaviour behaviour in triggerBehaviour1.Value.Where<StateMachine<TState, TTrigger>.TriggerBehaviour>((Func<StateMachine<TState, TTrigger>.TriggerBehaviour, bool>) (behaviour => behaviour is StateMachine<TState, TTrigger>.TransitioningTriggerBehaviour)))
        {
          StateInfo destinationStateInfo = lookupState(((StateMachine<TState, TTrigger>.TransitioningTriggerBehaviour) behaviour).Destination);
          fixedTransitionInfoList.Add(FixedTransitionInfo.Create<TState, TTrigger>(behaviour, destinationStateInfo));
        }
        foreach (StateMachine<TState, TTrigger>.TriggerBehaviour behaviour in triggerBehaviour1.Value.Where<StateMachine<TState, TTrigger>.TriggerBehaviour>((Func<StateMachine<TState, TTrigger>.TriggerBehaviour, bool>) (behaviour => behaviour is StateMachine<TState, TTrigger>.InternalTriggerBehaviour)))
        {
          StateInfo destinationStateInfo = lookupState(stateRepresentation.UnderlyingState);
          fixedTransitionInfoList.Add(FixedTransitionInfo.Create<TState, TTrigger>(behaviour, destinationStateInfo));
        }
        foreach (StateMachine<TState, TTrigger>.TriggerBehaviour triggerBehaviour2 in triggerBehaviour1.Value.Where<StateMachine<TState, TTrigger>.TriggerBehaviour>((Func<StateMachine<TState, TTrigger>.TriggerBehaviour, bool>) (behaviour => behaviour is StateMachine<TState, TTrigger>.DynamicTriggerBehaviour)))
          dynamicTransitionInfoList.Add(((StateMachine<TState, TTrigger>.DynamicTriggerBehaviour) triggerBehaviour2).TransitionInfo);
      }
      info.AddRelationships(superstate, (IEnumerable<StateInfo>) list, (IEnumerable<FixedTransitionInfo>) fixedTransitionInfoList, (IEnumerable<DynamicTransitionInfo>) dynamicTransitionInfoList);
    }

    private StateInfo(
      object underlyingState,
      IEnumerable<IgnoredTransitionInfo> ignoredTriggers,
      IEnumerable<ActionInfo> entryActions,
      IEnumerable<InvocationInfo> activateActions,
      IEnumerable<InvocationInfo> deactivateActions,
      IEnumerable<InvocationInfo> exitActions)
    {
      this.UnderlyingState = underlyingState;
      this.IgnoredTriggers = ignoredTriggers ?? throw new ArgumentNullException(nameof (ignoredTriggers));
      this.EntryActions = entryActions;
      this.ActivateActions = activateActions;
      this.DeactivateActions = deactivateActions;
      this.ExitActions = exitActions;
    }

    private void AddRelationships(
      StateInfo superstate,
      IEnumerable<StateInfo> substates,
      IEnumerable<FixedTransitionInfo> transitions,
      IEnumerable<DynamicTransitionInfo> dynamicTransitions)
    {
      this.Superstate = superstate;
      this.Substates = substates ?? throw new ArgumentNullException(nameof (substates));
      this.FixedTransitions = transitions ?? throw new ArgumentNullException(nameof (transitions));
      this.DynamicTransitions = dynamicTransitions ?? throw new ArgumentNullException(nameof (dynamicTransitions));
    }

    public object UnderlyingState { get; }

    public IEnumerable<StateInfo> Substates { get; private set; }

    public StateInfo Superstate { get; private set; }

    public IEnumerable<ActionInfo> EntryActions { get; private set; }

    public IEnumerable<InvocationInfo> ActivateActions { get; private set; }

    public IEnumerable<InvocationInfo> DeactivateActions { get; private set; }

    public IEnumerable<InvocationInfo> ExitActions { get; private set; }

    public IEnumerable<TransitionInfo> Transitions => ((IEnumerable<TransitionInfo>) this.FixedTransitions).Concat<TransitionInfo>((IEnumerable<TransitionInfo>) this.DynamicTransitions);

    public IEnumerable<FixedTransitionInfo> FixedTransitions { get; private set; }

    public IEnumerable<DynamicTransitionInfo> DynamicTransitions { get; private set; }

    public IEnumerable<IgnoredTransitionInfo> IgnoredTriggers { get; private set; }

    public override string ToString() => this.UnderlyingState?.ToString() ?? "<null>";
  }
}
