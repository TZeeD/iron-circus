// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEntitas.Systems.Gameplay.ContinuousPhysicsUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.Collision;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class ContinuousPhysicsUtils
  {
    private const int MaxBounces = 10;
    private static List<JRigidbody> ignoreList = new List<JRigidbody>();
    private static List<CollisionSystem.SphereOverlapResult> overlaps = new List<CollisionSystem.SphereOverlapResult>();
    private static List<JVector> depenetrationNormals = new List<JVector>();

    public static SphereCastResult SphereCast(
      GameContext gameContext,
      JVector origin,
      JVector direction,
      float length,
      float castRadius,
      int collisionLayer,
      int collisionMask = 2147483647,
      Func<JRigidbody, bool> rigidbodyFilter = null,
      CollisionCallback collisionCallback = null,
      JRigidbody[] ignore = null)
    {
      ContinuousPhysicsUtils.ignoreList.Clear();
      if (ignore != null)
        ContinuousPhysicsUtils.ignoreList.AddRange((IEnumerable<JRigidbody>) ignore);
      CollisionSystem collisionSystem = gameContext.gamePhysics.world.CollisionSystem;
      SphereCastResult sphereCastResult = new SphereCastResult();
      float num1 = length;
      sphereCastResult.contactPosition = origin;
      sphereCastResult.contactPoint = origin;
      sphereCastResult.normal = JVector.Zero;
      sphereCastResult.collisionFraction = 1f;
      JRigidbody jrigidbody = (JRigidbody) null;
      JVector jvector1 = JVector.Zero;
      float num2 = 0.005f;
      int num3 = 10;
      JVector jvector2 = origin;
      bool flag1 = false;
      float num4 = 0.0f;
      ContinuousPhysicsUtils.depenetrationNormals.Clear();
      for (int index = 0; index < num3; ++index)
      {
        JVector position = origin;
        float num5 = num2;
        collisionSystem.SphereOverlapAll(position, castRadius + num5, ref ContinuousPhysicsUtils.overlaps, collisionLayer, collisionMask, new RaycastCallback(ContinuousPhysicsUtils.CollisionFilter), rigidbodyFilter);
        if (ContinuousPhysicsUtils.overlaps.Count > 0)
        {
          bool flag2 = false;
          foreach (CollisionSystem.SphereOverlapResult overlap in ContinuousPhysicsUtils.overlaps)
          {
            flag2 = true;
            if (index == 0)
            {
              flag1 = true;
              ContinuousPhysicsUtils.depenetrationNormals.Add(overlap.normal);
              if (jrigidbody == null)
              {
                jrigidbody = ContinuousPhysicsUtils.overlaps[0].hitBody;
                jvector1 = ContinuousPhysicsUtils.overlaps[0].point1;
              }
            }
            JVector normal = overlap.normal;
            normal.Y = 0.0f;
            float penetration = overlap.penetration;
            num4 += penetration;
            float num6 = penetration + num5;
            origin += normal * num6;
            if (collisionCallback != null)
              collisionCallback(overlap.hitBody, overlap.point1, overlap.point2, overlap.normal, overlap.penetration);
          }
          if (!flag2)
            break;
        }
        else
          break;
      }
      if (flag1)
      {
        float num7 = (origin - jvector2).Length();
        if ((double) length < (double) num7)
        {
          length = 0.0f;
          sphereCastResult.collisionFraction = 0.0f;
        }
        else
        {
          sphereCastResult.collisionFraction = num7 / num1;
          length -= num7;
        }
        JVector zero = JVector.Zero;
        for (int index = 0; index < ContinuousPhysicsUtils.depenetrationNormals.Count; ++index)
          zero += ContinuousPhysicsUtils.depenetrationNormals[index];
        zero.Y = 0.0f;
        zero.Normalize();
        sphereCastResult.normal = zero;
        if ((double) JVector.Dot(zero, direction) < 0.0)
        {
          direction = direction.Reflect(zero);
          sphereCastResult.collided = true;
          sphereCastResult.reflectedDirection = direction;
          sphereCastResult.reflectedLength = length;
          sphereCastResult.contactPosition = origin;
          sphereCastResult.contactPoint = jvector1;
          sphereCastResult.resultPosition = sphereCastResult.contactPosition + sphereCastResult.reflectedDirection * sphereCastResult.reflectedLength;
          sphereCastResult.collRb = jrigidbody;
          sphereCastResult.penetration = num4;
          return sphereCastResult;
        }
      }
      sphereCastResult.reflectedDirection = direction;
      sphereCastResult.reflectedLength = length;
      sphereCastResult.contactPosition = origin;
      sphereCastResult.resultPosition = origin + direction * length;
      JRigidbody body = (JRigidbody) null;
      JVector normal1;
      float fraction;
      if (collisionSystem.SphereCast(origin, direction * length, castRadius, out body, out normal1, out fraction, collisionMask, new RaycastCallback(ContinuousPhysicsUtils.CollisionFilter), rigidbodyFilter) && (double) fraction <= 1.0 && !normal1.IsNearlyZero())
      {
        normal1.Y = 0.0f;
        normal1.Normalize();
        JVector jvector3 = direction.Reflect(normal1);
        float num8 = length * (1f - fraction);
        JVector jvector4 = origin + direction * length * fraction;
        jvector4.Y = jvector3.Y = 0.0f;
        JVector jvector5 = jvector4 - normal1 * castRadius;
        sphereCastResult.collided = true;
        sphereCastResult.reflectedDirection = jvector3;
        sphereCastResult.reflectedLength = num8;
        sphereCastResult.normal = normal1;
        sphereCastResult.contactPosition = jvector4;
        sphereCastResult.contactPoint = jvector5;
        sphereCastResult.collisionFraction = fraction;
        sphereCastResult.resultPosition = sphereCastResult.contactPosition + sphereCastResult.reflectedDirection * sphereCastResult.reflectedLength;
        sphereCastResult.collRb = body;
        sphereCastResult.penetration = 0.0f;
        if (collisionCallback != null)
          collisionCallback(body, jvector5, jvector5, normal1, 0.0f);
      }
      return sphereCastResult;
    }

    public static bool CollisionFilter(JRigidbody body, JVector normal, float fraction) => !ContinuousPhysicsUtils.ignoreList.Contains(body);

    public static JVector GlideAgainstObjects(
      GameContext gameContext,
      GameEntity player,
      JVector currentDir,
      int collisionMask)
    {
      if (currentDir.IsNearlyZero())
        return currentDir;
      JVector jvector1 = currentDir;
      JVector vector2 = currentDir;
      vector2.Y = 0.0f;
      vector2.Normalize();
      CollisionSystem collisionSystem = gameContext.gamePhysics.world.CollisionSystem;
      JRigidbody jrigidbody1 = player.rigidbody.value;
      float radius = ((CylinderShape) jrigidbody1.Shape).Radius;
      JVector position = player.transform.position;
      JVector jvector2 = currentDir;
      JVector jvector3 = jvector2 + vector2 * radius;
      JVector rayOrigin = position;
      JVector rayDirection = jvector3;
      JRigidbody jrigidbody2;
      ref JRigidbody local1 = ref jrigidbody2;
      JVector vector1;
      ref JVector local2 = ref vector1;
      float num1;
      ref float local3 = ref num1;
      JRigidbody originRB = jrigidbody1;
      int collisionMask1 = collisionMask;
      if (collisionSystem.Raycast2D(rayOrigin, rayDirection, (RaycastCallback) null, out local1, out local2, out local3, originRB, collisionMask1))
      {
        vector1.Y = 0.0f;
        if (jrigidbody2.IsTrigger)
          return currentDir;
        if ((double) num1 <= 1.0 && !vector1.IsNearlyZero())
        {
          JVector jvector4 = jvector3 * num1 - vector2 * radius;
          JVector jvector5 = position + jvector4;
          double num2 = (double) jvector2.Length();
          float num3 = jvector4.Length();
          double num4 = (double) num3;
          if (num2 - num4 > 0.0)
          {
            vector1.Normalize();
            JVector jvector6 = JVector.Dot(vector1, vector2) * vector1;
            JVector jvector7 = vector2 - jvector6;
            if (jvector7.IsNearlyZero())
              return currentDir;
            jvector7.Normalize();
            JVector jvector8 = jvector7 * (currentDir.Length() - num3);
            JVector jvector9 = jvector5 + jvector8 - position;
            jvector9.Normalize();
            jvector9 *= currentDir.Length();
            jvector1 = jvector9;
          }
        }
      }
      return jvector1;
    }
  }
}
