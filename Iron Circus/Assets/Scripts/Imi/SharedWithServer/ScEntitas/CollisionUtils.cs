// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.CollisionUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.Dynamics;
using Jitter.LinearMath;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.ScEntitas
{
  public static class CollisionUtils
  {
    private static List<JCollision> CollisionListReference;

    public static List<JCollision> GetCollisionsForRigidbody(
      GameContext gameContext,
      JRigidbody jRigidbody)
    {
      List<JCollision> jcollisionList = new List<JCollision>();
      foreach (JCollision collision in gameContext.collisionEvents.collisions)
      {
        if (collision.body1 != null && collision.body2 != null)
        {
          if (collision.body1 == jRigidbody)
            jcollisionList.Add(collision);
          else if (collision.body2 == jRigidbody)
          {
            JCollision jcollision1 = collision;
            JCollision jcollision2 = new JCollision(jcollision1.entity2, jcollision1.entity1, jcollision1.body2, jcollision1.body1, jcollision1.point2, jcollision1.point1, jcollision1.normal * -1f, jcollision1.penetration);
            jcollisionList.Add(jcollision2);
          }
        }
      }
      return jcollisionList;
    }

    public static List<JCollision> GetTriggerEnterForRigidbody(
      GameContext gameContext,
      JRigidbody jRigidbody)
    {
      List<JCollision> jcollisionList = new List<JCollision>();
      foreach (JCollision jcollision in gameContext.collisionEvents.triggerEnter)
      {
        if (jcollision.body1 != null && jcollision.body2 != null)
        {
          if (jcollision.body1 == jRigidbody)
            jcollisionList.Add(jcollision);
          else if (jcollision.body2 == jRigidbody)
            jcollisionList.Add(new JCollision()
            {
              entity1 = jcollision.entity2,
              entity2 = jcollision.entity1,
              body1 = jcollision.body2,
              body2 = jcollision.body1,
              point1 = jcollision.point2,
              point2 = jcollision.point1,
              normal = jcollision.normal,
              penetration = jcollision.penetration
            });
        }
      }
      return jcollisionList;
    }

    public static void CreateCollisionEvent(
      GameContext gameContext,
      GameEntity entity1,
      GameEntity entity2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      CollisionUtils.CreateCollisionEvent(gameContext, new JCollision(entity1, entity2, entity1.rigidbody.value, entity2.rigidbody.value, point1, point2, normal, penetration));
    }

    public static void CreateCollisionEvent(
      GameContext gameContext,
      JRigidbody body1,
      JRigidbody body2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      GameEntity entityWithRigidbody1 = gameContext.GetFirstEntityWithRigidbody(body1);
      GameEntity entityWithRigidbody2 = gameContext.GetFirstEntityWithRigidbody(body2);
      CollisionUtils.CreateCollisionEvent(gameContext, new JCollision(entityWithRigidbody1, entityWithRigidbody2, body1, body2, point1, point2, normal, penetration));
    }

    public static void CreateTriggerEvent(
      GameContext gameContext,
      JRigidbody body1,
      JRigidbody body2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      if (!body1.IsTrigger && !body2.IsTrigger)
        return;
      JTriggerPair jtriggerPair = new JTriggerPair(body1, body2);
      JTriggerPair bodies1 = new JTriggerPair(body2, body1);
      HashSet<GameEntity> gameEntitySet = new HashSet<GameEntity>((IEnumerable<GameEntity>) gameContext.GetEntitiesWithTriggerEvent(jtriggerPair));
      gameEntitySet.UnionWith((IEnumerable<GameEntity>) gameContext.GetEntitiesWithTriggerEvent(bodies1));
      int currentTick = gameContext.globalTime.currentTick;
      if (gameEntitySet.Count != 0)
      {
        GameEntity gameEntity = (GameEntity) null;
        HashSet<GameEntity>.Enumerator enumerator = gameEntitySet.GetEnumerator();
        if (enumerator.MoveNext())
          gameEntity = enumerator.Current;
        JTriggerPair bodies2 = gameEntity.triggerEvent.bodies;
        int firstCollisionFrame = gameEntity.triggerEvent.firstCollisionFrame;
        gameEntity.ReplaceTriggerEvent(bodies2, firstCollisionFrame, currentTick);
        CollisionUtils.CreateTriggerStayEvent(gameContext, body1, body2, point1, point2, normal, penetration);
      }
      else
      {
        gameContext.CreateEntity().AddTriggerEvent(jtriggerPair, currentTick, currentTick);
        CollisionUtils.CreateTriggerEnterEvent(gameContext, body1, body2, point1, point2, normal, penetration);
      }
    }

    public static void CreateTriggerEnterEvent(
      GameContext gameContext,
      JRigidbody body1,
      JRigidbody body2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      JCollision collision = new JCollision(gameContext.GetFirstEntityWithRigidbody(body1), gameContext.GetFirstEntityWithRigidbody(body2), body1, body2, point1, point2, normal, penetration);
      CollisionUtils.CreateTriggerEnterEvent(gameContext, collision);
    }

    public static void CreateTriggerStayEvent(
      GameContext gameContext,
      JRigidbody body1,
      JRigidbody body2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      JCollision collision = new JCollision(gameContext.GetFirstEntityWithRigidbody(body1), gameContext.GetFirstEntityWithRigidbody(body2), body1, body2, point1, point2, normal, penetration);
      CollisionUtils.CreateTriggerStayEvent(gameContext, collision);
    }

    [MethodImpl((MethodImplOptions) 256)]
    public static void CreateTriggerEnterEvent(GameContext gameContext, JCollision collision) => gameContext.deferredCollisionEvents.triggerEnter.Add(collision);

    [MethodImpl((MethodImplOptions) 256)]
    public static void CreateTriggerStayEvent(GameContext gameContext, JCollision collision) => gameContext.deferredCollisionEvents.triggerStay.Add(collision);

    [MethodImpl((MethodImplOptions) 256)]
    public static void CreateCollisionEvent(GameContext gameContext, JCollision collision) => gameContext.deferredCollisionEvents.collisions.Add(collision);

    public static void SetDeferredCollisionsActive(GameContext gameContext)
    {
      CollisionUtils.CollisionListReference = gameContext.collisionEvents.collisions;
      CollisionUtils.CollisionListReference.Clear();
      gameContext.collisionEvents.collisions = gameContext.deferredCollisionEvents.collisions;
      gameContext.deferredCollisionEvents.collisions = CollisionUtils.CollisionListReference;
      CollisionUtils.CollisionListReference = gameContext.collisionEvents.triggerEnter;
      CollisionUtils.CollisionListReference.Clear();
      gameContext.collisionEvents.triggerEnter = gameContext.deferredCollisionEvents.triggerEnter;
      gameContext.deferredCollisionEvents.triggerEnter = CollisionUtils.CollisionListReference;
      CollisionUtils.CollisionListReference = gameContext.collisionEvents.triggerStay;
      CollisionUtils.CollisionListReference.Clear();
      gameContext.collisionEvents.triggerStay = gameContext.deferredCollisionEvents.triggerStay;
      gameContext.deferredCollisionEvents.triggerStay = CollisionUtils.CollisionListReference;
      CollisionUtils.CollisionListReference = (List<JCollision>) null;
    }
  }
}
