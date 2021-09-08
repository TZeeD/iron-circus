// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Constraints.SingleBody.PointOnPoint
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter.Dynamics.Constraints.SingleBody
{
  public class PointOnPoint : Constraint
  {
    private JVector localAnchor1;
    private JVector anchor;
    private JVector r1;
    private float biasFactor = 0.1f;
    private float softness = 0.01f;
    private float effectiveMass;
    private float accumulatedImpulse;
    private float bias;
    private float softnessOverDt;
    private JVector[] jacobian = new JVector[2];

    public PointOnPoint(JRigidbody body, JVector localAnchor)
      : base(body, (JRigidbody) null)
    {
      this.localAnchor1 = localAnchor;
      this.anchor = body.position + JVector.Transform(localAnchor, body.orientation);
    }

    public float AppliedImpulse => this.accumulatedImpulse;

    public float Softness
    {
      get => this.softness;
      set => this.softness = value;
    }

    public JVector Anchor
    {
      get => this.anchor;
      set => this.anchor = value;
    }

    public float BiasFactor
    {
      get => this.biasFactor;
      set => this.biasFactor = value;
    }

    public override void PrepareForIteration(float timestep)
    {
      JVector.Transform(ref this.localAnchor1, ref this.body1.orientation, out this.r1);
      JVector result1;
      JVector.Add(ref this.body1.position, ref this.r1, out result1);
      JVector result2;
      JVector.Subtract(ref result1, ref this.anchor, out result2);
      float num = result2.Length();
      JVector jvector = this.anchor - result1;
      if ((double) jvector.LengthSquared() != 0.0)
        jvector.Normalize();
      this.jacobian[0] = -1f * jvector;
      this.jacobian[1] = -1f * (this.r1 % jvector);
      this.effectiveMass = this.body1.inverseMass + JVector.Transform(this.jacobian[1], this.body1.invInertiaWorld) * this.jacobian[1];
      this.softnessOverDt = this.softness / timestep;
      this.effectiveMass += this.softnessOverDt;
      this.effectiveMass = 1f / this.effectiveMass;
      this.bias = (float) ((double) num * (double) this.biasFactor * (1.0 / (double) timestep));
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

    public override void DebugDraw(IDebugDrawer drawer) => drawer.DrawPoint(this.anchor);
  }
}
