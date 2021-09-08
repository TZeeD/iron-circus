// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Utility.DestroyEntitySystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using SharedWithServer.ScEvents;
using UnityEngine;

namespace Imi.SharedWithServer.ScEntitas.Systems.Utility
{
  public class DestroyEntitySystem : GameSystem, ICleanupSystem, ISystem
  {
    protected readonly IGroup<GameEntity> destroyedEntities;
    protected Events events;

    public DestroyEntitySystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
      this.destroyedEntities = this.gameContext.GetGroup(GameMatcher.Destroyed);
    }

    public void Cleanup()
    {
      foreach (GameEntity entity in this.destroyedEntities.GetEntities())
      {
        this.CleanupInternal(entity);
        if (entity.hasUniqueId)
          this.events.FireEventDestroyEntity(entity.uniqueId.id.Value());
        if (entity.hasRigidbody)
          this.gameContext.gamePhysics.world.RemoveBody(entity.rigidbody.value);
        if (entity.hasUnityView)
        {
          GameObject gameObject = entity.unityView.gameObject;
          if ((Object) gameObject != (Object) null)
          {
            gameObject.Unlink();
            Object.DestroyImmediate((Object) gameObject);
          }
          entity.RemoveUnityView();
        }
        entity.Destroy();
      }
    }

    protected virtual void CleanupInternal(GameEntity entity)
    {
    }
  }
}
