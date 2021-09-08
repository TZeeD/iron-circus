// Decompiled with JetBrains decompiler
// Type: Jitter.LinearMath.JConvexHull
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;
using System.Collections.Generic;

namespace Jitter.LinearMath
{
  public static class JConvexHull
  {
    public static int[] Build(List<JVector> pointCloud, JConvexHull.Approximation factor)
    {
      List<int> intList = new List<int>();
      int num1 = (int) factor;
      for (int index1 = 0; index1 < num1; ++index1)
      {
        double d1;
        float num2 = (float) Math.Sin(d1 = 3.14159274101257 / (double) (num1 - 1) * (double) index1);
        float y = (float) Math.Cos(d1);
        for (int index2 = 0; index2 < num1; ++index2)
        {
          double d2;
          float num3 = (float) Math.Sin(d2 = 6.28318548202515 / (double) num1 * (double) index2 - 3.14159274101257);
          float num4 = (float) Math.Cos(d2);
          JVector dir = new JVector(num2 * num4, y, num2 * num3);
          int extremePoint = JConvexHull.FindExtremePoint(pointCloud, ref dir);
          intList.Add(extremePoint);
        }
      }
      intList.Sort();
      for (int index = 1; index < intList.Count; ++index)
      {
        if (intList[index - 1] == intList[index])
        {
          intList.RemoveAt(index - 1);
          --index;
        }
      }
      return intList.ToArray();
    }

    private static int FindExtremePoint(List<JVector> points, ref JVector dir)
    {
      int num1 = 0;
      float num2 = float.MinValue;
      for (int index = 1; index < points.Count; ++index)
      {
        JVector point = points[index];
        float num3 = JVector.Dot(ref point, ref dir);
        if ((double) num3 > (double) num2)
        {
          num2 = num3;
          num1 = index;
        }
      }
      return num1;
    }

    public enum Approximation
    {
      Level1 = 6,
      Level2 = 7,
      Level3 = 8,
      Level4 = 9,
      Level5 = 10, // 0x0000000A
      Level6 = 11, // 0x0000000B
      Level7 = 12, // 0x0000000C
      Level8 = 13, // 0x0000000D
      Level9 = 15, // 0x0000000F
      Level10 = 20, // 0x00000014
      Level15 = 25, // 0x00000019
      Level20 = 30, // 0x0000001E
    }
  }
}
