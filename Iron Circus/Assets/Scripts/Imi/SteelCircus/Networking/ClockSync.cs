// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Networking.ClockSync
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Utils.Extensions;
using Imi.Utils.Common;
using System;
using System.Runtime.CompilerServices;
using UnityEngine;

namespace Imi.SteelCircus.Networking
{
  [Serializable]
  public class ClockSync
  {
    [Header("Snap Tick Settings")]
    [Tooltip("The default amount of ticks added on the clock sync.")]
    public int MinimumJitterBuffer;
    [Tooltip("Threshold of how many ticks the client is allowed to be in the past before snapping occurs.")]
    public int Past = 30;
    [Tooltip("Threshold of how many ticks the client is allowed to be in the future before snapping occurs.")]
    public int Future = 30;
    [Space]
    [Header("Offset Smoothing Settings")]
    [Tooltip("The current smoothed offset.")]
    [Readonly]
    public float smoothedOffset;
    public float defaultSmoothing = 0.99f;
    [Tooltip("When our messages arrive on the server, they should arrive this many ticks before the server reaches the same tick number we sent this message in. So: Our message is sent in tick 1000. At that time the server is in tick 990. our message should arrive at the server tick 1000 - targetOffset")]
    public float targetOffset = 1f;
    [Readonly]
    public float adjustedTargetOffset;
    [Space(3f)]
    [Tooltip("If the actual offset is this much higher or lower than the targetOffset, use a different smoothing to get back to targetOffset.")]
    public float softSmoothIntervall = 0.25f;
    [Tooltip("Use this smoothing when in the softSmoothInterval.")]
    public float softSmoothValue = 0.9f;
    [Space(3f)]
    [Tooltip("If the actual offset is this much higher or lower than the targetOffset, use a different smoothing to get back to targetOffset.")]
    public float hardSmoothIntervall = 1f;
    [Tooltip("Use this smoothing when in the hardSmoothInterval.")]
    public float hardSmoothValue = 0.7f;
    [Header("Loss specific settings")]
    public float upscalingPerLoss = 0.5f;
    public float downscalingRate = 0.01f;
    public int MaxLossDetected = 10;
    [Readonly]
    public float lossDetected;
    [Header("Tick Rate Settings")]
    [Tooltip("How much bigger than the targetOffset can the smoothed Offset get before we tick slower")]
    public float tickSlowerThreshold = 0.6f;
    [Range(1f, 10f)]
    public int tickSlowerOffset = 2;
    [Tooltip("How much smaller than the targetOffset can the smoothed Offset get before we tick faster")]
    public float tickFasterThreshold = 0.2f;
    [Range(1f, 10f)]
    public int tickFasterOffset = 5;
    [Space]
    [Readonly]
    public int defaultTickRate;

    public void Init(int defaultTickRate)
    {
      this.defaultTickRate = defaultTickRate;
      this.smoothedOffset = this.targetOffset;
    }

    public int SnapTickIfNecessary(int currentTick, int lastServerTick, int offset, int rttAsTick)
    {
      if (offset < -this.Past || offset > this.Future)
      {
        Log.Warning(string.Format("Snap(A) from {0} to {1}, lastServerTick: {2}, offset: {3}, rttAsTick: {4}", (object) currentTick, (object) (lastServerTick + rttAsTick + this.MinimumJitterBuffer), (object) lastServerTick, (object) offset, (object) rttAsTick));
        currentTick = lastServerTick + rttAsTick + this.MinimumJitterBuffer;
      }
      if (currentTick < lastServerTick - this.Past || currentTick > lastServerTick + this.Future)
      {
        Log.Warning(string.Format("Snap(B) from {0} to {1}, lastServerTick: {2}, offset: {3}, rttAsTick: {4}", (object) currentTick, (object) (lastServerTick + rttAsTick + this.MinimumJitterBuffer), (object) lastServerTick, (object) offset, (object) rttAsTick));
        currentTick = lastServerTick + rttAsTick + this.MinimumJitterBuffer;
      }
      return currentTick;
    }

    public float SyncClock(bool hadLoss, int offset)
    {
      float smoothing = this.defaultSmoothing;
      if (hadLoss && (offset > -this.Past || offset < this.Future))
        this.lossDetected += this.upscalingPerLoss;
      this.lossDetected = Math.Min(this.lossDetected, (float) this.MaxLossDetected);
      this.adjustedTargetOffset = this.targetOffset + this.lossDetected;
      if (this.IsInSoftSmoothIntervall())
        smoothing = this.softSmoothValue;
      if (this.IsInHardSmoothIntervall())
        smoothing = this.hardSmoothValue;
      this.smoothedOffset = this.smoothedOffset.Smooth(offset, smoothing);
      return !this.ShouldTickSlower() ? (!this.ShouldTickFaster() ? 1f / (float) this.defaultTickRate : (float) (1.0 / ((double) this.defaultTickRate + (double) this.tickFasterOffset))) : (float) (1.0 / ((double) this.defaultTickRate - (double) this.tickSlowerOffset));
    }

    [MethodImpl((MethodImplOptions) 256)]
    private bool ShouldTickFaster() => (double) this.smoothedOffset < (double) this.adjustedTargetOffset - (double) this.tickFasterThreshold;

    [MethodImpl((MethodImplOptions) 256)]
    private bool ShouldTickSlower() => (double) this.smoothedOffset > (double) this.adjustedTargetOffset + (double) this.tickSlowerThreshold;

    [MethodImpl((MethodImplOptions) 256)]
    private bool IsInHardSmoothIntervall() => (double) this.smoothedOffset <= (double) this.adjustedTargetOffset - (double) this.hardSmoothIntervall || (double) this.smoothedOffset >= (double) this.adjustedTargetOffset + (double) this.hardSmoothIntervall;

    [MethodImpl((MethodImplOptions) 256)]
    private bool IsInSoftSmoothIntervall() => (double) this.smoothedOffset <= (double) this.adjustedTargetOffset - (double) this.softSmoothIntervall || (double) this.smoothedOffset >= (double) this.adjustedTargetOffset + (double) this.softSmoothIntervall;

    public void DegradeLoss() => this.lossDetected = Mathf.Max(0.0f, this.lossDetected - this.downscalingRate);
  }
}
