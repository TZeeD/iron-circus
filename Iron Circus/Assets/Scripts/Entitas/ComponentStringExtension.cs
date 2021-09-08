// Decompiled with JetBrains decompiler
// Type: Entitas.ComponentStringExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public static class ComponentStringExtension
  {
    private const string COMPONENT_SUFFIX = "Component";

    public static string AddComponentSuffix(this string str) => !str.EndsWith("Component", StringComparison.Ordinal) ? str + "Component" : str;

    public static string RemoveComponentSuffix(this string str) => !str.EndsWith("Component", StringComparison.Ordinal) ? str : str.Substring(0, str.Length - "Component".Length);
  }
}
