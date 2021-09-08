// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.ScTime
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Utils;
using System;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public static class ScTime
  {
    private static DateTime startTime = DateTime.Now;

    public static double TicksToSeconds(int ticks, float fixedTimeStep) => (double) ticks * (double) fixedTimeStep;

    public static float TicksToMillis(int ticks, float fixedTimeStep) => (float) ((double) ticks * (double) fixedTimeStep * 1000.0);

    public static double GetTimeStamp() => DateTime.Now.GetTotalSeconds() - ScTime.startTime.GetTotalSeconds();
  }
}
