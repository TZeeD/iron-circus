// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Joints.LimitedHingeJoint
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Dynamics.Constraints;
using Jitter.LinearMath;
using System;

namespace Jitter.Dynamics.Joints
{
  public class LimitedHingeJoint : Joint
  {
    private PointOnPoint[] worldPointConstraint;
    private PointPointDistance distance;

    public PointOnPoint PointConstraint1 => this.worldPointConstraint[0];

    public PointOnPoint PointConstraint2 => this.worldPointConstraint[1];

    public PointPointDistance DistanceConstraint => this.distance;

    public LimitedHingeJoint(
      World world,
      JRigidbody body1,
      JRigidbody body2,
      JVector position,
      JVector hingeAxis,
      float hingeFwdAngle,
      float hingeBckAngle)
      : base(world)
    {
      this.worldPointConstraint = new PointOnPoint[2];
      hingeAxis *= 0.5f;
      JVector result1 = position;
      JVector.Add(ref result1, ref hingeAxis, out result1);
      JVector result2 = position;
      JVector.Subtract(ref result2, ref hingeAxis, out result2);
      this.worldPointConstraint[0] = new PointOnPoint(body1, body2, result1);
      this.worldPointConstraint[1] = new PointOnPoint(body1, body2, result2);
      hingeAxis.Normalize();
      JVector jvector1 = JVector.Up;
      if ((double) JVector.Dot(jvector1, hingeAxis) > 0.100000001490116)
        jvector1 = JVector.Right * -1f;
      JVector jvector2 = JVector.Cross(JVector.Cross(hingeAxis, jvector1), hingeAxis);
      jvector2.Normalize();
      float num1 = 30f;
      JVector position1 = jvector2 * num1;
      float num2 = (float) (0.5 * ((double) hingeFwdAngle - (double) hingeBckAngle));
      JVector jvector3 = JVector.Transform(position1, JMatrix.CreateFromAxisAngle(hingeAxis, (float) (-(double) num2 / 360.0 * 2.0 * 3.14159274101257)));
      float num3 = (float) (0.5 * ((double) hingeFwdAngle + (double) hingeBckAngle));
      float num4 = num1 * 2f * (float) Math.Sin((double) num3 * 0.5 / 360.0 * 2.0 * 3.14159274101257);
      JVector position2 = body1.Position;
      JVector anchor1 = position2 + position1;
      JVector anchor2 = position2 + jvector3;
      this.distance = new PointPointDistance(body1, body2, anchor1, anchor2);
      this.distance.Distance = num4;
      this.distance.Behavior = PointPointDistance.DistanceBehavior.LimitMaximumDistance;
    }

    public override void Activate()
    {
      this.World.AddConstraint((Constraint) this.worldPointConstraint[0]);
      this.World.AddConstraint((Constraint) this.worldPointConstraint[1]);
      this.World.AddConstraint((Constraint) this.distance);
    }

    public override void Deactivate()
    {
      this.World.RemoveConstraint((Constraint) this.worldPointConstraint[0]);
      this.World.RemoveConstraint((Constraint) this.worldPointConstraint[1]);
      this.World.RemoveConstraint((Constraint) this.distance);
    }
  }
}
