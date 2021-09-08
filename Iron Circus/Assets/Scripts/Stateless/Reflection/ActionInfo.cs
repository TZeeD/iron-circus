// Decompiled with JetBrains decompiler
// Type: Stateless.Reflection.ActionInfo
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

namespace Stateless.Reflection
{
  public class ActionInfo
  {
    public InvocationInfo Method { get; internal set; }

    public string FromTrigger { get; internal set; }

    internal static ActionInfo Create<TState, TTrigger>(
      StateMachine<TState, TTrigger>.EntryActionBehavior entryAction)
    {
      return entryAction is StateMachine<TState, TTrigger>.EntryActionBehavior.SyncFrom<TTrigger> syncFrom ? new ActionInfo(entryAction.Description, syncFrom.Trigger.ToString()) : new ActionInfo(entryAction.Description, (string) null);
    }

    public ActionInfo(InvocationInfo method, string fromTrigger)
    {
      this.Method = method;
      this.FromTrigger = fromTrigger;
    }
  }
}
