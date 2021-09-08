// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Contact
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;

namespace Jitter.Dynamics
{
  public class Contact : IConstraint
  {
    private ContactSettings settings;
    internal JRigidbody body1;
    internal JRigidbody body2;
    internal JVector normal;
    internal JVector tangent;
    internal JVector realRelPos1;
    internal JVector realRelPos2;
    internal JVector relativePos1;
    internal JVector relativePos2;
    internal JVector p1;
    internal JVector p2;
    internal float accumulatedNormalImpulse;
    internal float accumulatedTangentImpulse;
    internal float penetration;
    internal float initialPen;
    private float staticFriction;
    private float dynamicFriction;
    private float restitution;
    private float friction;
    private float massNormal;
    private float massTangent;
    private float restitutionBias;
    private bool newContact;
    private bool treatBody1AsStatic;
    private bool treatBody2AsStatic;
    private bool body1IsMassPoint;
    private bool body2IsMassPoint;
    private float lostSpeculativeBounce;
    private float speculativeVelocity;
    public static readonly ResourcePool<Contact> Pool = new ResourcePool<Contact>();
    private float lastTimeStep = float.PositiveInfinity;

    public float Restitution
    {
      get => this.restitution;
      set => this.restitution = value;
    }

    public float StaticFriction
    {
      get => this.staticFriction;
      set => this.staticFriction = value;
    }

    public float DynamicFriction
    {
      get => this.dynamicFriction;
      set => this.dynamicFriction = value;
    }

    public JRigidbody Body1 => this.body1;

    public JRigidbody Body2 => this.body2;

    public float Penetration => this.penetration;

    public JVector Position1 => this.p1;

    public JVector Position2 => this.p2;

    public JVector Tangent => this.tangent;

    public JVector Normal => this.normal;

    public JVector CalculateRelativeVelocity()
    {
      float num1 = (float) ((double) this.body2.angularVelocity.Y * (double) this.relativePos2.Z - (double) this.body2.angularVelocity.Z * (double) this.relativePos2.Y) + this.body2.linearVelocity.X;
      float num2 = (float) ((double) this.body2.angularVelocity.Z * (double) this.relativePos2.X - (double) this.body2.angularVelocity.X * (double) this.relativePos2.Z) + this.body2.linearVelocity.Y;
      float num3 = (float) ((double) this.body2.angularVelocity.X * (double) this.relativePos2.Y - (double) this.body2.angularVelocity.Y * (double) this.relativePos2.X) + this.body2.linearVelocity.Z;
      JVector jvector;
      jvector.X = (float) ((double) num1 - (double) this.body1.angularVelocity.Y * (double) this.relativePos1.Z + (double) this.body1.angularVelocity.Z * (double) this.relativePos1.Y) - this.body1.linearVelocity.X;
      jvector.Y = (float) ((double) num2 - (double) this.body1.angularVelocity.Z * (double) this.relativePos1.X + (double) this.body1.angularVelocity.X * (double) this.relativePos1.Z) - this.body1.linearVelocity.Y;
      jvector.Z = (float) ((double) num3 - (double) this.body1.angularVelocity.X * (double) this.relativePos1.Y + (double) this.body1.angularVelocity.Y * (double) this.relativePos1.X) - this.body1.linearVelocity.Z;
      return jvector;
    }

