// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.AnalogInputSmoothing
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class AnalogInputSmoothing
  {
    private const float smoothDurationInSeconds = 0.3f;
    private const int analogInputRingBufferSize = 50;
    private const float analogInputDistanceThreshold = 0.2f;
    private const float analogInputAngleThreshold = 10f;
    private const float analogInputWeightPow = 0.5f;
    private const float analogInputWeightAgeDecayCurve = 5f;
    private Vector3[] analogInputRingBuffer = new Vector3[50];
    private float[] timestampRingBuffer = new float[50];
    private int analogInputRingBufferIndex;

    public Vector3 SmoothAnalogInput(Vector3 input)
    {
      float realtimeSinceStartup = Time.realtimeSinceStartup;
      this.analogInputRingBuffer[this.analogInputRingBufferIndex] = input;
      this.timestampRingBuffer[this.analogInputRingBufferIndex] = realtimeSinceStartup;
      float magnitude1 = input.magnitude;
      float num1 = 1f;
      Vector3 vector3_1 = input;
      int num2 = 0;
      for (int index = 0; index < 49 && (double) this.timestampRingBuffer[((this.analogInputRingBufferIndex - (index + 1)) % 50 + 50) % 50] >= (double) realtimeSinceStartup - 0.300000011920929; ++index)
        ++num2;
      for (int index1 = 0; index1 < num2; ++index1)
      {
        int index2 = ((this.analogInputRingBufferIndex - (index1 + 1)) % 50 + 50) % 50;
        Vector3 to = this.analogInputRingBuffer[index2];
        double num3 = (double) this.timestampRingBuffer[index2];
        float magnitude2 = to.magnitude;
        float num4 = Vector3.Angle(input, to);
        float num5 = Mathf.Abs(magnitude1 - magnitude2);
        if ((double) num5 <= 0.200000002980232 && (double) num4 <= 10.0)
        {
          float num6 = (1f - Mathf.Pow((float) (((double) num5 / 0.200000002980232 + (double) num4 / 10.0) * 0.5), 0.5f)) * (1f - Mathf.Pow(((float) index1 + 1f) / (float) num2, 5f));
          vector3_1 += num6 * to;
          num1 += num6;
        }
        else
          break;
      }
      Vector3 vector3_2 = vector3_1 / num1;
      this.analogInputRingBufferIndex = (this.analogInputRingBufferIndex + 1) % 50;
      if ((double) vector3_2.sqrMagnitude > 1.0)
        vector3_2.Normalize();
      return vector3_2;
    }
  }
}
