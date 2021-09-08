// Decompiled with JetBrains decompiler
// Type: Jitter.LinearMath.JBBox
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

namespace Jitter.LinearMath
{
  public struct JBBox
  {
    public JVector Min;
    public JVector Max;
    public static readonly JBBox LargeBox;
    public static readonly JBBox SmallBox;

    static JBBox()
    {
      JBBox.LargeBox.Min = new JVector(float.MinValue);
      JBBox.LargeBox.Max = new JVector(float.MaxValue);
      JBBox.SmallBox.Min = new JVector(float.MaxValue);
      JBBox.SmallBox.Max = new JVector(float.MinValue);
    }

    public JBBox(JVector min, JVector max)
    {
      this.Min = min;
      this.Max = max;
    }

    public override string ToString() => string.Format("Min [{0}], Max [{1}]", (object) this.Min, (object) this.Max);

    internal void InverseTransform(ref JVector position, ref JMatrix orientation)
    {
      JVector.Subtract(ref this.Max, ref position, out this.Max);
      JVector.Subtract(ref this.Min, ref position, out this.Min);
      JVector result1;
      JVector.Add(ref this.Max, ref this.Min, out result1);
      result1.X *= 0.5f;
      result1.Y *= 0.5f;
      result1.Z *= 0.5f;
      JVector result2;
      JVector.Subtract(ref this.Max, ref this.Min, out result2);
      result2.X *= 0.5f;
      result2.Y *= 0.5f;
      result2.Z *= 0.5f;
      JVector.TransposedTransform(ref result1, ref orientation, out result1);
      JMatrix result3;
      JMath.Absolute(ref orientation, out result3);
      JVector.TransposedTransform(ref result2, ref result3, out result2);
      JVector.Add(ref result1, ref result2, out this.Max);
      JVector.Subtract(ref result1, ref result2, out this.Min);
    }

    public void Transform(ref JMatrix orientation)
    {
      JVector result1 = 0.5f * (this.Max - this.Min);
      JVector result2 = 0.5f * (this.Max + this.Min);
      JVector.Transform(ref result2, ref orientation, out result2);
      JMatrix result3;
      JMath.Absolute(ref orientation, out result3);
      JVector.Transform(ref result1, ref result3, out result1);
      this.Max = result2 + result1;
      this.Min = result2 - result1;
    }

    private bool Intersect1D(
      float start,
      float dir,
      float min,
      float max,
      ref float enter,
      ref float exit)
    {
      if ((double) dir * (double) dir < 1.42108539188611E-24)
        return (double) start >= (double) min && (double) start <= (double) max;
      float num1 = (min - start) / dir;
      float num2 = (max - start) / dir;
      if ((double) num1 > (double) num2)
      {
        double num3 = (double) num1;
        num1 = num2;
        num2 = (float) num3;
      }
      if ((double) num1 > (double) exit || (double) num2 < (double) enter)
        return false;
      if ((double) num1 > (double) enter)
        enter = num1;
      if ((double) num2 < (double) exit)
        exit = num2;
      return true;
    }

    public bool SegmentIntersect(ref JVector origin, ref JVector direction)
    {
      float enter = 0.0f;
      float exit = 1f;
      return this.Intersect1D(origin.X, direction.X, this.Min.X, this.Max.X, ref enter, ref exit) && this.Intersect1D(origin.Y, direction.Y, this.Min.Y, this.Max.Y, ref enter, ref exit) && this.Intersect1D(origin.Z, direction.Z, this.Min.Z, this.Max.Z, ref enter, ref exit);
    }

    public bool RayIntersect(ref JVector origin, ref JVector direction)
    {
      float enter = 0.0f;
      float maxValue = float.MaxValue;
      return this.Intersect1D(origin.X, direction.X, this.Min.X, this.Max.X, ref enter, ref maxValue) && this.Intersect1D(origin.Y, direction.Y, this.Min.Y, this.Max.Y, ref enter, ref maxValue) && this.Intersect1D(origin.Z, direction.Z, this.Min.Z, this.Max.Z, ref enter, ref maxValue);
    }

    public bool SegmentIntersect(JVector origin, JVector direction) => this.SegmentIntersect(ref origin, ref direction);

