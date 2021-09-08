// Decompiled with JetBrains decompiler
// Type: Jitter.LinearMath.JMatrix
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;

namespace Jitter.LinearMath
{
  public struct JMatrix : IEquatable<JMatrix>
  {
    public float M11;
    public float M12;
    public float M13;
    public float M21;
    public float M22;
    public float M23;
    public float M31;
    public float M32;
    public float M33;
    internal static JMatrix InternalIdentity;
    public static readonly JMatrix Identity;
    public static readonly JMatrix Zero = new JMatrix();

    static JMatrix()
    {
      JMatrix.Identity = new JMatrix();
      JMatrix.Identity.M11 = 1f;
      JMatrix.Identity.M22 = 1f;
      JMatrix.Identity.M33 = 1f;
      JMatrix.InternalIdentity = JMatrix.Identity;
    }

    public static JMatrix CreateFromYawPitchRoll(float yaw, float pitch, float roll)
    {
      JQuaternion result1;
      JQuaternion.CreateFromYawPitchRoll(yaw, pitch, roll, out result1);
      JMatrix result2;
      JMatrix.CreateFromQuaternion(ref result1, out result2);
      return result2;
    }

    public static JMatrix CreateRotationX(float radians)
    {
      float num1 = (float) Math.Cos((double) radians);
      float num2 = (float) Math.Sin((double) radians);
      JMatrix jmatrix;
      jmatrix.M11 = 1f;
      jmatrix.M12 = 0.0f;
      jmatrix.M13 = 0.0f;
      jmatrix.M21 = 0.0f;
      jmatrix.M22 = num1;
      jmatrix.M23 = num2;
      jmatrix.M31 = 0.0f;
      jmatrix.M32 = -num2;
      jmatrix.M33 = num1;
      return jmatrix;
    }

    public static void CreateRotationX(float radians, out JMatrix result)
    {
      float num1 = (float) Math.Cos((double) radians);
      float num2 = (float) Math.Sin((double) radians);
      result.M11 = 1f;
      result.M12 = 0.0f;
      result.M13 = 0.0f;
      result.M21 = 0.0f;
      result.M22 = num1;
      result.M23 = num2;
      result.M31 = 0.0f;
      result.M32 = -num2;
      result.M33 = num1;
    }

    public static JMatrix CreateRotationY(float radians)
    {
      float num1 = (float) Math.Cos((double) radians);
      float num2 = (float) Math.Sin((double) radians);
      JMatrix jmatrix;
      jmatrix.M11 = num1;
      jmatrix.M12 = 0.0f;
      jmatrix.M13 = -num2;
      jmatrix.M21 = 0.0f;
      jmatrix.M22 = 1f;
      jmatrix.M23 = 0.0f;
      jmatrix.M31 = num2;
      jmatrix.M32 = 0.0f;
      jmatrix.M33 = num1;
      return jmatrix;
    }

    public static void CreateRotationY(float radians, out JMatrix result)
    {
      float num1 = (float) Math.Cos((double) radians);
      float num2 = (float) Math.Sin((double) radians);
      result.M11 = num1;
      result.M12 = 0.0f;
      result.M13 = -num2;
      result.M21 = 0.0f;
      result.M22 = 1f;
      result.M23 = 0.0f;
      result.M31 = num2;
      result.M32 = 0.0f;
      result.M33 = num1;
    }

    public static JMatrix CreateRotationZ(float radians)
    {
      float num1 = (float) Math.Cos((double) radians);
      float num2 = (float) Math.Sin((double) radians);
      JMatrix jmatrix;
      jmatrix.M11 = num1;
      jmatrix.M12 = num2;
      jmatrix.M13 = 0.0f;
      jmatrix.M21 = -num2;
      jmatrix.M22 = num1;
      jmatrix.M23 = 0.0f;
      jmatrix.M31 = 0.0f;
      jmatrix.M32 = 0.0f;
      jmatrix.M33 = 1f;
      return jmatrix;
    }

