// Decompiled with JetBrains decompiler
// Type: Entitas.EntityIsNotDestroyedException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public class EntityIsNotDestroyedException : EntitasException
  {
    public EntityIsNotDestroyedException(string message)
      : base(message + "\nEntity is not destroyed yet!", "Did you manually call entity.Release(context) yourself? If so, please don't :)")
    {
    }
  }
}