    public void Iterate()
    {
      if (this.treatBody1AsStatic && this.treatBody2AsStatic || this.body1.isTrigger || this.body2.isTrigger)
        return;
      float num1 = this.body2.linearVelocity.X - this.body1.linearVelocity.X;
      float num2 = this.body2.linearVelocity.Y - this.body1.linearVelocity.Y;
      float num3 = this.body2.linearVelocity.Z - this.body1.linearVelocity.Z;
      if (!this.body1IsMassPoint)
      {
        num1 = (float) ((double) num1 - (double) this.body1.angularVelocity.Y * (double) this.relativePos1.Z + (double) this.body1.angularVelocity.Z * (double) this.relativePos1.Y);
        num2 = (float) ((double) num2 - (double) this.body1.angularVelocity.Z * (double) this.relativePos1.X + (double) this.body1.angularVelocity.X * (double) this.relativePos1.Z);
        num3 = (float) ((double) num3 - (double) this.body1.angularVelocity.X * (double) this.relativePos1.Y + (double) this.body1.angularVelocity.Y * (double) this.relativePos1.X);
      }
      if (!this.body2IsMassPoint)
      {
        num1 = (float) ((double) num1 + (double) this.body2.angularVelocity.Y * (double) this.relativePos2.Z - (double) this.body2.angularVelocity.Z * (double) this.relativePos2.Y);
        num2 = (float) ((double) num2 + (double) this.body2.angularVelocity.Z * (double) this.relativePos2.X - (double) this.body2.angularVelocity.X * (double) this.relativePos2.Z);
        num3 = (float) ((double) num3 + (double) this.body2.angularVelocity.X * (double) this.relativePos2.Y - (double) this.body2.angularVelocity.Y * (double) this.relativePos2.X);
      }
      float num4 = this.massNormal * ((float) -((double) this.normal.X * (double) num1 + (double) this.normal.Y * (double) num2 + (double) this.normal.Z * (double) num3) + this.restitutionBias + this.speculativeVelocity);
      float accumulatedNormalImpulse = this.accumulatedNormalImpulse;
      this.accumulatedNormalImpulse = accumulatedNormalImpulse + num4;
      if ((double) this.accumulatedNormalImpulse < 0.0)
        this.accumulatedNormalImpulse = 0.0f;
      float num5 = this.accumulatedNormalImpulse - accumulatedNormalImpulse;
      float num6 = (float) ((double) num1 * (double) this.tangent.X + (double) num2 * (double) this.tangent.Y + (double) num3 * (double) this.tangent.Z);
      float num7 = this.friction * this.accumulatedNormalImpulse;
      float num8 = this.massTangent * -num6;
      float accumulatedTangentImpulse = this.accumulatedTangentImpulse;
      this.accumulatedTangentImpulse = accumulatedTangentImpulse + num8;
      if ((double) this.accumulatedTangentImpulse < -(double) num7)
        this.accumulatedTangentImpulse = -num7;
      else if ((double) this.accumulatedTangentImpulse > (double) num7)
        this.accumulatedTangentImpulse = num7;
      float num9 = this.accumulatedTangentImpulse - accumulatedTangentImpulse;
      JVector jvector;
      jvector.X = (float) ((double) this.normal.X * (double) num5 + (double) this.tangent.X * (double) num9);
      jvector.Y = (float) ((double) this.normal.Y * (double) num5 + (double) this.tangent.Y * (double) num9);
      jvector.Z = (float) ((double) this.normal.Z * (double) num5 + (double) this.tangent.Z * (double) num9);
      if (!this.treatBody1AsStatic)
      {
        this.body1.linearVelocity.X -= jvector.X * this.body1.inverseMass;
        this.body1.linearVelocity.Y -= jvector.Y * this.body1.inverseMass;
        this.body1.linearVelocity.Z -= jvector.Z * this.body1.inverseMass;
        if (!this.body1IsMassPoint)
        {
          double num10 = (double) this.relativePos1.Y * (double) jvector.Z - (double) this.relativePos1.Z * (double) jvector.Y;
          float num11 = (float) ((double) this.relativePos1.Z * (double) jvector.X - (double) this.relativePos1.X * (double) jvector.Z);
          float num12 = (float) ((double) this.relativePos1.X * (double) jvector.Y - (double) this.relativePos1.Y * (double) jvector.X);
          float num13 = (float) (num10 * (double) this.body1.invInertiaWorld.M11 + (double) num11 * (double) this.body1.invInertiaWorld.M21 + (double) num12 * (double) this.body1.invInertiaWorld.M31);
          float num14 = (float) (num10 * (double) this.body1.invInertiaWorld.M12 + (double) num11 * (double) this.body1.invInertiaWorld.M22 + (double) num12 * (double) this.body1.invInertiaWorld.M32);
          float num15 = (float) (num10 * (double) this.body1.invInertiaWorld.M13 + (double) num11 * (double) this.body1.invInertiaWorld.M23 + (double) num12 * (double) this.body1.invInertiaWorld.M33);
          this.body1.angularVelocity.X -= num13;
          this.body1.angularVelocity.Y -= num14;
          this.body1.angularVelocity.Z -= num15;
        }
      }
      if (this.treatBody2AsStatic)
        return;
      this.body2.linearVelocity.X += jvector.X * this.body2.inverseMass;
      this.body2.linearVelocity.Y += jvector.Y * this.body2.inverseMass;
      this.body2.linearVelocity.Z += jvector.Z * this.body2.inverseMass;
      if (this.body2IsMassPoint)
        return;
      double num16 = (double) this.relativePos2.Y * (double) jvector.Z - (double) this.relativePos2.Z * (double) jvector.Y;
      float num17 = (float) ((double) this.relativePos2.Z * (double) jvector.X - (double) this.relativePos2.X * (double) jvector.Z);
      float num18 = (float) ((double) this.relativePos2.X * (double) jvector.Y - (double) this.relativePos2.Y * (double) jvector.X);
      float num19 = (float) (num16 * (double) this.body2.invInertiaWorld.M11 + (double) num17 * (double) this.body2.invInertiaWorld.M21 + (double) num18 * (double) this.body2.invInertiaWorld.M31);
      float num20 = (float) (num16 * (double) this.body2.invInertiaWorld.M12 + (double) num17 * (double) this.body2.invInertiaWorld.M22 + (double) num18 * (double) this.body2.invInertiaWorld.M32);
      float num21 = (float) (num16 * (double) this.body2.invInertiaWorld.M13 + (double) num17 * (double) this.body2.invInertiaWorld.M23 + (double) num18 * (double) this.body2.invInertiaWorld.M33);
      this.body2.angularVelocity.X += num19;
      this.body2.angularVelocity.Y += num20;
      this.body2.angularVelocity.Z += num21;
    }