    public static void CreateRotationZ(float radians, out JMatrix result)
    {
      float num1 = (float) Math.Cos((double) radians);
      float num2 = (float) Math.Sin((double) radians);
      result.M11 = num1;
      result.M12 = num2;
      result.M13 = 0.0f;
      result.M21 = -num2;
      result.M22 = num1;
      result.M23 = 0.0f;
      result.M31 = 0.0f;
      result.M32 = 0.0f;
      result.M33 = 1f;
    }

    public JMatrix(
      float m11,
      float m12,
      float m13,
      float m21,
      float m22,
      float m23,
      float m31,
      float m32,
      float m33)
    {
      this.M11 = m11;
      this.M12 = m12;
      this.M13 = m13;
      this.M21 = m21;
      this.M22 = m22;
      this.M23 = m23;
      this.M31 = m31;
      this.M32 = m32;
      this.M33 = m33;
    }

    public JMatrix(JVector side, JVector up, JVector fwd)
    {
      this.M11 = side.X;
      this.M12 = side.Y;
      this.M13 = side.Z;
      this.M21 = up.X;
      this.M22 = up.Y;
      this.M23 = up.Z;
      this.M31 = fwd.X;
      this.M32 = fwd.Y;
      this.M33 = fwd.Z;
    }

    public static JMatrix Multiply(JMatrix matrix1, JMatrix matrix2)
    {
      JMatrix result;
      JMatrix.Multiply(ref matrix1, ref matrix2, out result);
      return result;
    }

    public static void Multiply(ref JMatrix matrix1, ref JMatrix matrix2, out JMatrix result)
    {
      float num1 = (float) ((double) matrix1.M11 * (double) matrix2.M11 + (double) matrix1.M12 * (double) matrix2.M21 + (double) matrix1.M13 * (double) matrix2.M31);
      float num2 = (float) ((double) matrix1.M11 * (double) matrix2.M12 + (double) matrix1.M12 * (double) matrix2.M22 + (double) matrix1.M13 * (double) matrix2.M32);
      float num3 = (float) ((double) matrix1.M11 * (double) matrix2.M13 + (double) matrix1.M12 * (double) matrix2.M23 + (double) matrix1.M13 * (double) matrix2.M33);
      float num4 = (float) ((double) matrix1.M21 * (double) matrix2.M11 + (double) matrix1.M22 * (double) matrix2.M21 + (double) matrix1.M23 * (double) matrix2.M31);
      float num5 = (float) ((double) matrix1.M21 * (double) matrix2.M12 + (double) matrix1.M22 * (double) matrix2.M22 + (double) matrix1.M23 * (double) matrix2.M32);
      float num6 = (float) ((double) matrix1.M21 * (double) matrix2.M13 + (double) matrix1.M22 * (double) matrix2.M23 + (double) matrix1.M23 * (double) matrix2.M33);
      float num7 = (float) ((double) matrix1.M31 * (double) matrix2.M11 + (double) matrix1.M32 * (double) matrix2.M21 + (double) matrix1.M33 * (double) matrix2.M31);
      float num8 = (float) ((double) matrix1.M31 * (double) matrix2.M12 + (double) matrix1.M32 * (double) matrix2.M22 + (double) matrix1.M33 * (double) matrix2.M32);
      float num9 = (float) ((double) matrix1.M31 * (double) matrix2.M13 + (double) matrix1.M32 * (double) matrix2.M23 + (double) matrix1.M33 * (double) matrix2.M33);
      result.M11 = num1;
      result.M12 = num2;
      result.M13 = num3;
      result.M21 = num4;
      result.M22 = num5;
      result.M23 = num6;
      result.M31 = num7;
      result.M32 = num8;
      result.M33 = num9;
    }

    public static JMatrix Add(JMatrix matrix1, JMatrix matrix2)
    {
      JMatrix result;
      JMatrix.Add(ref matrix1, ref matrix2, out result);
      return result;
    }

    public static void Add(ref JMatrix matrix1, ref JMatrix matrix2, out JMatrix result)
    {
      result.M11 = matrix1.M11 + matrix2.M11;
      result.M12 = matrix1.M12 + matrix2.M12;
      result.M13 = matrix1.M13 + matrix2.M13;
      result.M21 = matrix1.M21 + matrix2.M21;
      result.M22 = matrix1.M22 + matrix2.M22;
      result.M23 = matrix1.M23 + matrix2.M23;
      result.M31 = matrix1.M31 + matrix2.M31;
      result.M32 = matrix1.M32 + matrix2.M32;
      result.M33 = matrix1.M33 + matrix2.M33;
    }

