// Decompiled with JetBrains decompiler
// Type: Jitter.LinearMath.JQuaternion
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;

namespace Jitter.LinearMath
{
  public struct JQuaternion : IEquatable<JQuaternion>
  {
    public float X;
    public float Y;
    public float Z;
    public float W;
    public static readonly JQuaternion LookForward = JQuaternion.LookRotation(JVector.Forward, JVector.Up);

    public JQuaternion(float x, float y, float z, float w)
    {
      this.X = x;
      this.Y = y;
      this.Z = z;
      this.W = w;
    }

    public static JQuaternion Add(JQuaternion quaternion1, JQuaternion quaternion2)
    {
      JQuaternion result;
      JQuaternion.Add(ref quaternion1, ref quaternion2, out result);
      return result;
    }

    public static void CreateFromYawPitchRoll(
      float yaw,
      float pitch,
      float roll,
      out JQuaternion result)
    {
      double d1;
      float num1 = (float) Math.Sin(d1 = (double) roll * 0.5);
      float num2 = (float) Math.Cos(d1);
      double d2;
      float num3 = (float) Math.Sin(d2 = (double) pitch * 0.5);
      float num4 = (float) Math.Cos(d2);
      double d3;
      float num5 = (float) Math.Sin(d3 = (double) yaw * 0.5);
      float num6 = (float) Math.Cos(d3);
      result.X = (float) ((double) num6 * (double) num3 * (double) num2 + (double) num5 * (double) num4 * (double) num1);
      result.Y = (float) ((double) num5 * (double) num4 * (double) num2 - (double) num6 * (double) num3 * (double) num1);
      result.Z = (float) ((double) num6 * (double) num4 * (double) num1 - (double) num5 * (double) num3 * (double) num2);
      result.W = (float) ((double) num6 * (double) num4 * (double) num2 + (double) num5 * (double) num3 * (double) num1);
    }

    public static void CreateFromEuler(float x, float y, float z, out JQuaternion result)
    {
      double num1 = (double) y * 0.5 * (Math.PI / 180.0);
      float num2 = (float) ((double) x * 0.5 * (Math.PI / 180.0));
      float num3 = (float) ((double) z * 0.5 * (Math.PI / 180.0));
      float num4 = (float) Math.Cos(num1);
      float num5 = (float) Math.Cos((double) num2);
      float num6 = (float) Math.Cos((double) num3);
      float num7 = (float) Math.Sin(num1);
      float num8 = (float) Math.Sin((double) num2);
      float num9 = (float) Math.Sin((double) num3);
      result.X = (float) ((double) num4 * (double) num8 * (double) num6 + (double) num7 * (double) num5 * (double) num9);
      result.Y = (float) ((double) num7 * (double) num5 * (double) num6 - (double) num4 * (double) num8 * (double) num9);
      result.Z = (float) ((double) num4 * (double) num5 * (double) num9 - (double) num7 * (double) num8 * (double) num6);
      result.W = (float) ((double) num4 * (double) num5 * (double) num6 + (double) num7 * (double) num8 * (double) num9);
    }

    public static JQuaternion CreateFromEuler(float x, float y, float z)
    {
      JQuaternion result = new JQuaternion();
      JQuaternion.CreateFromEuler(x, y, z, out result);
      return result;
    }

    public void ToEulerAngle(out float roll, out float pitch, out float yaw)
    {
      double y1 = 2.0 * ((double) this.W * (double) this.X + (double) this.Y * (double) this.Z);
      double x1 = 1.0 - 2.0 * ((double) this.X * (double) this.X + (double) this.Y * (double) this.Y);
      roll = (float) Math.Atan2(y1, x1);
      double d = 2.0 * ((double) this.W * (double) this.Y - (double) this.Z * (double) this.X);
      pitch = Math.Abs(d) < 1.0 ? (float) Math.Asin(d) : (d < 0.0 ? -3.141593f : 3.141593f);
      double y2 = 2.0 * ((double) this.W * (double) this.Z + (double) this.X * (double) this.Y);
      double x2 = 1.0 - 2.0 * ((double) this.Y * (double) this.Y + (double) this.Z * (double) this.Z);
      yaw = (float) Math.Atan2(y2, x2);
    }

    public static void Add(
      ref JQuaternion quaternion1,
      ref JQuaternion quaternion2,
      out JQuaternion result)
    {
      result.X = quaternion1.X + quaternion2.X;
      result.Y = quaternion1.Y + quaternion2.Y;
      result.Z = quaternion1.Z + quaternion2.Z;
      result.W = quaternion1.W + quaternion2.W;
    }

    public static JQuaternion Conjugate(JQuaternion value)
    {
      JQuaternion jquaternion;
      jquaternion.X = -value.X;
      jquaternion.Y = -value.Y;
      jquaternion.Z = -value.Z;
      jquaternion.W = value.W;
      return jquaternion;
    }