    public float AppliedNormalImpulse => this.accumulatedNormalImpulse;

    public float AppliedTangentImpulse => this.accumulatedTangentImpulse;

    public void UpdatePosition()
    {
      if (this.body1.isTrigger || this.body2.isTrigger)
        return;
      if (this.body1IsMassPoint)
      {
        JVector.Add(ref this.realRelPos1, ref this.body1.position, out this.p1);
      }
      else
      {
        JVector.Transform(ref this.realRelPos1, ref this.body1.orientation, out this.p1);
        JVector.Add(ref this.p1, ref this.body1.position, out this.p1);
      }
      if (this.body2IsMassPoint)
      {
        JVector.Add(ref this.realRelPos2, ref this.body2.position, out this.p2);
      }
      else
      {
        JVector.Transform(ref this.realRelPos2, ref this.body2.orientation, out this.p2);
        JVector.Add(ref this.p2, ref this.body2.position, out this.p2);
      }
      JVector result;
      JVector.Subtract(ref this.p1, ref this.p2, out result);
      this.penetration = JVector.Dot(ref result, ref this.normal);
    }

    public void ApplyImpulse(ref JVector impulse)
    {
      if (this.body1.isTrigger || this.body2.isTrigger)
        return;
      if (!this.treatBody1AsStatic)
      {
        this.body1.linearVelocity.X -= impulse.X * this.body1.inverseMass;
        this.body1.linearVelocity.Y -= impulse.Y * this.body1.inverseMass;
        this.body1.linearVelocity.Z -= impulse.Z * this.body1.inverseMass;
        double num1 = (double) this.relativePos1.Y * (double) impulse.Z - (double) this.relativePos1.Z * (double) impulse.Y;
        float num2 = (float) ((double) this.relativePos1.Z * (double) impulse.X - (double) this.relativePos1.X * (double) impulse.Z);
        float num3 = (float) ((double) this.relativePos1.X * (double) impulse.Y - (double) this.relativePos1.Y * (double) impulse.X);
        float num4 = (float) (num1 * (double) this.body1.invInertiaWorld.M11 + (double) num2 * (double) this.body1.invInertiaWorld.M21 + (double) num3 * (double) this.body1.invInertiaWorld.M31);
        float num5 = (float) (num1 * (double) this.body1.invInertiaWorld.M12 + (double) num2 * (double) this.body1.invInertiaWorld.M22 + (double) num3 * (double) this.body1.invInertiaWorld.M32);
        float num6 = (float) (num1 * (double) this.body1.invInertiaWorld.M13 + (double) num2 * (double) this.body1.invInertiaWorld.M23 + (double) num3 * (double) this.body1.invInertiaWorld.M33);
        this.body1.angularVelocity.X -= num4;
        this.body1.angularVelocity.Y -= num5;
        this.body1.angularVelocity.Z -= num6;
      }
      if (this.treatBody2AsStatic)
        return;
      this.body2.linearVelocity.X += impulse.X * this.body2.inverseMass;
      this.body2.linearVelocity.Y += impulse.Y * this.body2.inverseMass;
      this.body2.linearVelocity.Z += impulse.Z * this.body2.inverseMass;
      double num7 = (double) this.relativePos2.Y * (double) impulse.Z - (double) this.relativePos2.Z * (double) impulse.Y;
      float num8 = (float) ((double) this.relativePos2.Z * (double) impulse.X - (double) this.relativePos2.X * (double) impulse.Z);
      float num9 = (float) ((double) this.relativePos2.X * (double) impulse.Y - (double) this.relativePos2.Y * (double) impulse.X);
      float num10 = (float) (num7 * (double) this.body2.invInertiaWorld.M11 + (double) num8 * (double) this.body2.invInertiaWorld.M21 + (double) num9 * (double) this.body2.invInertiaWorld.M31);
      float num11 = (float) (num7 * (double) this.body2.invInertiaWorld.M12 + (double) num8 * (double) this.body2.invInertiaWorld.M22 + (double) num9 * (double) this.body2.invInertiaWorld.M32);
      float num12 = (float) (num7 * (double) this.body2.invInertiaWorld.M13 + (double) num8 * (double) this.body2.invInertiaWorld.M23 + (double) num9 * (double) this.body2.invInertiaWorld.M33);
      this.body2.angularVelocity.X += num10;
      this.body2.angularVelocity.Y += num11;
      this.body2.angularVelocity.Z += num12;
    }