    public static JMatrix Inverse(JMatrix matrix)
    {
      JMatrix result;
      JMatrix.Inverse(ref matrix, out result);
      return result;
    }

    public float Determinant() => (float) ((double) this.M11 * (double) this.M22 * (double) this.M33 + (double) this.M12 * (double) this.M23 * (double) this.M31 + (double) this.M13 * (double) this.M21 * (double) this.M32 - (double) this.M31 * (double) this.M22 * (double) this.M13 - (double) this.M32 * (double) this.M23 * (double) this.M11 - (double) this.M33 * (double) this.M21 * (double) this.M12);

    public static void Invert(ref JMatrix matrix, out JMatrix result)
    {
      float num1 = 1f / matrix.Determinant();
      float num2 = (float) ((double) matrix.M22 * (double) matrix.M33 - (double) matrix.M23 * (double) matrix.M32) * num1;
      float num3 = (float) ((double) matrix.M13 * (double) matrix.M32 - (double) matrix.M33 * (double) matrix.M12) * num1;
      float num4 = (float) ((double) matrix.M12 * (double) matrix.M23 - (double) matrix.M22 * (double) matrix.M13) * num1;
      float num5 = (float) ((double) matrix.M23 * (double) matrix.M31 - (double) matrix.M21 * (double) matrix.M33) * num1;
      float num6 = (float) ((double) matrix.M11 * (double) matrix.M33 - (double) matrix.M13 * (double) matrix.M31) * num1;
      float num7 = (float) ((double) matrix.M13 * (double) matrix.M21 - (double) matrix.M11 * (double) matrix.M23) * num1;
      float num8 = (float) ((double) matrix.M21 * (double) matrix.M32 - (double) matrix.M22 * (double) matrix.M31) * num1;
      float num9 = (float) ((double) matrix.M12 * (double) matrix.M31 - (double) matrix.M11 * (double) matrix.M32) * num1;
      float num10 = (float) ((double) matrix.M11 * (double) matrix.M22 - (double) matrix.M12 * (double) matrix.M21) * num1;
      result.M11 = num2;
      result.M12 = num3;
      result.M13 = num4;
      result.M21 = num5;
      result.M22 = num6;
      result.M23 = num7;
      result.M31 = num8;
      result.M32 = num9;
      result.M33 = num10;
    }

    public static void Inverse(ref JMatrix matrix, out JMatrix result)
    {
      float num1 = (float) ((double) matrix.M11 * (double) matrix.M22 * (double) matrix.M33 - (double) matrix.M11 * (double) matrix.M23 * (double) matrix.M32 - (double) matrix.M12 * (double) matrix.M21 * (double) matrix.M33 + (double) matrix.M12 * (double) matrix.M23 * (double) matrix.M31 + (double) matrix.M13 * (double) matrix.M21 * (double) matrix.M32 - (double) matrix.M13 * (double) matrix.M22 * (double) matrix.M31);
      float num2 = (float) ((double) matrix.M22 * (double) matrix.M33 - (double) matrix.M23 * (double) matrix.M32);
      float num3 = (float) ((double) matrix.M13 * (double) matrix.M32 - (double) matrix.M12 * (double) matrix.M33);
      float num4 = (float) ((double) matrix.M12 * (double) matrix.M23 - (double) matrix.M22 * (double) matrix.M13);
      float num5 = (float) ((double) matrix.M23 * (double) matrix.M31 - (double) matrix.M33 * (double) matrix.M21);
      float num6 = (float) ((double) matrix.M11 * (double) matrix.M33 - (double) matrix.M31 * (double) matrix.M13);
      float num7 = (float) ((double) matrix.M13 * (double) matrix.M21 - (double) matrix.M23 * (double) matrix.M11);
      float num8 = (float) ((double) matrix.M21 * (double) matrix.M32 - (double) matrix.M31 * (double) matrix.M22);
      float num9 = (float) ((double) matrix.M12 * (double) matrix.M31 - (double) matrix.M32 * (double) matrix.M11);
      float num10 = (float) ((double) matrix.M11 * (double) matrix.M22 - (double) matrix.M21 * (double) matrix.M12);
      result.M11 = num2 / num1;
      result.M12 = num3 / num1;
      result.M13 = num4 / num1;
      result.M21 = num5 / num1;
      result.M22 = num6 / num1;
      result.M23 = num7 / num1;
      result.M31 = num8 / num1;
      result.M32 = num9 / num1;
      result.M33 = num10 / num1;
    }

