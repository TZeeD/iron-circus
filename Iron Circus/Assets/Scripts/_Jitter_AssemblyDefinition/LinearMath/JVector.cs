// Decompiled with JetBrains decompiler
// Type: Jitter.LinearMath.JVector
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;

namespace Jitter.LinearMath
{
  [Serializable]
  public struct JVector : IEquatable<JVector>
  {
    private const float ZeroEpsilonSq = 1.421085E-24f;
    internal static JVector InternalZero;
    internal static JVector Arbitrary;
    public float X;
    public float Y;
    public float Z;
    public static readonly JVector Zero;
    public static readonly JVector Left;
    public static readonly JVector Right;
    public static readonly JVector Up;
    public static readonly JVector Down;
    public static readonly JVector Backward;
    public static readonly JVector Forward;
    public static readonly JVector One = new JVector(1f, 1f, 1f);
    public static readonly JVector MinValue;
    public static readonly JVector MaxValue;

    static JVector()
    {
      JVector.Zero = new JVector(0.0f, 0.0f, 0.0f);
      JVector.Left = new JVector(-1f, 0.0f, 0.0f);
      JVector.Right = new JVector(1f, 0.0f, 0.0f);
      JVector.Up = new JVector(0.0f, 1f, 0.0f);
      JVector.Down = new JVector(0.0f, -1f, 0.0f);
      JVector.Backward = new JVector(0.0f, 0.0f, -1f);
      JVector.Forward = new JVector(0.0f, 0.0f, 1f);
      JVector.MinValue = new JVector(float.MinValue);
      JVector.MaxValue = new JVector(float.MaxValue);
      JVector.Arbitrary = new JVector(1f, 1f, 1f);
      JVector.InternalZero = JVector.Zero;
    }

    public JVector(float x, float y, float z)
    {
      this.X = x;
      this.Y = y;
      this.Z = z;
    }

    public void Set(float x, float y, float z)
    {
      this.X = x;
      this.Y = y;
      this.Z = z;
    }

    public JVector(float xyz)
    {
      this.X = xyz;
      this.Y = xyz;
      this.Z = xyz;
    }

    public override string ToString() => string.Format("X={0} Y={1} Z={2}", (object) this.X, (object) this.Y, (object) this.Z);

    public string ToString(string floatFormatString) => "X=" + this.X.ToString(floatFormatString) + " Y=" + this.Y.ToString(floatFormatString) + " Z=" + this.Z.ToString(floatFormatString);

    public static bool operator ==(JVector value1, JVector value2) => (double) Math.Abs(value1.X - value2.X) < 1.40129846432482E-45 && (double) Math.Abs(value1.Y - value2.Y) < 1.40129846432482E-45 && (double) Math.Abs(value1.Z - value2.Z) < 1.40129846432482E-45;

    public static bool operator !=(JVector value1, JVector value2) => (double) value1.X != (double) value2.X || (double) value1.Y != (double) value2.Y || (double) value1.Z != (double) value2.Z;

    public static JVector Min(JVector value1, JVector value2)
    {
      JVector result;
      JVector.Min(ref value1, ref value2, out result);
      return result;
    }

    public static void Min(ref JVector value1, ref JVector value2, out JVector result)
    {
      result.X = (double) value1.X < (double) value2.X ? value1.X : value2.X;
      result.Y = (double) value1.Y < (double) value2.Y ? value1.Y : value2.Y;
      result.Z = (double) value1.Z < (double) value2.Z ? value1.Z : value2.Z;
    }

    public static JVector Max(JVector value1, JVector value2)
    {
      JVector result;
      JVector.Max(ref value1, ref value2, out result);
      return result;
    }

    public static void Max(ref JVector value1, ref JVector value2, out JVector result)
    {
      result.X = (double) value1.X > (double) value2.X ? value1.X : value2.X;
      result.Y = (double) value1.Y > (double) value2.Y ? value1.Y : value2.Y;
      result.Z = (double) value1.Z > (double) value2.Z ? value1.Z : value2.Z;
    }

    public void MakeZero()
    {
      this.X = 0.0f;
      this.Y = 0.0f;
      this.Z = 0.0f;
    }