    public void ApplyImpulse(JVector impulse)
    {
      if (this.body1.isTrigger || this.body2.isTrigger)
        return;
      if (!this.treatBody1AsStatic)
      {
        this.body1.linearVelocity.X -= impulse.X * this.body1.inverseMass;
        this.body1.linearVelocity.Y -= impulse.Y * this.body1.inverseMass;
        this.body1.linearVelocity.Z -= impulse.Z * this.body1.inverseMass;
        double num1 = (double) this.relativePos1.Y * (double) impulse.Z - (double) this.relativePos1.Z * (double) impulse.Y;
        float num2 = (float) ((double) this.relativePos1.Z * (double) impulse.X - (double) this.relativePos1.X * (double) impulse.Z);
        float num3 = (float) ((double) this.relativePos1.X * (double) impulse.Y - (double) this.relativePos1.Y * (double) impulse.X);
        float num4 = (float) (num1 * (double) this.body1.invInertiaWorld.M11 + (double) num2 * (double) this.body1.invInertiaWorld.M21 + (double) num3 * (double) this.body1.invInertiaWorld.M31);
        float num5 = (float) (num1 * (double) this.body1.invInertiaWorld.M12 + (double) num2 * (double) this.body1.invInertiaWorld.M22 + (double) num3 * (double) this.body1.invInertiaWorld.M32);
        float num6 = (float) (num1 * (double) this.body1.invInertiaWorld.M13 + (double) num2 * (double) this.body1.invInertiaWorld.M23 + (double) num3 * (double) this.body1.invInertiaWorld.M33);
        this.body1.angularVelocity.X -= num4;
        this.body1.angularVelocity.Y -= num5;
        this.body1.angularVelocity.Z -= num6;
      }
      if (this.treatBody2AsStatic)
        return;
      this.body2.linearVelocity.X += impulse.X * this.body2.inverseMass;
      this.body2.linearVelocity.Y += impulse.Y * this.body2.inverseMass;
      this.body2.linearVelocity.Z += impulse.Z * this.body2.inverseMass;
      double num7 = (double) this.relativePos2.Y * (double) impulse.Z - (double) this.relativePos2.Z * (double) impulse.Y;
      float num8 = (float) ((double) this.relativePos2.Z * (double) impulse.X - (double) this.relativePos2.X * (double) impulse.Z);
      float num9 = (float) ((double) this.relativePos2.X * (double) impulse.Y - (double) this.relativePos2.Y * (double) impulse.X);
      float num10 = (float) (num7 * (double) this.body2.invInertiaWorld.M11 + (double) num8 * (double) this.body2.invInertiaWorld.M21 + (double) num9 * (double) this.body2.invInertiaWorld.M31);
      float num11 = (float) (num7 * (double) this.body2.invInertiaWorld.M12 + (double) num8 * (double) this.body2.invInertiaWorld.M22 + (double) num9 * (double) this.body2.invInertiaWorld.M32);
      float num12 = (float) (num7 * (double) this.body2.invInertiaWorld.M13 + (double) num8 * (double) this.body2.invInertiaWorld.M23 + (double) num9 * (double) this.body2.invInertiaWorld.M33);
      this.body2.angularVelocity.X += num10;
      this.body2.angularVelocity.Y += num11;
      this.body2.angularVelocity.Z += num12;
    }

