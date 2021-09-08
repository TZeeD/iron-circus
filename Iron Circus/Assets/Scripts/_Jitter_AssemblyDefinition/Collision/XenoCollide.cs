// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.XenoCollide
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter.Collision
{
  public sealed class XenoCollide
  {
    private const float CollideEpsilon = 0.0001f;
    private const int MaximumIterations = 34;

    private static void SupportMapTransformed(
      ISupportMappable support,
      ref JMatrix orientation,
      ref JVector position,
      ref JVector direction,
      out JVector result)
    {
      result.X = (float) ((double) direction.X * (double) orientation.M11 + (double) direction.Y * (double) orientation.M12 + (double) direction.Z * (double) orientation.M13);
      result.Y = (float) ((double) direction.X * (double) orientation.M21 + (double) direction.Y * (double) orientation.M22 + (double) direction.Z * (double) orientation.M23);
      result.Z = (float) ((double) direction.X * (double) orientation.M31 + (double) direction.Y * (double) orientation.M32 + (double) direction.Z * (double) orientation.M33);
      support.SupportMapping(ref result, out result);
      float num1 = (float) ((double) result.X * (double) orientation.M11 + (double) result.Y * (double) orientation.M21 + (double) result.Z * (double) orientation.M31);
      float num2 = (float) ((double) result.X * (double) orientation.M12 + (double) result.Y * (double) orientation.M22 + (double) result.Z * (double) orientation.M32);
      float num3 = (float) ((double) result.X * (double) orientation.M13 + (double) result.Y * (double) orientation.M23 + (double) result.Z * (double) orientation.M33);
      result.X = position.X + num1;
      result.Y = position.Y + num2;
      result.Z = position.Z + num3;
    }

    public static bool Detect(
      ISupportMappable support1,
      ISupportMappable support2,
      ref JMatrix orientation1,
      ref JMatrix orientation2,
      ref JVector position1,
      ref JVector position2,
      out JVector point,
      out JVector normal,
      out float penetration)
    {
      point = normal = JVector.Zero;
      penetration = 0.0f;
      JVector position3;
      support1.SupportCenter(out position3);
      JVector.Transform(ref position3, ref orientation1, out position3);
      JVector.Add(ref position1, ref position3, out position3);
      JVector position4;
      support2.SupportCenter(out position4);
      JVector.Transform(ref position4, ref orientation2, out position4);
      JVector.Add(ref position2, ref position4, out position4);
      JVector result1;
      JVector.Subtract(ref position4, ref position3, out result1);
      if (result1.IsNearlyZero())
        result1 = new JVector(1E-05f, 0.0f, 0.0f);
      JVector result2 = result1;
      JVector.Negate(ref result1, out normal);
      JVector result3;
      XenoCollide.SupportMapTransformed(support1, ref orientation1, ref position1, ref result2, out result3);
      JVector result4;
      XenoCollide.SupportMapTransformed(support2, ref orientation2, ref position2, ref normal, out result4);
      JVector result5;
      JVector.Subtract(ref result4, ref result3, out result5);
      if ((double) JVector.Dot(ref result5, ref normal) <= 0.0)
        return false;
      JVector.Cross(ref result5, ref result1, out normal);
      if (normal.IsNearlyZero())
      {
        JVector.Subtract(ref result5, ref result1, out normal);
        normal.Normalize();
        point = result3;
        JVector.Add(ref point, ref result4, out point);
        JVector.Multiply(ref point, 0.5f, out point);
        JVector result6;
        JVector.Subtract(ref result4, ref result3, out result6);
        penetration = JVector.Dot(ref result6, ref normal);
        return true;
      }
      JVector.Negate(ref normal, out result2);
      JVector result7;
      XenoCollide.SupportMapTransformed(support1, ref orientation1, ref position1, ref result2, out result7);
      JVector result8;
      XenoCollide.SupportMapTransformed(support2, ref orientation2, ref position2, ref normal, out result8);
      JVector result9;
      JVector.Subtract(ref result8, ref result7, out result9);
      if ((double) JVector.Dot(ref result9, ref normal) <= 0.0)
        return false;
      JVector result10;
      JVector.Subtract(ref result5, ref result1, out result10);
      JVector result11;
      JVector.Subtract(ref result9, ref result1, out result11);
      JVector.Cross(ref result10, ref result11, out normal);
      if ((double) JVector.Dot(ref normal, ref result1) > 0.0)
      {
        JVector.Swap(ref result5, ref result9);
        JVector.Swap(ref result3, ref result7);
        JVector.Swap(ref result4, ref result8);
        JVector.Negate(ref normal, out normal);
      }
      int num1 = 0;
      int num2 = 0;
      bool flag = false;
      while (num2 <= 34)
      {
        ++num2;
        JVector.Negate(ref normal, out result2);
        JVector result12;
        XenoCollide.SupportMapTransformed(support1, ref orientation1, ref position1, ref result2, out result12);
        JVector result13;
        XenoCollide.SupportMapTransformed(support2, ref orientation2, ref position2, ref normal, out result13);
        JVector result14;
        JVector.Subtract(ref result13, ref result12, out result14);
        if ((double) JVector.Dot(ref result14, ref normal) <= 0.0)
          return false;
        JVector.Cross(ref result5, ref result14, out result10);
        if ((double) JVector.Dot(ref result10, ref result1) < 0.0)
        {
          result9 = result14;
          result7 = result12;
          result8 = result13;
          JVector.Subtract(ref result5, ref result1, out result10);
          JVector.Subtract(ref result14, ref result1, out result11);
          JVector.Cross(ref result10, ref result11, out normal);
        }
        else
        {
          JVector.Cross(ref result14, ref result9, out result10);
          if ((double) JVector.Dot(ref result10, ref result1) < 0.0)
          {
            result5 = result14;
            result3 = result12;
            result4 = result13;
            JVector.Subtract(ref result14, ref result1, out result10);
            JVector.Subtract(ref result9, ref result1, out result11);
            JVector.Cross(ref result10, ref result11, out normal);
          }
          else
          {
            while (true)
            {
              ++num1;
              JVector.Subtract(ref result9, ref result5, out result10);
              JVector.Subtract(ref result14, ref result5, out result11);
              JVector.Cross(ref result10, ref result11, out normal);
              if (!normal.IsNearlyZero())
              {
                normal.Normalize();
                if ((double) JVector.Dot(ref normal, ref result5) >= 0.0 && !flag)
                  flag = true;
                JVector.Negate(ref normal, out result2);
                JVector result15;
                XenoCollide.SupportMapTransformed(support1, ref orientation1, ref position1, ref result2, out result15);
                JVector result16;
                XenoCollide.SupportMapTransformed(support2, ref orientation2, ref position2, ref normal, out result16);
                JVector result17;
                JVector.Subtract(ref result16, ref result15, out result17);
                JVector.Subtract(ref result17, ref result14, out result10);
                double num3 = (double) JVector.Dot(ref result10, ref normal);
                penetration = JVector.Dot(ref result17, ref normal);
                if (num3 > 9.99999974737875E-05 && (double) penetration > 0.0 && num1 <= 34)
                {
                  JVector.Cross(ref result17, ref result1, out result10);
                  if ((double) JVector.Dot(ref result10, ref result5) >= 0.0)
                  {
                    if ((double) JVector.Dot(ref result10, ref result9) >= 0.0)
                    {
                      result5 = result17;
                      result3 = result15;
                      result4 = result16;
                    }
                    else
                    {
                      result14 = result17;
                      result12 = result15;
                      result13 = result16;
                    }
                  }
                  else if ((double) JVector.Dot(ref result10, ref result14) >= 0.0)
                  {
                    result9 = result17;
                    result7 = result15;
                    result8 = result16;
                  }
                  else
                  {
                    result5 = result17;
                    result3 = result15;
                    result4 = result16;
                  }
                }
                else
                  goto label_24;
              }
              else
                break;
            }
            return true;
label_24:
            if (flag)
            {
              JVector.Cross(ref result5, ref result9, out result10);
              float scaleFactor1 = JVector.Dot(ref result10, ref result14);
              JVector.Cross(ref result14, ref result9, out result10);
              float scaleFactor2 = JVector.Dot(ref result10, ref result1);
              JVector.Cross(ref result1, ref result5, out result10);
              float scaleFactor3 = JVector.Dot(ref result10, ref result14);
              JVector.Cross(ref result9, ref result5, out result10);
              float scaleFactor4 = JVector.Dot(ref result10, ref result1);
              float num4 = scaleFactor1 + scaleFactor2 + scaleFactor3 + scaleFactor4;
              if ((double) num4 <= 0.0)
              {
                scaleFactor1 = 0.0f;
                JVector.Cross(ref result9, ref result14, out result10);
                scaleFactor2 = JVector.Dot(ref result10, ref normal);
                JVector.Cross(ref result14, ref result5, out result10);
                scaleFactor3 = JVector.Dot(ref result10, ref normal);
                JVector.Cross(ref result5, ref result9, out result10);
                scaleFactor4 = JVector.Dot(ref result10, ref normal);
                num4 = scaleFactor2 + scaleFactor3 + scaleFactor4;
              }
              float num5 = 1f / num4;
              JVector.Multiply(ref position3, scaleFactor1, out point);
              JVector.Multiply(ref result3, scaleFactor2, out result10);
              JVector.Add(ref point, ref result10, out point);
              JVector.Multiply(ref result7, scaleFactor3, out result10);
              JVector.Add(ref point, ref result10, out point);
              JVector.Multiply(ref result12, scaleFactor4, out result10);
              JVector.Add(ref point, ref result10, out point);
              JVector.Multiply(ref position4, scaleFactor1, out result11);
              JVector.Add(ref result11, ref point, out point);
              JVector.Multiply(ref result4, scaleFactor2, out result10);
              JVector.Add(ref point, ref result10, out point);
              JVector.Multiply(ref result8, scaleFactor3, out result10);
              JVector.Add(ref point, ref result10, out point);
              JVector.Multiply(ref result13, scaleFactor4, out result10);
              JVector.Add(ref point, ref result10, out point);
              JVector.Multiply(ref point, num5 * 0.5f, out point);
            }
            return flag;
          }
        }
      }
      return false;
    }
  }
}
