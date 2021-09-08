// Decompiled with JetBrains decompiler
// Type: Stateless.Reflection.DynamicStateInfo
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

namespace Stateless.Reflection
{
  public class DynamicStateInfo
  {
    public DynamicStateInfo(string destinationState, string criterion)
    {
      this.DestinationState = destinationState;
      this.Criterion = criterion;
    }

    public string DestinationState { get; set; }

    public string Criterion { get; set; }
  }
}
