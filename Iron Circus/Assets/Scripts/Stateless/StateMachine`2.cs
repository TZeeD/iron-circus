// Decompiled with JetBrains decompiler
// Type: Stateless.StateMachine`2
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using Stateless.Reflection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Stateless
{
  public class StateMachine<TState, TTrigger>
  {
    private readonly IDictionary<TState, StateMachine<TState, TTrigger>.StateRepresentation> _stateConfiguration = (IDictionary<TState, StateMachine<TState, TTrigger>.StateRepresentation>) new Dictionary<TState, StateMachine<TState, TTrigger>.StateRepresentation>();
    private readonly IDictionary<TTrigger, StateMachine<TState, TTrigger>.TriggerWithParameters> _triggerConfiguration = (IDictionary<TTrigger, StateMachine<TState, TTrigger>.TriggerWithParameters>) new Dictionary<TTrigger, StateMachine<TState, TTrigger>.TriggerWithParameters>();
    private readonly Func<TState> _stateAccessor;
    private readonly Action<TState> _stateMutator;
    private StateMachine<TState, TTrigger>.UnhandledTriggerAction _unhandledTriggerAction;
    private StateMachine<TState, TTrigger>.OnTransitionedEvent _onTransitionedEvent;
    private readonly Queue<StateMachine<TState, TTrigger>.QueuedTrigger> _eventQueue = new Queue<StateMachine<TState, TTrigger>.QueuedTrigger>();
    private bool _firing;

    public Task ActivateAsync() => this.GetRepresentation(this.State).ActivateAsync();

    public Task DeactivateAsync() => this.GetRepresentation(this.State).DeactivateAsync();

    public Task FireAsync(TTrigger trigger) => this.InternalFireAsync(trigger);

    public Task FireAsync<TArg0>(
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
      TArg0 arg0)
    {
      if (trigger == null)
        throw new ArgumentNullException(nameof (trigger));
      return this.InternalFireAsync(trigger.Trigger, (object) arg0);
    }

    public Task FireAsync<TArg0, TArg1>(
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
      TArg0 arg0,
      TArg1 arg1)
    {
      if (trigger == null)
        throw new ArgumentNullException(nameof (trigger));
      return this.InternalFireAsync(trigger.Trigger, (object) arg0, (object) arg1);
    }

    public Task FireAsync<TArg0, TArg1, TArg2>(
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
      TArg0 arg0,
      TArg1 arg1,
      TArg2 arg2)
    {
      if (trigger == null)
        throw new ArgumentNullException(nameof (trigger));
      return this.InternalFireAsync(trigger.Trigger, (object) arg0, (object) arg1, (object) arg2);
    }

    private async Task InternalFireAsync(TTrigger trigger, params object[] args)
    {
      if (this._firing)
      {
        this._eventQueue.Enqueue(new StateMachine<TState, TTrigger>.QueuedTrigger()
        {
          Trigger = trigger,
          Args = args
        });
      }
      else
      {
        try
        {
          this._firing = true;
          await this.InternalFireOneAsync(trigger, args);
          while (this._eventQueue.Count != 0)
          {
            StateMachine<TState, TTrigger>.QueuedTrigger queuedTrigger = this._eventQueue.Dequeue();
            await this.InternalFireOneAsync(queuedTrigger.Trigger, queuedTrigger.Args);
          }
        }
        finally
        {
          this._firing = false;
        }
      }
    }

    private async Task InternalFireOneAsync(TTrigger trigger, params object[] args)
    {
      StateMachine<TState, TTrigger>.TriggerWithParameters triggerWithParameters;
      if (this._triggerConfiguration.TryGetValue(trigger, out triggerWithParameters))
        triggerWithParameters.ValidateParameters(args);
      TState source = this.State;
      StateMachine<TState, TTrigger>.StateRepresentation representativeState = this.GetRepresentation(source);
      StateMachine<TState, TTrigger>.TriggerBehaviourResult result;
      if (!representativeState.TryFindHandler(trigger, out result))
      {
        await this._unhandledTriggerAction.ExecuteAsync(representativeState.UnderlyingState, trigger, result?.UnmetGuardConditions);
      }
      else
      {
        TState destination;
        if (result.Handler.ResultsInTransitionFrom(source, args, out destination))
        {
          StateMachine<TState, TTrigger>.Transition transition = new StateMachine<TState, TTrigger>.Transition(source, destination, trigger);
          await representativeState.ExitAsync(transition);
          this.State = transition.Destination;
          StateMachine<TState, TTrigger>.StateRepresentation newRepresentation = this.GetRepresentation(transition.Destination);
          await this._onTransitionedEvent.InvokeAsync(transition);
          await newRepresentation.EnterAsync(transition, args);
          transition = (StateMachine<TState, TTrigger>.Transition) null;
          newRepresentation = (StateMachine<TState, TTrigger>.StateRepresentation) null;
        }
        else
          await this.CurrentRepresentation.InternalActionAsync(new StateMachine<TState, TTrigger>.Transition(source, destination, trigger), args);
      }
    }

    public void OnUnhandledTriggerAsync(
      Func<TState, TTrigger, Task> unhandledTriggerAction)
    {
      if (unhandledTriggerAction == null)
        throw new ArgumentNullException(nameof (unhandledTriggerAction));
      this._unhandledTriggerAction = (StateMachine<TState, TTrigger>.UnhandledTriggerAction) new StateMachine<TState, TTrigger>.UnhandledTriggerAction.Async((Func<TState, TTrigger, ICollection<string>, Task>) ((s, t, c) => unhandledTriggerAction(s, t)));
    }

    public void OnUnhandledTriggerAsync(
      Func<TState, TTrigger, ICollection<string>, Task> unhandledTriggerAction)
    {
      this._unhandledTriggerAction = unhandledTriggerAction != null ? (StateMachine<TState, TTrigger>.UnhandledTriggerAction) new StateMachine<TState, TTrigger>.UnhandledTriggerAction.Async(unhandledTriggerAction) : throw new ArgumentNullException(nameof (unhandledTriggerAction));
    }

    public void OnTransitionedAsync(
      Func<StateMachine<TState, TTrigger>.Transition, Task> onTransitionAction)
    {
      if (onTransitionAction == null)
        throw new ArgumentNullException(nameof (onTransitionAction));
      this._onTransitionedEvent.Register(onTransitionAction);
    }

    public StateMachine(Func<TState> stateAccessor, Action<TState> stateMutator)
      : this()
    {
      this._stateAccessor = stateAccessor ?? throw new ArgumentNullException(nameof (stateAccessor));
      this._stateMutator = stateMutator ?? throw new ArgumentNullException(nameof (stateMutator));
    }

    public StateMachine(TState initialState)
      : this()
    {
      StateMachine<TState, TTrigger>.StateReference reference = new StateMachine<TState, TTrigger>.StateReference()
      {
        State = initialState
      };
      this._stateAccessor = (Func<TState>) (() => reference.State);
      this._stateMutator = (Action<TState>) (s => reference.State = s);
    }

    private StateMachine()
    {
      this._unhandledTriggerAction = (StateMachine<TState, TTrigger>.UnhandledTriggerAction) new StateMachine<TState, TTrigger>.UnhandledTriggerAction.Sync(new Action<TState, TTrigger, ICollection<string>>(this.DefaultUnhandledTriggerAction));
      this._onTransitionedEvent = new StateMachine<TState, TTrigger>.OnTransitionedEvent();
    }

    public TState State
    {
      get => this._stateAccessor();
      private set => this._stateMutator(value);
    }

    public IEnumerable<TTrigger> PermittedTriggers => this.CurrentRepresentation.PermittedTriggers;

    private StateMachine<TState, TTrigger>.StateRepresentation CurrentRepresentation => this.GetRepresentation(this.State);

    public StateMachineInfo GetInfo()
    {
      Dictionary<TState, StateMachine<TState, TTrigger>.StateRepresentation> dictionary = this._stateConfiguration.ToDictionary<KeyValuePair<TState, StateMachine<TState, TTrigger>.StateRepresentation>, TState, StateMachine<TState, TTrigger>.StateRepresentation>((Func<KeyValuePair<TState, StateMachine<TState, TTrigger>.StateRepresentation>, TState>) (kvp => kvp.Key), (Func<KeyValuePair<TState, StateMachine<TState, TTrigger>.StateRepresentation>, StateMachine<TState, TTrigger>.StateRepresentation>) (kvp => kvp.Value));
      foreach (StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation in this._stateConfiguration.SelectMany<KeyValuePair<TState, StateMachine<TState, TTrigger>.StateRepresentation>, TState>((Func<KeyValuePair<TState, StateMachine<TState, TTrigger>.StateRepresentation>, IEnumerable<TState>>) (kvp => kvp.Value.TriggerBehaviours.SelectMany<KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>, TState>((Func<KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>, IEnumerable<TState>>) (b => b.Value.OfType<StateMachine<TState, TTrigger>.TransitioningTriggerBehaviour>().Select<StateMachine<TState, TTrigger>.TransitioningTriggerBehaviour, TState>((Func<StateMachine<TState, TTrigger>.TransitioningTriggerBehaviour, TState>) (tb => tb.Destination)))))).Distinct<TState>().Except<TState>((IEnumerable<TState>) dictionary.Keys).Select<TState, StateMachine<TState, TTrigger>.StateRepresentation>((Func<TState, StateMachine<TState, TTrigger>.StateRepresentation>) (underlying => new StateMachine<TState, TTrigger>.StateRepresentation(underlying))).ToArray<StateMachine<TState, TTrigger>.StateRepresentation>())
        dictionary.Add(stateRepresentation.UnderlyingState, stateRepresentation);
      Dictionary<TState, StateInfo> info = dictionary.ToDictionary<KeyValuePair<TState, StateMachine<TState, TTrigger>.StateRepresentation>, TState, StateInfo>((Func<KeyValuePair<TState, StateMachine<TState, TTrigger>.StateRepresentation>, TState>) (kvp => kvp.Key), (Func<KeyValuePair<TState, StateMachine<TState, TTrigger>.StateRepresentation>, StateInfo>) (kvp => StateInfo.CreateStateInfo<TState, TTrigger>(kvp.Value)));
      foreach (KeyValuePair<TState, StateInfo> keyValuePair in info)
        StateInfo.AddRelationships<TState, TTrigger>(keyValuePair.Value, dictionary[keyValuePair.Key], (Func<TState, StateInfo>) (k => info[k]));
      return new StateMachineInfo((IEnumerable<StateInfo>) info.Values, typeof (TState), typeof (TTrigger));
    }

    private StateMachine<TState, TTrigger>.StateRepresentation GetRepresentation(
      TState state)
    {
      StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation;
      if (!this._stateConfiguration.TryGetValue(state, out stateRepresentation))
      {
        stateRepresentation = new StateMachine<TState, TTrigger>.StateRepresentation(state);
        this._stateConfiguration.Add(state, stateRepresentation);
      }
      return stateRepresentation;
    }

    public StateMachine<TState, TTrigger>.StateConfiguration Configure(TState state) => new StateMachine<TState, TTrigger>.StateConfiguration(this, this.GetRepresentation(state), new Func<TState, StateMachine<TState, TTrigger>.StateRepresentation>(this.GetRepresentation));

    public void Fire(TTrigger trigger) => this.InternalFire(trigger);

    public void Fire<TArg0>(
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
      TArg0 arg0)
    {
      if (trigger == null)
        throw new ArgumentNullException(nameof (trigger));
      this.InternalFire(trigger.Trigger, (object) arg0);
    }

    public void Fire<TArg0, TArg1>(
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
      TArg0 arg0,
      TArg1 arg1)
    {
      if (trigger == null)
        throw new ArgumentNullException(nameof (trigger));
      this.InternalFire(trigger.Trigger, (object) arg0, (object) arg1);
    }

    public void Fire<TArg0, TArg1, TArg2>(
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
      TArg0 arg0,
      TArg1 arg1,
      TArg2 arg2)
    {
      if (trigger == null)
        throw new ArgumentNullException(nameof (trigger));
      this.InternalFire(trigger.Trigger, (object) arg0, (object) arg1, (object) arg2);
    }

    public void Activate() => this.GetRepresentation(this.State).Activate();

    public void Deactivate() => this.GetRepresentation(this.State).Deactivate();

    private void InternalFire(TTrigger trigger, params object[] args)
    {
      if (this._firing)
      {
        this._eventQueue.Enqueue(new StateMachine<TState, TTrigger>.QueuedTrigger()
        {
          Trigger = trigger,
          Args = args
        });
      }
      else
      {
        try
        {
          this._firing = true;
          this.InternalFireOne(trigger, args);
          while (this._eventQueue.Count != 0)
          {
            StateMachine<TState, TTrigger>.QueuedTrigger queuedTrigger = this._eventQueue.Dequeue();
            this.InternalFireOne(queuedTrigger.Trigger, queuedTrigger.Args);
          }
        }
        finally
        {
          this._firing = false;
        }
      }
    }

    private void InternalFireOne(TTrigger trigger, params object[] args)
    {
      StateMachine<TState, TTrigger>.TriggerWithParameters triggerWithParameters;
      if (this._triggerConfiguration.TryGetValue(trigger, out triggerWithParameters))
        triggerWithParameters.ValidateParameters(args);
      TState state = this.State;
      StateMachine<TState, TTrigger>.StateRepresentation representation1 = this.GetRepresentation(state);
      StateMachine<TState, TTrigger>.TriggerBehaviourResult handler;
      if (!representation1.TryFindHandler(trigger, out handler))
      {
        this._unhandledTriggerAction.Execute(representation1.UnderlyingState, trigger, handler?.UnmetGuardConditions);
      }
      else
      {
        TState destination;
        if (handler.Handler.ResultsInTransitionFrom(state, args, out destination))
        {
          StateMachine<TState, TTrigger>.Transition transition1 = new StateMachine<TState, TTrigger>.Transition(state, destination, trigger);
          representation1.Exit(transition1);
          this.State = transition1.Destination;
          StateMachine<TState, TTrigger>.StateRepresentation representation2 = this.GetRepresentation(transition1.Destination);
          this._onTransitionedEvent.Invoke(transition1);
          StateMachine<TState, TTrigger>.Transition transition2 = transition1;
          object[] objArray = args;
          representation2.Enter(transition2, objArray);
        }
        else
          this.CurrentRepresentation.InternalAction(new StateMachine<TState, TTrigger>.Transition(state, destination, trigger), args);
      }
    }

    public void OnUnhandledTrigger(Action<TState, TTrigger> unhandledTriggerAction)
    {
      if (unhandledTriggerAction == null)
        throw new ArgumentNullException(nameof (unhandledTriggerAction));
      this._unhandledTriggerAction = (StateMachine<TState, TTrigger>.UnhandledTriggerAction) new StateMachine<TState, TTrigger>.UnhandledTriggerAction.Sync((Action<TState, TTrigger, ICollection<string>>) ((s, t, c) => unhandledTriggerAction(s, t)));
    }

    public void OnUnhandledTrigger(
      Action<TState, TTrigger, ICollection<string>> unhandledTriggerAction)
    {
      this._unhandledTriggerAction = unhandledTriggerAction != null ? (StateMachine<TState, TTrigger>.UnhandledTriggerAction) new StateMachine<TState, TTrigger>.UnhandledTriggerAction.Sync(unhandledTriggerAction) : throw new ArgumentNullException(nameof (unhandledTriggerAction));
    }

    public bool IsInState(TState state) => this.CurrentRepresentation.IsIncludedIn(state);

    public bool CanFire(TTrigger trigger) => this.CurrentRepresentation.CanHandle(trigger);

    public override string ToString() => string.Format("StateMachine {{ State = {0}, PermittedTriggers = {{ {1} }}}}", (object) this.State, (object) string.Join(", ", this.PermittedTriggers.Select<TTrigger, string>((Func<TTrigger, string>) (t => t.ToString())).ToArray<string>()));

    public StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> SetTriggerParameters<TArg0>(
      TTrigger trigger)
    {
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> triggerWithParameters = new StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0>(trigger);
      this.SaveTriggerConfiguration((StateMachine<TState, TTrigger>.TriggerWithParameters) triggerWithParameters);
      return triggerWithParameters;
    }

    public StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> SetTriggerParameters<TArg0, TArg1>(
      TTrigger trigger)
    {
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> triggerWithParameters = new StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1>(trigger);
      this.SaveTriggerConfiguration((StateMachine<TState, TTrigger>.TriggerWithParameters) triggerWithParameters);
      return triggerWithParameters;
    }

    public StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> SetTriggerParameters<TArg0, TArg1, TArg2>(
      TTrigger trigger)
    {
      StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> triggerWithParameters = new StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2>(trigger);
      this.SaveTriggerConfiguration((StateMachine<TState, TTrigger>.TriggerWithParameters) triggerWithParameters);
      return triggerWithParameters;
    }

    private void SaveTriggerConfiguration(
      StateMachine<TState, TTrigger>.TriggerWithParameters trigger)
    {
      if (this._triggerConfiguration.ContainsKey(trigger.Trigger))
        throw new InvalidOperationException(string.Format(StateMachineResources.CannotReconfigureParameters, (object) trigger));
      this._triggerConfiguration.Add(trigger.Trigger, trigger);
    }

    private void DefaultUnhandledTriggerAction(
      TState state,
      TTrigger trigger,
      ICollection<string> unmetGuardConditions)
    {
      this.GetRepresentation(state);
      if (unmetGuardConditions != null && unmetGuardConditions.Any<string>())
        throw new InvalidOperationException(string.Format(StateMachineResources.NoTransitionsUnmetGuardConditions, (object) trigger, (object) state, (object) string.Join(", ", (IEnumerable<string>) unmetGuardConditions)));
      throw new InvalidOperationException(string.Format(StateMachineResources.NoTransitionsPermitted, (object) trigger, (object) state));
    }

    public void OnTransitioned(
      Action<StateMachine<TState, TTrigger>.Transition> onTransitionAction)
    {
      if (onTransitionAction == null)
        throw new ArgumentNullException(nameof (onTransitionAction));
      this._onTransitionedEvent.Register(onTransitionAction);
    }

    internal abstract class ActivateActionBehaviour
    {
      private readonly TState _state;
      private readonly InvocationInfo _actionDescription;

      protected ActivateActionBehaviour(TState state, InvocationInfo actionDescription)
      {
        this._state = state;
        this._actionDescription = actionDescription ?? throw new ArgumentNullException(nameof (actionDescription));
      }

      internal InvocationInfo Description => this._actionDescription;

      public abstract void Execute();

      public abstract Task ExecuteAsync();

      public class Sync : StateMachine<TState, TTrigger>.ActivateActionBehaviour
      {
        private readonly Action _action;

        public Sync(TState state, Action action, InvocationInfo actionDescription)
          : base(state, actionDescription)
        {
          this._action = action;
        }

        public override void Execute() => this._action();

        public override Task ExecuteAsync()
        {
          this.Execute();
          return TaskResult.Done;
        }
      }

      public class Async : StateMachine<TState, TTrigger>.ActivateActionBehaviour
      {
        private readonly Func<Task> _action;

        public Async(TState state, Func<Task> action, InvocationInfo actionDescription)
          : base(state, actionDescription)
        {
          this._action = action;
        }

        public override void Execute() => throw new InvalidOperationException(string.Format("Cannot execute asynchronous action specified in OnActivateAsync for '{0}' state. ", (object) this._state) + "Use asynchronous version of Activate [ActivateAsync]");

        public override Task ExecuteAsync() => this._action();
      }
    }

    internal abstract class DeactivateActionBehaviour
    {
      private readonly TState _state;
      private readonly InvocationInfo _actionDescription;

      protected DeactivateActionBehaviour(TState state, InvocationInfo actionDescription)
      {
        this._state = state;
        this._actionDescription = actionDescription ?? throw new ArgumentNullException(nameof (actionDescription));
      }

      internal InvocationInfo Description => this._actionDescription;

      public abstract void Execute();

      public abstract Task ExecuteAsync();

      public class Sync : StateMachine<TState, TTrigger>.DeactivateActionBehaviour
      {
        private readonly Action _action;

        public Sync(TState state, Action action, InvocationInfo actionDescription)
          : base(state, actionDescription)
        {
          this._action = action;
        }

        public override void Execute() => this._action();

        public override Task ExecuteAsync()
        {
          this.Execute();
          return TaskResult.Done;
        }
      }

      public class Async : StateMachine<TState, TTrigger>.DeactivateActionBehaviour
      {
        private readonly Func<Task> _action;

        public Async(TState state, Func<Task> action, InvocationInfo actionDescription)
          : base(state, actionDescription)
        {
          this._action = action;
        }

        public override void Execute() => throw new InvalidOperationException(string.Format("Cannot execute asynchronous action specified in OnDeactivateAsync for '{0}' state. ", (object) this._state) + "Use asynchronous version of Deactivate [DeactivateAsync]");

        public override Task ExecuteAsync() => this._action();
      }
    }

    internal class DynamicTriggerBehaviour : StateMachine<TState, TTrigger>.TriggerBehaviour
    {
      private readonly Func<object[], TState> _destination;

      internal DynamicTransitionInfo TransitionInfo { get; private set; }

      public DynamicTriggerBehaviour(
        TTrigger trigger,
        Func<object[], TState> destination,
        StateMachine<TState, TTrigger>.TransitionGuard transitionGuard,
        DynamicTransitionInfo info)
        : base(trigger, transitionGuard)
      {
        this._destination = destination ?? throw new ArgumentNullException(nameof (destination));
        this.TransitionInfo = info ?? throw new ArgumentNullException(nameof (info));
      }

      public override bool ResultsInTransitionFrom(
        TState source,
        object[] args,
        out TState destination)
      {
        destination = this._destination(args);
        return true;
      }
    }

    internal abstract class EntryActionBehavior
    {
      private InvocationInfo _description;

      protected EntryActionBehavior(InvocationInfo description) => this._description = description;

      public InvocationInfo Description => this._description;

      public abstract void Execute(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] args);

      public abstract Task ExecuteAsync(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] args);

      public class Sync : StateMachine<TState, TTrigger>.EntryActionBehavior
      {
        private readonly Action<StateMachine<TState, TTrigger>.Transition, object[]> _action;

        public Sync(
          Action<StateMachine<TState, TTrigger>.Transition, object[]> action,
          InvocationInfo description)
          : base(description)
        {
          this._action = action;
        }

        public override void Execute(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          this._action(transition, args);
        }

        public override Task ExecuteAsync(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          this.Execute(transition, args);
          return TaskResult.Done;
        }
      }

      public class SyncFrom<TTriggerType> : StateMachine<TState, TTrigger>.EntryActionBehavior.Sync
      {
        internal TTriggerType Trigger { get; private set; }

        public SyncFrom(
          TTriggerType trigger,
          Action<StateMachine<TState, TTrigger>.Transition, object[]> action,
          InvocationInfo description)
          : base(action, description)
        {
          this.Trigger = trigger;
        }

        public override void Execute(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          if (!transition.Trigger.Equals((object) this.Trigger))
            return;
          base.Execute(transition, args);
        }

        public override Task ExecuteAsync(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          this.Execute(transition, args);
          return TaskResult.Done;
        }
      }

      public class Async : StateMachine<TState, TTrigger>.EntryActionBehavior
      {
        private readonly Func<StateMachine<TState, TTrigger>.Transition, object[], Task> _action;

        public Async(
          Func<StateMachine<TState, TTrigger>.Transition, object[], Task> action,
          InvocationInfo description)
          : base(description)
        {
          this._action = action;
        }

        public override void Execute(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          throw new InvalidOperationException(string.Format("Cannot execute asynchronous action specified in OnEntry event for '{0}' state. ", (object) transition.Destination) + "Use asynchronous version of Fire [FireAsync]");
        }

        public override Task ExecuteAsync(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          return this._action(transition, args);
        }
      }
    }

    internal abstract class ExitActionBehavior
    {
      private readonly InvocationInfo _actionDescription;

      public abstract void Execute(
        StateMachine<TState, TTrigger>.Transition transition);

      public abstract Task ExecuteAsync(
        StateMachine<TState, TTrigger>.Transition transition);

      protected ExitActionBehavior(InvocationInfo actionDescription) => this._actionDescription = actionDescription ?? throw new ArgumentNullException(nameof (actionDescription));

      internal InvocationInfo Description => this._actionDescription;

      public class Sync : StateMachine<TState, TTrigger>.ExitActionBehavior
      {
        private readonly Action<StateMachine<TState, TTrigger>.Transition> _action;

        public Sync(
          Action<StateMachine<TState, TTrigger>.Transition> action,
          InvocationInfo actionDescription)
          : base(actionDescription)
        {
          this._action = action;
        }

        public override void Execute(
          StateMachine<TState, TTrigger>.Transition transition)
        {
          this._action(transition);
        }

        public override Task ExecuteAsync(
          StateMachine<TState, TTrigger>.Transition transition)
        {
          this.Execute(transition);
          return TaskResult.Done;
        }
      }

      public class Async : StateMachine<TState, TTrigger>.ExitActionBehavior
      {
        private readonly Func<StateMachine<TState, TTrigger>.Transition, Task> _action;

        public Async(
          Func<StateMachine<TState, TTrigger>.Transition, Task> action,
          InvocationInfo actionDescription)
          : base(actionDescription)
        {
          this._action = action;
        }

        public override void Execute(
          StateMachine<TState, TTrigger>.Transition transition)
        {
          throw new InvalidOperationException(string.Format("Cannot execute asynchronous action specified in OnExit event for '{0}' state. ", (object) transition.Source) + "Use asynchronous version of Fire [FireAsync]");
        }

        public override Task ExecuteAsync(
          StateMachine<TState, TTrigger>.Transition transition)
        {
          return this._action(transition);
        }
      }
    }

    internal class GuardCondition
    {
      private InvocationInfo _methodDescription;

      internal GuardCondition(Func<bool> guard, InvocationInfo description)
      {
        this.Guard = guard ?? throw new ArgumentNullException(nameof (guard));
        this._methodDescription = description ?? throw new ArgumentNullException(nameof (description));
      }

      internal Func<bool> Guard { get; }

      internal string Description => this._methodDescription.Description;

      internal InvocationInfo MethodDescription => this._methodDescription;
    }

    internal class IgnoredTriggerBehaviour : StateMachine<TState, TTrigger>.TriggerBehaviour
    {
      public IgnoredTriggerBehaviour(
        TTrigger trigger,
        StateMachine<TState, TTrigger>.TransitionGuard transitionGuard)
        : base(trigger, transitionGuard)
      {
      }

      public override bool ResultsInTransitionFrom(
        TState source,
        object[] args,
        out TState destination)
      {
        destination = default (TState);
        return false;
      }
    }

    internal abstract class InternalActionBehaviour
    {
      public abstract void Execute(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] args);

      public abstract Task ExecuteAsync(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] args);

      public class Sync : StateMachine<TState, TTrigger>.InternalActionBehaviour
      {
        private readonly Action<StateMachine<TState, TTrigger>.Transition, object[]> _action;

        public Sync(
          Action<StateMachine<TState, TTrigger>.Transition, object[]> action)
        {
          this._action = action;
        }

        public override void Execute(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          this._action(transition, args);
        }

        public override Task ExecuteAsync(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          this.Execute(transition, args);
          return TaskResult.Done;
        }
      }

      public class Async : StateMachine<TState, TTrigger>.InternalActionBehaviour
      {
        private readonly Func<StateMachine<TState, TTrigger>.Transition, object[], Task> _action;

        public Async(
          Func<StateMachine<TState, TTrigger>.Transition, object[], Task> action)
        {
          this._action = action;
        }

        public override void Execute(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          throw new InvalidOperationException(string.Format("Cannot execute asynchronous action specified in OnEntry event for '{0}' state. ", (object) transition.Destination) + "Use asynchronous version of Fire [FireAsync]");
        }

        public override Task ExecuteAsync(
          StateMachine<TState, TTrigger>.Transition transition,
          object[] args)
        {
          return this._action(transition, args);
        }
      }
    }

    internal class InternalTriggerBehaviour : StateMachine<TState, TTrigger>.TriggerBehaviour
    {
      public InternalTriggerBehaviour(TTrigger trigger, Func<bool> guard)
        : base(trigger, new StateMachine<TState, TTrigger>.TransitionGuard(guard, "Internal Transition"))
      {
      }

      public override bool ResultsInTransitionFrom(
        TState source,
        object[] args,
        out TState destination)
      {
        destination = source;
        return false;
      }
    }

    private class OnTransitionedEvent
    {
      private readonly List<Func<StateMachine<TState, TTrigger>.Transition, Task>> _onTransitionedAsync = new List<Func<StateMachine<TState, TTrigger>.Transition, Task>>();

      private event Action<StateMachine<TState, TTrigger>.Transition> _onTransitioned;

      public void Invoke(
        StateMachine<TState, TTrigger>.Transition transition)
      {
        if (this._onTransitionedAsync.Count != 0)
          throw new InvalidOperationException("Cannot execute asynchronous action specified as OnTransitioned callback. Use asynchronous version of Fire [FireAsync]");
        Action<StateMachine<TState, TTrigger>.Transition> onTransitioned = this._onTransitioned;
        if (onTransitioned == null)
          return;
        onTransitioned(transition);
      }

      public async Task InvokeAsync(
        StateMachine<TState, TTrigger>.Transition transition)
      {
        Action<StateMachine<TState, TTrigger>.Transition> onTransitioned = this._onTransitioned;
        if (onTransitioned != null)
          onTransitioned(transition);
        foreach (Func<StateMachine<TState, TTrigger>.Transition, Task> func in this._onTransitionedAsync)
          await func(transition);
      }

      public void Register(
        Action<StateMachine<TState, TTrigger>.Transition> action)
      {
        this._onTransitioned += action;
      }

      public void Register(
        Func<StateMachine<TState, TTrigger>.Transition, Task> action)
      {
        this._onTransitionedAsync.Add(action);
      }
    }

    public class StateConfiguration
    {
      private readonly StateMachine<TState, TTrigger> _machine;
      private readonly StateMachine<TState, TTrigger>.StateRepresentation _representation;
      private readonly Func<TState, StateMachine<TState, TTrigger>.StateRepresentation> _lookup;

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsyncIf(
        TTrigger trigger,
        Func<bool> guard,
        Func<StateMachine<TState, TTrigger>.Transition, Task> entryAction)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger, guard));
        this._representation.AddInternalAction(trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsyncIf(
        TTrigger trigger,
        Func<bool> guard,
        Func<Task> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger, guard));
        this._representation.AddInternalAction(trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => internalAction()));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsyncIf<TArg0>(
        TTrigger trigger,
        Func<bool> guard,
        Func<StateMachine<TState, TTrigger>.Transition, Task> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger, guard));
        this._representation.AddInternalAction(trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => internalAction(t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsyncIf<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Func<bool> guard,
        Func<TArg0, StateMachine<TState, TTrigger>.Transition, Task> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger.Trigger, guard));
        this._representation.AddInternalAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => internalAction(ParameterConversion.Unpack<TArg0>(args, 0), t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsyncIf<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Func<bool> guard,
        Func<TArg0, TArg1, StateMachine<TState, TTrigger>.Transition, Task> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger.Trigger, guard));
        this._representation.AddInternalAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => internalAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsyncIf<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Func<bool> guard,
        Func<TArg0, TArg1, TArg2, StateMachine<TState, TTrigger>.Transition, Task> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger.Trigger, guard));
        this._representation.AddInternalAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => internalAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2), t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsync(
        TTrigger trigger,
        Func<StateMachine<TState, TTrigger>.Transition, Task> entryAction)
      {
        return this.InternalTransitionAsyncIf(trigger, (Func<bool>) (() => true), entryAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsync(
        TTrigger trigger,
        Func<Task> internalAction)
      {
        return this.InternalTransitionAsyncIf(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsync<TArg0>(
        TTrigger trigger,
        Func<StateMachine<TState, TTrigger>.Transition, Task> internalAction)
      {
        return this.InternalTransitionAsyncIf(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsync<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Func<TArg0, StateMachine<TState, TTrigger>.Transition, Task> internalAction)
      {
        return this.InternalTransitionAsyncIf<TArg0>(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsync<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Func<TArg0, TArg1, StateMachine<TState, TTrigger>.Transition, Task> internalAction)
      {
        return this.InternalTransitionAsyncIf<TArg0, TArg1>(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionAsync<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Func<TArg0, TArg1, TArg2, StateMachine<TState, TTrigger>.Transition, Task> internalAction)
      {
        return this.InternalTransitionAsyncIf<TArg0, TArg1, TArg2>(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnActivateAsync(
        Func<Task> activateAction,
        string activateActionDescription = null)
      {
        this._representation.AddActivateAction(activateAction, InvocationInfo.Create((Delegate) activateAction, activateActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnDeactivateAsync(
        Func<Task> deactivateAction,
        string deactivateActionDescription = null)
      {
        this._representation.AddDeactivateAction(deactivateAction, InvocationInfo.Create((Delegate) deactivateAction, deactivateActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryAsync(
        Func<Task> entryAction,
        string entryActionDescription = null)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction((Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction()), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryAsync(
        Func<StateMachine<TState, TTrigger>.Transition, Task> entryAction,
        string entryActionDescription = null)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction((Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFromAsync(
        TTrigger trigger,
        Func<Task> entryAction,
        string entryActionDescription = null)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction()), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFromAsync(
        TTrigger trigger,
        Func<StateMachine<TState, TTrigger>.Transition, Task> entryAction,
        string entryActionDescription = null)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFromAsync<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Func<TArg0, Task> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0))), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFromAsync<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Func<TArg0, StateMachine<TState, TTrigger>.Transition, Task> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFromAsync<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Func<TArg0, TArg1, Task> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1))), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFromAsync<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Func<TArg0, TArg1, StateMachine<TState, TTrigger>.Transition, Task> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFromAsync<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Func<TArg0, TArg1, TArg2, Task> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2))), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFromAsync<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Func<TArg0, TArg1, TArg2, StateMachine<TState, TTrigger>.Transition, Task> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2), t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnExitAsync(
        Func<Task> exitAction,
        string exitActionDescription = null)
      {
        if (exitAction == null)
          throw new ArgumentNullException(nameof (exitAction));
        this._representation.AddExitAction((Func<StateMachine<TState, TTrigger>.Transition, Task>) (t => exitAction()), InvocationInfo.Create((Delegate) exitAction, exitActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnExitAsync(
        Func<StateMachine<TState, TTrigger>.Transition, Task> exitAction,
        string exitActionDescription = null)
      {
        this._representation.AddExitAction(exitAction, InvocationInfo.Create((Delegate) exitAction, exitActionDescription, InvocationInfo.Timing.Asynchronous));
        return this;
      }

      internal StateConfiguration(
        StateMachine<TState, TTrigger> machine,
        StateMachine<TState, TTrigger>.StateRepresentation representation,
        Func<TState, StateMachine<TState, TTrigger>.StateRepresentation> lookup)
      {
        this._machine = machine;
        this._representation = representation;
        this._lookup = lookup;
      }

      public TState State => this._representation.UnderlyingState;

      public StateMachine<TState, TTrigger> Machine => this._machine;

      public StateMachine<TState, TTrigger>.StateConfiguration Permit(
        TTrigger trigger,
        TState destinationState)
      {
        this.EnforceNotIdentityTransition(destinationState);
        return this.InternalPermit(trigger, destinationState);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransition(
        TTrigger trigger,
        Action<StateMachine<TState, TTrigger>.Transition> entryAction)
      {
        return this.InternalTransitionIf(trigger, (Func<bool>) (() => true), entryAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionIf(
        TTrigger trigger,
        Func<bool> guard,
        Action<StateMachine<TState, TTrigger>.Transition> entryAction)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger, guard));
        this._representation.AddInternalAction(trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransition(
        TTrigger trigger,
        Action internalAction)
      {
        return this.InternalTransitionIf(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionIf(
        TTrigger trigger,
        Func<bool> guard,
        Action internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger, guard));
        this._representation.AddInternalAction(trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => internalAction()));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionIf<TArg0>(
        TTrigger trigger,
        Func<bool> guard,
        Action<StateMachine<TState, TTrigger>.Transition> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger, guard));
        this._representation.AddInternalAction(trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => internalAction(t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransition<TArg0>(
        TTrigger trigger,
        Action<StateMachine<TState, TTrigger>.Transition> internalAction)
      {
        return this.InternalTransitionIf(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransition<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Action<TArg0, StateMachine<TState, TTrigger>.Transition> internalAction)
      {
        return this.InternalTransitionIf<TArg0>(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionIf<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Func<bool> guard,
        Action<TArg0, StateMachine<TState, TTrigger>.Transition> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger.Trigger, guard));
        this._representation.AddInternalAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => internalAction(ParameterConversion.Unpack<TArg0>(args, 0), t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransition<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Action<TArg0, TArg1, StateMachine<TState, TTrigger>.Transition> internalAction)
      {
        return this.InternalTransitionIf<TArg0, TArg1>(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionIf<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Func<bool> guard,
        Action<TArg0, TArg1, StateMachine<TState, TTrigger>.Transition> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger.Trigger, guard));
        this._representation.AddInternalAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => internalAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransitionIf<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Func<bool> guard,
        Action<TArg0, TArg1, TArg2, StateMachine<TState, TTrigger>.Transition> internalAction)
      {
        if (internalAction == null)
          throw new ArgumentNullException(nameof (internalAction));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.InternalTriggerBehaviour(trigger.Trigger, guard));
        this._representation.AddInternalAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => internalAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2), t)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration InternalTransition<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Action<TArg0, TArg1, TArg2, StateMachine<TState, TTrigger>.Transition> internalAction)
      {
        return this.InternalTransitionIf<TArg0, TArg1, TArg2>(trigger, (Func<bool>) (() => true), internalAction);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitIf(
        TTrigger trigger,
        TState destinationState,
        Func<bool> guard,
        string guardDescription = null)
      {
        this.EnforceNotIdentityTransition(destinationState);
        return this.InternalPermitIf(trigger, destinationState, new StateMachine<TState, TTrigger>.TransitionGuard(guard, guardDescription));
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitIf(
        TTrigger trigger,
        TState destinationState,
        params Tuple<Func<bool>, string>[] guards)
      {
        this.EnforceNotIdentityTransition(destinationState);
        return this.InternalPermitIf(trigger, destinationState, new StateMachine<TState, TTrigger>.TransitionGuard(guards));
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitReentry(
        TTrigger trigger)
      {
        return this.InternalPermit(trigger, this._representation.UnderlyingState);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitReentryIf(
        TTrigger trigger,
        Func<bool> guard,
        string guardDescription = null)
      {
        return this.InternalPermitIf(trigger, this._representation.UnderlyingState, new StateMachine<TState, TTrigger>.TransitionGuard(guard, guardDescription));
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitReentryIf(
        TTrigger trigger,
        params Tuple<Func<bool>, string>[] guards)
      {
        return this.InternalPermitIf(trigger, this._representation.UnderlyingState, new StateMachine<TState, TTrigger>.TransitionGuard(guards));
      }

      public StateMachine<TState, TTrigger>.StateConfiguration Ignore(TTrigger trigger)
      {
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.IgnoredTriggerBehaviour(trigger, (StateMachine<TState, TTrigger>.TransitionGuard) null));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration IgnoreIf(
        TTrigger trigger,
        Func<bool> guard,
        string guardDescription = null)
      {
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.IgnoredTriggerBehaviour(trigger, new StateMachine<TState, TTrigger>.TransitionGuard(guard, guardDescription)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration IgnoreIf(
        TTrigger trigger,
        params Tuple<Func<bool>, string>[] guards)
      {
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.IgnoredTriggerBehaviour(trigger, new StateMachine<TState, TTrigger>.TransitionGuard(guards)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnActivate(
        Action activateAction,
        string activateActionDescription = null)
      {
        this._representation.AddActivateAction(activateAction, InvocationInfo.Create((Delegate) activateAction, activateActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnDeactivate(
        Action deactivateAction,
        string deactivateActionDescription = null)
      {
        this._representation.AddDeactivateAction(deactivateAction, InvocationInfo.Create((Delegate) deactivateAction, deactivateActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntry(
        Action entryAction,
        string entryActionDescription = null)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction((Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction()), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntry(
        Action<StateMachine<TState, TTrigger>.Transition> entryAction,
        string entryActionDescription = null)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction((Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFrom(
        TTrigger trigger,
        Action entryAction,
        string entryActionDescription = null)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction()), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFrom(
        TTrigger trigger,
        Action<StateMachine<TState, TTrigger>.Transition> entryAction,
        string entryActionDescription = null)
      {
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFrom<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Action<TArg0> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0))), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFrom<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Action<TArg0, StateMachine<TState, TTrigger>.Transition> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFrom<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Action<TArg0, TArg1> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1))), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFrom<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Action<TArg0, TArg1, StateMachine<TState, TTrigger>.Transition> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFrom<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Action<TArg0, TArg1, TArg2> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2))), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnEntryFrom<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Action<TArg0, TArg1, TArg2, StateMachine<TState, TTrigger>.Transition> entryAction,
        string entryActionDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (entryAction == null)
          throw new ArgumentNullException(nameof (entryAction));
        this._representation.AddEntryAction(trigger.Trigger, (Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) => entryAction(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2), t)), InvocationInfo.Create((Delegate) entryAction, entryActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnExit(
        Action exitAction,
        string exitActionDescription = null)
      {
        if (exitAction == null)
          throw new ArgumentNullException(nameof (exitAction));
        this._representation.AddExitAction((Action<StateMachine<TState, TTrigger>.Transition>) (t => exitAction()), InvocationInfo.Create((Delegate) exitAction, exitActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration OnExit(
        Action<StateMachine<TState, TTrigger>.Transition> exitAction,
        string exitActionDescription = null)
      {
        this._representation.AddExitAction(exitAction, InvocationInfo.Create((Delegate) exitAction, exitActionDescription));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration SubstateOf(
        TState superstate)
      {
        TState underlyingState = this._representation.UnderlyingState;
        HashSet<TState> stateSet = !underlyingState.Equals((object) superstate) ? new HashSet<TState>()
        {
          underlyingState
        } : throw new ArgumentException(string.Format("Configuring {0} as a substate of {1} creates an illegal cyclic configuration.", (object) underlyingState, (object) superstate));
        for (StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation = this._lookup(superstate); stateRepresentation.Superstate != null; stateRepresentation = this._lookup(stateRepresentation.Superstate.UnderlyingState))
        {
          if (stateSet.Contains(stateRepresentation.Superstate.UnderlyingState))
            throw new ArgumentException(string.Format("Configuring {0} as a substate of {1} creates an illegal nested cyclic configuration.", (object) underlyingState, (object) superstate));
          stateSet.Add(stateRepresentation.Superstate.UnderlyingState);
        }
        StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation1 = this._lookup(superstate);
        this._representation.Superstate = stateRepresentation1;
        stateRepresentation1.AddSubstate(this._representation);
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamic(
        TTrigger trigger,
        Func<TState> destinationStateSelector,
        string destinationStateSelectorDescription = null,
        DynamicStateInfos possibleDestinationStates = null)
      {
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.DynamicTriggerBehaviour(trigger, (Func<object[], TState>) (args => destinationStateSelector()), (StateMachine<TState, TTrigger>.TransitionGuard) null, DynamicTransitionInfo.Create<TTrigger>(trigger, (IEnumerable<InvocationInfo>) null, InvocationInfo.Create((Delegate) destinationStateSelector, destinationStateSelectorDescription), possibleDestinationStates)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamic<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Func<TArg0, TState> destinationStateSelector,
        string destinationStateSelectorDescription = null)
      {
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.DynamicTriggerBehaviour(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0))), (StateMachine<TState, TTrigger>.TransitionGuard) null, DynamicTransitionInfo.Create<TTrigger>(trigger.Trigger, (IEnumerable<InvocationInfo>) null, InvocationInfo.Create((Delegate) destinationStateSelector, destinationStateSelectorDescription), (DynamicStateInfos) null)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamic<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Func<TArg0, TArg1, TState> destinationStateSelector,
        string destinationStateSelectorDescription = null)
      {
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.DynamicTriggerBehaviour(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1))), (StateMachine<TState, TTrigger>.TransitionGuard) null, DynamicTransitionInfo.Create<TTrigger>(trigger.Trigger, (IEnumerable<InvocationInfo>) null, InvocationInfo.Create((Delegate) destinationStateSelector, destinationStateSelectorDescription), (DynamicStateInfos) null)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamic<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Func<TArg0, TArg1, TArg2, TState> destinationStateSelector,
        string destinationStateSelectorDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.DynamicTriggerBehaviour(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2))), (StateMachine<TState, TTrigger>.TransitionGuard) null, DynamicTransitionInfo.Create<TTrigger>(trigger.Trigger, (IEnumerable<InvocationInfo>) null, InvocationInfo.Create((Delegate) destinationStateSelector, destinationStateSelectorDescription), (DynamicStateInfos) null)));
        return this;
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf(
        TTrigger trigger,
        Func<TState> destinationStateSelector,
        Func<bool> guard,
        string guardDescription = null)
      {
        return this.PermitDynamicIf(trigger, destinationStateSelector, (string) null, guard, guardDescription);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf(
        TTrigger trigger,
        Func<TState> destinationStateSelector,
        string destinationStateSelectorDescription,
        Func<bool> guard,
        string guardDescription = null)
      {
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        return this.InternalPermitDynamicIf(trigger, (Func<object[], TState>) (args => destinationStateSelector()), destinationStateSelectorDescription, new StateMachine<TState, TTrigger>.TransitionGuard(guard, guardDescription), (DynamicStateInfos) null);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf(
        TTrigger trigger,
        Func<TState> destinationStateSelector,
        params Tuple<Func<bool>, string>[] guards)
      {
        return this.PermitDynamicIf(trigger, destinationStateSelector, (string) null, guards);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf(
        TTrigger trigger,
        Func<TState> destinationStateSelector,
        string destinationStateSelectorDescription,
        params Tuple<Func<bool>, string>[] guards)
      {
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        return this.InternalPermitDynamicIf(trigger, (Func<object[], TState>) (args => destinationStateSelector()), destinationStateSelectorDescription, new StateMachine<TState, TTrigger>.TransitionGuard(guards), (DynamicStateInfos) null);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Func<TArg0, TState> destinationStateSelector,
        Func<bool> guard,
        string guardDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        return this.InternalPermitDynamicIf(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0))), (string) null, new StateMachine<TState, TTrigger>.TransitionGuard(guard, guardDescription), (DynamicStateInfos) null);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf<TArg0>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0> trigger,
        Func<TArg0, TState> destinationStateSelector,
        params Tuple<Func<bool>, string>[] guards)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        return this.InternalPermitDynamicIf(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0))), (string) null, new StateMachine<TState, TTrigger>.TransitionGuard(guards), (DynamicStateInfos) null);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Func<TArg0, TArg1, TState> destinationStateSelector,
        Func<bool> guard,
        string guardDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        return this.InternalPermitDynamicIf(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1))), (string) null, new StateMachine<TState, TTrigger>.TransitionGuard(guard, guardDescription), (DynamicStateInfos) null);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf<TArg0, TArg1>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1> trigger,
        Func<TArg0, TArg1, TState> destinationStateSelector,
        params Tuple<Func<bool>, string>[] guards)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        return this.InternalPermitDynamicIf(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1))), (string) null, new StateMachine<TState, TTrigger>.TransitionGuard(guards), (DynamicStateInfos) null);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Func<TArg0, TArg1, TArg2, TState> destinationStateSelector,
        Func<bool> guard,
        string guardDescription = null)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        return this.InternalPermitDynamicIf(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2))), (string) null, new StateMachine<TState, TTrigger>.TransitionGuard(guard, guardDescription), (DynamicStateInfos) null);
      }

      public StateMachine<TState, TTrigger>.StateConfiguration PermitDynamicIf<TArg0, TArg1, TArg2>(
        StateMachine<TState, TTrigger>.TriggerWithParameters<TArg0, TArg1, TArg2> trigger,
        Func<TArg0, TArg1, TArg2, TState> destinationStateSelector,
        params Tuple<Func<bool>, string>[] guards)
      {
        if (trigger == null)
          throw new ArgumentNullException(nameof (trigger));
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        return this.InternalPermitDynamicIf(trigger.Trigger, (Func<object[], TState>) (args => destinationStateSelector(ParameterConversion.Unpack<TArg0>(args, 0), ParameterConversion.Unpack<TArg1>(args, 1), ParameterConversion.Unpack<TArg2>(args, 2))), (string) null, new StateMachine<TState, TTrigger>.TransitionGuard(guards), (DynamicStateInfos) null);
      }

      private void EnforceNotIdentityTransition(TState destination)
      {
        if (destination.Equals((object) this._representation.UnderlyingState))
          throw new ArgumentException(StateConfigurationResources.SelfTransitionsEitherIgnoredOrReentrant);
      }

      private StateMachine<TState, TTrigger>.StateConfiguration InternalPermit(
        TTrigger trigger,
        TState destinationState)
      {
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.TransitioningTriggerBehaviour(trigger, destinationState, (StateMachine<TState, TTrigger>.TransitionGuard) null));
        return this;
      }

      private StateMachine<TState, TTrigger>.StateConfiguration InternalPermitIf(
        TTrigger trigger,
        TState destinationState,
        StateMachine<TState, TTrigger>.TransitionGuard transitionGuard)
      {
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.TransitioningTriggerBehaviour(trigger, destinationState, transitionGuard));
        return this;
      }

      private StateMachine<TState, TTrigger>.StateConfiguration InternalPermitDynamicIf(
        TTrigger trigger,
        Func<object[], TState> destinationStateSelector,
        string destinationStateSelectorDescription,
        StateMachine<TState, TTrigger>.TransitionGuard transitionGuard,
        DynamicStateInfos possibleDestinationStates)
      {
        if (destinationStateSelector == null)
          throw new ArgumentNullException(nameof (destinationStateSelector));
        if (transitionGuard == null)
          throw new ArgumentNullException(nameof (transitionGuard));
        this._representation.AddTriggerBehaviour((StateMachine<TState, TTrigger>.TriggerBehaviour) new StateMachine<TState, TTrigger>.DynamicTriggerBehaviour(trigger, destinationStateSelector, transitionGuard, DynamicTransitionInfo.Create<TTrigger>(trigger, transitionGuard.Conditions.Select<StateMachine<TState, TTrigger>.GuardCondition, InvocationInfo>((Func<StateMachine<TState, TTrigger>.GuardCondition, InvocationInfo>) (x => x.MethodDescription)), InvocationInfo.Create((Delegate) destinationStateSelector, destinationStateSelectorDescription), possibleDestinationStates)));
        return this;
      }
    }

    private class QueuedTrigger
    {
      public TTrigger Trigger { get; set; }

      public object[] Args { get; set; }
    }

    internal class StateReference
    {
      public TState State { get; set; }
    }

    internal class StateRepresentation
    {
      private readonly TState _state;
      private readonly IDictionary<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>> _triggerBehaviours = (IDictionary<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>) new Dictionary<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>();
      private readonly ICollection<StateMachine<TState, TTrigger>.EntryActionBehavior> _entryActions = (ICollection<StateMachine<TState, TTrigger>.EntryActionBehavior>) new List<StateMachine<TState, TTrigger>.EntryActionBehavior>();
      private readonly ICollection<StateMachine<TState, TTrigger>.ExitActionBehavior> _exitActions = (ICollection<StateMachine<TState, TTrigger>.ExitActionBehavior>) new List<StateMachine<TState, TTrigger>.ExitActionBehavior>();
      private readonly ICollection<StateMachine<TState, TTrigger>.ActivateActionBehaviour> _activateActions = (ICollection<StateMachine<TState, TTrigger>.ActivateActionBehaviour>) new List<StateMachine<TState, TTrigger>.ActivateActionBehaviour>();
      private readonly ICollection<StateMachine<TState, TTrigger>.DeactivateActionBehaviour> _deactivateActions = (ICollection<StateMachine<TState, TTrigger>.DeactivateActionBehaviour>) new List<StateMachine<TState, TTrigger>.DeactivateActionBehaviour>();
      private readonly ICollection<StateMachine<TState, TTrigger>.InternalActionBehaviour> _internalActions = (ICollection<StateMachine<TState, TTrigger>.InternalActionBehaviour>) new List<StateMachine<TState, TTrigger>.InternalActionBehaviour>();
      private StateMachine<TState, TTrigger>.StateRepresentation _superstate;
      private bool active;
      private readonly ICollection<StateMachine<TState, TTrigger>.StateRepresentation> _substates = (ICollection<StateMachine<TState, TTrigger>.StateRepresentation>) new List<StateMachine<TState, TTrigger>.StateRepresentation>();

      public void AddActivateAction(Func<Task> action, InvocationInfo activateActionDescription) => this._activateActions.Add((StateMachine<TState, TTrigger>.ActivateActionBehaviour) new StateMachine<TState, TTrigger>.ActivateActionBehaviour.Async(this._state, action, activateActionDescription));

      public void AddDeactivateAction(Func<Task> action, InvocationInfo deactivateActionDescription) => this._deactivateActions.Add((StateMachine<TState, TTrigger>.DeactivateActionBehaviour) new StateMachine<TState, TTrigger>.DeactivateActionBehaviour.Async(this._state, action, deactivateActionDescription));

      public void AddEntryAction(
        TTrigger trigger,
        Func<StateMachine<TState, TTrigger>.Transition, object[], Task> action,
        InvocationInfo entryActionDescription)
      {
        if (action == null)
          throw new ArgumentNullException(nameof (action));
        this._entryActions.Add((StateMachine<TState, TTrigger>.EntryActionBehavior) new StateMachine<TState, TTrigger>.EntryActionBehavior.Async((Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => t.Trigger.Equals((object) trigger) ? action(t, args) : TaskResult.Done), entryActionDescription));
      }

      public void AddEntryAction(
        Func<StateMachine<TState, TTrigger>.Transition, object[], Task> action,
        InvocationInfo entryActionDescription)
      {
        this._entryActions.Add((StateMachine<TState, TTrigger>.EntryActionBehavior) new StateMachine<TState, TTrigger>.EntryActionBehavior.Async(action, entryActionDescription));
      }

      public void AddExitAction(
        Func<StateMachine<TState, TTrigger>.Transition, Task> action,
        InvocationInfo exitActionDescription)
      {
        this._exitActions.Add((StateMachine<TState, TTrigger>.ExitActionBehavior) new StateMachine<TState, TTrigger>.ExitActionBehavior.Async(action, exitActionDescription));
      }

      internal void AddInternalAction(
        TTrigger trigger,
        Func<StateMachine<TState, TTrigger>.Transition, object[], Task> action)
      {
        if (action == null)
          throw new ArgumentNullException(nameof (action));
        this._internalActions.Add((StateMachine<TState, TTrigger>.InternalActionBehaviour) new StateMachine<TState, TTrigger>.InternalActionBehaviour.Async((Func<StateMachine<TState, TTrigger>.Transition, object[], Task>) ((t, args) => t.Trigger.Equals((object) trigger) ? action(t, args) : TaskResult.Done)));
      }

      public async Task ActivateAsync()
      {
        if (this._superstate != null)
          await this._superstate.ActivateAsync();
        if (this.active)
          return;
        await this.ExecuteActivationActionsAsync();
        this.active = true;
      }

      public async Task DeactivateAsync()
      {
        if (!this.active)
          return;
        await this.ExecuteDeactivationActionsAsync();
        this.active = false;
        if (this._superstate == null)
          return;
        await this._superstate.DeactivateAsync();
      }

      private async Task ExecuteActivationActionsAsync()
      {
        foreach (StateMachine<TState, TTrigger>.ActivateActionBehaviour activateAction in (IEnumerable<StateMachine<TState, TTrigger>.ActivateActionBehaviour>) this._activateActions)
          await activateAction.ExecuteAsync();
      }

      private async Task ExecuteDeactivationActionsAsync()
      {
        foreach (StateMachine<TState, TTrigger>.DeactivateActionBehaviour deactivateAction in (IEnumerable<StateMachine<TState, TTrigger>.DeactivateActionBehaviour>) this._deactivateActions)
          await deactivateAction.ExecuteAsync();
      }

      public async Task EnterAsync(
        StateMachine<TState, TTrigger>.Transition transition,
        params object[] entryArgs)
      {
        if (transition.IsReentry)
        {
          await this.ExecuteEntryActionsAsync(transition, entryArgs);
          await this.ExecuteActivationActionsAsync();
        }
        else
        {
          if (this.Includes(transition.Source))
            return;
          if (this._superstate != null)
            await this._superstate.EnterAsync(transition, entryArgs);
          await this.ExecuteEntryActionsAsync(transition, entryArgs);
          await this.ExecuteActivationActionsAsync();
        }
      }

      public async Task ExitAsync(
        StateMachine<TState, TTrigger>.Transition transition)
      {
        if (transition.IsReentry)
        {
          await this.ExecuteDeactivationActionsAsync();
          await this.ExecuteExitActionsAsync(transition);
        }
        else
        {
          if (this.Includes(transition.Destination))
            return;
          await this.ExecuteDeactivationActionsAsync();
          await this.ExecuteExitActionsAsync(transition);
          if (this._superstate == null)
            return;
          await this._superstate.ExitAsync(transition);
        }
      }

      private async Task ExecuteEntryActionsAsync(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] entryArgs)
      {
        foreach (StateMachine<TState, TTrigger>.EntryActionBehavior entryAction in (IEnumerable<StateMachine<TState, TTrigger>.EntryActionBehavior>) this._entryActions)
          await entryAction.ExecuteAsync(transition, entryArgs);
      }

      private async Task ExecuteExitActionsAsync(
        StateMachine<TState, TTrigger>.Transition transition)
      {
        foreach (StateMachine<TState, TTrigger>.ExitActionBehavior exitAction in (IEnumerable<StateMachine<TState, TTrigger>.ExitActionBehavior>) this._exitActions)
          await exitAction.ExecuteAsync(transition);
      }

      private async Task ExecuteInternalActionsAsync(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] args)
      {
        StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation1 = this;
        List<StateMachine<TState, TTrigger>.InternalActionBehaviour> internalActionBehaviourList = new List<StateMachine<TState, TTrigger>.InternalActionBehaviour>();
        StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation2 = stateRepresentation1;
        do
        {
          internalActionBehaviourList.AddRange((IEnumerable<StateMachine<TState, TTrigger>.InternalActionBehaviour>) stateRepresentation2._internalActions);
          stateRepresentation2 = stateRepresentation2._superstate;
        }
        while (stateRepresentation2 != null);
        foreach (StateMachine<TState, TTrigger>.InternalActionBehaviour internalActionBehaviour in internalActionBehaviourList)
          await internalActionBehaviour.ExecuteAsync(transition, args);
      }

      internal Task InternalActionAsync(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] args)
      {
        return this.ExecuteInternalActionsAsync(transition, args);
      }

      internal IDictionary<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>> TriggerBehaviours => this._triggerBehaviours;

      internal ICollection<StateMachine<TState, TTrigger>.EntryActionBehavior> EntryActions => this._entryActions;

      internal ICollection<StateMachine<TState, TTrigger>.ExitActionBehavior> ExitActions => this._exitActions;

      internal ICollection<StateMachine<TState, TTrigger>.ActivateActionBehaviour> ActivateActions => this._activateActions;

      internal ICollection<StateMachine<TState, TTrigger>.DeactivateActionBehaviour> DeactivateActions => this._deactivateActions;

      public StateRepresentation(TState state) => this._state = state;

      internal ICollection<StateMachine<TState, TTrigger>.StateRepresentation> GetSubstates() => this._substates;

      public bool CanHandle(TTrigger trigger) => this.TryFindHandler(trigger, out StateMachine<TState, TTrigger>.TriggerBehaviourResult _);

      public bool TryFindHandler(
        TTrigger trigger,
        out StateMachine<TState, TTrigger>.TriggerBehaviourResult handler)
      {
        if (this.TryFindLocalHandler(trigger, out handler))
          return true;
        return this.Superstate != null && this.Superstate.TryFindHandler(trigger, out handler);
      }

      private bool TryFindLocalHandler(
        TTrigger trigger,
        out StateMachine<TState, TTrigger>.TriggerBehaviourResult handlerResult)
      {
        ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour> source;
        if (!this._triggerBehaviours.TryGetValue(trigger, out source))
        {
          handlerResult = (StateMachine<TState, TTrigger>.TriggerBehaviourResult) null;
          return false;
        }
        IEnumerable<StateMachine<TState, TTrigger>.TriggerBehaviourResult> results = source.Select<StateMachine<TState, TTrigger>.TriggerBehaviour, StateMachine<TState, TTrigger>.TriggerBehaviourResult>((Func<StateMachine<TState, TTrigger>.TriggerBehaviour, StateMachine<TState, TTrigger>.TriggerBehaviourResult>) (h => new StateMachine<TState, TTrigger>.TriggerBehaviourResult(h, h.UnmetGuardConditions)));
        handlerResult = this.TryFindLocalHandlerResult(trigger, results, (Func<StateMachine<TState, TTrigger>.TriggerBehaviourResult, bool>) (r => !r.UnmetGuardConditions.Any<string>())) ?? this.TryFindLocalHandlerResult(trigger, results, (Func<StateMachine<TState, TTrigger>.TriggerBehaviourResult, bool>) (r => r.UnmetGuardConditions.Any<string>()));
        return !handlerResult.UnmetGuardConditions.Any<string>();
      }

      private StateMachine<TState, TTrigger>.TriggerBehaviourResult TryFindLocalHandlerResult(
        TTrigger trigger,
        IEnumerable<StateMachine<TState, TTrigger>.TriggerBehaviourResult> results,
        Func<StateMachine<TState, TTrigger>.TriggerBehaviourResult, bool> filter)
      {
        IEnumerable<StateMachine<TState, TTrigger>.TriggerBehaviourResult> source = results.Where<StateMachine<TState, TTrigger>.TriggerBehaviourResult>(filter);
        return source.Count<StateMachine<TState, TTrigger>.TriggerBehaviourResult>() <= 1 ? source.FirstOrDefault<StateMachine<TState, TTrigger>.TriggerBehaviourResult>() : throw new InvalidOperationException(string.Format(StateRepresentationResources.MultipleTransitionsPermitted, (object) trigger, (object) this._state));
      }

      public void AddActivateAction(Action action, InvocationInfo activateActionDescription) => this._activateActions.Add((StateMachine<TState, TTrigger>.ActivateActionBehaviour) new StateMachine<TState, TTrigger>.ActivateActionBehaviour.Sync(this._state, action, activateActionDescription));

      public void AddDeactivateAction(Action action, InvocationInfo deactivateActionDescription) => this._deactivateActions.Add((StateMachine<TState, TTrigger>.DeactivateActionBehaviour) new StateMachine<TState, TTrigger>.DeactivateActionBehaviour.Sync(this._state, action, deactivateActionDescription));

      public void AddEntryAction(
        TTrigger trigger,
        Action<StateMachine<TState, TTrigger>.Transition, object[]> action,
        InvocationInfo entryActionDescription)
      {
        this._entryActions.Add((StateMachine<TState, TTrigger>.EntryActionBehavior) new StateMachine<TState, TTrigger>.EntryActionBehavior.SyncFrom<TTrigger>(trigger, action, entryActionDescription));
      }

      public void AddEntryAction(
        Action<StateMachine<TState, TTrigger>.Transition, object[]> action,
        InvocationInfo entryActionDescription)
      {
        this._entryActions.Add((StateMachine<TState, TTrigger>.EntryActionBehavior) new StateMachine<TState, TTrigger>.EntryActionBehavior.Sync(action, entryActionDescription));
      }

      public void AddExitAction(
        Action<StateMachine<TState, TTrigger>.Transition> action,
        InvocationInfo exitActionDescription)
      {
        this._exitActions.Add((StateMachine<TState, TTrigger>.ExitActionBehavior) new StateMachine<TState, TTrigger>.ExitActionBehavior.Sync(action, exitActionDescription));
      }

      internal void AddInternalAction(
        TTrigger trigger,
        Action<StateMachine<TState, TTrigger>.Transition, object[]> action)
      {
        if (action == null)
          throw new ArgumentNullException(nameof (action));
        this._internalActions.Add((StateMachine<TState, TTrigger>.InternalActionBehaviour) new StateMachine<TState, TTrigger>.InternalActionBehaviour.Sync((Action<StateMachine<TState, TTrigger>.Transition, object[]>) ((t, args) =>
        {
          if (!t.Trigger.Equals((object) trigger))
            return;
          action(t, args);
        })));
      }

      public void Activate()
      {
        if (this._superstate != null)
          this._superstate.Activate();
        if (this.active)
          return;
        this.ExecuteActivationActions();
        this.active = true;
      }

      public void Deactivate()
      {
        if (!this.active)
          return;
        this.ExecuteDeactivationActions();
        this.active = false;
        if (this._superstate == null)
          return;
        this._superstate.Deactivate();
      }

      private void ExecuteActivationActions()
      {
        foreach (StateMachine<TState, TTrigger>.ActivateActionBehaviour activateAction in (IEnumerable<StateMachine<TState, TTrigger>.ActivateActionBehaviour>) this._activateActions)
          activateAction.Execute();
      }

      private void ExecuteDeactivationActions()
      {
        foreach (StateMachine<TState, TTrigger>.DeactivateActionBehaviour deactivateAction in (IEnumerable<StateMachine<TState, TTrigger>.DeactivateActionBehaviour>) this._deactivateActions)
          deactivateAction.Execute();
      }

      public void Enter(
        StateMachine<TState, TTrigger>.Transition transition,
        params object[] entryArgs)
      {
        if (transition.IsReentry)
        {
          this.ExecuteEntryActions(transition, entryArgs);
          this.ExecuteActivationActions();
        }
        else
        {
          if (this.Includes(transition.Source))
            return;
          if (this._superstate != null)
            this._superstate.Enter(transition, entryArgs);
          this.ExecuteEntryActions(transition, entryArgs);
          this.ExecuteActivationActions();
        }
      }

      public void Exit(
        StateMachine<TState, TTrigger>.Transition transition)
      {
        if (transition.IsReentry)
        {
          this.ExecuteDeactivationActions();
          this.ExecuteExitActions(transition);
        }
        else
        {
          if (this.Includes(transition.Destination))
            return;
          this.ExecuteDeactivationActions();
          this.ExecuteExitActions(transition);
          if (this._superstate == null)
            return;
          this._superstate.Exit(transition);
        }
      }

      private void ExecuteEntryActions(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] entryArgs)
      {
        foreach (StateMachine<TState, TTrigger>.EntryActionBehavior entryAction in (IEnumerable<StateMachine<TState, TTrigger>.EntryActionBehavior>) this._entryActions)
          entryAction.Execute(transition, entryArgs);
      }

      private void ExecuteExitActions(
        StateMachine<TState, TTrigger>.Transition transition)
      {
        foreach (StateMachine<TState, TTrigger>.ExitActionBehavior exitAction in (IEnumerable<StateMachine<TState, TTrigger>.ExitActionBehavior>) this._exitActions)
          exitAction.Execute(transition);
      }

      internal void InternalAction(
        StateMachine<TState, TTrigger>.Transition transition,
        object[] args)
      {
        List<StateMachine<TState, TTrigger>.InternalActionBehaviour> internalActionBehaviourList = new List<StateMachine<TState, TTrigger>.InternalActionBehaviour>();
        for (StateMachine<TState, TTrigger>.StateRepresentation stateRepresentation = this; stateRepresentation != null; stateRepresentation = stateRepresentation._superstate)
        {
          if (stateRepresentation.TryFindLocalHandler(transition.Trigger, out StateMachine<TState, TTrigger>.TriggerBehaviourResult _))
          {
            internalActionBehaviourList.AddRange((IEnumerable<StateMachine<TState, TTrigger>.InternalActionBehaviour>) stateRepresentation._internalActions);
            break;
          }
        }
        foreach (StateMachine<TState, TTrigger>.InternalActionBehaviour internalActionBehaviour in internalActionBehaviourList)
          internalActionBehaviour.Execute(transition, args);
      }

      public void AddTriggerBehaviour(
        StateMachine<TState, TTrigger>.TriggerBehaviour triggerBehaviour)
      {
        ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour> triggerBehaviours;
        if (!this._triggerBehaviours.TryGetValue(triggerBehaviour.Trigger, out triggerBehaviours))
        {
          triggerBehaviours = (ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>) new List<StateMachine<TState, TTrigger>.TriggerBehaviour>();
          this._triggerBehaviours.Add(triggerBehaviour.Trigger, triggerBehaviours);
        }
        triggerBehaviours.Add(triggerBehaviour);
      }

      public StateMachine<TState, TTrigger>.StateRepresentation Superstate
      {
        get => this._superstate;
        set => this._superstate = value;
      }

      public TState UnderlyingState => this._state;

      public void AddSubstate(
        StateMachine<TState, TTrigger>.StateRepresentation substate)
      {
        this._substates.Add(substate);
      }

      public bool Includes(TState state) => this._state.Equals((object) state) || this._substates.Any<StateMachine<TState, TTrigger>.StateRepresentation>((Func<StateMachine<TState, TTrigger>.StateRepresentation, bool>) (s => s.Includes(state)));

      public bool IsIncludedIn(TState state)
      {
        if (this._state.Equals((object) state))
          return true;
        return this._superstate != null && this._superstate.IsIncludedIn(state);
      }

      public IEnumerable<TTrigger> PermittedTriggers
      {
        get
        {
          IEnumerable<TTrigger> triggers = this._triggerBehaviours.Where<KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>>((Func<KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>, bool>) (t => t.Value.Any<StateMachine<TState, TTrigger>.TriggerBehaviour>((Func<StateMachine<TState, TTrigger>.TriggerBehaviour, bool>) (a => !a.UnmetGuardConditions.Any<string>())))).Select<KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>, TTrigger>((Func<KeyValuePair<TTrigger, ICollection<StateMachine<TState, TTrigger>.TriggerBehaviour>>, TTrigger>) (t => t.Key));
          if (this.Superstate != null)
            triggers = triggers.Union<TTrigger>(this.Superstate.PermittedTriggers);
          return (IEnumerable<TTrigger>) triggers.ToArray<TTrigger>();
        }
      }
    }

    public class Transition
    {
      private readonly TState _source;
      private readonly TState _destination;
      private readonly TTrigger _trigger;

      public Transition(TState source, TState destination, TTrigger trigger)
      {
        this._source = source;
        this._destination = destination;
        this._trigger = trigger;
      }

      public TState Source => this._source;

      public TState Destination => this._destination;

      public TTrigger Trigger => this._trigger;

      public bool IsReentry => this.Source.Equals((object) this.Destination);
    }

    internal class TransitionGuard
    {
      public static readonly StateMachine<TState, TTrigger>.TransitionGuard Empty = new StateMachine<TState, TTrigger>.TransitionGuard(new Tuple<Func<bool>, string>[0]);

      internal IList<StateMachine<TState, TTrigger>.GuardCondition> Conditions { get; }

      internal TransitionGuard(Tuple<Func<bool>, string>[] guards) => this.Conditions = (IList<StateMachine<TState, TTrigger>.GuardCondition>) ((IEnumerable<Tuple<Func<bool>, string>>) guards).Select<Tuple<Func<bool>, string>, StateMachine<TState, TTrigger>.GuardCondition>((Func<Tuple<Func<bool>, string>, StateMachine<TState, TTrigger>.GuardCondition>) (g => new StateMachine<TState, TTrigger>.GuardCondition(g.Item1, InvocationInfo.Create((Delegate) g.Item1, g.Item2)))).ToList<StateMachine<TState, TTrigger>.GuardCondition>();

      internal TransitionGuard(Func<bool> guard, string description = null) => this.Conditions = (IList<StateMachine<TState, TTrigger>.GuardCondition>) new List<StateMachine<TState, TTrigger>.GuardCondition>()
      {
        new StateMachine<TState, TTrigger>.GuardCondition(guard, InvocationInfo.Create((Delegate) guard, description))
      };

      internal ICollection<Func<bool>> Guards => (ICollection<Func<bool>>) this.Conditions.Select<StateMachine<TState, TTrigger>.GuardCondition, Func<bool>>((Func<StateMachine<TState, TTrigger>.GuardCondition, Func<bool>>) (g => g.Guard)).ToList<Func<bool>>();

      public bool GuardConditionsMet => this.Conditions.All<StateMachine<TState, TTrigger>.GuardCondition>((Func<StateMachine<TState, TTrigger>.GuardCondition, bool>) (c => c.Guard()));

      public ICollection<string> UnmetGuardConditions => (ICollection<string>) this.Conditions.Where<StateMachine<TState, TTrigger>.GuardCondition>((Func<StateMachine<TState, TTrigger>.GuardCondition, bool>) (c => !c.Guard())).Select<StateMachine<TState, TTrigger>.GuardCondition, string>((Func<StateMachine<TState, TTrigger>.GuardCondition, string>) (c => c.Description)).ToList<string>();
    }

    internal class TransitioningTriggerBehaviour : StateMachine<TState, TTrigger>.TriggerBehaviour
    {
      private readonly TState _destination;

      internal TState Destination => this._destination;

      public TransitioningTriggerBehaviour(
        TTrigger trigger,
        TState destination,
        StateMachine<TState, TTrigger>.TransitionGuard transitionGuard)
        : base(trigger, transitionGuard)
      {
        this._destination = destination;
      }

      public override bool ResultsInTransitionFrom(
        TState source,
        object[] args,
        out TState destination)
      {
        destination = this._destination;
        return true;
      }
    }

    internal abstract class TriggerBehaviour
    {
      private readonly StateMachine<TState, TTrigger>.TransitionGuard _guard;

      protected TriggerBehaviour(
        TTrigger trigger,
        StateMachine<TState, TTrigger>.TransitionGuard guard)
      {
        this._guard = guard ?? StateMachine<TState, TTrigger>.TransitionGuard.Empty;
        this.Trigger = trigger;
      }

      public TTrigger Trigger { get; }

      internal StateMachine<TState, TTrigger>.TransitionGuard Guard => this._guard;

      internal ICollection<Func<bool>> Guards => this._guard.Guards;

      public bool GuardConditionsMet => this._guard.GuardConditionsMet;

      public ICollection<string> UnmetGuardConditions => this._guard.UnmetGuardConditions;

      public abstract bool ResultsInTransitionFrom(
        TState source,
        object[] args,
        out TState destination);
    }

    internal class TriggerBehaviourResult
    {
      public TriggerBehaviourResult(
        StateMachine<TState, TTrigger>.TriggerBehaviour handler,
        ICollection<string> unmetGuardConditions)
      {
        this.Handler = handler;
        this.UnmetGuardConditions = unmetGuardConditions;
      }

      public StateMachine<TState, TTrigger>.TriggerBehaviour Handler { get; }

      public ICollection<string> UnmetGuardConditions { get; }
    }

    public abstract class TriggerWithParameters
    {
      private readonly TTrigger _underlyingTrigger;
      private readonly Type[] _argumentTypes;

      public TriggerWithParameters(TTrigger underlyingTrigger, params Type[] argumentTypes)
      {
        this._underlyingTrigger = underlyingTrigger;
        this._argumentTypes = argumentTypes ?? throw new ArgumentNullException(nameof (argumentTypes));
      }

      public TTrigger Trigger => this._underlyingTrigger;

      public void ValidateParameters(object[] args)
      {
        if (args == null)
          throw new ArgumentNullException(nameof (args));
        ParameterConversion.Validate(args, this._argumentTypes);
      }
    }

    public class TriggerWithParameters<TArg0> : StateMachine<TState, TTrigger>.TriggerWithParameters
    {
      public TriggerWithParameters(TTrigger underlyingTrigger)
        : base(underlyingTrigger, typeof (TArg0))
      {
      }
    }

    public class TriggerWithParameters<TArg0, TArg1> : 
      StateMachine<TState, TTrigger>.TriggerWithParameters
    {
      public TriggerWithParameters(TTrigger underlyingTrigger)
        : base(underlyingTrigger, typeof (TArg0), typeof (TArg1))
      {
      }
    }

    public class TriggerWithParameters<TArg0, TArg1, TArg2> : 
      StateMachine<TState, TTrigger>.TriggerWithParameters
    {
      public TriggerWithParameters(TTrigger underlyingTrigger)
        : base(underlyingTrigger, typeof (TArg0), typeof (TArg1), typeof (TArg2))
      {
      }
    }

    private abstract class UnhandledTriggerAction
    {
      public abstract void Execute(TState state, TTrigger trigger, ICollection<string> unmetGuards);

      public abstract Task ExecuteAsync(
        TState state,
        TTrigger trigger,
        ICollection<string> unmetGuards);

      internal class Sync : StateMachine<TState, TTrigger>.UnhandledTriggerAction
      {
        private readonly Action<TState, TTrigger, ICollection<string>> _action;

        internal Sync(
          Action<TState, TTrigger, ICollection<string>> action = null)
        {
          this._action = action;
        }

        public override void Execute(
          TState state,
          TTrigger trigger,
          ICollection<string> unmetGuards)
        {
          this._action(state, trigger, unmetGuards);
        }

        public override Task ExecuteAsync(
          TState state,
          TTrigger trigger,
          ICollection<string> unmetGuards)
        {
          this.Execute(state, trigger, unmetGuards);
          return TaskResult.Done;
        }
      }

      internal class Async : StateMachine<TState, TTrigger>.UnhandledTriggerAction
      {
        private readonly Func<TState, TTrigger, ICollection<string>, Task> _action;

        internal Async(
          Func<TState, TTrigger, ICollection<string>, Task> action)
        {
          this._action = action;
        }

        public override void Execute(
          TState state,
          TTrigger trigger,
          ICollection<string> unmetGuards)
        {
          throw new InvalidOperationException("Cannot execute asynchronous action specified in OnUnhandledTrigger. Use asynchronous version of Fire [FireAsync]");
        }

        public override Task ExecuteAsync(
          TState state,
          TTrigger trigger,
          ICollection<string> unmetGuards)
        {
          return this._action(state, trigger, unmetGuards);
        }
      }
    }
  }
}