    public static JMatrix Multiply(JMatrix matrix1, float scaleFactor)
    {
      JMatrix result;
      JMatrix.Multiply(ref matrix1, scaleFactor, out result);
      return result;
    }

    public static void Multiply(ref JMatrix matrix1, float scaleFactor, out JMatrix result)
    {
      float num = scaleFactor;
      result.M11 = matrix1.M11 * num;
      result.M12 = matrix1.M12 * num;
      result.M13 = matrix1.M13 * num;
      result.M21 = matrix1.M21 * num;
      result.M22 = matrix1.M22 * num;
      result.M23 = matrix1.M23 * num;
      result.M31 = matrix1.M31 * num;
      result.M32 = matrix1.M32 * num;
      result.M33 = matrix1.M33 * num;
    }

    public static JMatrix CreateFromQuaternion(JQuaternion quaternion)
    {
      JMatrix result;
      JMatrix.CreateFromQuaternion(ref quaternion, out result);
      return result;
    }

    public static void CreateFromQuaternion(ref JQuaternion quaternion, out JMatrix result)
    {
      float num1 = quaternion.X * quaternion.X;
      float num2 = quaternion.Y * quaternion.Y;
      float num3 = quaternion.Z * quaternion.Z;
      float num4 = quaternion.X * quaternion.Y;
      float num5 = quaternion.Z * quaternion.W;
      float num6 = quaternion.Z * quaternion.X;
      float num7 = quaternion.Y * quaternion.W;
      float num8 = quaternion.Y * quaternion.Z;
      float num9 = quaternion.X * quaternion.W;
      result.M11 = (float) (1.0 - 2.0 * ((double) num2 + (double) num3));
      result.M12 = (float) (2.0 * ((double) num4 + (double) num5));
      result.M13 = (float) (2.0 * ((double) num6 - (double) num7));
      result.M21 = (float) (2.0 * ((double) num4 - (double) num5));
      result.M22 = (float) (1.0 - 2.0 * ((double) num3 + (double) num1));
      result.M23 = (float) (2.0 * ((double) num8 + (double) num9));
      result.M31 = (float) (2.0 * ((double) num6 + (double) num7));
      result.M32 = (float) (2.0 * ((double) num8 - (double) num9));
      result.M33 = (float) (1.0 - 2.0 * ((double) num2 + (double) num1));
    }

    public static JMatrix Transpose(JMatrix matrix)
    {
      JMatrix result;
      JMatrix.Transpose(ref matrix, out result);
      return result;
    }

    public static void Transpose(ref JMatrix matrix, out JMatrix result)
    {
      result.M11 = matrix.M11;
      result.M12 = matrix.M21;
      result.M13 = matrix.M31;
      result.M21 = matrix.M12;
      result.M22 = matrix.M22;
      result.M23 = matrix.M32;
      result.M31 = matrix.M13;
      result.M32 = matrix.M23;
      result.M33 = matrix.M33;
    }

    public static JMatrix operator *(JMatrix value1, JMatrix value2)
    {
      JMatrix result;
      JMatrix.Multiply(ref value1, ref value2, out result);
      return result;
    }

    public float Trace() => this.M11 + this.M22 + this.M33;

    public static JMatrix operator +(JMatrix value1, JMatrix value2)
    {
      JMatrix result;
      JMatrix.Add(ref value1, ref value2, out result);
      return result;
    }

    public static JMatrix operator -(JMatrix value1, JMatrix value2)
    {
      JMatrix.Multiply(ref value2, -1f, out value2);
      JMatrix result;
      JMatrix.Add(ref value1, ref value2, out result);
      return result;
    }

