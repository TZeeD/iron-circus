﻿// Decompiled with JetBrains decompiler
// Type: Stateless.Graph.Decision
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using Stateless.Reflection;

namespace Stateless.Graph
{
  internal class Decision : State
  {
    public InvocationInfo Method { get; private set; }

    internal Decision(InvocationInfo method, int num)
      : base(nameof (Decision) + num.ToString())
    {
      this.Method = method;
    }
  }
}
