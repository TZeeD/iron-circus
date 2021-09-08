// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.CollisionSystem
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Jitter.Collision
{
  public abstract class CollisionSystem
  {
    protected ThreadManager threadManager = ThreadManager.Instance;
    internal bool useTerrainNormal = true;
    internal bool useTriangleMeshNormal = true;
    protected readonly List<IBroadphaseEntity> bodyList = new List<IBroadphaseEntity>();
    private SphereShape sphere = new SphereShape(1f);
    private MinkowskiSumShape cashedMinkowskyShape = new MinkowskiSumShape();
    private SphereShape sphereOverlapShape;
    private JRigidbody sphereOverlapRb;
    private readonly ResourcePool<List<int>> potentialTriangleLists = new ResourcePool<List<int>>();

    public bool EnableSpeculativeContacts { get; set; }

    public bool UseTriangleMeshNormal
    {
      get => this.useTriangleMeshNormal;
      set => this.useTriangleMeshNormal = value;
    }

    public bool UseTerrainNormal
    {
      get => this.useTerrainNormal;
      set => this.useTerrainNormal = value;
    }

    public abstract bool RemoveEntity(IBroadphaseEntity body);

    public abstract void AddEntity(IBroadphaseEntity body);

    public event PassedBroadphaseHandler PassedBroadphase;

    public event CollisionDetectedHandler CollisionDetected;

    public CollisionSystem()
    {
      this.sphereOverlapShape = new SphereShape(1f);
      this.sphereOverlapRb = new JRigidbody((Shape) this.sphereOverlapShape);
    }

    public bool Raycast(
      JVector rayOrigin,
      JVector rayDirection,
      RaycastCallback raycast,
      out JRigidbody body,
      out JVector normal,
      out float fraction,
      JRigidbody originRb = null,
      int collisionMask = 2147483647)
    {
      return this.RaycastWithDelegate(new CollisionSystem.RaycastType(this.RaycastSingleBody), rayOrigin, rayDirection, raycast, out body, out normal, out fraction, originRb, collisionMask);
    }

    public bool SphereCast(
      JVector rayOrigin,
      JVector rayDirection,
      float radius,
      out JRigidbody body,
      out JVector normal,
      out float fraction,
      int collisionMask = 2147483647,
      RaycastCallback raycastCb = null,
      Func<JRigidbody, bool> rigidbodyFilter = null)
    {
      body = (JRigidbody) null;
      normal = JVector.Zero;
      fraction = float.MaxValue;
      bool flag = false;
      foreach (IBroadphaseEntity body1 in this.bodyList)
      {
        if ((body1.CollisionLayer & collisionMask) != 0 && body1 is JRigidbody)
        {
          JRigidbody body2 = body1 as JRigidbody;
          JVector normal1;
          float fraction1;
          if (this.SpherecastSingleBody(body2, rayOrigin, rayDirection, radius, out normal1, out fraction1) && (double) fraction1 < 1.0 && (double) fraction1 < (double) fraction && (raycastCb == null || raycastCb(body2, normal1, fraction1)) && (rigidbodyFilter == null || rigidbodyFilter(body2)))
          {
            body = body2;
            normal = normal1;
            fraction = fraction1;
            flag = true;
          }
        }
      }
      return flag;
    }

    public bool Raycast2D(
      JVector rayOrigin,
      JVector rayDirection,
      RaycastCallback raycast,
      out JRigidbody body,
      out JVector normal,
      out float fraction,
      JRigidbody originRB = null,
      int collisionMask = 2147483647)
    {
      return this.RaycastWithDelegate(new CollisionSystem.RaycastType(this.RaycastSingleBody2D), rayOrigin, rayDirection, raycast, out body, out normal, out fraction, originRB, collisionMask);
    }

    private bool RaycastWithDelegate(
      CollisionSystem.RaycastType raycastDelegate,
      JVector rayOrigin,
      JVector rayDirection,
      RaycastCallback raycastCB,
      out JRigidbody body,
      out JVector normal,
      out float fraction,
      JRigidbody originRB = null,
      int collisionMask = 2147483647)
    {
      body = (JRigidbody) null;
      normal = JVector.Zero;
      fraction = float.MaxValue;
      bool flag = false;
      JVector normal1;
      float fraction1;
      foreach (IBroadphaseEntity body1 in this.bodyList)
      {
        if (body1 != originRB && (body1.CollisionLayer & collisionMask) != 0)
        {
          if (body1 is SoftBody)
          {
            foreach (JRigidbody vertexBody in (body1 as SoftBody).VertexBodies)
            {
              if (raycastDelegate(vertexBody, rayOrigin, rayDirection, out normal1, out fraction1) && (double) fraction1 < (double) fraction && (raycastCB == null || raycastCB(vertexBody, normal1, fraction1)))
              {
                body = vertexBody;
                normal = normal1;
                fraction = fraction1;
                flag = true;
              }
            }
          }
          else
          {
            JRigidbody body2 = body1 as JRigidbody;
            if (raycastDelegate(body2, rayOrigin, rayDirection, out normal1, out fraction1) && (double) fraction1 < (double) fraction && (raycastCB == null || raycastCB(body2, normal1, fraction1)))
            {
              body = body2;
              normal = normal1;
              fraction = fraction1;
              flag = true;
            }
          }
        }
      }
      return flag;
    }

    public bool RaycastSingleBody(
      JRigidbody body,
      JVector rayOrigin,
      JVector rayDirection,
      out JVector normal,
      out float fraction,
      int collisionMask = 2147483647)
    {
      fraction = float.MaxValue;
      normal = JVector.Zero;
      if ((body.CollisionLayer & collisionMask) == 0 || !body.BoundingBox.RayIntersect(ref rayOrigin, ref rayDirection))
        return false;
      if (!(body.Shape is Multishape))
        return GJKCollide.Raycast((ISupportMappable) body.Shape, ref body.orientation, ref body.invOrientation, ref body.position, ref rayOrigin, ref rayDirection, out fraction, out normal);
      Multishape multishape = (body.Shape as Multishape).RequestWorkingClone();
      bool flag = false;
      JVector result1;
      JVector.Subtract(ref rayOrigin, ref body.position, out result1);
      JVector.Transform(ref result1, ref body.invOrientation, out result1);
      JVector result2;
      JVector.Transform(ref rayDirection, ref body.invOrientation, out result2);
      int num = multishape.Prepare(ref result1, ref result2);
      for (int index = 0; index < num; ++index)
      {
        multishape.SetCurrentShape(index);
        float fraction1;
        JVector position;
        if (GJKCollide.Raycast((ISupportMappable) multishape, ref body.orientation, ref body.invOrientation, ref body.position, ref rayOrigin, ref rayDirection, out fraction1, out position) && (double) fraction1 < (double) fraction)
        {
          if (this.useTerrainNormal && multishape is TerrainShape)
          {
            (multishape as TerrainShape).CollisionNormal(out position);
            JVector.Transform(ref position, ref body.orientation, out position);
            position.Negate();
          }
          else if (this.useTriangleMeshNormal && multishape is TriangleMeshShape)
          {
            (multishape as TriangleMeshShape).CollisionNormal(out position);
            JVector.Transform(ref position, ref body.orientation, out position);
            position.Negate();
          }
          normal = position;
          fraction = fraction1;
          flag = true;
        }
      }
      multishape.ReturnWorkingClone();
      return flag;
    }

    public bool SpherecastSingleBody(
      JRigidbody body,
      JVector rayOrigin,
      JVector rayDirection,
      float radius,
      out JVector normal,
      out float fraction,
      int collisionMask = 2147483647)
    {
      fraction = float.MaxValue;
      normal = JVector.Zero;
      if ((body.CollisionLayer & collisionMask) == 0 || body.Shape is Multishape)
        return false;
      this.sphere.Radius = radius;
      this.cashedMinkowskyShape.AddShape((Shape) this.sphere, true);
      this.cashedMinkowskyShape.AddShape(body.Shape, true);
      int num = GJKCollide.Raycast((ISupportMappable) this.cashedMinkowskyShape, ref body.orientation, ref body.invOrientation, ref body.position, ref rayOrigin, ref rayDirection, out fraction, out normal) ? 1 : 0;
      this.cashedMinkowskyShape.ClearShapes();
      return num != 0;
    }

    public bool RaycastSingleBody2D(
      JRigidbody body,
      JVector rayOrigin,
      JVector rayDirection,
      out JVector normal,
      out float fraction,
      int collisionMask = 2147483647)
    {
      fraction = float.MaxValue;
      normal = JVector.Zero;
      if ((body.CollisionLayer & collisionMask) == 0 || !body.BoundingBox.RayIntersect(ref rayOrigin, ref rayDirection))
        return false;
      if (body.Shape is Multishape)
      {
        Multishape multishape = (body.Shape as Multishape).RequestWorkingClone();
        bool flag = false;
        JVector result1;
        JVector.Subtract(ref rayOrigin, ref body.position, out result1);
        JVector.Transform(ref result1, ref body.invOrientation, out result1);
        JVector result2;
        JVector.Transform(ref rayDirection, ref body.invOrientation, out result2);
        int num = multishape.Prepare(ref result1, ref result2);
        for (int index = 0; index < num; ++index)
        {
          multishape.SetCurrentShape(index);
          float fraction1;
          JVector position;
          if (GJKCollide.Raycast((ISupportMappable) multishape, ref body.orientation, ref body.invOrientation, ref body.position, ref rayOrigin, ref rayDirection, out fraction1, out position) && (double) fraction1 < (double) fraction)
          {
            if (this.useTerrainNormal && multishape is TerrainShape)
            {
              (multishape as TerrainShape).CollisionNormal(out position);
              JVector.Transform(ref position, ref body.orientation, out position);
              position.Negate();
            }
            else if (this.useTriangleMeshNormal && multishape is TriangleMeshShape)
            {
              (multishape as TriangleMeshShape).CollisionNormal(out position);
              JVector.Transform(ref position, ref body.orientation, out position);
              position.Negate();
            }
            normal = position;
            fraction = fraction1;
            flag = true;
          }
        }
        multishape.ReturnWorkingClone();
        return flag;
      }
      return body.Shape is ISupports2DRaycast ? ((ISupports2DRaycast) body.Shape).Raycast2D(ref body.orientation, ref body.invOrientation, ref body.position, ref rayOrigin, ref rayDirection, out fraction, out normal) : GJKCollide.Raycast((ISupportMappable) body.Shape, ref body.orientation, ref body.invOrientation, ref body.position, ref rayOrigin, ref rayDirection, out fraction, out normal);
    }

    public bool CheckCollisionMasks(IBroadphaseEntity entity1, IBroadphaseEntity entity2) => (entity1.CollisionLayer & entity2.CollisionMask) != 0 || (uint) (entity1.CollisionMask & entity2.CollisionLayer) > 0U;

    public bool CheckBothStaticOrInactive(IBroadphaseEntity entity1, IBroadphaseEntity entity2) => entity1.IsStaticOrInactive && entity2.IsStaticOrInactive;

    public bool CheckBoundingBoxes(IBroadphaseEntity entity1, IBroadphaseEntity entity2)
    {
      JBBox boundingBox1 = entity1.BoundingBox;
      JBBox boundingBox2 = entity2.BoundingBox;
      return (double) boundingBox1.Max.Z >= (double) boundingBox2.Min.Z && (double) boundingBox1.Min.Z <= (double) boundingBox2.Max.Z && (double) boundingBox1.Max.Y >= (double) boundingBox2.Min.Y && (double) boundingBox1.Min.Y <= (double) boundingBox2.Max.Y && (double) boundingBox1.Max.X >= (double) boundingBox2.Min.X && (double) boundingBox1.Min.X <= (double) boundingBox2.Max.X;
    }

    public bool RaisePassedBroadphase(IBroadphaseEntity entity1, IBroadphaseEntity entity2) => this.PassedBroadphase == null || this.PassedBroadphase(entity1, entity2);

    protected void RaiseCollisionDetected(
      JRigidbody body1,
      JRigidbody body2,
      ref JVector point1,
      ref JVector point2,
      ref JVector normal,
      float penetration)
    {
      if (this.CollisionDetected == null)
        return;
      this.CollisionDetected(body1, body2, point1, point2, normal, penetration);
    }

    public abstract void Detect(bool multiThreaded);

    public bool RigidbodyOverlap(
      JRigidbody body,
      out JRigidbody hitBody,
      out JVector point1,
      out JVector point2,
      out JVector normal,
      out float penetration)
    {
      hitBody = (JRigidbody) null;
      point1 = point2 = normal = JVector.Zero;
      penetration = 0.0f;
      for (int index = 0; index < this.bodyList.Count; ++index)
      {
        IBroadphaseEntity body1 = this.bodyList[index];
        if (body1 is JRigidbody)
        {
          JRigidbody body2 = body1 as JRigidbody;
          if (body2 != this.sphereOverlapRb && !this.CheckBothStaticOrInactive((IBroadphaseEntity) this.sphereOverlapRb, (IBroadphaseEntity) body2) && this.CheckCollisionMasks((IBroadphaseEntity) this.sphereOverlapRb, (IBroadphaseEntity) body2) && this.CheckBoundingBoxes((IBroadphaseEntity) this.sphereOverlapRb, (IBroadphaseEntity) body2) && this.RaisePassedBroadphase((IBroadphaseEntity) body2, (IBroadphaseEntity) this.sphereOverlapRb))
          {
            if (!this.DetectRigidRigid(this.sphereOverlapRb, body2, out point1, out point2, out normal, out penetration))
              return false;
            hitBody = body2;
            return true;
          }
        }
      }
      return false;
    }

    public bool SphereOverlap(
      JVector position,
      float radius,
      out JRigidbody hitBody,
      out JVector point1,
      out JVector point2,
      out JVector normal,
      out float penetration,
      int collisionLayer,
      int collisionMask)
    {
      this.sphereOverlapRb.Position = position;
      this.sphereOverlapRb.CollisionLayer = collisionLayer;
      this.sphereOverlapRb.CollisionMask = collisionMask;
      this.sphereOverlapShape.Radius = radius;
      hitBody = (JRigidbody) null;
      point1 = point2 = normal = JVector.Zero;
      penetration = 0.0f;
      for (int index = 0; index < this.bodyList.Count; ++index)
      {
        IBroadphaseEntity body = this.bodyList[index];
        if (body is JRigidbody)
        {
          JRigidbody body2 = body as JRigidbody;
          if (body2 != this.sphereOverlapRb && !this.CheckBothStaticOrInactive((IBroadphaseEntity) this.sphereOverlapRb, (IBroadphaseEntity) body2) && this.CheckCollisionMasks((IBroadphaseEntity) this.sphereOverlapRb, (IBroadphaseEntity) body2) && this.CheckBoundingBoxes((IBroadphaseEntity) this.sphereOverlapRb, (IBroadphaseEntity) body2) && this.RaisePassedBroadphase((IBroadphaseEntity) body2, (IBroadphaseEntity) this.sphereOverlapRb))
          {
            if (!this.DetectRigidRigid(this.sphereOverlapRb, body2, out point1, out point2, out normal, out penetration))
              return false;
            hitBody = body2;
            return true;
          }
        }
      }
      return false;
    }

    public int SphereOverlapAll(
      JVector position,
      float radius,
      ref List<CollisionSystem.SphereOverlapResult> collisions,
      int collisionLayer,
      int collisionMask,
      RaycastCallback raycastCb = null,
      Func<JRigidbody, bool> rigidbodyFilter = null)
    {
      collisions.Clear();
      this.sphereOverlapRb.Position = position;
      this.sphereOverlapRb.CollisionLayer = collisionLayer;
      this.sphereOverlapRb.CollisionMask = collisionMask;
      this.sphereOverlapShape.Radius = radius;
      for (int index = 0; index < this.bodyList.Count; ++index)
      {
        IBroadphaseEntity body = this.bodyList[index];
        if (body is JRigidbody)
        {
          JRigidbody jrigidbody = body as JRigidbody;
          JVector point1;
          JVector point2;
          JVector normal;
          float penetration;
          if (jrigidbody != this.sphereOverlapRb && !this.CheckBothStaticOrInactive((IBroadphaseEntity) this.sphereOverlapRb, (IBroadphaseEntity) jrigidbody) && (jrigidbody.collisionLayer & collisionMask) != 0 && this.CheckBoundingBoxes((IBroadphaseEntity) this.sphereOverlapRb, (IBroadphaseEntity) jrigidbody) && this.RaisePassedBroadphase((IBroadphaseEntity) jrigidbody, (IBroadphaseEntity) this.sphereOverlapRb) && this.DetectRigidRigid(this.sphereOverlapRb, jrigidbody, out point1, out point2, out normal, out penetration) && (raycastCb == null || raycastCb(jrigidbody, normal, penetration)) && (rigidbodyFilter == null || rigidbodyFilter(jrigidbody)))
            collisions.Add(new CollisionSystem.SphereOverlapResult()
            {
              point1 = point1,
              point2 = point2,
              hitBody = jrigidbody,
              normal = normal,
              penetration = penetration
            });
        }
      }
      return collisions.Count;
    }

    public virtual void Detect(IBroadphaseEntity entity1, IBroadphaseEntity entity2)
    {
      JRigidbody jrigidbody1 = entity1 as JRigidbody;
      JRigidbody jrigidbody2 = entity2 as JRigidbody;
      if (jrigidbody1 != null)
      {
        if (jrigidbody2 != null)
        {
          this.DetectRigidRigid(jrigidbody1, jrigidbody2);
        }
        else
        {
          if (!(entity2 is SoftBody softBody4))
            return;
          this.DetectSoftRigid(jrigidbody1, softBody4);
        }
      }
      else
      {
        SoftBody softBody3 = entity1 as SoftBody;
        if (jrigidbody2 != null)
        {
          if (softBody3 == null)
            return;
          this.DetectSoftRigid(jrigidbody2, softBody3);
        }
        else
        {
          SoftBody body2 = entity2 as SoftBody;
          if (softBody3 == null || body2 == null)
            return;
          this.DetectSoftSoft(softBody3, body2);
        }
      }
    }

    private void DetectSoftSoft(SoftBody body1, SoftBody body2)
    {
      List<int> my = this.potentialTriangleLists.GetNew();
      List<int> other = this.potentialTriangleLists.GetNew();
      body1.dynamicTree.Query(other, my, body2.dynamicTree);
      for (int index = 0; index < other.Count; ++index)
      {
        JVector point;
        JVector normal;
        float penetration;
        if (XenoCollide.Detect((ISupportMappable) body1.dynamicTree.GetUserData(my[index]), (ISupportMappable) body2.dynamicTree.GetUserData(other[index]), ref JMatrix.InternalIdentity, ref JMatrix.InternalIdentity, ref JVector.InternalZero, ref JVector.InternalZero, out point, out normal, out penetration))
        {
          int nearestTrianglePoint1 = CollisionSystem.FindNearestTrianglePoint(body1, my[index], ref point);
          int nearestTrianglePoint2 = CollisionSystem.FindNearestTrianglePoint(body2, other[index], ref point);
          this.RaiseCollisionDetected((JRigidbody) body1.VertexBodies[nearestTrianglePoint1], (JRigidbody) body2.VertexBodies[nearestTrianglePoint2], ref point, ref point, ref normal, penetration);
        }
      }
      my.Clear();
      other.Clear();
      this.potentialTriangleLists.GiveBack(my);
      this.potentialTriangleLists.GiveBack(other);
    }

    private bool DetectRigidRigid(
      JRigidbody body1,
      JRigidbody body2,
      out JVector point1,
      out JVector point2,
      out JVector normal,
      out float penetration)
    {
      JVector point = point1 = point2 = normal = JVector.Zero;
      penetration = 0.0f;
      if (body1.Shape is Multishape | body2.Shape is Multishape || !XenoCollide.Detect((ISupportMappable) body1.Shape, (ISupportMappable) body2.Shape, ref body1.orientation, ref body2.orientation, ref body1.position, ref body2.position, out point, out normal, out penetration))
        return false;
      this.FindSupportPoints(body1, body2, body1.Shape, body2.Shape, ref point, ref normal, out point1, out point2);
      return true;
    }

    private void DetectRigidRigid(JRigidbody body1, JRigidbody body2)
    {
      bool flag1 = body1.Shape is Multishape;
      bool flag2 = body2.Shape is Multishape;
      bool flag3 = this.EnableSpeculativeContacts || body1.EnableSpeculativeContacts || body2.EnableSpeculativeContacts;
      if (!flag1 && !flag2)
      {
        JVector point;
        JVector normal;
        float penetration;
        if (XenoCollide.Detect((ISupportMappable) body1.Shape, (ISupportMappable) body2.Shape, ref body1.orientation, ref body2.orientation, ref body1.position, ref body2.position, out point, out normal, out penetration))
        {
          JVector point1;
          JVector point2;
          this.FindSupportPoints(body1, body2, body1.Shape, body2.Shape, ref point, ref normal, out point1, out point2);
          this.RaiseCollisionDetected(body1, body2, ref point1, ref point2, ref normal, penetration);
        }
        else
        {
          JVector p1;
          JVector p2;
          if (!flag3 || !GJKCollide.ClosestPoints((ISupportMappable) body1.Shape, (ISupportMappable) body2.Shape, ref body1.orientation, ref body2.orientation, ref body1.position, ref body2.position, out p1, out p2, out normal))
            return;
          JVector jvector = p2 - p1;
          if ((double) jvector.LengthSquared() >= (double) (body1.sweptDirection - body2.sweptDirection).LengthSquared())
            return;
          penetration = jvector * normal;
          if ((double) penetration >= 0.0)
            return;
          this.RaiseCollisionDetected(body1, body2, ref p1, ref p2, ref normal, penetration);
        }
      }
      else if (flag1 & flag2)
      {
        Multishape shape1 = body1.Shape as Multishape;
        Multishape shape2 = body2.Shape as Multishape;
        Multishape multishape1 = shape1.RequestWorkingClone();
        Multishape multishape2 = shape2.RequestWorkingClone();
        JBBox boundingBox = body2.boundingBox;
        boundingBox.InverseTransform(ref body1.position, ref body1.orientation);
        int num1 = multishape1.Prepare(ref boundingBox);
        boundingBox = body1.boundingBox;
        boundingBox.InverseTransform(ref body2.position, ref body2.orientation);
        int num2 = multishape2.Prepare(ref boundingBox);
        if (num1 == 0 || num2 == 0)
        {
          multishape1.ReturnWorkingClone();
          multishape2.ReturnWorkingClone();
        }
        else
        {
          for (int index1 = 0; index1 < num1; ++index1)
          {
            multishape1.SetCurrentShape(index1);
            for (int index2 = 0; index2 < num2; ++index2)
            {
              multishape2.SetCurrentShape(index2);
              JVector point;
              JVector normal;
              float penetration;
              if (XenoCollide.Detect((ISupportMappable) multishape1, (ISupportMappable) multishape2, ref body1.orientation, ref body2.orientation, ref body1.position, ref body2.position, out point, out normal, out penetration))
              {
                JVector point1;
                JVector point2;
                this.FindSupportPoints(body1, body2, (Shape) multishape1, (Shape) multishape2, ref point, ref normal, out point1, out point2);
                this.RaiseCollisionDetected(body1, body2, ref point1, ref point2, ref normal, penetration);
              }
              else
              {
                JVector p1;
                JVector p2;
                if (flag3 && GJKCollide.ClosestPoints((ISupportMappable) multishape1, (ISupportMappable) multishape2, ref body1.orientation, ref body2.orientation, ref body1.position, ref body2.position, out p1, out p2, out normal))
                {
                  JVector jvector = p2 - p1;
                  if ((double) jvector.LengthSquared() < (double) (body1.sweptDirection - body2.sweptDirection).LengthSquared())
                  {
                    penetration = jvector * normal;
                    if ((double) penetration < 0.0)
                      this.RaiseCollisionDetected(body1, body2, ref p1, ref p2, ref normal, penetration);
                  }
                }
              }
            }
          }
          multishape1.ReturnWorkingClone();
          multishape2.ReturnWorkingClone();
        }
      }
      else
      {
        JRigidbody body1_1;
        JRigidbody body2_1;
        if (body2.Shape is Multishape)
        {
          body1_1 = body2;
          body2_1 = body1;
        }
        else
        {
          body2_1 = body2;
          body1_1 = body1;
        }
        Multishape multishape = (body1_1.Shape as Multishape).RequestWorkingClone();
        JBBox boundingBox = body2_1.boundingBox;
        boundingBox.InverseTransform(ref body1_1.position, ref body1_1.orientation);
        int num = multishape.Prepare(ref boundingBox);
        if (num == 0)
        {
          multishape.ReturnWorkingClone();
        }
        else
        {
          for (int index = 0; index < num; ++index)
          {
            multishape.SetCurrentShape(index);
            JVector point;
            JVector jvector1;
            float penetration;
            if (XenoCollide.Detect((ISupportMappable) multishape, (ISupportMappable) body2_1.Shape, ref body1_1.orientation, ref body2_1.orientation, ref body1_1.position, ref body2_1.position, out point, out jvector1, out penetration))
            {
              JVector point1;
              JVector point2;
              this.FindSupportPoints(body1_1, body2_1, (Shape) multishape, body2_1.Shape, ref point, ref jvector1, out point1, out point2);
              if (this.useTerrainNormal && multishape is TerrainShape)
              {
                (multishape as TerrainShape).CollisionNormal(out jvector1);
                JVector.Transform(ref jvector1, ref body1_1.orientation, out jvector1);
              }
              else if (this.useTriangleMeshNormal && multishape is TriangleMeshShape)
              {
                (multishape as TriangleMeshShape).CollisionNormal(out jvector1);
                JVector.Transform(ref jvector1, ref body1_1.orientation, out jvector1);
              }
              this.RaiseCollisionDetected(body1_1, body2_1, ref point1, ref point2, ref jvector1, penetration);
            }
            else
            {
              JVector p1;
              JVector p2;
              if (flag3 && GJKCollide.ClosestPoints((ISupportMappable) multishape, (ISupportMappable) body2_1.Shape, ref body1_1.orientation, ref body2_1.orientation, ref body1_1.position, ref body2_1.position, out p1, out p2, out jvector1))
              {
                JVector jvector2 = p2 - p1;
                if ((double) jvector2.LengthSquared() < (double) (body1.sweptDirection - body2.sweptDirection).LengthSquared())
                {
                  penetration = jvector2 * jvector1;
                  if ((double) penetration < 0.0)
                    this.RaiseCollisionDetected(body1_1, body2_1, ref p1, ref p2, ref jvector1, penetration);
                }
              }
            }
          }
          multishape.ReturnWorkingClone();
        }
      }
    }

    private void DetectSoftRigid(JRigidbody rigidBody, SoftBody softBody)
    {
      if (rigidBody.Shape is Multishape)
      {
        Multishape multishape = (rigidBody.Shape as Multishape).RequestWorkingClone();
        JBBox boundingBox = softBody.BoundingBox;
        boundingBox.InverseTransform(ref rigidBody.position, ref rigidBody.orientation);
        int num1 = multishape.Prepare(ref boundingBox);
        List<int> my = this.potentialTriangleLists.GetNew();
        softBody.dynamicTree.Query(my, ref rigidBody.boundingBox);
        foreach (int num2 in my)
        {
          SoftBody.Triangle userData = softBody.dynamicTree.GetUserData(num2);
          for (int index = 0; index < num1; ++index)
          {
            multishape.SetCurrentShape(index);
            JVector point;
            JVector normal;
            float penetration;
            if (XenoCollide.Detect((ISupportMappable) multishape, (ISupportMappable) userData, ref rigidBody.orientation, ref JMatrix.InternalIdentity, ref rigidBody.position, ref JVector.InternalZero, out point, out normal, out penetration))
            {
              int nearestTrianglePoint = CollisionSystem.FindNearestTrianglePoint(softBody, num2, ref point);
              this.RaiseCollisionDetected(rigidBody, (JRigidbody) softBody.VertexBodies[nearestTrianglePoint], ref point, ref point, ref normal, penetration);
            }
          }
        }
        my.Clear();
        this.potentialTriangleLists.GiveBack(my);
        multishape.ReturnWorkingClone();
      }
      else
      {
        List<int> my = this.potentialTriangleLists.GetNew();
        softBody.dynamicTree.Query(my, ref rigidBody.boundingBox);
        foreach (int num in my)
        {
          SoftBody.Triangle userData = softBody.dynamicTree.GetUserData(num);
          JVector point;
          JVector normal;
          float penetration;
          if (XenoCollide.Detect((ISupportMappable) rigidBody.Shape, (ISupportMappable) userData, ref rigidBody.orientation, ref JMatrix.InternalIdentity, ref rigidBody.position, ref JVector.InternalZero, out point, out normal, out penetration))
          {
            int nearestTrianglePoint = CollisionSystem.FindNearestTrianglePoint(softBody, num, ref point);
            this.RaiseCollisionDetected(rigidBody, (JRigidbody) softBody.VertexBodies[nearestTrianglePoint], ref point, ref point, ref normal, penetration);
          }
        }
        my.Clear();
        this.potentialTriangleLists.GiveBack(my);
      }
    }

    public static int FindNearestTrianglePoint(SoftBody sb, int id, ref JVector point)
    {
      SoftBody.Triangle userData = sb.dynamicTree.GetUserData(id);
      JVector result1 = sb.VertexBodies[userData.indices.I0].position;
      JVector.Subtract(ref result1, ref point, out result1);
      float num1 = result1.LengthSquared();
      JVector result2 = sb.VertexBodies[userData.indices.I1].position;
      JVector.Subtract(ref result2, ref point, out result2);
      float num2 = result2.LengthSquared();
      JVector result3 = sb.VertexBodies[userData.indices.I2].position;
      JVector.Subtract(ref result3, ref point, out result3);
      float num3 = result3.LengthSquared();
      return (double) num1 < (double) num2 ? ((double) num1 < (double) num3 ? userData.indices.I0 : userData.indices.I2) : ((double) num2 < (double) num3 ? userData.indices.I1 : userData.indices.I2);
    }

    private void FindSupportPoints(
      JRigidbody body1,
      JRigidbody body2,
      Shape shape1,
      Shape shape2,
      ref JVector point,
      ref JVector normal,
      out JVector point1,
      out JVector point2)
    {
      JVector result1;
      JVector.Negate(ref normal, out result1);
      JVector result2;
      this.SupportMapping(body1, shape1, ref result1, out result2);
      JVector result3;
      this.SupportMapping(body2, shape2, ref normal, out result3);
      JVector.Subtract(ref result2, ref point, out result2);
      JVector.Subtract(ref result3, ref point, out result3);
      float scaleFactor1 = JVector.Dot(ref result2, ref normal);
      float scaleFactor2 = JVector.Dot(ref result3, ref normal);
      JVector.Multiply(ref normal, scaleFactor1, out result2);
      JVector.Multiply(ref normal, scaleFactor2, out result3);
      JVector.Add(ref point, ref result2, out point1);
      JVector.Add(ref point, ref result3, out point2);
    }

    private void SupportMapping(
      JRigidbody body,
      Shape workingShape,
      ref JVector direction,
      out JVector result)
    {
      JVector.Transform(ref direction, ref body.invOrientation, out result);
      workingShape.SupportMapping(ref result, out result);
      JVector.Transform(ref result, ref body.orientation, out result);
      JVector.Add(ref result, ref body.position, out result);
    }

    private delegate bool RaycastType(
      JRigidbody body,
      JVector rayOrigin,
      JVector rayDirection,
      out JVector normal,
      out float fraction,
      int collisionMask = 2147483647);

    protected class BroadphasePair
    {
      public static ResourcePool<CollisionSystem.BroadphasePair> Pool = new ResourcePool<CollisionSystem.BroadphasePair>();
      public IBroadphaseEntity Entity1;
      public IBroadphaseEntity Entity2;
    }

    public struct SphereOverlapResult
    {
      public JRigidbody hitBody;
      public JVector point1;
      public JVector point2;
      public JVector normal;
      public float penetration;
    }
  }
}
