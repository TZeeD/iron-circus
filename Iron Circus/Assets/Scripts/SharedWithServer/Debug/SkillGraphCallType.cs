﻿// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Debug.SkillGraphCallType
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace SharedWithServer.Debug
{
  public enum SkillGraphCallType
  {
    TickEntity,
    TickGraph,
    TickState,
    TickSimulation,
    EnterState,
    ExitState,
    SetFromBitmap,
    DoAction,
    DoSyncedAction,
    FirePlug,
    AbortPlug,
    Event,
    ReconcileRemote,
    Rollback,
    Repredict,
    Pop,
  }
}