    public static JQuaternion Subtract(JQuaternion quaternion1, JQuaternion quaternion2)
    {
      JQuaternion result;
      JQuaternion.Subtract(ref quaternion1, ref quaternion2, out result);
      return result;
    }

    public static void Subtract(
      ref JQuaternion quaternion1,
      ref JQuaternion quaternion2,
      out JQuaternion result)
    {
      result.X = quaternion1.X - quaternion2.X;
      result.Y = quaternion1.Y - quaternion2.Y;
      result.Z = quaternion1.Z - quaternion2.Z;
      result.W = quaternion1.W - quaternion2.W;
    }

    public static JQuaternion Multiply(JQuaternion quaternion1, JQuaternion quaternion2)
    {
      JQuaternion result;
      JQuaternion.Multiply(ref quaternion1, ref quaternion2, out result);
      return result;
    }

    public static void Multiply(
      ref JQuaternion quaternion1,
      ref JQuaternion quaternion2,
      out JQuaternion result)
    {
      float x1 = quaternion1.X;
      float y1 = quaternion1.Y;
      float z1 = quaternion1.Z;
      float w1 = quaternion1.W;
      float x2 = quaternion2.X;
      float y2 = quaternion2.Y;
      float z2 = quaternion2.Z;
      float w2 = quaternion2.W;
      float num1 = (float) ((double) y1 * (double) z2 - (double) z1 * (double) y2);
      float num2 = (float) ((double) z1 * (double) x2 - (double) x1 * (double) z2);
      float num3 = (float) ((double) x1 * (double) y2 - (double) y1 * (double) x2);
      float num4 = (float) ((double) x1 * (double) x2 + (double) y1 * (double) y2 + (double) z1 * (double) z2);
      result.X = (float) ((double) x1 * (double) w2 + (double) x2 * (double) w1) + num1;
      result.Y = (float) ((double) y1 * (double) w2 + (double) y2 * (double) w1) + num2;
      result.Z = (float) ((double) z1 * (double) w2 + (double) z2 * (double) w1) + num3;
      result.W = w1 * w2 - num4;
    }

    public static JQuaternion Multiply(JQuaternion quaternion1, float scaleFactor)
    {
      JQuaternion result;
      JQuaternion.Multiply(ref quaternion1, scaleFactor, out result);
      return result;
    }

    public static void Multiply(
      ref JQuaternion quaternion1,
      float scaleFactor,
      out JQuaternion result)
    {
      result.X = quaternion1.X * scaleFactor;
      result.Y = quaternion1.Y * scaleFactor;
      result.Z = quaternion1.Z * scaleFactor;
      result.W = quaternion1.W * scaleFactor;
    }

    public void Normalize()
    {
      float num = 1f / (float) Math.Sqrt((double) this.X * (double) this.X + (double) this.Y * (double) this.Y + (double) this.Z * (double) this.Z + (double) this.W * (double) this.W);
      this.X *= num;
      this.Y *= num;
      this.Z *= num;
      this.W *= num;
    }

    public static JQuaternion CreateFromMatrix(JMatrix matrix)
    {
      JQuaternion result;
      JQuaternion.CreateFromMatrix(ref matrix, out result);
      return result;
    }

    public static void CreateFromMatrix(ref JMatrix matrix, out JQuaternion result)
    {
      float num1 = matrix.M11 + matrix.M22 + matrix.M33;
      if ((double) num1 > 0.0)
      {
        float num2 = (float) Math.Sqrt((double) num1 + 1.0);
        result.W = num2 * 0.5f;
        float num3 = 0.5f / num2;
        result.X = (matrix.M23 - matrix.M32) * num3;
        result.Y = (matrix.M31 - matrix.M13) * num3;
        result.Z = (matrix.M12 - matrix.M21) * num3;
      }
      else if ((double) matrix.M11 >= (double) matrix.M22 && (double) matrix.M11 >= (double) matrix.M33)
      {
        float num4 = (float) Math.Sqrt(1.0 + (double) matrix.M11 - (double) matrix.M22 - (double) matrix.M33);
        float num5 = 0.5f / num4;
        result.X = 0.5f * num4;
        result.Y = (matrix.M12 + matrix.M21) * num5;
        result.Z = (matrix.M13 + matrix.M31) * num5;
        result.W = (matrix.M23 - matrix.M32) * num5;
      }
      else if ((double) matrix.M22 > (double) matrix.M33)
      {
        float num6 = (float) Math.Sqrt(1.0 + (double) matrix.M22 - (double) matrix.M11 - (double) matrix.M33);
        float num7 = 0.5f / num6;
        result.X = (matrix.M21 + matrix.M12) * num7;
        result.Y = 0.5f * num6;
        result.Z = (matrix.M32 + matrix.M23) * num7;
        result.W = (matrix.M31 - matrix.M13) * num7;
      }
      else
      {
        float num8 = (float) Math.Sqrt(1.0 + (double) matrix.M33 - (double) matrix.M11 - (double) matrix.M22);
        float num9 = 0.5f / num8;
        result.X = (matrix.M31 + matrix.M13) * num9;
        result.Y = (matrix.M32 + matrix.M23) * num9;
        result.Z = 0.5f * num8;
        result.W = (matrix.M12 - matrix.M21) * num9;
      }
    }

