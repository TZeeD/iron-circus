// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Joints.HingeJoint
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Dynamics.Constraints;
using Jitter.LinearMath;

namespace Jitter.Dynamics.Joints
{
  public class HingeJoint : Joint
  {
    private PointOnPoint[] worldPointConstraint;

    public PointOnPoint PointConstraint1 => this.worldPointConstraint[0];

    public PointOnPoint PointConstraint2 => this.worldPointConstraint[1];

    public HingeJoint(
      World world,
      JRigidbody body1,
      JRigidbody body2,
      JVector position,
      JVector hingeAxis)
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
    }

    public PointOnPoint PointOnPointConstraint1 => this.worldPointConstraint[0];

    public PointOnPoint PointOnPointConstraint2 => this.worldPointConstraint[1];

    public float AppliedImpulse => this.worldPointConstraint[0].AppliedImpulse + this.worldPointConstraint[1].AppliedImpulse;

    public override void Activate()
    {
      this.World.AddConstraint((Constraint) this.worldPointConstraint[0]);
      this.World.AddConstraint((Constraint) this.worldPointConstraint[1]);
    }

    public override void Deactivate()
    {
      this.World.RemoveConstraint((Constraint) this.worldPointConstraint[0]);
      this.World.RemoveConstraint((Constraint) this.worldPointConstraint[1]);
    }
  }
}
