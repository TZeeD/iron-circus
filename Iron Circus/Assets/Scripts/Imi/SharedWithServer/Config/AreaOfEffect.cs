// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.AreaOfEffect
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System;

namespace Imi.SharedWithServer.Config
{
  [Serializable]
  public struct AreaOfEffect
  {
    public AoeShape shape;
    public float radius;
    public float deadZone;
    public float angle;
    public float rectWidth;
    public float rectLength;
    public VfxPrefab vfxPrefab;

    public byte[] ToBytes()
    {
      byte[] numArray = new byte[24];
      BitConverter.GetBytes((int) this.shape).CopyTo((Array) numArray, 0);
      BitConverter.GetBytes((int) this.radius).CopyTo((Array) numArray, 4);
      BitConverter.GetBytes((int) this.deadZone).CopyTo((Array) numArray, 8);
      BitConverter.GetBytes((int) this.angle).CopyTo((Array) numArray, 12);
      BitConverter.GetBytes((int) this.rectWidth).CopyTo((Array) numArray, 16);
      BitConverter.GetBytes((int) this.rectLength).CopyTo((Array) numArray, 20);
      return numArray;
    }

    public int FromBytes(byte[] bytes, int startIdx)
    {
      this.shape = (AoeShape) BitConverter.ToInt32(bytes, startIdx);
      startIdx += 4;
      this.radius = BitConverter.ToSingle(bytes, startIdx);
      startIdx += 4;
      this.deadZone = BitConverter.ToSingle(bytes, startIdx);
      startIdx += 4;
      this.angle = BitConverter.ToSingle(bytes, startIdx);
      startIdx += 4;
      this.rectWidth = BitConverter.ToSingle(bytes, startIdx);
      startIdx += 4;
      this.rectLength = BitConverter.ToSingle(bytes, startIdx);
      startIdx += 4;
      return startIdx;
    }

    public void IfInRange(
      TransformComponent ownerTransform,
      GameEntity[] players,
      Action<GameEntity> onInRange,
      Func<GameEntity, bool> additionalCondition = null)
    {
      foreach (GameEntity player in players)
      {
        if ((additionalCondition == null || additionalCondition(player)) && this.IsInRange(ownerTransform.position, ownerTransform.Forward, player.transform.position, player.championConfig.value.colliderRadius) && onInRange != null)
          onInRange(player);
      }
    }

    public bool IsInRange2D(JVector position, JVector forward, JRigidbody target)
    {
      JVector position1 = target.Position;
      float colliderRadius = AreaOfEffect.GetColliderRadius(target);
      return this.IsInRange2D(position, forward, position1, colliderRadius);
    }

    public bool IsInRange2D(
      JVector position,
      JVector forward,
      JVector target,
      float targetColliderRadius)
    {
      position.Y = 0.0f;
      target.Y = 0.0f;
      forward.Y = 0.0f;
      forward = forward.Normalized();
      return this.IsInRange(position, forward, target, targetColliderRadius);
    }

    public bool IsInRange(
      JVector position,
      JVector forward,
      JVector target,
      float targetColliderRadius)
    {
      switch (this.shape)
      {
        case AoeShape.Circle:
          return this.CheckSphere(position, target, targetColliderRadius);
        case AoeShape.Cone:
          return this.CheckCone(position, forward, target, targetColliderRadius);
        case AoeShape.Rectangle:
          return this.CheckRect(position, forward, target, targetColliderRadius);
        default:
          throw new Exception("No shape defined for AreaOfEffect");
      }
    }

    private static float GetColliderRadius(JRigidbody target)
    {
      float num = 0.0f;
      if (target.Shape is SphereShape)
        num = (target.Shape as SphereShape).Radius;
      else if (target.Shape is CapsuleShape)
        num = (target.Shape as CapsuleShape).Radius;
      else if (target.Shape is CylinderShape)
        num = (target.Shape as CylinderShape).Radius;
      else
        Log.Error(string.Format("AreaOfEffect cannot handle colliders of type '{0}'. ", (object) target.Shape.GetType()) + "The Radius of the collider will be assumed to be '0'. The target will only be inside the AoE if it's position is inside.");
      return num;
    }

