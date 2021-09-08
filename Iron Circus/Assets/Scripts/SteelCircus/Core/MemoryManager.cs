// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.MemoryManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Scripting;

namespace SteelCircus.Core
{
  public class MemoryManager : MonoBehaviour
  {
    private const long noGcMemoryLimit = 1073741824;
    private bool alreadyExpandedHeap;
    private static bool gcBrokeDuringSession;
    private long prevFrameUsedMemory;
    private int lastManualGCTriggerFrame;
    private long runningTotalUsedMemory;
    private float lastReportTime;
    private float reportIntervalInSeconds = 10f;
    private bool gcDisabled;

    public bool GcDisabled => this.gcDisabled;

    public void Awake() => UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object) this);

    public void Start()
    {
      this.ResetTracker();
      Events.Global.OnEventMatchStateChanged += (Events.EventMatchStateChanged) ((state, duration, time) =>
      {
        switch (state)
        {
          case MatchState.Intro:
            this.ResetTracker();
            break;
          case MatchState.GetReady:
          case MatchState.StartPoint:
            Log.Debug(string.Format("Memory tracking: Match state {0}. Running GC.Collect()", (object) state));
            this.SetGCDisabled(false);
            this.TriggerFullGC(false);
            this.SetGCDisabled(true);
            break;
          case MatchState.Goal:
            this.SetGCDisabled(false);
            break;
          case MatchState.MatchOver:
            Log.Debug(string.Format("Memory tracking: Match is over. Total heap memory used: {0}MB.", (object) (float) ((double) this.runningTotalUsedMemory / 1048576.0)));
            this.SetGCDisabled(false);
            break;
        }
      });
    }

    private void OnGCBroke(string msg)
    {
      if (MemoryManager.gcBrokeDuringSession)
        return;
      MemoryManager.gcBrokeDuringSession = true;
      ImiServices.Instance.Analytics.OnGCBroke(msg);
    }

    private void SetGCDisabled(bool disabled) => this.SetGCDisabledPlayer(disabled);

    private void SetGCDisabledPlayer(bool disabled)
    {
      if (!disabled && GarbageCollector.GCMode != GarbageCollector.Mode.Enabled)
      {
        GarbageCollector.GCMode = GarbageCollector.Mode.Enabled;
        Log.Debug("GC enabled");
      }
      else if (disabled && GarbageCollector.GCMode != GarbageCollector.Mode.Disabled)
      {
        GarbageCollector.GCMode = GarbageCollector.Mode.Disabled;
        Log.Debug("GC disabled");
      }
      this.gcDisabled = disabled;
    }

    private void SetGCDisabledEditor(bool disabled)
    {
      if (!disabled)
        Log.Debug("GC enabled (won't work in editor)");
      else
        Log.Debug("GC disabled (won't work in editor)");
      this.gcDisabled = disabled;
    }

    private void Update() => this.UpdateTracker();

    private void TriggerFullGC(bool twice)
    {
      Log.Debug("Full GC collect triggered.");
      GC.Collect(GC.MaxGeneration, GCCollectionMode.Forced, true);
      if (twice)
      {
        GC.WaitForPendingFinalizers();
        GC.Collect(GC.MaxGeneration, GCCollectionMode.Forced, true);
      }
      this.lastManualGCTriggerFrame = Time.frameCount;
    }

    private void UpdateTracker()
    {
      long totalMemory = GC.GetTotalMemory(false);
      if (totalMemory > this.prevFrameUsedMemory)
        this.runningTotalUsedMemory += totalMemory - this.prevFrameUsedMemory;
      else if (totalMemory < this.prevFrameUsedMemory)
      {
        Log.Warning(string.Format("Heap memory use went down ({0}->{1}MB). Looks like we garbage collected. Last frame delta time: {2}s.", (object) (float) ((double) this.prevFrameUsedMemory / 1048576.0), (object) (float) ((double) totalMemory / 1048576.0), (object) Time.deltaTime));
        if (this.GcDisabled && Time.frameCount > this.lastManualGCTriggerFrame + 1)
        {
          Log.Warning("We garbage collected even though GC is disabled (This is okay in Editor)");
          this.OnGCBroke("CollectDuringGCDisabled");
        }
      }
      if ((double) Time.unscaledTime > (double) this.lastReportTime + (double) this.reportIntervalInSeconds)
      {
        this.lastReportTime = Time.unscaledTime;
        Log.Debug(string.Format("Memory tracking: Total heap memory allocated since last reset: {0}MB. Currently used: {1}MB.", (object) (float) ((double) this.runningTotalUsedMemory / 1048576.0), (object) (float) ((double) totalMemory / 1048576.0)));
      }
      if (totalMemory > 1073741824L && this.gcDisabled)
      {
        this.SetGCDisabled(false);
        Log.Warning(string.Format("Current memory use is over limit, reenabling GC. (This is okay in Editor) Used: {0}, limit: {1}", (object) totalMemory, (object) 1073741824L));
        Events.Global.FireEventMemoryOverLimit(totalMemory, 1073741824L);
        this.OnGCBroke("MemoryLimitExceeded");
      }
      this.prevFrameUsedMemory = totalMemory;
    }

    private IEnumerator ExpandHeap()
    {
      MemoryManager memoryManager = this;
      yield return (object) null;
      if (!memoryManager.alreadyExpandedHeap)
      {
        memoryManager.alreadyExpandedHeap = true;
        yield return (object) null;
        object[] objArray = new object[1048576];
        for (int index = 0; index < 1048576; ++index)
          objArray[index] = (object) new byte[1024];
        yield return (object) null;
        memoryManager.TriggerFullGC(true);
        memoryManager.StartCoroutine(memoryManager.DelayedGC());
      }
    }

    private IEnumerator DelayedGC()
    {
      yield return (object) new WaitForSecondsRealtime(1f);
      this.TriggerFullGC(true);
      if (GC.GetTotalMemory(false) > 1073741824L)
        Log.Error("Could not collect initial heap expansion.");
    }

    private void ResetTracker()
    {
      long totalMemory = GC.GetTotalMemory(false);
      this.lastReportTime = Time.unscaledTime;
      Log.Debug(string.Format("Memory tracking: Resetting. Current heap memory use: {0}MB.", (object) (float) ((double) totalMemory / 1048576.0)));
      this.prevFrameUsedMemory = 0L;
      this.runningTotalUsedMemory = 0L;
    }
  }
}
