// Decompiled with JetBrains decompiler
// Type: Entitas.EntityStringExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public static class EntityStringExtension
  {
    private const string ENTITY_SUFFIX = "Entity";

    public static string AddEntitySuffix(this string str) => !str.EndsWith("Entity", StringComparison.Ordinal) ? str + "Entity" : str;

    public static string RemoveEntitySuffix(this string str) => !str.EndsWith("Entity", StringComparison.Ordinal) ? str : str.Substring(0, str.Length - "Entity".Length);
  }
}
