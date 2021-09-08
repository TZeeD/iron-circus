// Decompiled with JetBrains decompiler
// Type: Imi.ScGameStats.TrackingEvent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.ScEvents;
using System;

namespace Imi.ScGameStats
{
  public class TrackingEvent
  {
    public ulong playerId;
    public Statistics statistics;
    public float value;
    public StatisticsMode calculationMode;

    public TrackingEvent(ulong playerId, Statistics statistics, float value = 1f, StatisticsMode mode = StatisticsMode.Add)
    {
      this.playerId = playerId;
      this.statistics = statistics;
      this.value = Math.Abs(value);
      this.calculationMode = mode;
    }
  }
}