    public void PrepareForIteration(float timestep)
    {
      if (this.body1.isTrigger || this.body2.isTrigger)
        return;
      float num1 = (float) ((double) this.body2.angularVelocity.Y * (double) this.relativePos2.Z - (double) this.body2.angularVelocity.Z * (double) this.relativePos2.Y) + this.body2.linearVelocity.X;
      float num2 = (float) ((double) this.body2.angularVelocity.Z * (double) this.relativePos2.X - (double) this.body2.angularVelocity.X * (double) this.relativePos2.Z) + this.body2.linearVelocity.Y;
      float num3 = (float) ((double) this.body2.angularVelocity.X * (double) this.relativePos2.Y - (double) this.body2.angularVelocity.Y * (double) this.relativePos2.X) + this.body2.linearVelocity.Z;
      float num4 = (float) ((double) num1 - (double) this.body1.angularVelocity.Y * (double) this.relativePos1.Z + (double) this.body1.angularVelocity.Z * (double) this.relativePos1.Y) - this.body1.linearVelocity.X;
      float num5 = (float) ((double) num2 - (double) this.body1.angularVelocity.Z * (double) this.relativePos1.X + (double) this.body1.angularVelocity.X * (double) this.relativePos1.Z) - this.body1.linearVelocity.Y;
      float num6 = (float) ((double) num3 - (double) this.body1.angularVelocity.X * (double) this.relativePos1.Y + (double) this.body1.angularVelocity.Y * (double) this.relativePos1.X) - this.body1.linearVelocity.Z;
      float num7 = 0.0f;
      JVector zero1 = JVector.Zero;
      if (!this.treatBody1AsStatic)
      {
        num7 += this.body1.inverseMass;
        if (!this.body1IsMassPoint)
        {
          zero1.X = (float) ((double) this.relativePos1.Y * (double) this.normal.Z - (double) this.relativePos1.Z * (double) this.normal.Y);
          zero1.Y = (float) ((double) this.relativePos1.Z * (double) this.normal.X - (double) this.relativePos1.X * (double) this.normal.Z);
          zero1.Z = (float) ((double) this.relativePos1.X * (double) this.normal.Y - (double) this.relativePos1.Y * (double) this.normal.X);
          float num8 = (float) ((double) zero1.X * (double) this.body1.invInertiaWorld.M11 + (double) zero1.Y * (double) this.body1.invInertiaWorld.M21 + (double) zero1.Z * (double) this.body1.invInertiaWorld.M31);
          float num9 = (float) ((double) zero1.X * (double) this.body1.invInertiaWorld.M12 + (double) zero1.Y * (double) this.body1.invInertiaWorld.M22 + (double) zero1.Z * (double) this.body1.invInertiaWorld.M32);
          float num10 = (float) ((double) zero1.X * (double) this.body1.invInertiaWorld.M13 + (double) zero1.Y * (double) this.body1.invInertiaWorld.M23 + (double) zero1.Z * (double) this.body1.invInertiaWorld.M33);
          zero1.X = num8;
          zero1.Y = num9;
          zero1.Z = num10;
          float num11 = (float) ((double) zero1.Y * (double) this.relativePos1.Z - (double) zero1.Z * (double) this.relativePos1.Y);
          float num12 = (float) ((double) zero1.Z * (double) this.relativePos1.X - (double) zero1.X * (double) this.relativePos1.Z);
          float num13 = (float) ((double) zero1.X * (double) this.relativePos1.Y - (double) zero1.Y * (double) this.relativePos1.X);
          zero1.X = num11;
          zero1.Y = num12;
          zero1.Z = num13;
        }
      }
      JVector zero2 = JVector.Zero;
      if (!this.treatBody2AsStatic)
      {
        num7 += this.body2.inverseMass;
        if (!this.body2IsMassPoint)
        {
          zero2.X = (float) ((double) this.relativePos2.Y * (double) this.normal.Z - (double) this.relativePos2.Z * (double) this.normal.Y);
          zero2.Y = (float) ((double) this.relativePos2.Z * (double) this.normal.X - (double) this.relativePos2.X * (double) this.normal.Z);
          zero2.Z = (float) ((double) this.relativePos2.X * (double) this.normal.Y - (double) this.relativePos2.Y * (double) this.normal.X);
          float num14 = (float) ((double) zero2.X * (double) this.body2.invInertiaWorld.M11 + (double) zero2.Y * (double) this.body2.invInertiaWorld.M21 + (double) zero2.Z * (double) this.body2.invInertiaWorld.M31);
          float num15 = (float) ((double) zero2.X * (double) this.body2.invInertiaWorld.M12 + (double) zero2.Y * (double) this.body2.invInertiaWorld.M22 + (double) zero2.Z * (double) this.body2.invInertiaWorld.M32);
          float num16 = (float) ((double) zero2.X * (double) this.body2.invInertiaWorld.M13 + (double) zero2.Y * (double) this.body2.invInertiaWorld.M23 + (double) zero2.Z * (double) this.body2.invInertiaWorld.M33);
          zero2.X = num14;
          zero2.Y = num15;
          zero2.Z = num16;
          float num17 = (float) ((double) zero2.Y * (double) this.relativePos2.Z - (double) zero2.Z * (double) this.relativePos2.Y);
          float num18 = (float) ((double) zero2.Z * (double) this.relativePos2.X - (double) zero2.X * (double) this.relativePos2.Z);
          float num19 = (float) ((double) zero2.X * (double) this.relativePos2.Y - (double) zero2.Y * (double) this.relativePos2.X);
          zero2.X = num17;
          zero2.Y = num18;
          zero2.Z = num19;
        }
      }
      if (!this.treatBody1AsStatic)
        num7 += (float) ((double) zero1.X * (double) this.normal.X + (double) zero1.Y * (double) this.normal.Y + (double) zero1.Z * (double) this.normal.Z);
      if (!this.treatBody2AsStatic)
        num7 += (float) ((double) zero2.X * (double) this.normal.X + (double) zero2.Y * (double) this.normal.Y + (double) zero2.Z * (double) this.normal.Z);
      this.massNormal = 1f / num7;
      float num20 = (float) ((double) num4 * (double) this.normal.X + (double) num5 * (double) this.normal.Y + (double) num6 * (double) this.normal.Z);
      this.tangent.X = num4 - this.normal.X * num20;
      this.tangent.Y = num5 - this.normal.Y * num20;
      this.tangent.Z = num6 - this.normal.Z * num20;
      float num21 = (float) ((double) this.tangent.X * (double) this.tangent.X + (double) this.tangent.Y * (double) this.tangent.Y + (double) this.tangent.Z * (double) this.tangent.Z);
      if ((double) num21 != 0.0)
      {
        float num22 = (float) Math.Sqrt((double) num21);
        this.tangent.X /= num22;
        this.tangent.Y /= num22;
        this.tangent.Z /= num22;
      }
      float num23 = 0.0f;
      if (this.treatBody1AsStatic)
      {
        zero1.MakeZero();
      }
      else
      {
        num23 += this.body1.inverseMass;
        if (!this.body1IsMassPoint)
        {
          zero1.X = (float) ((double) this.relativePos1.Y * (double) this.tangent.Z - (double) this.relativePos1.Z * (double) this.tangent.Y);
          zero1.Y = (float) ((double) this.relativePos1.Z * (double) this.tangent.X - (double) this.relativePos1.X * (double) this.tangent.Z);
          zero1.Z = (float) ((double) this.relativePos1.X * (double) this.tangent.Y - (double) this.relativePos1.Y * (double) this.tangent.X);
          float num24 = (float) ((double) zero1.X * (double) this.body1.invInertiaWorld.M11 + (double) zero1.Y * (double) this.body1.invInertiaWorld.M21 + (double) zero1.Z * (double) this.body1.invInertiaWorld.M31);
          float num25 = (float) ((double) zero1.X * (double) this.body1.invInertiaWorld.M12 + (double) zero1.Y * (double) this.body1.invInertiaWorld.M22 + (double) zero1.Z * (double) this.body1.invInertiaWorld.M32);
          float num26 = (float) ((double) zero1.X * (double) this.body1.invInertiaWorld.M13 + (double) zero1.Y * (double) this.body1.invInertiaWorld.M23 + (double) zero1.Z * (double) this.body1.invInertiaWorld.M33);
          zero1.X = num24;
          zero1.Y = num25;
          zero1.Z = num26;
          float num27 = (float) ((double) zero1.Y * (double) this.relativePos1.Z - (double) zero1.Z * (double) this.relativePos1.Y);
          float num28 = (float) ((double) zero1.Z * (double) this.relativePos1.X - (double) zero1.X * (double) this.relativePos1.Z);
          float num29 = (float) ((double) zero1.X * (double) this.relativePos1.Y - (double) zero1.Y * (double) this.relativePos1.X);
          zero1.X = num27;
          zero1.Y = num28;
          zero1.Z = num29;
        }
      }
      if (this.treatBody2AsStatic)
      {
        zero2.MakeZero();
      }
      else
      {
        num23 += this.body2.inverseMass;
        if (!this.body2IsMassPoint)
        {
          zero2.X = (float) ((double) this.relativePos2.Y * (double) this.tangent.Z - (double) this.relativePos2.Z * (double) this.tangent.Y);
          zero2.Y = (float) ((double) this.relativePos2.Z * (double) this.tangent.X - (double) this.relativePos2.X * (double) this.tangent.Z);
          zero2.Z = (float) ((double) this.relativePos2.X * (double) this.tangent.Y - (double) this.relativePos2.Y * (double) this.tangent.X);
          float num30 = (float) ((double) zero2.X * (double) this.body2.invInertiaWorld.M11 + (double) zero2.Y * (double) this.body2.invInertiaWorld.M21 + (double) zero2.Z * (double) this.body2.invInertiaWorld.M31);
          float num31 = (float) ((double) zero2.X * (double) this.body2.invInertiaWorld.M12 + (double) zero2.Y * (double) this.body2.invInertiaWorld.M22 + (double) zero2.Z * (double) this.body2.invInertiaWorld.M32);
          float num32 = (float) ((double) zero2.X * (double) this.body2.invInertiaWorld.M13 + (double) zero2.Y * (double) this.body2.invInertiaWorld.M23 + (double) zero2.Z * (double) this.body2.invInertiaWorld.M33);
          zero2.X = num30;
          zero2.Y = num31;
          zero2.Z = num32;
          float num33 = (float) ((double) zero2.Y * (double) this.relativePos2.Z - (double) zero2.Z * (double) this.relativePos2.Y);
          float num34 = (float) ((double) zero2.Z * (double) this.relativePos2.X - (double) zero2.X * (double) this.relativePos2.Z);
          float num35 = (float) ((double) zero2.X * (double) this.relativePos2.Y - (double) zero2.Y * (double) this.relativePos2.X);
          zero2.X = num33;
          zero2.Y = num34;
          zero2.Z = num35;
        }
      }
      if (!this.treatBody1AsStatic)
        num23 += JVector.Dot(ref zero1, ref this.tangent);
      if (!this.treatBody2AsStatic)
        num23 += JVector.Dot(ref zero2, ref this.tangent);
      this.massTangent = 1f / num23;
      this.restitutionBias = this.lostSpeculativeBounce;
      this.speculativeVelocity = 0.0f;
      float num36 = (float) ((double) this.normal.X * (double) num4 + (double) this.normal.Y * (double) num5 + (double) this.normal.Z * (double) num6);
      if ((double) this.Penetration > (double) this.settings.allowedPenetration)
      {
        this.restitutionBias = this.settings.bias * (1f / timestep) * JMath.Max(0.0f, this.Penetration - this.settings.allowedPenetration);
        this.restitutionBias = JMath.Clamp(this.restitutionBias, 0.0f, this.settings.maximumBias);
      }
      float num37 = timestep / this.lastTimeStep;
      this.accumulatedNormalImpulse *= num37;
      this.accumulatedTangentImpulse *= num37;
      this.friction = (double) this.massTangent * -((double) this.tangent.X * (double) num4 + (double) this.tangent.Y * (double) num5 + (double) this.tangent.Z * (double) num6) >= (double) (-this.staticFriction * this.accumulatedNormalImpulse) ? this.staticFriction : this.dynamicFriction;
      if ((double) num36 < -1.0 && this.newContact)
        this.restitutionBias = Math.Max(-this.restitution * num36, this.restitutionBias);
      if ((double) this.penetration < -(double) this.settings.allowedPenetration)
      {
        this.speculativeVelocity = this.penetration / timestep;
        this.lostSpeculativeBounce = this.restitutionBias;
        this.restitutionBias = 0.0f;
      }
      else
        this.lostSpeculativeBounce = 0.0f;
      JVector jvector;
      jvector.X = (float) ((double) this.normal.X * (double) this.accumulatedNormalImpulse + (double) this.tangent.X * (double) this.accumulatedTangentImpulse);
      jvector.Y = (float) ((double) this.normal.Y * (double) this.accumulatedNormalImpulse + (double) this.tangent.Y * (double) this.accumulatedTangentImpulse);
      jvector.Z = (float) ((double) this.normal.Z * (double) this.accumulatedNormalImpulse + (double) this.tangent.Z * (double) this.accumulatedTangentImpulse);
      if (!this.treatBody1AsStatic)
      {
        this.body1.linearVelocity.X -= jvector.X * this.body1.inverseMass;
        this.body1.linearVelocity.Y -= jvector.Y * this.body1.inverseMass;
        this.body1.linearVelocity.Z -= jvector.Z * this.body1.inverseMass;
        if (!this.body1IsMassPoint)
        {
          double num38 = (double) this.relativePos1.Y * (double) jvector.Z - (double) this.relativePos1.Z * (double) jvector.Y;
          float num39 = (float) ((double) this.relativePos1.Z * (double) jvector.X - (double) this.relativePos1.X * (double) jvector.Z);
          float num40 = (float) ((double) this.relativePos1.X * (double) jvector.Y - (double) this.relativePos1.Y * (double) jvector.X);
          float num41 = (float) (num38 * (double) this.body1.invInertiaWorld.M11 + (double) num39 * (double) this.body1.invInertiaWorld.M21 + (double) num40 * (double) this.body1.invInertiaWorld.M31);
          float num42 = (float) (num38 * (double) this.body1.invInertiaWorld.M12 + (double) num39 * (double) this.body1.invInertiaWorld.M22 + (double) num40 * (double) this.body1.invInertiaWorld.M32);
          float num43 = (float) (num38 * (double) this.body1.invInertiaWorld.M13 + (double) num39 * (double) this.body1.invInertiaWorld.M23 + (double) num40 * (double) this.body1.invInertiaWorld.M33);
          this.body1.angularVelocity.X -= num41;
          this.body1.angularVelocity.Y -= num42;
          this.body1.angularVelocity.Z -= num43;
        }
      }
      if (!this.treatBody2AsStatic)
      {
        this.body2.linearVelocity.X += jvector.X * this.body2.inverseMass;
        this.body2.linearVelocity.Y += jvector.Y * this.body2.inverseMass;
        this.body2.linearVelocity.Z += jvector.Z * this.body2.inverseMass;
        if (!this.body2IsMassPoint)
        {
          double num44 = (double) this.relativePos2.Y * (double) jvector.Z - (double) this.relativePos2.Z * (double) jvector.Y;
          float num45 = (float) ((double) this.relativePos2.Z * (double) jvector.X - (double) this.relativePos2.X * (double) jvector.Z);
          float num46 = (float) ((double) this.relativePos2.X * (double) jvector.Y - (double) this.relativePos2.Y * (double) jvector.X);
          float num47 = (float) (num44 * (double) this.body2.invInertiaWorld.M11 + (double) num45 * (double) this.body2.invInertiaWorld.M21 + (double) num46 * (double) this.body2.invInertiaWorld.M31);
          float num48 = (float) (num44 * (double) this.body2.invInertiaWorld.M12 + (double) num45 * (double) this.body2.invInertiaWorld.M22 + (double) num46 * (double) this.body2.invInertiaWorld.M32);
          float num49 = (float) (num44 * (double) this.body2.invInertiaWorld.M13 + (double) num45 * (double) this.body2.invInertiaWorld.M23 + (double) num46 * (double) this.body2.invInertiaWorld.M33);
          this.body2.angularVelocity.X += num47;
          this.body2.angularVelocity.Y += num48;
          this.body2.angularVelocity.Z += num49;
        }
      }
      this.lastTimeStep = timestep;
      this.newContact = false;
    }

