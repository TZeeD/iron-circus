// Decompiled with JetBrains decompiler
// Type: Entitas.SystemStringExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public static class SystemStringExtension
  {
    private const string COMPONENT_SUFFIX = "System";

    public static string AddSystemSuffix(this string str) => !str.EndsWith("System", StringComparison.Ordinal) ? str + "System" : str;

    public static string RemoveSystemSuffix(this string str) => !str.EndsWith("System", StringComparison.Ordinal) ? str : str.Substring(0, str.Length - "System".Length);
  }
}
