// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Core.ClientTick
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Networking;
using System.Collections.Generic;
using System.Diagnostics;

namespace Imi.SteelCircus.Core
{
  public class ClientTick : ITick
  {
    private readonly ClockSync clockSync;
    private readonly ISystemHelper systemHelper;
    private readonly ClientTick.OnTickDelegate onTick;
    private readonly int maxTickMillis;
    private double currentTime;
    private double accumulator;
    private double dt;
    private int tick;
    private readonly float simDt;
    private readonly Stopwatch simulationExecutionTimer;
    private readonly Stopwatch realDeltaTimeTimer;
    private float simProcessingTime;
    private float realDeltaTime;
    private const int HistorySize = 100;
    private List<double> renderTimeHistory;
    private List<double> renderTimeHistorySorted;
    private bool useDebugLog;
    private double mean;

    public ClientTick(
      ClockSync clockSync,
      ISystemHelper systemHelper,
      ClientTick.OnTickDelegate onTick,
      bool useDebugLog)
    {
      this.clockSync = clockSync;
      this.systemHelper = systemHelper;
      this.onTick = onTick;
      this.simDt = 1f / (float) clockSync.defaultTickRate;
      this.dt = (double) this.simDt;
      this.simulationExecutionTimer = new Stopwatch();
      this.realDeltaTimeTimer = new Stopwatch();
      this.renderTimeHistory = new List<double>(100);
      this.renderTimeHistorySorted = new List<double>(100);
      this.useDebugLog = useDebugLog;
    }

    public int Tick()
    {
      double timeSinceStartup = (double) this.systemHelper.GetTimeSinceStartup();
      double num = timeSinceStartup - this.currentTime;
      if (num > 0.25)
        num = 0.25;
      this.currentTime = timeSinceStartup;
      this.accumulator += num;
      while (this.accumulator >= this.dt)
      {
        this.TickInternal();
        this.accumulator -= this.dt;
        ++this.tick;
      }
      return this.tick;
    }

    public float GetSimulationDeltaTime() => this.simProcessingTime;

    public float GetSimulationFixedDeltaTime() => this.simDt;

    public float GetDeltaTime() => (float) this.dt;

    public float GetRealDeltaTime() => this.realDeltaTime;

    public int GetTick() => this.tick;

    public void OnClockSync(int serverTick, int offset, int rttt, bool hadLoss)
    {
      this.tick = this.clockSync.SnapTickIfNecessary(this.tick, serverTick, offset, rttt);
      this.dt = (double) this.clockSync.SyncClock(hadLoss, offset);
    }

    private void TickInternal()
    {
      this.realDeltaTime = (float) this.realDeltaTimeTimer.Elapsed.TotalMilliseconds;
      this.realDeltaTimeTimer.Restart();
      if (this.useDebugLog)
      {
        this.renderTimeHistory.Add((double) this.realDeltaTime);
        if (this.renderTimeHistory.Count > 100)
          this.renderTimeHistory.RemoveAt(0);
        this.mean = this.GetMean(this.renderTimeHistory);
      }
      this.simulationExecutionTimer.Restart();
      ClientTick.OnTickDelegate onTick = this.onTick;
      if (onTick != null)
        onTick(this.tick, (float) this.currentTime);
      this.simProcessingTime = (float) this.simulationExecutionTimer.Elapsed.TotalMilliseconds;
      this.clockSync.DegradeLoss();
      if (!this.useDebugLog || this.tick % 600 != 0)
        return;
      Imi.Diagnostics.Log.Debug(string.Format("Tick [{0}], Time Data (Sim/Real/Mean) [ {1:00.00} , {2:00.00} , {3:00.00}]", (object) this.tick, (object) this.simProcessingTime, (object) this.realDeltaTime, (object) this.mean));
    }

    private double GetMean(List<double> values)
    {
      double num1 = 0.0;
      foreach (double num2 in values)
        num1 += num2;
      return num1 / (double) values.Count;
    }

    private double GetMedian(List<double> values)
    {
      this.renderTimeHistorySorted = new List<double>((IEnumerable<double>) values);
      this.renderTimeHistorySorted.Sort();
      if (this.renderTimeHistorySorted.Count % 2 != 0)
        return this.renderTimeHistorySorted[this.renderTimeHistorySorted.Count / 2];
      int index = this.renderTimeHistorySorted.Count / 2;
      return (this.renderTimeHistorySorted[index - 1] + this.renderTimeHistorySorted[index]) / 2.0;
    }

    public int ForceTickIncrement() => ++this.tick;

    public delegate void OnTickDelegate(int tick, float timeSinceStart);
  }
}
