// Decompiled with JetBrains decompiler
// Type: SteelCircus.GameElements.Curve
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Utils.Extensions;
using System;
using System.Collections.Generic;

namespace SteelCircus.GameElements
{
  [Serializable]
  public class Curve
  {
    private const int IntegrationTableSize = 120;
    private const float CurveStepSize = 0.008333334f;
    private float[] table;
    public List<CurvePoint> points;

    public byte[] ToBytes()
    {
      byte[] numArray = new byte[4 + this.points.Count * 4 * 4];
      int index1 = 0;
      BitConverter.GetBytes(this.points.Count).CopyTo((Array) numArray, index1);
      int index2 = index1 + 4;
      for (int index3 = 0; index3 < this.points.Count; ++index3)
      {
        CurvePoint point = this.points[index3];
        BitConverter.GetBytes(point.time).CopyTo((Array) numArray, index2);
        int index4 = index2 + 4;
        BitConverter.GetBytes(point.value).CopyTo((Array) numArray, index4);
        int index5 = index4 + 4;
        BitConverter.GetBytes(point.inSlope).CopyTo((Array) numArray, index5);
        int index6 = index5 + 4;
        BitConverter.GetBytes(point.outSlope).CopyTo((Array) numArray, index6);
        index2 = index6 + 4;
      }
      return numArray;
    }

    public int FromBytes(byte[] bytes, int startIdx)
    {
      int int32 = BitConverter.ToInt32(bytes, startIdx);
      startIdx += 4;
      this.points.Clear();
      for (int index = 0; index < int32; ++index)
      {
        CurvePoint curvePoint = new CurvePoint();
        curvePoint.time = BitConverter.ToSingle(bytes, startIdx);
        startIdx += 4;
        curvePoint.value = BitConverter.ToSingle(bytes, startIdx);
        startIdx += 4;
        curvePoint.inSlope = BitConverter.ToSingle(bytes, startIdx);
        startIdx += 4;
        curvePoint.outSlope = BitConverter.ToSingle(bytes, startIdx);
        startIdx += 4;
        this.points.Add(curvePoint);
      }
      return startIdx;
    }

    public float Evaluate(float t) => this.Evaluate(t, this.points);

    public float GetNormalizedProgress(float t)
    {
      t = (double) t < 0.0 ? 0.0f : ((double) t > 1.0 ? 1f : t);
      this.UpdateIntegrationTable();
      return this.SampleIntegrationTable(t) / this.table[this.table.Length - 1];
    }

    public float Integrate(float stepSize, float t)
    {
      if ((double) stepSize <= 0.0)
        return 0.0f;
      t = (double) t < 0.0 ? 0.0f : ((double) t > 1.0 ? 1f : t);
      this.UpdateIntegrationTable();
      return this.SampleIntegrationTable(t);
    }

    private float SampleIntegrationTable(float t)
    {
      float num = t / 0.008333334f;
      int index = (int) num;
      int length = this.table.Length;
      if (index >= length)
        return this.table[length - 1];
      if (index <= 0)
        return 0.0f;
      float t1 = num - (float) index;
      return MathExtensions.Interpolate(this.table[index - 1], this.table[index], t1);
    }

    private void UpdateIntegrationTable()
    {
      if (this.table == null || this.table.Length != 120)
        this.table = new float[120];
      float num = 0.0f;
      float t = 0.008333334f;
      for (int index = 0; index < 119; ++index)
      {
        num += Math.Abs(this.Evaluate(t) * 0.008333334f);
        this.table[index] = num;
        t += 0.008333334f;
      }
      this.table[119] = num + Math.Abs(this.Evaluate(1f) * 0.008333334f);
    }

    public float Evaluate(float t, List<CurvePoint> points)
    {
      if (points.Count < 2)
      {
        Log.Error("Cannot evaluate curve with less than two points!");
      }
      else
      {
        if ((double) t > (double) points[points.Count - 1].time)
          return points[points.Count - 1].value;
        if ((double) t < (double) points[0].time)
          return points[0].value;
      }
      int index1 = 0;
      for (int index2 = 0; index2 < points.Count; ++index2)
      {
        if ((double) points[index2].time >= (double) t)
        {
          index1 = index2;
          break;
        }
      }
      if (index1 <= 0 || index1 >= points.Count)
        return 0.0f;
      CurvePoint point1 = points[index1 - 1];
      CurvePoint point2 = points[index1];
      if (float.IsInfinity(point1.outSlope) || float.IsInfinity(point2.inSlope))
        return point1.value;
      float num1 = point2.time - point1.time;
      t = (t - point1.time) / num1;
      float num2 = point1.outSlope * num1;
      float num3 = point2.inSlope * num1;
      float num4 = t * t;
      float num5 = num4 * t;
      double num6 = 2.0 * (double) num5 - 3.0 * (double) num4 + 1.0;
      float num7 = num5 - 2f * num4 + t;
      float num8 = num5 - num4;
      float num9 = (float) (-2.0 * (double) num5 + 3.0 * (double) num4);
      double num10 = (double) point1.value;
      return (float) (num6 * num10 + (double) num7 * (double) num2 + (double) num8 * (double) num3 + (double) num9 * (double) point2.value);
    }
  }
}