    public bool RayIntersect(JVector origin, JVector direction) => this.RayIntersect(ref origin, ref direction);

    public JBBox.ContainmentType Contains(JVector point) => this.Contains(ref point);

    public JBBox.ContainmentType Contains(ref JVector point) => (double) this.Min.X > (double) point.X || (double) point.X > (double) this.Max.X || (double) this.Min.Y > (double) point.Y || (double) point.Y > (double) this.Max.Y || (double) this.Min.Z > (double) point.Z || (double) point.Z > (double) this.Max.Z ? JBBox.ContainmentType.Disjoint : JBBox.ContainmentType.Contains;

    public void GetCorners(JVector[] corners)
    {
      corners[0].Set(this.Max.X, this.Max.Y, this.Max.Z);
      corners[1].Set(this.Max.X, this.Max.Y, this.Min.Z);
      corners[2].Set(this.Min.X, this.Max.Y, this.Min.Z);
      corners[3].Set(this.Min.X, this.Max.Y, this.Max.Z);
      corners[4].Set(this.Max.X, this.Min.Y, this.Max.Z);
      corners[5].Set(this.Max.X, this.Min.Y, this.Min.Z);
      corners[6].Set(this.Min.X, this.Min.Y, this.Min.Z);
      corners[7].Set(this.Min.X, this.Min.Y, this.Max.Z);
    }

    public void AddPoint(JVector point) => this.AddPoint(ref point);

    public void AddPoint(ref JVector point)
    {
      JVector.Max(ref this.Max, ref point, out this.Max);
      JVector.Min(ref this.Min, ref point, out this.Min);
    }

    public static JBBox CreateFromPoints(JVector[] points)
    {
      JVector result1 = new JVector(float.MaxValue);
      JVector result2 = new JVector(float.MinValue);
      for (int index = 0; index < points.Length; ++index)
      {
        JVector.Min(ref result1, ref points[index], out result1);
        JVector.Max(ref result2, ref points[index], out result2);
      }
      return new JBBox(result1, result2);
    }

    public JBBox.ContainmentType Contains(JBBox box) => this.Contains(ref box);

    public JBBox.ContainmentType Contains(ref JBBox box)
    {
      JBBox.ContainmentType containmentType = JBBox.ContainmentType.Disjoint;
      if ((double) this.Max.X >= (double) box.Min.X && (double) this.Min.X <= (double) box.Max.X && (double) this.Max.Y >= (double) box.Min.Y && (double) this.Min.Y <= (double) box.Max.Y && (double) this.Max.Z >= (double) box.Min.Z && (double) this.Min.Z <= (double) box.Max.Z)
        containmentType = (double) this.Min.X > (double) box.Min.X || (double) box.Max.X > (double) this.Max.X || (double) this.Min.Y > (double) box.Min.Y || (double) box.Max.Y > (double) this.Max.Y || (double) this.Min.Z > (double) box.Min.Z || (double) box.Max.Z > (double) this.Max.Z ? JBBox.ContainmentType.Intersects : JBBox.ContainmentType.Contains;
      return containmentType;
    }

    public static JBBox CreateMerged(JBBox original, JBBox additional)
    {
      JBBox result;
      JBBox.CreateMerged(ref original, ref additional, out result);
      return result;
    }

    public static void CreateMerged(ref JBBox original, ref JBBox additional, out JBBox result)
    {
      JVector result1;
      JVector.Min(ref original.Min, ref additional.Min, out result1);
      JVector result2;
      JVector.Max(ref original.Max, ref additional.Max, out result2);
      result.Min = result1;
      result.Max = result2;
    }

    public JVector Center => (this.Min + this.Max) * 0.5f;

    internal float Perimeter => (float) (2.0 * (((double) this.Max.X - (double) this.Min.X) * ((double) this.Max.Y - (double) this.Min.Y) + ((double) this.Max.X - (double) this.Min.X) * ((double) this.Max.Z - (double) this.Min.Z) + ((double) this.Max.Z - (double) this.Min.Z) * ((double) this.Max.Y - (double) this.Min.Y)));

    public enum ContainmentType
    {
      Disjoint,
      Contains,
      Intersects,
    }
  }
}
