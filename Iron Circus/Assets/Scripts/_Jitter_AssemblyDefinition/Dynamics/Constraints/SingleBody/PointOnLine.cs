// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Constraints.SingleBody.PointOnLine
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;

namespace Jitter.Dynamics.Constraints.SingleBody
{
  public class PointOnLine : Constraint
  {
    private JVector localAnchor1;
    private JVector r1;
    private JVector lineNormal = JVector.Right * -1f;
    private JVector anchor;
    private float biasFactor = 0.5f;
    private float softness;
    private float effectiveMass;
    private float accumulatedImpulse;
    private float bias;
    private float softnessOverDt;
    private JVector[] jacobian = new JVector[2];

    public PointOnLine(JRigidbody body, JVector localAnchor, JVector lineDirection)
      : base(body, (JRigidbody) null)
    {
      if ((double) lineDirection.LengthSquared() == 0.0)
        throw new ArgumentException("Line direction can't be zero", nameof (lineDirection));
      this.localAnchor1 = localAnchor;
      this.anchor = body.position + JVector.Transform(localAnchor, body.orientation);
      this.lineNormal = lineDirection;
      this.lineNormal.Normalize();
    }

    public JVector Anchor
    {
      get => this.anchor;
      set => this.anchor = value;
    }

    public JVector Axis
    {
      get => this.lineNormal;
      set
      {
        this.lineNormal = value;
        this.lineNormal.Normalize();
      }
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
      JVector.Transform(ref this.localAnchor1, ref this.body1.orientation, out this.r1);
      JVector result;
      JVector.Add(ref this.body1.position, ref this.r1, out result);
      JVector.Subtract(ref result, ref this.anchor, out JVector _);
      JVector lineNormal = this.lineNormal;
      JVector jvector = (result - this.anchor) % lineNormal;
      if ((double) jvector.LengthSquared() != 0.0)
        jvector.Normalize();
      jvector %= lineNormal;
      this.jacobian[0] = jvector;
      this.jacobian[1] = this.r1 % jvector;
      this.effectiveMass = this.body1.inverseMass + JVector.Transform(this.jacobian[1], this.body1.invInertiaWorld) * this.jacobian[1];
      this.softnessOverDt = this.softness / timestep;
      this.effectiveMass += this.softnessOverDt;
      if ((double) this.effectiveMass != 0.0)
        this.effectiveMass = 1f / this.effectiveMass;
      this.bias = (float) (-(double) (lineNormal % (result - this.anchor)).Length() * (double) this.biasFactor * (1.0 / (double) timestep));
      if (this.body1.isStatic)
        return;
      this.body1.linearVelocity += this.body1.inverseMass * this.accumulatedImpulse * this.jacobian[0];
      this.body1.angularVelocity += JVector.Transform(this.accumulatedImpulse * this.jacobian[1], this.body1.invInertiaWorld);
    }

    public override void Iterate()
    {
      float num = (float) (-(double) this.effectiveMass * ((double) (this.body1.linearVelocity * this.jacobian[0] + this.body1.angularVelocity * this.jacobian[1]) + (double) this.bias + (double) (this.accumulatedImpulse * this.softnessOverDt)));
      this.accumulatedImpulse += num;
      if (this.body1.isStatic)
        return;
      this.body1.linearVelocity += this.body1.inverseMass * num * this.jacobian[0];
      this.body1.angularVelocity += JVector.Transform(num * this.jacobian[1], this.body1.invInertiaWorld);
    }

    public override void DebugDraw(IDebugDrawer drawer)
    {
      drawer.DrawLine(this.anchor - this.lineNormal * 50f, this.anchor + this.lineNormal * 50f);
      drawer.DrawLine(this.body1.position, this.body1.position + this.r1);
    }
  }
}
