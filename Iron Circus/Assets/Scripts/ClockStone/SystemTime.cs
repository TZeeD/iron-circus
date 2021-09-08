// Decompiled with JetBrains decompiler
// Type: ClockStone.SystemTime
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace ClockStone
{
  public static class SystemTime
  {
    private static double _timeAtLaunch = SystemTime.time;

    public static double time => (double) DateTime.Now.Ticks * 1E-07;

    public static double timeSinceLaunch => SystemTime.time - SystemTime._timeAtLaunch;
  }
}