    public static JQuaternion operator *(JQuaternion value1, JQuaternion value2)
    {
      JQuaternion result;
      JQuaternion.Multiply(ref value1, ref value2, out result);
      return result;
    }

    public static JQuaternion operator +(JQuaternion value1, JQuaternion value2)
    {
      JQuaternion result;
      JQuaternion.Add(ref value1, ref value2, out result);
      return result;
    }

    public static JQuaternion operator -(JQuaternion value1, JQuaternion value2)
    {
      JQuaternion result;
      JQuaternion.Subtract(ref value1, ref value2, out result);
      return result;
    }

    public static JQuaternion Inverse(JQuaternion a) => JQuaternion.Multiply(JQuaternion.Conjugate(a), (float) ((double) a.X * (double) a.X + (double) a.Y * (double) a.Y + (double) a.Z * (double) a.Z + (double) a.W * (double) a.W));

    public static float Angle(JQuaternion a, JQuaternion b)
    {
      JQuaternion jquaternion = JQuaternion.Inverse(a);
      float num = (float) (Math.Acos((double) JMath.Clamp((b * jquaternion).W, -1f, 1f)) * 2.0 * 57.2957763671875);
      if ((double) num > 180.0)
        num -= 360f;
      return Math.Abs(num);
    }

    public static JQuaternion LookRotation(JVector fwd, JVector up)
    {
      fwd.Normalize();
      up.Normalize();
      JVector jvector = JVector.Cross(up, fwd);
      jvector.Normalize();
      up = JVector.Cross(fwd, jvector);
      return JQuaternion.CreateFromMatrix(new JMatrix(jvector, up, fwd));
    }

    public static JQuaternion FromAxisAngle(JVector axis, float angleRad)
    {
      float num1 = (float) Math.Sin((double) angleRad / 2.0);
      double num2 = (double) axis.X * (double) num1;
      float num3 = axis.Y * num1;
      float num4 = axis.Z * num1;
      float num5 = (float) Math.Cos((double) angleRad / 2.0);
      double num6 = (double) num3;
      double num7 = (double) num4;
      double num8 = (double) num5;
      return new JQuaternion((float) num2, (float) num6, (float) num7, (float) num8);
    }

    public override string ToString() => string.Format("X: {0}, Y: {1}, Z: {2}, W: {3}", (object) this.X, (object) this.Y, (object) this.Z, (object) this.W);

    public bool Equals(JQuaternion other) => this.X.Equals(other.X) && this.Y.Equals(other.Y) && this.Z.Equals(other.Z) && this.W.Equals(other.W);

    public override bool Equals(object obj) => obj != null && obj is JQuaternion other && this.Equals(other);

    public override int GetHashCode() => ((this.X.GetHashCode() * 397 ^ this.Y.GetHashCode()) * 397 ^ this.Z.GetHashCode()) * 397 ^ this.W.GetHashCode();

    public JVector Forward()
    {
      JVector zero = JVector.Zero;
      float num1 = this.X * this.X;
      float num2 = this.Y * this.Y;
      float num3 = this.Z * this.X;
      float num4 = this.Y * this.W;
      float num5 = this.Y * this.Z;
      float num6 = this.X * this.W;
      zero.X = (float) (2.0 * ((double) num3 + (double) num4));
      zero.Y = (float) (2.0 * ((double) num5 - (double) num6));
      zero.Z = (float) (1.0 - 2.0 * ((double) num2 + (double) num1));
      return zero;
    }

    public float ToAngle2D() => JQuaternion.ToAngle2D(this);

    public static float ToAngle2D(JQuaternion quaternion)
    {
      JVector b = quaternion.Forward();
      float num = JVector.Angle(JVector.Forward, b);
      return (double) b.X <= 0.0 ? -num : num;
    }

    public static void From2DAngle(float a, out JQuaternion b)
    {
      JQuaternion jquaternion = JQuaternion.FromAxisAngle(JVector.Up, a * ((float) Math.PI / 180f));
      b.X = jquaternion.X;
      b.Y = jquaternion.Y;
      b.Z = jquaternion.Z;
      b.W = jquaternion.W;
    }

    public static JQuaternion From2DAngle(float a)
    {
      JQuaternion b;
      JQuaternion.From2DAngle(a, out b);
      return b;
    }
  }
}
