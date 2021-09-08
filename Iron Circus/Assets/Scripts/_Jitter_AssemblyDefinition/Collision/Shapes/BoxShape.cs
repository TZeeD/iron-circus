// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.BoxShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using Newtonsoft.Json;
using System;

namespace Jitter.Collision.Shapes
{
  public class BoxShape : Shape, ISupports2DRaycast
  {
    private JVector halfSize = JVector.Zero;
    private JVector size = JVector.Zero;

    [JsonConstructor]
    public BoxShape(JVector size)
    {
      this.size = size;
      this.UpdateShape(false);
    }

    public BoxShape(float length, float height, float width)
    {
      this.size.X = length;
      this.size.Y = height;
      this.size.Z = width;
      this.UpdateShape(false);
    }

    public JVector Size
    {
      get => this.size;
      set
      {
        this.size = value;
        this.UpdateShape(false);
      }
    }

    public override void UpdateShape(bool skipMassInertia = false)
    {
      this.halfSize = this.size * 0.5f;
      base.UpdateShape(skipMassInertia);
    }

    public override void GetBoundingBox(ref JMatrix orientation, out JBBox box)
    {
      JMatrix result1;
      JMath.Absolute(ref orientation, out result1);
      JVector result2;
      JVector.Transform(ref this.halfSize, ref result1, out result2);
      box.Max = result2;
      JVector.Negate(ref result2, out box.Min);
    }

    public override void CalculateMassInertia()
    {
      this.mass = this.size.X * this.size.Y * this.size.Z;
      this.inertia = JMatrix.Identity;
      this.inertia.M11 = (float) (0.0833333358168602 * (double) this.mass * ((double) this.size.Y * (double) this.size.Y + (double) this.size.Z * (double) this.size.Z));
      this.inertia.M22 = (float) (0.0833333358168602 * (double) this.mass * ((double) this.size.X * (double) this.size.X + (double) this.size.Z * (double) this.size.Z));
      this.inertia.M33 = (float) (0.0833333358168602 * (double) this.mass * ((double) this.size.X * (double) this.size.X + (double) this.size.Y * (double) this.size.Y));
      this.geomCen = JVector.Zero;
    }

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      result.X = (float) Math.Sign(direction.X) * this.halfSize.X;
      result.Y = (float) Math.Sign(direction.Y) * this.halfSize.Y;
      result.Z = (float) Math.Sign(direction.Z) * this.halfSize.Z;
    }

    public bool Raycast2D(
      ref JMatrix orientation,
      ref JMatrix invOrientation,
      ref JVector position,
      ref JVector origin,
      ref JVector direction,
      out float fraction,
      out JVector normal)
    {
      fraction = float.MaxValue;
      normal = JVector.Zero;
      JVector result1;
      JVector.TransposedTransform(ref direction, ref orientation, out result1);
      JVector position1 = origin - position;
      JVector result2;
      JVector.TransposedTransform(ref position1, ref orientation, out result2);
      result1.Y = 0.0f;
      result2.Y = 0.0f;
      JVector position2 = JVector.Zero;
      float num1 = float.MaxValue;
      if ((double) JMath.Abs(result1.X) > 1.19209286539301E-12)
      {
        float num2 = (this.halfSize.X - result2.X) / result1.X;
        if ((double) JMath.Abs(result2.Z + num2 * result1.Z) <= (double) this.halfSize.Z && (double) num2 < (double) num1 && (double) num2 >= 0.0)
        {
          num1 = num2;
          position2 = JVector.Right;
        }
        float num3 = (-this.halfSize.X - result2.X) / result1.X;
        if ((double) JMath.Abs(result2.Z + num3 * result1.Z) <= (double) this.halfSize.Z && (double) num3 < (double) num1 && (double) num3 >= 0.0)
        {
          num1 = num3;
          position2 = JVector.Left;
        }
      }
      if ((double) JMath.Abs(result1.Z) > 1.19209286539301E-12)
      {
        float num4 = (this.halfSize.Z - result2.Z) / result1.Z;
        if ((double) JMath.Abs(result2.X + num4 * result1.X) <= (double) this.halfSize.X && (double) num4 < (double) num1 && (double) num4 >= 0.0)
        {
          num1 = num4;
          position2 = JVector.Forward;
        }
        float num5 = (-this.halfSize.Z - result2.Z) / result1.Z;
        if ((double) JMath.Abs(result2.X + num5 * result1.X) <= (double) this.halfSize.X && (double) num5 < (double) num1 && (double) num5 >= 0.0)
        {
          num1 = num5;
          position2 = JVector.Backward;
        }
      }
      if ((double) num1 == 3.40282346638529E+38)
        return false;
      fraction = num1;
      JVector.Transform(ref position2, ref orientation, out normal);
      normal.Normalize();
      return true;
    }
  }
}