    public bool IsInRange2D(TransformComponent ownerTransform, JRigidbody target)
    {
      JVector position = target.Position;
      position.Y = 0.0f;
      float colliderRadius = AreaOfEffect.GetColliderRadius(target);
      return this.IsInRange(ownerTransform.Position2D, ownerTransform.Forward, position, colliderRadius);
    }

    private bool CheckSphere(JVector position, JVector target, float targetColliderRadius)
    {
      float num = (position - target).Length();
      return (double) num <= (double) this.radius + (double) targetColliderRadius && (double) num + (double) targetColliderRadius >= (double) this.deadZone;
    }

    private bool CheckCone(
      JVector position,
      JVector forward,
      JVector targetPosition,
      float targetColliderRadius)
    {
      JVector vector2_1 = targetPosition - position;
      float num1 = vector2_1.LengthSquared();
      float num2 = (float) (((double) this.radius + (double) targetColliderRadius) * ((double) this.radius + (double) targetColliderRadius));
      float num3 = (float) (((double) this.deadZone - (double) targetColliderRadius) * ((double) this.deadZone - (double) targetColliderRadius));
      if ((double) num1 < (double) num2 && (double) num1 > (double) num3)
      {
        float num4 = (float) ((double) this.angle * 0.5 * (Math.PI / 180.0));
        float num5 = (float) Math.Cos((double) num4);
        float num6 = vector2_1.Length();
        JVector vector2_2 = vector2_1 * (1f / num6);
        float num7 = JVector.Dot(forward, vector2_2);
        if ((double) num5 - (double) num7 <= 0.0)
          return true;
        float num8 = (float) Math.Sin((double) num4);
        JVector jvector1 = JVector.Cross(forward, vector2_2);
        JVector vector = JVector.Zero;
        vector = (double) jvector1.Y <= 0.0 ? new JVector((float) ((double) forward.X * (double) num5 - (double) forward.Z * (double) num8), 0.0f, (float) ((double) forward.X * (double) num8 + (double) forward.Z * (double) num5)) : new JVector((float) ((double) forward.X * (double) num5 + (double) forward.Z * (double) num8), 0.0f, (float) ((double) forward.X * -(double) num8 + (double) forward.Z * (double) num5));
        JVector jvector2 = vector.Normalized();
        if ((double) num1 > (double) this.radius * (double) this.radius)
        {
          JVector jvector3 = jvector2 * this.radius;
          if ((double) (targetPosition - jvector3).Length() > (double) targetColliderRadius)
            return false;
        }
        if ((double) num1 < (double) this.deadZone * (double) this.deadZone)
        {
          JVector jvector4 = jvector2 * this.deadZone;
          if ((double) (targetPosition - jvector4).Length() > (double) targetColliderRadius)
            return false;
        }
        if ((double) JVector.Cross(jvector2 * this.radius, vector2_1).Length() / (double) this.radius <= (double) targetColliderRadius)
          return true;
      }
      return false;
    }

    private bool CheckRect(
      JVector position,
      JVector forward,
      JVector targetPos,
      float targetColliderRadius)
    {
      JVector posToTarget = targetPos - position;
      float collisionThreshold1 = targetColliderRadius + this.rectLength / 2f;
      if (!AreaOfEffect.CheckAxis(posToTarget, forward, collisionThreshold1))
        return false;
      float collisionThreshold2 = targetColliderRadius + this.rectWidth / 2f;
      JVector axis = JVector.Cross(forward, JVector.Up);
      return AreaOfEffect.CheckAxis(posToTarget, axis, collisionThreshold2);
    }

    private static bool CheckAxis(JVector posToTarget, JVector axis, float collisionThreshold) => (double) Math.Abs(JVector.Dot(posToTarget, axis)) <= (double) collisionThreshold;
  }
}
