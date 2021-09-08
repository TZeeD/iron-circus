// Decompiled with JetBrains decompiler
// Type: Entitas.EntitasException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public class EntitasException : Exception
  {
    public EntitasException(string message, string hint)
      : base(hint != null ? message + "\n" + hint : message)
    {
    }
  }
}
