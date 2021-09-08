// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.JRigidbody
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Collision;
using Jitter.Collision.Shapes;
using Jitter.DataStructures;
using Jitter.Dynamics.Constraints;
using Jitter.LinearMath;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Threading;

namespace Jitter.Dynamics
{
  public class JRigidbody : 
    IBroadphaseEntity,
    IDebugDrawable,
    IEquatable<JRigidbody>,
    IComparable<JRigidbody>
  {
    public string name = "unnamed";
    internal JMatrix inertia;
    internal JMatrix invInertia;
    internal JMatrix invInertiaWorld;
    internal JMatrix orientation;
    internal JMatrix invOrientation;
    internal JVector position;
    internal JVector linearVelocity;
    internal JVector angularVelocity;
    internal Material material;
    internal JBBox boundingBox;
    internal int collisionLayer = 1;
    internal int collisionMask = int.MaxValue;
    internal float inactiveTime;
    internal bool isActive = true;
    internal bool isStatic;
    internal bool isKinematic;
    internal bool isTrigger;
    internal bool affectedByGravity = true;
    internal CollisionIsland island;
    internal float inverseMass;
    internal JVector force;
    internal JVector torque;
    private int hashCode;
    internal int internalIndex;
    private ShapeUpdatedHandler updatedHandler;
    internal List<JRigidbody> connections = new List<JRigidbody>();
    internal HashSet<Arbiter> arbiters = new HashSet<Arbiter>();
    internal HashSet<Constraint> constraints = new HashSet<Constraint>();
    private ReadOnlyHashset<Arbiter> readOnlyArbiters;
    private ReadOnlyHashset<Constraint> readOnlyConstraints;
    internal int marker;
    internal bool isParticle;
    private static int instanceCount;
    private int instance;
    protected bool useShapeMassProperties = true;
    private Shape shape;
    internal JVector sweptDirection = JVector.Zero;
    private bool enableDebugDraw;
    private List<JVector> hullPoints = new List<JVector>();

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

    public bool IsActive
    {
      get => this.isActive;
      set
      {
        if (!this.isActive & value)
          this.inactiveTime = 0.0f;
        else if (this.isActive && !value)
        {
          this.inactiveTime = float.PositiveInfinity;
          this.angularVelocity.MakeZero();
          this.linearVelocity.MakeZero();
        }
        this.isActive = value;
      }
    }

    public bool IsStatic
    {
      get => this.isStatic;
      set
      {
        if (value && !this.isStatic)
        {
          if (this.island != null)
            this.island.islandManager.MakeBodyStatic(this);
          this.angularVelocity.MakeZero();
          this.linearVelocity.MakeZero();
        }
        this.isStatic = value;
      }
    }

    public bool AffectedByGravity
    {
      get => this.affectedByGravity;
      set => this.affectedByGravity = value;
    }

    public bool IsKinematic
    {
      get => this.isKinematic;
      set => this.isKinematic = value;
    }

    public bool IsTrigger
    {
      get => this.isTrigger;
      set => this.isTrigger = value;
    }

    [JsonConstructor]
    public JRigidbody(Shape shape)
      : this(shape, new Material(), false)
    {
    }

    public bool IsParticle
    {
      get => this.isParticle;
      set
      {
        if (this.isParticle && !value)
        {
          this.updatedHandler = new ShapeUpdatedHandler(this.ShapeUpdated);
          this.Shape.ShapeUpdated += this.updatedHandler;
          this.SetMassProperties();
          this.isParticle = false;
        }
        else if (!this.isParticle & value)
        {
          this.inertia = JMatrix.Zero;
          this.invInertia = this.invInertiaWorld = JMatrix.Zero;
          this.invOrientation = this.orientation = JMatrix.Identity;
          this.inverseMass = 1f;
          this.Shape.ShapeUpdated -= this.updatedHandler;
          this.isParticle = true;
        }
        this.Update();
      }
    }

    public JRigidbody(Shape shape, Material material)
      : this(shape, material, false)
    {
    }

    public JRigidbody(Shape shape, Material material, bool isParticle)
    {
      this.readOnlyArbiters = new ReadOnlyHashset<Arbiter>(this.arbiters);
      this.readOnlyConstraints = new ReadOnlyHashset<Constraint>(this.constraints);
      this.instance = Interlocked.Increment(ref JRigidbody.instanceCount);
      this.hashCode = this.CalculateHash(this.instance);
      this.Shape = shape;
      this.orientation = JMatrix.Identity;
      if (!isParticle)
      {
        this.updatedHandler = new ShapeUpdatedHandler(this.ShapeUpdated);
        this.Shape.ShapeUpdated += this.updatedHandler;
        this.SetMassProperties();
      }
      else
      {
        this.inertia = JMatrix.Zero;
        this.invInertia = this.invInertiaWorld = JMatrix.Zero;
        this.invOrientation = this.orientation = JMatrix.Identity;
        this.inverseMass = 1f;
      }
      this.material = material;
      this.AllowDeactivation = true;
      this.EnableSpeculativeContacts = false;
      this.isParticle = isParticle;
      this.Update();
    }

    public override int GetHashCode() => this.hashCode;

    public ReadOnlyHashset<Arbiter> Arbiters => this.readOnlyArbiters;

    public ReadOnlyHashset<Constraint> Constraints => this.readOnlyConstraints;

    public bool AllowDeactivation { get; set; }

    public bool EnableSpeculativeContacts { get; set; }

    public JBBox BoundingBox => this.boundingBox;

    private int CalculateHash(int a)
    {
      a = a ^ 61 ^ a >> 16;
      a += a << 3;
      a ^= a >> 4;
      a *= 668265261;
      a ^= a >> 15;
      return a;
    }

    public CollisionIsland CollisionIsland => this.island;

    public void ApplyImpulse(JVector impulse)
    {
      if (this.isStatic)
        throw new InvalidOperationException("Can't apply an impulse to a static body.");
      JVector result;
      JVector.Multiply(ref impulse, this.inverseMass, out result);
      JVector.Add(ref this.linearVelocity, ref result, out this.linearVelocity);
    }

    public void ApplyImpulse(JVector impulse, JVector relativePosition)
    {
      if (this.isStatic)
        throw new InvalidOperationException("Can't apply an impulse to a static body.");
      JVector result;
      JVector.Multiply(ref impulse, this.inverseMass, out result);
      JVector.Add(ref this.linearVelocity, ref result, out this.linearVelocity);
      JVector.Cross(ref relativePosition, ref impulse, out result);
      JVector.Transform(ref result, ref this.invInertiaWorld, out result);
      JVector.Add(ref this.angularVelocity, ref result, out this.angularVelocity);
    }

    public void AddForce(JVector force) => JVector.Add(ref force, ref this.force, out this.force);

    public void AddForce(JVector force, JVector pos)
    {
      JVector.Add(ref this.force, ref force, out this.force);
      JVector.Subtract(ref pos, ref this.position, out pos);
      JVector.Cross(ref pos, ref force, out pos);
      JVector.Add(ref pos, ref this.torque, out this.torque);
    }

    public JVector Torque => this.torque;

    public JVector Force
    {
      get => this.force;
      set => this.force = value;
    }

    public void AddTorque(JVector torque) => JVector.Add(ref torque, ref this.torque, out this.torque);

    public void SetMassProperties()
    {
      this.inertia = this.Shape.inertia;
      JMatrix.Inverse(ref this.inertia, out this.invInertia);
      this.inverseMass = 1f / this.Shape.mass;
      this.useShapeMassProperties = true;
    }

    public void SetMassProperties(JMatrix inertia, float mass, bool setAsInverseValues)
    {
      if (setAsInverseValues)
      {
        if (!this.isParticle)
        {
          this.invInertia = inertia;
          JMatrix.Inverse(ref inertia, out this.inertia);
        }
        this.inverseMass = mass;
      }
      else
      {
        if (!this.isParticle)
        {
          this.inertia = inertia;
          JMatrix.Inverse(ref inertia, out this.invInertia);
        }
        this.inverseMass = 1f / mass;
      }
      this.useShapeMassProperties = false;
      this.Update();
    }

    private void ShapeUpdated()
    {
      if (this.useShapeMassProperties)
        this.SetMassProperties();
      this.Update();
      this.UpdateHullData();
    }

    public Shape Shape
    {
      get => this.shape;
      set
      {
        if (this.shape != null)
          this.shape.ShapeUpdated -= this.updatedHandler;
        this.shape = value;
        this.shape.ShapeUpdated += new ShapeUpdatedHandler(this.ShapeUpdated);
      }
    }

    public float LinearDrag { get; set; }

    public float AngularDrag { get; set; }

    public Material Material
    {
      get => this.material;
      set => this.material = value;
    }

    public JMatrix Inertia => this.inertia;

    public JMatrix InverseInertia => this.invInertia;

    public JVector LinearVelocity
    {
      get => this.linearVelocity;
      set
      {
        if (this.linearVelocity == value)
          return;
        if (this.isStatic)
          Console.WriteLine("Can't set a velocity to a static body.");
        else
          this.linearVelocity = value;
      }
    }

    public JVector AngularVelocity
    {
      get => this.angularVelocity;
      set
      {
        if (this.angularVelocity == value)
          return;
        if (this.isStatic)
          Console.WriteLine("Can't set a velocity to a static body.");
        else
          this.angularVelocity = value;
      }
    }

    public JVector Position
    {
      get => this.position;
      set
      {
        this.position = value;
        this.Update();
      }
    }

    public JMatrix Orientation
    {
      get => this.orientation;
      set
      {
        this.orientation = value;
        this.Update();
      }
    }

    public void SetPositionAndOrientation(JVector pos, JMatrix orientation)
    {
      if (this.position.Equals(pos) && this.orientation.Equals(orientation))
        return;
      this.position = pos;
      this.orientation = orientation;
      this.Update();
    }

    public void SetPositionAndRotation(JVector pos, JQuaternion rotation)
    {
      JMatrix fromQuaternion = JMatrix.CreateFromQuaternion(rotation);
      if (this.position.Equals(pos) && this.orientation.Equals(fromQuaternion))
        return;
      this.position = pos;
      this.orientation = fromQuaternion;
      this.Update();
    }

    public JMatrix InverseInertiaWorld => this.invInertiaWorld;

    public float Mass
    {
      get => 1f / this.inverseMass;
      set
      {
        if ((double) value <= 0.0)
          throw new ArgumentException("Mass can't be less or equal zero.");
        if (!this.isParticle)
        {
          JMatrix.Multiply(ref this.Shape.inertia, value / this.Shape.mass, out this.inertia);
          JMatrix.Inverse(ref this.inertia, out this.invInertia);
        }
        this.inverseMass = 1f / value;
      }
    }

    public void SweptExpandBoundingBox(float timestep)
    {
      this.sweptDirection = this.linearVelocity * timestep;
      if ((double) this.sweptDirection.X < 0.0)
        this.boundingBox.Min.X += this.sweptDirection.X;
      else
        this.boundingBox.Max.X += this.sweptDirection.X;
      if ((double) this.sweptDirection.Y < 0.0)
        this.boundingBox.Min.Y += this.sweptDirection.Y;
      else
        this.boundingBox.Max.Y += this.sweptDirection.Y;
      if ((double) this.sweptDirection.Z < 0.0)
        this.boundingBox.Min.Z += this.sweptDirection.Z;
      else
        this.boundingBox.Max.Z += this.sweptDirection.Z;
    }

    public virtual void Update()
    {
      if (this.isParticle)
      {
        this.inertia = JMatrix.Zero;
        this.invInertia = this.invInertiaWorld = JMatrix.Zero;
        this.invOrientation = this.orientation = JMatrix.Identity;
        this.boundingBox = this.shape.boundingBox;
        JVector.Add(ref this.boundingBox.Min, ref this.position, out this.boundingBox.Min);
        JVector.Add(ref this.boundingBox.Max, ref this.position, out this.boundingBox.Max);
        this.angularVelocity.MakeZero();
      }
      else
      {
        JMatrix.Transpose(ref this.orientation, out this.invOrientation);
        this.Shape.GetBoundingBox(ref this.orientation, out this.boundingBox);
        JVector.Add(ref this.boundingBox.Min, ref this.position, out this.boundingBox.Min);
        JVector.Add(ref this.boundingBox.Max, ref this.position, out this.boundingBox.Max);
        if (this.isStatic)
          return;
        JMatrix.Multiply(ref this.invOrientation, ref this.invInertia, out this.invInertiaWorld);
        JMatrix.Multiply(ref this.invInertiaWorld, ref this.orientation, out this.invInertiaWorld);
      }
    }

    public bool Equals(JRigidbody other) => other.instance == this.instance;

    public int CompareTo(JRigidbody other)
    {
      if (other.instance < this.instance)
        return -1;
      return other.instance > this.instance ? 1 : 0;
    }

    public int BroadphaseTag { get; set; }

    public virtual void PreStep(float timestep)
    {
    }

    public virtual void PostStep(float timestep)
    {
    }

    public bool IsStaticOrInactive => !this.isActive || this.isStatic;

    public bool EnableDebugDraw
    {
      get => this.enableDebugDraw;
      set
      {
        this.enableDebugDraw = value;
        this.UpdateHullData();
      }
    }

    private void UpdateHullData()
    {
      this.hullPoints.Clear();
      if (!this.enableDebugDraw)
        return;
      this.shape.MakeHull(ref this.hullPoints, 3);
    }

    public override string ToString() => string.Format("{0} Position[{1}]", (object) this.name, (object) this.position);

    public void DebugDraw(IDebugDrawer drawer)
    {
      if (this.shape is CylinderShape)
      {
        CylinderShape shape = (CylinderShape) this.shape;
        float height = shape.Height / 2f;
        float radius = shape.Radius;
        drawer.DrawCylinder(height, radius, this.orientation, this.position);
      }
      else if (this.shape is CapsuleShape)
      {
        CapsuleShape shape = (CapsuleShape) this.shape;
        float height = shape.Length / 2f;
        float radius = shape.Radius;
        drawer.DrawCapsule(height, radius, this.orientation, this.position);
      }
      else if (this.shape is BoxShape)
      {
        BoxShape shape = (BoxShape) this.shape;
        drawer.DebugDrawBox(shape.Size, this.orientation, this.position);
      }
      else
      {
        if (!(this.shape is SphereShape))
          return;
        SphereShape shape = (SphereShape) this.shape;
        drawer.DrawSphere(shape.Radius, this.orientation, this.position);
      }
    }

    private void DebugDrawBoundingBox(IDebugDrawer drawer, JBBox bBox)
    {
      JVector[] corners = new JVector[8];
      bBox.GetCorners(corners);
      for (int index = 0; index < 8; ++index)
        corners[index] = this.TransformPoint(corners[index]);
      drawer.DrawLine(corners[0], corners[1]);
      drawer.DrawLine(corners[1], corners[2]);
      drawer.DrawLine(corners[2], corners[3]);
      drawer.DrawLine(corners[3], corners[0]);
      drawer.DrawLine(corners[4], corners[5]);
      drawer.DrawLine(corners[5], corners[6]);
      drawer.DrawLine(corners[6], corners[7]);
      drawer.DrawLine(corners[7], corners[4]);
      drawer.DrawLine(corners[0], corners[4]);
      drawer.DrawLine(corners[1], corners[5]);
      drawer.DrawLine(corners[2], corners[6]);
      drawer.DrawLine(corners[3], corners[7]);
    }

    private JVector TransformPoint(JVector pt)
    {
      JVector.Transform(ref pt, ref this.orientation, out pt);
      JVector.Add(ref pt, ref this.position, out pt);
      return pt;
    }
  }
}
