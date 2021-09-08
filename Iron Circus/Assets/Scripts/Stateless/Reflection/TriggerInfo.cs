// Decompiled with JetBrains decompiler
// Type: Stateless.Reflection.TriggerInfo
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

namespace Stateless.Reflection
{
  public class TriggerInfo
  {
    internal TriggerInfo(object underlyingTrigger) => this.UnderlyingTrigger = underlyingTrigger;

    public object UnderlyingTrigger { get; }

    public override string ToString() => this.UnderlyingTrigger?.ToString() ?? "<null>";
  }
}
