// Decompiled with JetBrains decompiler
// Type: Entitas.MatcherException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public class MatcherException : Exception
  {
    public MatcherException(int indices)
      : base("matcher.indices.Length must be 1 but was " + (object) indices)
    {
    }
  }
}
