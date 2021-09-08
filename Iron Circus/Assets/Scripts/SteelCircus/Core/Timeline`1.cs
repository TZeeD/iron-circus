// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Timeline`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using System;
using System.Collections.Generic;

namespace SteelCircus.Core
{
  public abstract class Timeline<T> where T : struct
  {
    public const int MaxDurationSeconds = 5;
    public const int MaxDurationMillis = 5000;
    public const int MaxDurationMicro = 5000000;
    public const int MaxDuration = 5000;
    public const float KeyAliasEpsilon = 0.001f;
    public TimelineMode mode;
    public TimelineInfinity preInfinity;
    public TimelineInfinity postInfinity;
    private List<TimelineKeyframe<T>> keyframes = new List<TimelineKeyframe<T>>(100);

    public List<TimelineKeyframe<T>> Keyframes => this.keyframes;

    protected abstract T Interpolate(T a, T b, float t);

    public void Add(float time, T value)
    {
      int index1 = this.keyframes.Count;
      for (int index2 = this.keyframes.Count - 1; index2 >= 0 && (double) this.keyframes[index2].time > (double) time; --index2)
        index1 = index2;
      if (index1 > 0 && (double) time - (double) this.keyframes[index1 - 1].time <= 1.0 / 1000.0)
      {
        TimelineKeyframe<T> keyframe = this.keyframes[index1 - 1];
        keyframe.value = value;
        this.keyframes[index1 - 1] = keyframe;
      }
      else if (index1 > 0 && index1 < this.keyframes.Count)
      {
        this.keyframes.Insert(index1, new TimelineKeyframe<T>()
        {
          time = time,
          value = value
        });
      }
      else
      {
        this.keyframes.Insert(index1, new TimelineKeyframe<T>()
        {
          time = time,
          value = value
        });
        if (this.keyframes.Count <= 1)
          return;
        float num1 = this.keyframes[this.keyframes.Count - 1].time - this.keyframes[0].time;
        if ((double) num1 <= 5000.0)
          return;
        TimelineKeyframe<T> keyframe1 = this.keyframes[0];
        TimelineKeyframe<T> keyframe2 = this.keyframes[1];
        float num2 = num1 - 5000f;
        float num3;
        for (num3 = keyframe2.time - keyframe1.time; (double) num2 > (double) num3; num3 = keyframe2.time - keyframe1.time)
        {
          this.keyframes.RemoveAt(0);
          keyframe1 = this.keyframes[0];
          keyframe2 = this.keyframes[1];
          num2 -= num3;
        }
        float num4 = keyframe1.time + num2;
        if ((double) this.keyframes[1].time <= (double) num4)
          return;
        if (this.mode == TimelineMode.Interpolate)
        {
          float t = num2 / num3;
          this.keyframes[0] = new TimelineKeyframe<T>()
          {
            time = num4,
            value = this.Interpolate(keyframe1.value, keyframe2.value, t)
          };
        }
        else if (this.mode == TimelineMode.Step)
        {
          TimelineKeyframe<T> keyframe3 = this.keyframes[0];
          keyframe3.time = num4;
          this.keyframes[0] = keyframe3;
        }
        else
        {
          if (this.mode != TimelineMode.Pulse)
            return;
          this.keyframes.RemoveAt(0);
        }
      }
    }

    public T ValueAt(float sampleTime)
    {
      int count = this.keyframes.Count;
      if (count < 1)
      {
        Log.Error("Timeline has no entries!");
        return default (T);
      }
      if ((double) sampleTime >= (double) this.keyframes[count - 1].time)
      {
        switch (this.mode)
        {
          case TimelineMode.Interpolate:
            if (this.postInfinity != TimelineInfinity.Extrapolate || this.keyframes.Count <= 1)
              return this.keyframes[count - 1].value;
            TimelineKeyframe<T> keyframe1 = this.keyframes[count - 2];
            TimelineKeyframe<T> keyframe2 = this.keyframes[count - 1];
            return this.Interpolate(keyframe1.value, keyframe2.value, (float) (((double) sampleTime - (double) keyframe1.time) / ((double) keyframe2.time - (double) keyframe1.time)));
          case TimelineMode.Step:
            return this.keyframes[count - 1].value;
          case TimelineMode.Pulse:
            return (double) sampleTime - (double) this.keyframes[count - 1].time <= 1.0 / 1000.0 ? this.keyframes[count - 1].value : default (T);
          default:
            throw new ArgumentOutOfRangeException();
        }
      }
      else if ((double) sampleTime <= (double) this.keyframes[0].time)
      {
        switch (this.mode)
        {
          case TimelineMode.Interpolate:
            if (this.preInfinity != TimelineInfinity.Extrapolate || this.keyframes.Count <= 1)
              return this.keyframes[0].value;
            TimelineKeyframe<T> keyframe3 = this.keyframes[0];
            TimelineKeyframe<T> keyframe4 = this.keyframes[1];
            return this.Interpolate(keyframe3.value, keyframe4.value, (float) (((double) sampleTime - (double) keyframe3.time) / ((double) keyframe4.time - (double) keyframe3.time)));
          case TimelineMode.Step:
          case TimelineMode.Pulse:
            return (double) sampleTime - (double) this.keyframes[0].time <= 1.0 / 1000.0 ? this.keyframes[0].value : default (T);
          default:
            throw new ArgumentOutOfRangeException();
        }
      }
      else
      {
        int index1 = this.keyframes.Count;
        for (int index2 = this.keyframes.Count - 1; index2 >= 0 && (double) this.keyframes[index2].time > (double) sampleTime; --index2)
          index1 = index2;
        switch (this.mode)
        {
          case TimelineMode.Interpolate:
            TimelineKeyframe<T> keyframe5 = this.keyframes[index1 - 1];
            TimelineKeyframe<T> keyframe6 = this.keyframes[index1];
            float num = keyframe6.time - keyframe5.time;
            float t = (sampleTime - keyframe5.time) / num;
            return this.Interpolate(keyframe5.value, keyframe6.value, t);
          case TimelineMode.Step:
            return this.keyframes[index1 - 1].value;
          case TimelineMode.Pulse:
            return default (T);
          default:
            throw new ArgumentOutOfRangeException(string.Format("TimelineMode {0} node implemented!", (object) this.mode));
        }
      }
    }

    public void ClearRange(float startTime, float endTime)
    {
      int index = 0;
      int count = this.keyframes.Count;
      while (index < count)
      {
        float time = this.keyframes[index].time;
        if ((double) time <= (double) startTime)
        {
          if ((double) time > (double) endTime)
            break;
          this.keyframes.RemoveAt(index);
          --count;
        }
        else
          ++index;
      }
    }
  }
}
