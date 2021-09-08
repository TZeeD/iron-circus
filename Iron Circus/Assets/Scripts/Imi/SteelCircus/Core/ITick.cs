﻿// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Core.ITick
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SteelCircus.Core
{
  public interface ITick
  {
    int Tick();

    float GetSimulationDeltaTime();

    float GetSimulationFixedDeltaTime();

    float GetDeltaTime();

    float GetRealDeltaTime();

    void OnClockSync(int serverTick, int offset, int rttt, bool hadLoss);
  }
}
