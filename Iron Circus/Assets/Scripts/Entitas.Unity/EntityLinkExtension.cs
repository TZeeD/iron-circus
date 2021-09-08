// Decompiled with JetBrains decompiler
// Type: Entitas.Unity.EntityLinkExtension
// Assembly: Entitas.Unity, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: F2BCDAAE-92ED-418E-9A81-A1CC48630C6D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.Unity.dll

using UnityEngine;

namespace Entitas.Unity
{
  public static class EntityLinkExtension
  {
    public static EntityLink GetEntityLink(this GameObject gameObject) => gameObject.GetComponent<EntityLink>();

    public static EntityLink Link(
      this GameObject gameObject,
      IEntity entity,
      IContext context)
    {
      EntityLink entityLink = gameObject.GetEntityLink();
      if ((Object) entityLink == (Object) null)
        entityLink = gameObject.AddComponent<EntityLink>();
      entityLink.Link(entity, context);
      return entityLink;
    }

    public static void Unlink(this GameObject gameObject) => gameObject.GetEntityLink().Unlink();
  }
}
