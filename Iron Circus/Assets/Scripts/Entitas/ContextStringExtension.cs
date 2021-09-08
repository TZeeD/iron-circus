// Decompiled with JetBrains decompiler
// Type: Entitas.ContextStringExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public static class ContextStringExtension
  {
    private const string CONTEXT_SUFFIX = "Context";

    public static string AddContextSuffix(this string str) => !str.EndsWith("Context", StringComparison.Ordinal) ? str + "Context" : str;

    public static string RemoveContextSuffix(this string str) => !str.EndsWith("Context", StringComparison.Ordinal) ? str : str.Substring(0, str.Length - "Context".Length);
  }
}
