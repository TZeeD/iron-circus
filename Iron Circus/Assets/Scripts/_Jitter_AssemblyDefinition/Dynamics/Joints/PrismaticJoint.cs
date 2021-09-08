// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Joints.PrismaticJoint
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Dynamics.Constraints;
using Jitter.LinearMath;

namespace Jitter.Dynamics.Joints
{
  public class PrismaticJoint : Joint
  {
    private FixedAngle fixedAngle;
    private PointOnLine pointOnLine;
    private PointPointDistance minDistance;
    private PointPointDistance maxDistance;

    public PointPointDistance MaximumDistanceConstraint => this.maxDistance;

    public PointPointDistance MinimumDistanceConstraint => this.minDistance;

    public FixedAngle FixedAngleConstraint => this.fixedAngle;

    public PointOnLine PointOnLineConstraint => this.pointOnLine;

    public PrismaticJoint(World world, JRigidbody body1, JRigidbody body2)
      : base(world)
    {
      this.fixedAngle = new FixedAngle(body1, body2);
      this.pointOnLine = new PointOnLine(body1, body2, body1.position, body2.position);
    }

    public PrismaticJoint(
      World world,
      JRigidbody body1,
      JRigidbody body2,
      float minimumDistance,
      float maximumDistance)
      : base(world)
    {
      this.fixedAngle = new FixedAngle(body1, body2);
      this.pointOnLine = new PointOnLine(body1, body2, body1.position, body2.position);
      this.minDistance = new PointPointDistance(body1, body2, body1.position, body2.position);
      this.minDistance.Behavior = PointPointDistance.DistanceBehavior.LimitMinimumDistance;
      this.minDistance.Distance = minimumDistance;
      this.maxDistance = new PointPointDistance(body1, body2, body1.position, body2.position);
      this.maxDistance.Behavior = PointPointDistance.DistanceBehavior.LimitMaximumDistance;
      this.maxDistance.Distance = maximumDistance;
    }

    public PrismaticJoint(
      World world,
      JRigidbody body1,
      JRigidbody body2,
      JVector pointOnBody1,
      JVector pointOnBody2)
      : base(world)
    {
      this.fixedAngle = new FixedAngle(body1, body2);
      this.pointOnLine = new PointOnLine(body1, body2, pointOnBody1, pointOnBody2);
    }

    public PrismaticJoint(
      World world,
      JRigidbody body1,
      JRigidbody body2,
      JVector pointOnBody1,
      JVector pointOnBody2,
      float maximumDistance,
      float minimumDistance)
      : base(world)
    {
      this.fixedAngle = new FixedAngle(body1, body2);
      this.pointOnLine = new PointOnLine(body1, body2, pointOnBody1, pointOnBody2);
    }

    public override void Activate()
    {
      if (this.maxDistance != null)
        this.World.AddConstraint((Constraint) this.maxDistance);
      if (this.minDistance != null)
        this.World.AddConstraint((Constraint) this.minDistance);
      this.World.AddConstraint((Constraint) this.fixedAngle);
      this.World.AddConstraint((Constraint) this.pointOnLine);
    }

    public override void Deactivate()
    {
      if (this.maxDistance != null)
        this.World.RemoveConstraint((Constraint) this.maxDistance);
      if (this.minDistance != null)
        this.World.RemoveConstraint((Constraint) this.minDistance);
      this.World.RemoveConstraint((Constraint) this.fixedAngle);
      this.World.RemoveConstraint((Constraint) this.pointOnLine);
    }
  }
}
