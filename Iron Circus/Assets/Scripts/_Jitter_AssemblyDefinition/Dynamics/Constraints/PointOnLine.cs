﻿// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Constraints.PointOnLine
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter.Dynamics.Constraints
{
  public class PointOnLine : Constraint
  {
    private JVector lineNormal;
    private JVector localAnchor1;
    private JVector localAnchor2;
    private JVector r1;
    private JVector r2;
    private float biasFactor = 0.5f;
    private float softness;
    private float effectiveMass;
    private float accumulatedImpulse;
    private float bias;
    private float softnessOverDt;
    private JVector[] jacobian = new JVector[4];

    public PointOnLine(
      JRigidbody body1,
      JRigidbody body2,
      JVector lineStartPointBody1,
      JVector pointBody2)
      : base(body1, body2)
    {
      JVector.Subtract(ref lineStartPointBody1, ref body1.position, out this.localAnchor1);
      JVector.Subtract(ref pointBody2, ref body2.position, out this.localAnchor2);
      JVector.Transform(ref this.localAnchor1, ref body1.invOrientation, out this.localAnchor1);
      JVector.Transform(ref this.localAnchor2, ref body2.invOrientation, out this.localAnchor2);
      this.lineNormal = JVector.Normalize(lineStartPointBody1 - pointBody2);
    }

    public float AppliedImpulse => this.accumulatedImpulse;

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
      JVector.Transform(ref this.localAnchor1, ref this.body1.orientation, out this.r1);
      JVector.Transform(ref this.localAnchor2, ref this.body2.orientation, out this.r2);
      JVector result1;
      JVector.Add(ref this.body1.position, ref this.r1, out result1);
      JVector result2;
      JVector.Add(ref this.body2.position, ref this.r2, out result2);
      JVector.Subtract(ref result2, ref result1, out JVector _);
      JVector jvector1 = JVector.Transform(this.lineNormal, this.body1.orientation);
      jvector1.Normalize();
      JVector jvector2 = (result1 - result2) % jvector1;
      if ((double) jvector2.LengthSquared() != 0.0)
        jvector2.Normalize();
      jvector2 %= jvector1;
      this.jacobian[0] = jvector2;
      this.jacobian[1] = (this.r1 + result2 - result1) % jvector2;
      this.jacobian[2] = -1f * jvector2;
      this.jacobian[3] = -1f * this.r2 % jvector2;
      this.effectiveMass = this.body1.inverseMass + this.body2.inverseMass + JVector.Transform(this.jacobian[1], this.body1.invInertiaWorld) * this.jacobian[1] + JVector.Transform(this.jacobian[3], this.body2.invInertiaWorld) * this.jacobian[3];
      this.softnessOverDt = this.softness / timestep;
      this.effectiveMass += this.softnessOverDt;
      if ((double) this.effectiveMass != 0.0)
        this.effectiveMass = 1f / this.effectiveMass;
      this.bias = (float) (-(double) (jvector1 % (result2 - result1)).Length() * (double) this.biasFactor * (1.0 / (double) timestep));
      if (!this.body1.isStatic)
      {
        this.body1.linearVelocity += this.body1.inverseMass * this.accumulatedImpulse * this.jacobian[0];
        this.body1.angularVelocity += JVector.Transform(this.accumulatedImpulse * this.jacobian[1], this.body1.invInertiaWorld);
      }
      if (this.body2.isStatic)
        return;
      this.body2.linearVelocity += this.body2.inverseMass * this.accumulatedImpulse * this.jacobian[2];
      this.body2.angularVelocity += JVector.Transform(this.accumulatedImpulse * this.jacobian[3], this.body2.invInertiaWorld);
    }

    public override void Iterate()
    {
      float num = (float) (-(double) this.effectiveMass * ((double) (this.body1.linearVelocity * this.jacobian[0] + this.body1.angularVelocity * this.jacobian[1] + this.body2.linearVelocity * this.jacobian[2] + this.body2.angularVelocity * this.jacobian[3]) + (double) this.bias + (double) (this.accumulatedImpulse * this.softnessOverDt)));
      this.accumulatedImpulse += num;
      if (!this.body1.isStatic)
      {
        this.body1.linearVelocity += this.body1.inverseMass * num * this.jacobian[0];
        this.body1.angularVelocity += JVector.Transform(num * this.jacobian[1], this.body1.invInertiaWorld);
      }
      if (this.body2.isStatic)
        return;
      this.body2.linearVelocity += this.body2.inverseMass * num * this.jacobian[2];
      this.body2.angularVelocity += JVector.Transform(num * this.jacobian[3], this.body2.invInertiaWorld);
    }

    public override void DebugDraw(IDebugDrawer drawer) => drawer.DrawLine(this.body1.position + this.r1, this.body1.position + this.r1 + JVector.Transform(this.lineNormal, this.body1.orientation) * 100f);
  }
}
