﻿// Decompiled with JetBrains decompiler
// Type: Entitas.ContextDoesNotContainEntityException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public class ContextDoesNotContainEntityException : EntitasException
  {
    public ContextDoesNotContainEntityException(string message, string hint)
      : base(message + "\nContext does not contain entity!", hint)
    {
    }
  }
}