    public bool IsZero() => (double) this.LengthSquared() == 0.0;

    public bool IsNearlyZero() => (double) this.LengthSquared() < 1.42108539188611E-24;

    public static JVector Transform(JVector position, JMatrix matrix)
    {
      JVector result;
      JVector.Transform(ref position, ref matrix, out result);
      return result;
    }

    public static void Transform(ref JVector position, ref JMatrix matrix, out JVector result)
    {
      float num1 = (float) ((double) position.X * (double) matrix.M11 + (double) position.Y * (double) matrix.M21 + (double) position.Z * (double) matrix.M31);
      float num2 = (float) ((double) position.X * (double) matrix.M12 + (double) position.Y * (double) matrix.M22 + (double) position.Z * (double) matrix.M32);
      float num3 = (float) ((double) position.X * (double) matrix.M13 + (double) position.Y * (double) matrix.M23 + (double) position.Z * (double) matrix.M33);
      result.X = num1;
      result.Y = num2;
      result.Z = num3;
    }

    public static void TransposedTransform(
      ref JVector position,
      ref JMatrix matrix,
      out JVector result)
    {
      float num1 = (float) ((double) position.X * (double) matrix.M11 + (double) position.Y * (double) matrix.M12 + (double) position.Z * (double) matrix.M13);
      float num2 = (float) ((double) position.X * (double) matrix.M21 + (double) position.Y * (double) matrix.M22 + (double) position.Z * (double) matrix.M23);
      float num3 = (float) ((double) position.X * (double) matrix.M31 + (double) position.Y * (double) matrix.M32 + (double) position.Z * (double) matrix.M33);
      result.X = num1;
      result.Y = num2;
      result.Z = num3;
    }

    public static float Dot(JVector vector1, JVector vector2) => JVector.Dot(ref vector1, ref vector2);

    public static float Dot(ref JVector vector1, ref JVector vector2) => (float) ((double) vector1.X * (double) vector2.X + (double) vector1.Y * (double) vector2.Y + (double) vector1.Z * (double) vector2.Z);

    public static JVector Add(JVector value1, JVector value2)
    {
      JVector result;
      JVector.Add(ref value1, ref value2, out result);
      return result;
    }

    public static void Add(ref JVector value1, ref JVector value2, out JVector result)
    {
      float num1 = value1.X + value2.X;
      float num2 = value1.Y + value2.Y;
      float num3 = value1.Z + value2.Z;
      result.X = num1;
      result.Y = num2;
      result.Z = num3;
    }

    public static JVector Subtract(JVector value1, JVector value2)
    {
      JVector result;
      JVector.Subtract(ref value1, ref value2, out result);
      return result;
    }

    public static void Subtract(ref JVector value1, ref JVector value2, out JVector result)
    {
      float num1 = value1.X - value2.X;
      float num2 = value1.Y - value2.Y;
      float num3 = value1.Z - value2.Z;
      result.X = num1;
      result.Y = num2;
      result.Z = num3;
    }

    public static JVector Cross(JVector vector1, JVector vector2)
    {
      JVector result;
      JVector.Cross(ref vector1, ref vector2, out result);
      return result;
    }

    public static void Cross(ref JVector vector1, ref JVector vector2, out JVector result)
    {
      float num1 = (float) ((double) vector1.Y * (double) vector2.Z - (double) vector1.Z * (double) vector2.Y);
      float num2 = (float) ((double) vector1.Z * (double) vector2.X - (double) vector1.X * (double) vector2.Z);
      float num3 = (float) ((double) vector1.X * (double) vector2.Y - (double) vector1.Y * (double) vector2.X);
      result.X = num1;
      result.Y = num2;
      result.Z = num3;
    }

    public override int GetHashCode() => (this.X.GetHashCode() * 397 ^ this.Y.GetHashCode()) * 397 ^ this.Z.GetHashCode();

    public void Negate()
    {
      this.X = -this.X;
      this.Y = -this.Y;
      this.Z = -this.Z;
    }

    public static JVector Negate(JVector value)
    {
      JVector result;
      JVector.Negate(ref value, out result);
      return result;
    }

