// Decompiled with JetBrains decompiler
// Type: Stateless.Reflection.IgnoredTransitionInfo
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System;
using System.Collections.Generic;
using System.Linq;

namespace Stateless.Reflection
{
  public class IgnoredTransitionInfo : TransitionInfo
  {
    internal static IgnoredTransitionInfo Create<TState, TTrigger>(
      StateMachine<TState, TTrigger>.IgnoredTriggerBehaviour behaviour)
    {
      IgnoredTransitionInfo ignoredTransitionInfo = new IgnoredTransitionInfo();
      ignoredTransitionInfo.Trigger = new TriggerInfo((object) behaviour.Trigger);
      ignoredTransitionInfo.GuardConditionsMethodDescriptions = behaviour.Guard == null ? (IEnumerable<InvocationInfo>) new List<InvocationInfo>() : behaviour.Guard.Conditions.Select<StateMachine<TState, TTrigger>.GuardCondition, InvocationInfo>((Func<StateMachine<TState, TTrigger>.GuardCondition, InvocationInfo>) (c => c.MethodDescription));
      return ignoredTransitionInfo;
    }

    private IgnoredTransitionInfo()
    {
    }
  }
}
