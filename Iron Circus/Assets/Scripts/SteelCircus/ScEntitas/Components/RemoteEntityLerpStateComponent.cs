// Decompiled with JetBrains decompiler
// Type: SteelCircus.ScEntitas.Components.RemoteEntityLerpStateComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.CodeGeneration.Attributes;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.ScEntitas.Systems;
using Imi.SteelCircus.Utils.Smoothing;
using System.Collections.Generic;

namespace SteelCircus.ScEntitas.Components
{
  [Game]
  [Unique]
  public sealed class RemoteEntityLerpStateComponent : ImiComponent
  {
    public List<RemoteEntityLerpSystem.RemoteStateHistoryEntry> historyBuffer;
    public List<RemoteEntityLerpSystem.RemoteStateLerpPair> activeLerpPairs;
    public float currentLerpTimestamp;
    public FilteredFloat smoothedRTT;
  }
}