    public static void Negate(ref JVector value, out JVector result)
    {
      float num1 = -value.X;
      float num2 = -value.Y;
      float num3 = -value.Z;
      result.X = num1;
      result.Y = num2;
      result.Z = num3;
    }

    public static JVector Normalize(JVector value)
    {
      JVector result;
      JVector.Normalize(ref value, out result);
      return result;
    }

    public void Normalize()
    {
      if (this.IsNearlyZero())
      {
        this = JVector.Zero;
      }
      else
      {
        float num = 1f / (float) Math.Sqrt((double) this.X * (double) this.X + (double) this.Y * (double) this.Y + (double) this.Z * (double) this.Z);
        this.X *= num;
        this.Y *= num;
        this.Z *= num;
      }
    }

    public static void Normalize(ref JVector value, out JVector result)
    {
      if (value.IsNearlyZero())
      {
        result = JVector.Zero;
      }
      else
      {
        float num = 1f / (float) Math.Sqrt((double) value.X * (double) value.X + (double) value.Y * (double) value.Y + (double) value.Z * (double) value.Z);
        result.X = value.X * num;
        result.Y = value.Y * num;
        result.Z = value.Z * num;
      }
    }

    public float LengthSquared() => (float) ((double) this.X * (double) this.X + (double) this.Y * (double) this.Y + (double) this.Z * (double) this.Z);

    public float Length() => (float) Math.Sqrt((double) this.X * (double) this.X + (double) this.Y * (double) this.Y + (double) this.Z * (double) this.Z);

    public static void Swap(ref JVector vector1, ref JVector vector2)
    {
      float x = vector1.X;
      vector1.X = vector2.X;
      vector2.X = x;
      float y = vector1.Y;
      vector1.Y = vector2.Y;
      vector2.Y = y;
      float z = vector1.Z;
      vector1.Z = vector2.Z;
      vector2.Z = z;
    }

    public static JVector Multiply(JVector value1, float scaleFactor)
    {
      JVector result;
      JVector.Multiply(ref value1, scaleFactor, out result);
      return result;
    }

    public static void Multiply(ref JVector value1, float scaleFactor, out JVector result)
    {
      result.X = value1.X * scaleFactor;
      result.Y = value1.Y * scaleFactor;
      result.Z = value1.Z * scaleFactor;
    }

    public static JVector Multiply(ref JVector value1, float scaleFactor) => new JVector()
    {
      X = value1.X * scaleFactor,
      Y = value1.Y * scaleFactor,
      Z = value1.Z * scaleFactor
    };

    public static JVector operator %(JVector value1, JVector value2)
    {
      JVector result;
      JVector.Cross(ref value1, ref value2, out result);
      return result;
    }

    public static float operator *(JVector value1, JVector value2) => JVector.Dot(ref value1, ref value2);

    public static JVector operator *(JVector value1, float value2)
    {
      JVector result;
      JVector.Multiply(ref value1, value2, out result);
      return result;
    }

    public static JVector operator *(float value1, JVector value2)
    {
      JVector result;
      JVector.Multiply(ref value2, value1, out result);
      return result;
    }

    public static JVector operator -(JVector value1, JVector value2)
    {
      JVector result;
      JVector.Subtract(ref value1, ref value2, out result);
      return result;
    }

    public static JVector operator +(JVector value1, JVector value2)
    {
      JVector result;
      JVector.Add(ref value1, ref value2, out result);
      return result;
    }

    public static JVector Lerp(JVector value1, JVector value2, float t) => value1 * (1f - t) + value2 * t;

    public static float Angle(JVector a, JVector b)
    {
      if (a.Equals(b))
        return 0.0f;
      a.Normalize();
      b.Normalize();
      return (float) Math.Acos((double) JMath.Clamp(JVector.Dot(a, b), -1f, 1f)) * 57.29578f;
    }

    public bool Equals(JVector other) => (double) Math.Abs(this.X - other.X) < 1.19209286539301E-12 && (double) Math.Abs(this.Y - other.Y) < 1.19209286539301E-12 && (double) Math.Abs(this.Z - other.Z) < 1.19209286539301E-12;

    public override bool Equals(object obj) => obj != null && obj is JVector other && this.Equals(other);
  }
}
