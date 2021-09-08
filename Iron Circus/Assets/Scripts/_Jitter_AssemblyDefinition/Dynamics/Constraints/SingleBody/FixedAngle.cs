// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Constraints.SingleBody.FixedAngle
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;

namespace Jitter.Dynamics.Constraints.SingleBody
{
  public class FixedAngle : Constraint
  {
    private float biasFactor = 0.05f;
    private float softness;
    private JMatrix orientation;
    private JVector accumulatedImpulse;
    private JMatrix effectiveMass;
    private JVector bias;
    private float softnessOverDt;

    public FixedAngle(JRigidbody body1)
      : base(body1, (JRigidbody) null)
    {
      this.orientation = body1.orientation;
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

    public JMatrix InitialOrientation
    {
      get => this.orientation;
      set => this.orientation = value;
    }

    public override void PrepareForIteration(float timestep)
    {
      this.effectiveMass = this.body1.invInertiaWorld;
      this.softnessOverDt = this.softness / timestep;
      this.effectiveMass.M11 += this.softnessOverDt;
      this.effectiveMass.M22 += this.softnessOverDt;
      this.effectiveMass.M33 += this.softnessOverDt;
      JMatrix.Inverse(ref this.effectiveMass, out this.effectiveMass);
      JMatrix jmatrix = JMatrix.Transpose(this.orientation) * this.body1.orientation;
      double num1 = (double) jmatrix.M32 - (double) jmatrix.M23;
      float y = jmatrix.M13 - jmatrix.M31;
      float z = jmatrix.M21 - jmatrix.M12;
      float num2 = JMath.Sqrt((float) (num1 * num1 + (double) y * (double) y + (double) z * (double) z));
      float num3 = jmatrix.M11 + jmatrix.M22 + jmatrix.M33;
      float num4 = (float) Math.Atan2((double) num2, (double) num3 - 1.0);
      JVector jvector = new JVector((float) num1, y, z) * num4;
      if ((double) num2 != 0.0)
        jvector *= 1f / num2;
      this.bias = jvector * this.biasFactor * (-1f / timestep);
      if (this.body1.IsStatic)
        return;
      this.body1.angularVelocity += JVector.Transform(this.accumulatedImpulse, this.body1.invInertiaWorld);
    }

    public override void Iterate()
    {
      JVector position = -1f * JVector.Transform(this.body1.angularVelocity + this.bias + this.accumulatedImpulse * this.softnessOverDt, this.effectiveMass);
      this.accumulatedImpulse += position;
      if (this.body1.IsStatic)
        return;
      this.body1.angularVelocity += JVector.Transform(position, this.body1.invInertiaWorld);
    }
  }
}
