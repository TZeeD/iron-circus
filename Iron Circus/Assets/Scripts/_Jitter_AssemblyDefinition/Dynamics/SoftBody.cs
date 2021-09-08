// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.SoftBody
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Collision;
using Jitter.Collision.Shapes;
using Jitter.Dynamics.Constraints;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Jitter.Dynamics
{
  public class SoftBody : IBroadphaseEntity
  {
    private SphereShape sphere = new SphereShape(0.1f);
    protected List<SoftBody.Spring> springs = new List<SoftBody.Spring>();
    protected List<SoftBody.MassPoint> points = new List<SoftBody.MassPoint>();
    protected List<SoftBody.Triangle> triangles = new List<SoftBody.Triangle>();
    protected float triangleExpansion = 0.1f;
    private bool selfCollision;
    private float volume = 1f;
    private float mass = 1f;
    internal Jitter.Collision.DynamicTree<SoftBody.Triangle> dynamicTree = new Jitter.Collision.DynamicTree<SoftBody.Triangle>();
    private Material material = new Material();
    private JBBox box;
    private bool active = true;
    private float pressure;
    private List<int> queryList = new List<int>();
    public int collisionLayer = 1;
    public int collisionMask = int.MaxValue;

    public ReadOnlyCollection<SoftBody.Spring> EdgeSprings { get; private set; }

    public ReadOnlyCollection<SoftBody.MassPoint> VertexBodies { get; private set; }

    public ReadOnlyCollection<SoftBody.Triangle> Triangles { private set; get; }

    public bool SelfCollision
    {
      get => this.selfCollision;
      set => this.selfCollision = value;
    }

    public float TriangleExpansion
    {
      get => this.triangleExpansion;
      set => this.triangleExpansion = value;
    }

    public float VertexExpansion
    {
      get => this.sphere.Radius;
      set => this.sphere.Radius = value;
    }

    public Jitter.Collision.DynamicTree<SoftBody.Triangle> DynamicTree => this.dynamicTree;

    public Material Material => this.material;

    public SoftBody()
    {
    }

    public SoftBody(int sizeX, int sizeY, float scale)
    {
      List<TriangleVertexIndices> indices = new List<TriangleVertexIndices>();
      List<JVector> vertices = new List<JVector>();
      for (int index1 = 0; index1 < sizeY; ++index1)
      {
        for (int index2 = 0; index2 < sizeX; ++index2)
          vertices.Add(new JVector((float) index1, 0.0f, (float) index2) * scale);
      }
      for (int index3 = 0; index3 < sizeX - 1; ++index3)
      {
        for (int index4 = 0; index4 < sizeY - 1; ++index4)
        {
          TriangleVertexIndices triangleVertexIndices = new TriangleVertexIndices();
          triangleVertexIndices.I0 = index4 * sizeX + index3;
          triangleVertexIndices.I1 = index4 * sizeX + index3 + 1;
          triangleVertexIndices.I2 = (index4 + 1) * sizeX + index3 + 1;
          indices.Add(triangleVertexIndices);
          triangleVertexIndices.I0 = index4 * sizeX + index3;
          triangleVertexIndices.I1 = (index4 + 1) * sizeX + index3 + 1;
          triangleVertexIndices.I2 = (index4 + 1) * sizeX + index3;
          indices.Add(triangleVertexIndices);
        }
      }
      this.EdgeSprings = new ReadOnlyCollection<SoftBody.Spring>((IList<SoftBody.Spring>) this.springs);
      this.VertexBodies = new ReadOnlyCollection<SoftBody.MassPoint>((IList<SoftBody.MassPoint>) this.points);
      this.Triangles = new ReadOnlyCollection<SoftBody.Triangle>((IList<SoftBody.Triangle>) this.triangles);
      this.AddPointsAndSprings(indices, vertices);
      for (int index5 = 0; index5 < sizeX - 1; ++index5)
      {
        for (int index6 = 0; index6 < sizeY - 1; ++index6)
          this.springs.Add(new SoftBody.Spring((JRigidbody) this.points[index6 * sizeX + index5 + 1], (JRigidbody) this.points[(index6 + 1) * sizeX + index5])
          {
            Softness = 0.01f,
            BiasFactor = 0.1f
          });
      }
      foreach (SoftBody.Spring spring in this.springs)
      {
        JVector jvector = spring.body1.position - spring.body2.position;
        spring.SpringType = (double) jvector.Z == 0.0 || (double) jvector.X == 0.0 ? SoftBody.SpringType.EdgeSpring : SoftBody.SpringType.ShearSpring;
      }
      for (int index7 = 0; index7 < sizeX - 2; ++index7)
      {
        for (int index8 = 0; index8 < sizeY - 2; ++index8)
        {
          SoftBody.Spring spring1 = new SoftBody.Spring((JRigidbody) this.points[index8 * sizeX + index7], (JRigidbody) this.points[index8 * sizeX + index7 + 2]);
          spring1.Softness = 0.01f;
          spring1.BiasFactor = 0.1f;
          SoftBody.Spring spring2 = new SoftBody.Spring((JRigidbody) this.points[index8 * sizeX + index7], (JRigidbody) this.points[(index8 + 2) * sizeX + index7]);
          spring2.Softness = 0.01f;
          spring2.BiasFactor = 0.1f;
          spring1.SpringType = SoftBody.SpringType.BendSpring;
          spring2.SpringType = SoftBody.SpringType.BendSpring;
          this.springs.Add(spring1);
          this.springs.Add(spring2);
        }
      }
    }

    public SoftBody(List<TriangleVertexIndices> indices, List<JVector> vertices)
    {
      this.EdgeSprings = new ReadOnlyCollection<SoftBody.Spring>((IList<SoftBody.Spring>) this.springs);
      this.VertexBodies = new ReadOnlyCollection<SoftBody.MassPoint>((IList<SoftBody.MassPoint>) this.points);
      this.AddPointsAndSprings(indices, vertices);
      this.Triangles = new ReadOnlyCollection<SoftBody.Triangle>((IList<SoftBody.Triangle>) this.triangles);
    }

    public float Pressure
    {
      get => this.pressure;
      set => this.pressure = value;
    }

    private void AddPressureForces(float timeStep)
    {
      if ((double) this.pressure == 0.0 || (double) this.volume == 0.0)
        return;
      float num = 1f / this.volume;
      foreach (SoftBody.Triangle triangle in this.triangles)
      {
        JVector position1 = this.points[triangle.indices.I0].position;
        JVector position2 = this.points[triangle.indices.I1].position;
        JVector jvector = (this.points[triangle.indices.I2].position - position1) % (position2 - position1);
        this.points[triangle.indices.I0].AddForce(num * jvector * this.pressure);
        this.points[triangle.indices.I1].AddForce(num * jvector * this.pressure);
        this.points[triangle.indices.I2].AddForce(num * jvector * this.pressure);
      }
    }

    public void Translate(JVector position)
    {
      foreach (SoftBody.MassPoint point in this.points)
        point.Position = point.Position + position;
      this.Update(float.Epsilon);
    }

    public void AddForce(JVector force) => throw new NotImplementedException();

    public void Rotate(JMatrix orientation, JVector center)
    {
      for (int index = 0; index < this.points.Count; ++index)
        this.points[index].position = JVector.Transform(this.points[index].position - center, orientation);
    }

    public JVector CalculateCenter() => throw new NotImplementedException();

    private HashSet<SoftBody.Edge> GetEdges(List<TriangleVertexIndices> indices)
    {
      HashSet<SoftBody.Edge> edgeSet = new HashSet<SoftBody.Edge>();
      for (int index = 0; index < indices.Count; ++index)
      {
        SoftBody.Edge edge = new SoftBody.Edge(indices[index].I0, indices[index].I1);
        if (!edgeSet.Contains(edge))
          edgeSet.Add(edge);
        edge = new SoftBody.Edge(indices[index].I1, indices[index].I2);
        if (!edgeSet.Contains(edge))
          edgeSet.Add(edge);
        edge = new SoftBody.Edge(indices[index].I2, indices[index].I0);
        if (!edgeSet.Contains(edge))
          edgeSet.Add(edge);
      }
      return edgeSet;
    }

    public virtual void DoSelfCollision(CollisionDetectedHandler collision)
    {
      if (!this.selfCollision)
        return;
      for (int index1 = 0; index1 < this.points.Count; ++index1)
      {
        this.queryList.Clear();
        this.dynamicTree.Query(this.queryList, ref this.points[index1].boundingBox);
        for (int index2 = 0; index2 < this.queryList.Count; ++index2)
        {
          SoftBody.Triangle userData = this.dynamicTree.GetUserData(this.queryList[index2]);
          JVector point;
          JVector normal;
          float penetration;
          if (userData.VertexBody1 != this.points[index1] && userData.VertexBody2 != this.points[index1] && userData.VertexBody3 != this.points[index1] && XenoCollide.Detect((ISupportMappable) this.points[index1].Shape, (ISupportMappable) userData, ref this.points[index1].orientation, ref JMatrix.InternalIdentity, ref this.points[index1].position, ref JVector.InternalZero, out point, out normal, out penetration))
          {
            int nearestTrianglePoint = CollisionSystem.FindNearestTrianglePoint(this, this.queryList[index2], ref point);
            collision((JRigidbody) this.points[index1], (JRigidbody) this.points[nearestTrianglePoint], point, point, normal, penetration);
          }
        }
      }
    }

    private void AddPointsAndSprings(List<TriangleVertexIndices> indices, List<JVector> vertices)
    {
      for (int index = 0; index < vertices.Count; ++index)
      {
        SoftBody.MassPoint massPoint = new SoftBody.MassPoint((Shape) this.sphere, this, this.material);
        massPoint.Position = vertices[index];
        massPoint.Mass = 0.1f;
        this.points.Add(massPoint);
      }
      for (int index1 = 0; index1 < indices.Count; ++index1)
      {
        TriangleVertexIndices index2 = indices[index1];
        SoftBody.Triangle userData = new SoftBody.Triangle(this);
        userData.indices = index2;
        this.triangles.Add(userData);
        userData.boundingBox = JBBox.SmallBox;
        userData.boundingBox.AddPoint(this.points[userData.indices.I0].position);
        userData.boundingBox.AddPoint(this.points[userData.indices.I1].position);
        userData.boundingBox.AddPoint(this.points[userData.indices.I2].position);
        userData.dynamicTreeID = this.dynamicTree.AddProxy(ref userData.boundingBox, userData);
      }
      HashSet<SoftBody.Edge> edges = this.GetEdges(indices);
      int num = 0;
      foreach (SoftBody.Edge edge in edges)
      {
        this.springs.Add(new SoftBody.Spring((JRigidbody) this.points[edge.Index1], (JRigidbody) this.points[edge.Index2])
        {
          Softness = 0.01f,
          BiasFactor = 0.1f,
          SpringType = SoftBody.SpringType.EdgeSpring
        });
        ++num;
      }
    }

    public void SetSpringValues(float bias, float softness) => this.SetSpringValues(SoftBody.SpringType.EdgeSpring | SoftBody.SpringType.ShearSpring | SoftBody.SpringType.BendSpring, bias, softness);

    public void SetSpringValues(SoftBody.SpringType type, float bias, float softness)
    {
      for (int index = 0; index < this.springs.Count; ++index)
      {
        if ((this.springs[index].SpringType & type) != (SoftBody.SpringType) 0)
        {
          this.springs[index].Softness = softness;
          this.springs[index].BiasFactor = bias;
        }
      }
    }

    public virtual void Update(float timestep)
    {
      this.active = false;
      foreach (SoftBody.MassPoint point in this.points)
      {
        if (point.isActive && !point.isStatic)
        {
          this.active = true;
          break;
        }
      }
      if (!this.active)
        return;
      this.box = JBBox.SmallBox;
      this.volume = 0.0f;
      this.mass = 0.0f;
      foreach (SoftBody.MassPoint point in this.points)
      {
        this.mass += point.Mass;
        this.box.AddPoint(point.position);
      }
      this.box.Min -= new JVector(this.TriangleExpansion);
      this.box.Max += new JVector(this.TriangleExpansion);
      foreach (SoftBody.Triangle triangle in this.triangles)
      {
        JVector center = triangle.boundingBox.Center;
        triangle.UpdateBoundingBox();
        JVector jvector = (triangle.VertexBody1.linearVelocity + triangle.VertexBody2.linearVelocity + triangle.VertexBody3.linearVelocity) * 0.3333333f;
        this.dynamicTree.MoveProxy(triangle.dynamicTreeID, ref triangle.boundingBox, jvector * timestep);
        JVector position1 = this.points[triangle.indices.I0].position;
        JVector position2 = this.points[triangle.indices.I1].position;
        JVector position3 = this.points[triangle.indices.I2].position;
        this.volume -= (float) ((((double) position2.Y - (double) position1.Y) * ((double) position3.Z - (double) position1.Z) - ((double) position2.Z - (double) position1.Z) * ((double) position3.Y - (double) position1.Y)) * ((double) position1.X + (double) position2.X + (double) position3.X));
      }
      this.volume /= 6f;
      this.AddPressureForces(timestep);
    }

    public float Mass
    {
      get => this.mass;
      set
      {
        for (int index = 0; index < this.points.Count; ++index)
          this.points[index].Mass = value / (float) this.points.Count;
      }
    }

    public float Volume => this.volume;

    public JBBox BoundingBox => this.box;

    public int BroadphaseTag { get; set; }

    public object Tag { get; set; }

    public bool IsStaticOrInactive => !this.active;

    public int CollisionLayer
    {
      get => this.collisionLayer;
      set => this.collisionLayer = value;
    }

    public int CollisionMask
    {
      get => this.collisionMask;
      set => this.collisionMask = value;
    }

    [Flags]
    public enum SpringType
    {
      EdgeSpring = 2,
      ShearSpring = 4,
      BendSpring = 8,
    }

    public class Spring : Constraint
    {
      private float biasFactor = 0.1f;
      private float softness = 0.01f;
      private float distance;
      private SoftBody.Spring.DistanceBehavior behavior;
      private float effectiveMass;
      private float accumulatedImpulse;
      private float bias;
      private float softnessOverDt;
      private JVector[] jacobian = new JVector[2];
      private bool skipConstraint;

      public SoftBody.SpringType SpringType { get; set; }

      public Spring(JRigidbody body1, JRigidbody body2)
        : base(body1, body2)
      {
        this.distance = (body1.position - body2.position).Length();
      }

      public float AppliedImpulse => this.accumulatedImpulse;

      public float Distance
      {
        get => this.distance;
        set => this.distance = value;
      }

      public SoftBody.Spring.DistanceBehavior Behavior
      {
        get => this.behavior;
        set => this.behavior = value;
      }

      public float Softness
      {
        get => this.softness;
        set => this.softness = value;
      }

      public float BiasFactor
      {
        get => this.biasFactor;
        set => this.biasFactor = value;
      }

      public override void PrepareForIteration(float timestep)
      {
        JVector result;
        JVector.Subtract(ref this.body2.position, ref this.body1.position, out result);
        float num = result.Length() - this.distance;
        if (this.behavior == SoftBody.Spring.DistanceBehavior.LimitMaximumDistance && (double) num <= 0.0)
          this.skipConstraint = true;
        else if (this.behavior == SoftBody.Spring.DistanceBehavior.LimitMinimumDistance && (double) num >= 0.0)
        {
          this.skipConstraint = true;
        }
        else
        {
          this.skipConstraint = false;
          JVector jvector = result;
          if ((double) jvector.LengthSquared() != 0.0)
            jvector.Normalize();
          this.jacobian[0] = -1f * jvector;
          this.jacobian[1] = 1f * jvector;
          this.effectiveMass = this.body1.inverseMass + this.body2.inverseMass;
          this.softnessOverDt = this.softness / timestep;
          this.effectiveMass += this.softnessOverDt;
          this.effectiveMass = 1f / this.effectiveMass;
          this.bias = (float) ((double) num * (double) this.biasFactor * (1.0 / (double) timestep));
          if (!this.body1.isStatic)
            this.body1.linearVelocity += this.body1.inverseMass * this.accumulatedImpulse * this.jacobian[0];
          if (this.body2.isStatic)
            return;
          this.body2.linearVelocity += this.body2.inverseMass * this.accumulatedImpulse * this.jacobian[1];
        }
      }

      public override void Iterate()
      {
        if (this.skipConstraint)
          return;
        float num = (float) (-(double) this.effectiveMass * ((double) (JVector.Dot(ref this.body1.linearVelocity, ref this.jacobian[0]) + JVector.Dot(ref this.body2.linearVelocity, ref this.jacobian[1])) + (double) this.bias + (double) (this.accumulatedImpulse * this.softnessOverDt)));
        if (this.behavior == SoftBody.Spring.DistanceBehavior.LimitMinimumDistance)
        {
          float accumulatedImpulse = this.accumulatedImpulse;
          this.accumulatedImpulse = JMath.Max(this.accumulatedImpulse + num, 0.0f);
          num = this.accumulatedImpulse - accumulatedImpulse;
        }
        else if (this.behavior == SoftBody.Spring.DistanceBehavior.LimitMaximumDistance)
        {
          float accumulatedImpulse = this.accumulatedImpulse;
          this.accumulatedImpulse = JMath.Min(this.accumulatedImpulse + num, 0.0f);
          num = this.accumulatedImpulse - accumulatedImpulse;
        }
        else
          this.accumulatedImpulse += num;
        JVector result;
        if (!this.body1.isStatic)
        {
          JVector.Multiply(ref this.jacobian[0], num * this.body1.inverseMass, out result);
          JVector.Add(ref result, ref this.body1.linearVelocity, out this.body1.linearVelocity);
        }
        if (this.body2.isStatic)
          return;
        JVector.Multiply(ref this.jacobian[1], num * this.body2.inverseMass, out result);
        JVector.Add(ref result, ref this.body2.linearVelocity, out this.body2.linearVelocity);
      }

      public override void DebugDraw(IDebugDrawer drawer) => drawer.DrawLine(this.body1.position, this.body2.position);

      public enum DistanceBehavior
      {
        LimitDistance,
        LimitMaximumDistance,
        LimitMinimumDistance,
      }
    }

    public class MassPoint : JRigidbody
    {
      public SoftBody SoftBody { get; private set; }

      public MassPoint(Shape shape, SoftBody owner, Material material)
        : base(shape, material, true)
      {
        this.SoftBody = owner;
      }
    }

    public class Triangle : ISupportMappable
    {
      private SoftBody owner;
      internal JBBox boundingBox;
      internal int dynamicTreeID;
      internal TriangleVertexIndices indices;

      public SoftBody Owner => this.owner;

      public JBBox BoundingBox => this.boundingBox;

      public int DynamicTreeID => this.dynamicTreeID;

      public TriangleVertexIndices Indices => this.indices;

      public SoftBody.MassPoint VertexBody1 => this.owner.points[this.indices.I0];

      public SoftBody.MassPoint VertexBody2 => this.owner.points[this.indices.I1];

      public SoftBody.MassPoint VertexBody3 => this.owner.points[this.indices.I2];

      public Triangle(SoftBody owner) => this.owner = owner;

      public void GetNormal(out JVector normal)
      {
        JVector result;
        JVector.Subtract(ref this.owner.points[this.indices.I1].position, ref this.owner.points[this.indices.I0].position, out result);
        JVector.Subtract(ref this.owner.points[this.indices.I2].position, ref this.owner.points[this.indices.I0].position, out normal);
        JVector.Cross(ref result, ref normal, out normal);
      }

      public void UpdateBoundingBox()
      {
        this.boundingBox = JBBox.SmallBox;
        this.boundingBox.AddPoint(ref this.owner.points[this.indices.I0].position);
        this.boundingBox.AddPoint(ref this.owner.points[this.indices.I1].position);
        this.boundingBox.AddPoint(ref this.owner.points[this.indices.I2].position);
        this.boundingBox.Min -= new JVector(this.owner.triangleExpansion);
        this.boundingBox.Max += new JVector(this.owner.triangleExpansion);
      }

      public float CalculateArea() => ((this.owner.points[this.indices.I1].position - this.owner.points[this.indices.I0].position) % (this.owner.points[this.indices.I2].position - this.owner.points[this.indices.I0].position)).Length();

      public void SupportMapping(ref JVector direction, out JVector result)
      {
        float num1 = JVector.Dot(ref this.owner.points[this.indices.I0].position, ref direction);
        float num2 = JVector.Dot(ref this.owner.points[this.indices.I1].position, ref direction);
        JVector position = this.owner.points[this.indices.I0].position;
        if ((double) num2 > (double) num1)
        {
          num1 = num2;
          position = this.owner.points[this.indices.I1].position;
        }
        if ((double) JVector.Dot(ref this.owner.points[this.indices.I2].position, ref direction) > (double) num1)
          position = this.owner.points[this.indices.I2].position;
        JVector result1;
        JVector.Normalize(ref direction, out result1);
        result1 *= this.owner.triangleExpansion;
        result = position + result1;
      }

      public void SupportCenter(out JVector center)
      {
        center = this.owner.points[this.indices.I0].position;
        JVector.Add(ref center, ref this.owner.points[this.indices.I1].position, out center);
        JVector.Add(ref center, ref this.owner.points[this.indices.I2].position, out center);
        JVector.Multiply(ref center, 0.3333333f, out center);
      }
    }

    private struct Edge
    {
      public int Index1;
      public int Index2;

      public Edge(int index1, int index2)
      {
        this.Index1 = index1;
        this.Index2 = index2;
      }

      public override int GetHashCode() => this.Index1.GetHashCode() + this.Index2.GetHashCode();

      public override bool Equals(object obj)
      {
        SoftBody.Edge edge = (SoftBody.Edge) obj;
        if (edge.Index1 == this.Index1 && edge.Index2 == this.Index2)
          return true;
        return edge.Index1 == this.Index2 && edge.Index2 == this.Index1;
      }
    }
  }
}
