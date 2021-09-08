// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.Smoothing.FilteredFloat
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SteelCircus.Utils.Smoothing
{
  public class FilteredFloat
  {
    private FilteredFloat.TimeValuePair[] ringBuffer;
    private float smoothDuration = 1f;
    private int currentReadIndex = -1;

    public FilteredFloat(float smoothDuration = 1f)
    {
      this.smoothDuration = smoothDuration;
      int length = (int) ((double) smoothDuration * 90.0);
      this.ringBuffer = new FilteredFloat.TimeValuePair[length];
      for (int index = 0; index < length; ++index)
        this.ringBuffer[index].timestamp = -1f;
    }

    public void Clear()
    {
      for (int index = this.ringBuffer.Length - 1; index >= 0; --index)
        this.ringBuffer[index].timestamp = -1f;
      this.currentReadIndex = -1;
    }

    public bool CanAdd(float timestampInSeconds) => this.currentReadIndex == -1 || (double) this.ringBuffer[this.currentReadIndex].timestamp < (double) timestampInSeconds;

    public void Add(float value, float timestampInSeconds)
    {
      if (this.currentReadIndex != -1 && (double) timestampInSeconds <= (double) this.ringBuffer[this.currentReadIndex].timestamp)
        throw new ArgumentException("A value with the same or newer timestamp has already been added.");
      float num = timestampInSeconds - this.smoothDuration;
      int index = (this.currentReadIndex + 1) % this.ringBuffer.Length;
      FilteredFloat.TimeValuePair timeValuePair = this.ringBuffer[(this.currentReadIndex + 2) % this.ringBuffer.Length];
      if ((double) timeValuePair.timestamp != -1.0 && (double) timeValuePair.timestamp > (double) num)
      {
        this.IncreaseBufferCapacity();
        this.Add(value, timestampInSeconds);
      }
      else
      {
        this.ringBuffer[index].timestamp = timestampInSeconds;
        this.ringBuffer[index].value = value;
        this.currentReadIndex = index;
      }
    }

    public float GetSimpleAverage()
    {
      int num1 = 0;
      float num2 = 0.0f;
      if (this.currentReadIndex == -1)
        return 0.0f;
      float num3 = this.ringBuffer[this.currentReadIndex].timestamp - this.smoothDuration;
      for (int index = this.ringBuffer.Length - 1; index >= 0; --index)
      {
        FilteredFloat.TimeValuePair timeValuePair = this.ringBuffer[index];
        if ((double) timeValuePair.timestamp >= (double) num3)
        {
          ++num1;
          num2 += timeValuePair.value;
        }
      }
      return num2 / (float) num1;
    }

    private void IncreaseBufferCapacity()
    {
      int length1 = this.ringBuffer.Length * 2;
      FilteredFloat.TimeValuePair[] timeValuePairArray = new FilteredFloat.TimeValuePair[length1];
      for (int index = 0; index < length1; ++index)
        timeValuePairArray[index].timestamp = -1f;
      Array.Copy((Array) this.ringBuffer, (Array) timeValuePairArray, this.currentReadIndex + 1);
      if (this.currentReadIndex + 1 < this.ringBuffer.Length)
      {
        int length2 = this.ringBuffer.Length - (this.currentReadIndex + 1);
        Array.Copy((Array) this.ringBuffer, this.currentReadIndex + 1, (Array) timeValuePairArray, length1 - length2, length2);
      }
      this.ringBuffer = timeValuePairArray;
    }

    private struct TimeValuePair
    {
      public float timestamp;
      public float value;
    }
  }
}
