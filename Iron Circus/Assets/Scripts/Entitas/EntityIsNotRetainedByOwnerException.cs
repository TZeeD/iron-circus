// Decompiled with JetBrains decompiler
// Type: Entitas.EntityIsNotRetainedByOwnerException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public class EntityIsNotRetainedByOwnerException : EntitasException
  {
    public EntityIsNotRetainedByOwnerException(IEntity entity, object owner)
      : base("'" + owner + "' cannot release " + (object) entity + "!\nEntity is not retained by this object!", "An entity can only be released from objects that retain it.")
    {
    }
  }
}