    public void TreatBodyAsStatic(RigidbodyIndex index)
    {
      if (index == RigidbodyIndex.Rigidbody1)
        this.treatBody1AsStatic = true;
      else
        this.treatBody2AsStatic = true;
    }

    public void Initialize(
      JRigidbody body1,
      JRigidbody body2,
      ref JVector point1,
      ref JVector point2,
      ref JVector n,
      float penetration,
      bool newContact,
      ContactSettings settings)
    {
      this.body1 = body1;
      this.body2 = body2;
      if (body1.isTrigger || body2.isTrigger)
        return;
      this.normal = n;
      this.normal.Normalize();
      this.p1 = point1;
      this.p2 = point2;
      this.newContact = newContact;
      JVector.Subtract(ref this.p1, ref body1.position, out this.relativePos1);
      JVector.Subtract(ref this.p2, ref body2.position, out this.relativePos2);
      JVector.Transform(ref this.relativePos1, ref body1.invOrientation, out this.realRelPos1);
      JVector.Transform(ref this.relativePos2, ref body2.invOrientation, out this.realRelPos2);
      this.initialPen = penetration;
      this.penetration = penetration;
      this.body1IsMassPoint = body1.isParticle;
      this.body2IsMassPoint = body2.isParticle;
      if (newContact)
      {
        this.treatBody1AsStatic = body1.isStatic || body1.isKinematic;
        this.treatBody2AsStatic = body2.isStatic || body2.isKinematic;
        this.accumulatedNormalImpulse = 0.0f;
        this.accumulatedTangentImpulse = 0.0f;
        this.lostSpeculativeBounce = 0.0f;
        switch (settings.MaterialCoefficientMixing)
        {
          case ContactSettings.MaterialCoefficientMixingType.TakeMaximum:
            this.staticFriction = JMath.Max(body1.material.staticFriction, body2.material.staticFriction);
            this.dynamicFriction = JMath.Max(body1.material.kineticFriction, body2.material.kineticFriction);
            this.restitution = JMath.Max(body1.material.restitution, body2.material.restitution);
            break;
          case ContactSettings.MaterialCoefficientMixingType.TakeMinimum:
            this.staticFriction = JMath.Min(body1.material.staticFriction, body2.material.staticFriction);
            this.dynamicFriction = JMath.Min(body1.material.kineticFriction, body2.material.kineticFriction);
            this.restitution = JMath.Min(body1.material.restitution, body2.material.restitution);
            break;
          case ContactSettings.MaterialCoefficientMixingType.UseAverage:
            this.staticFriction = (float) (((double) body1.material.staticFriction + (double) body2.material.staticFriction) / 2.0);
            this.dynamicFriction = (float) (((double) body1.material.kineticFriction + (double) body2.material.kineticFriction) / 2.0);
            this.restitution = (float) (((double) body1.material.restitution + (double) body2.material.restitution) / 2.0);
            break;
        }
      }
      this.settings = settings;
    }
  }
}
