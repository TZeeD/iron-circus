// Decompiled with JetBrains decompiler
// Type: Entitas.ContextStillHasRetainedEntitiesException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;
using System.Collections.Generic;
using System.Linq;

namespace Entitas
{
  public class ContextStillHasRetainedEntitiesException : EntitasException
  {
    public ContextStillHasRetainedEntitiesException(IContext context, IEntity[] entities)
      : base("'" + (object) context + "' detected retained entities although all entities got destroyed!", "Did you release all entities? Try calling systems.ClearReactiveSystems()before calling context.DestroyAllEntities() to avoid memory leaks.\n" + string.Join("\n", ((IEnumerable<IEntity>) entities).Select<IEntity, string>((Func<IEntity, string>) (e => e.aerc is SafeAERC aerc ? e.ToString() + " - " + string.Join(", ", aerc.owners.Select<object, string>((Func<object, string>) (o => o.ToString())).ToArray<string>()) : e.ToString())).ToArray<string>()))
    {
    }
  }
}