    public static void CreateFromAxisAngle(ref JVector axis, float angle, out JMatrix result)
    {
      float x = axis.X;
      float y = axis.Y;
      float z = axis.Z;
      float num1 = (float) Math.Sin((double) angle);
      float num2 = (float) Math.Cos((double) angle);
      float num3 = x * x;
      float num4 = y * y;
      float num5 = z * z;
      float num6 = x * y;
      float num7 = x * z;
      float num8 = y * z;
      result.M11 = num3 + num2 * (1f - num3);
      result.M12 = (float) ((double) num6 - (double) num2 * (double) num6 + (double) num1 * (double) z);
      result.M13 = (float) ((double) num7 - (double) num2 * (double) num7 - (double) num1 * (double) y);
      result.M21 = (float) ((double) num6 - (double) num2 * (double) num6 - (double) num1 * (double) z);
      result.M22 = num4 + num2 * (1f - num4);
      result.M23 = (float) ((double) num8 - (double) num2 * (double) num8 + (double) num1 * (double) x);
      result.M31 = (float) ((double) num7 - (double) num2 * (double) num7 + (double) num1 * (double) y);
      result.M32 = (float) ((double) num8 - (double) num2 * (double) num8 - (double) num1 * (double) x);
      result.M33 = num5 + num2 * (1f - num5);
    }

    public static JMatrix CreateFromAxisAngle(JVector axis, float angle)
    {
      JMatrix result;
      JMatrix.CreateFromAxisAngle(ref axis, angle, out result);
      return result;
    }

    public static JMatrix CreateFromLookDir(JVector lookDir, JVector up)
    {
      JVector vector2 = JVector.Cross(up, lookDir);
      up = JVector.Cross(lookDir, vector2);
      return new JMatrix(vector2.X, vector2.Y, vector2.Z, up.X, up.Y, up.Z, lookDir.X, lookDir.Y, lookDir.Z);
    }

    public JVector Left() => new JVector(-this.M11, -this.M12, -this.M13);

    public JVector Up() => new JVector(this.M21, this.M22, this.M23);

    public JVector Forward() => new JVector(this.M31, this.M32, this.M33);

    public static float ToAngle2D(JMatrix quaternion)
    {
      JVector b = quaternion.Forward();
      float num = JVector.Angle(JVector.Forward, b);
      return (double) b.X <= 0.0 ? -num : num;
    }

    public float ToAngle2D() => JMatrix.ToAngle2D(this);

    public bool Equals(JMatrix other) => (double) Math.Abs(this.M11 - other.M11) < 1.19209286539301E-12 && (double) Math.Abs(this.M12 - other.M12) < 1.19209286539301E-12 && (double) Math.Abs(this.M13 - other.M13) < 1.19209286539301E-12 && (double) Math.Abs(this.M21 - other.M21) < 1.19209286539301E-12 && (double) Math.Abs(this.M22 - other.M22) < 1.19209286539301E-12 && (double) Math.Abs(this.M23 - other.M23) < 1.19209286539301E-12 && (double) Math.Abs(this.M31 - other.M31) < 1.19209286539301E-12 && (double) Math.Abs(this.M32 - other.M32) < 1.19209286539301E-12 && (double) Math.Abs(this.M33 - other.M33) < 1.19209286539301E-12;

    public override bool Equals(object obj) => obj != null && obj is JMatrix other && this.Equals(other);

    public override int GetHashCode() => (((((((this.M11.GetHashCode() * 397 ^ this.M12.GetHashCode()) * 397 ^ this.M13.GetHashCode()) * 397 ^ this.M21.GetHashCode()) * 397 ^ this.M22.GetHashCode()) * 397 ^ this.M23.GetHashCode()) * 397 ^ this.M31.GetHashCode()) * 397 ^ this.M32.GetHashCode()) * 397 ^ this.M33.GetHashCode();

    public override string ToString() => "{" + string.Format("m11:{0}, m12:{1}, m13:{2}", (object) this.M11, (object) this.M12, (object) this.M13) + "}, {" + string.Format("m21:{0}, m22:{1}, m23:{2} ", (object) this.M21, (object) this.M22, (object) this.M23) + "}, {" + string.Format("m31:{0}, m32:{1}, m33:{2}", (object) this.M31, (object) this.M32, (object) this.M33) + "}";
  }
}
