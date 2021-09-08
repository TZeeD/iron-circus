// Decompiled with JetBrains decompiler
// Type: Stateless.Graph.UmlDotGraph
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using Stateless.Reflection;

namespace Stateless.Graph
{
  public static class UmlDotGraph
  {
    public static string Format(StateMachineInfo machineInfo) => new StateGraph(machineInfo).ToGraph((IGraphStyle) new UmlDotGraphStyle());
  }
}
