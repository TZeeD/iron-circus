// Decompiled with JetBrains decompiler
// Type: Entitas.EntityIsAlreadyRetainedByOwnerException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public class EntityIsAlreadyRetainedByOwnerException : EntitasException
  {
    public EntityIsAlreadyRetainedByOwnerException(IEntity entity, object owner)
      : base("'" + owner + "' cannot retain " + (object) entity + "!\nEntity is already retained by this object!", "The entity must be released by this object first.")
    {
    }
  }
}
