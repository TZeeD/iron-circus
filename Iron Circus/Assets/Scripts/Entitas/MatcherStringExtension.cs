// Decompiled with JetBrains decompiler
// Type: Entitas.MatcherStringExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public static class MatcherStringExtension
  {
    private const string MATCHER_SUFFIX = "Matcher";

    public static string AddMatcherSuffix(this string str) => !str.EndsWith("Matcher", StringComparison.Ordinal) ? str + "Matcher" : str;

    public static string RemoveMatcherSuffix(this string str) => !str.EndsWith("Matcher", StringComparison.Ordinal) ? str : str.Substring(0, str.Length - "Matcher".Length);
  }
}
