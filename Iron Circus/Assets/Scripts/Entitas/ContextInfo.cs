// Decompiled with JetBrains decompiler
// Type: Entitas.ContextInfo
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public class ContextInfo
  {
    public readonly string name;
    public readonly string[] componentNames;
    public readonly Type[] componentTypes;

    public ContextInfo(string name, string[] componentNames, Type[] componentTypes)
    {
      this.name = name;
      this.componentNames = componentNames;
      this.componentTypes = componentTypes;
    }
  }
}
