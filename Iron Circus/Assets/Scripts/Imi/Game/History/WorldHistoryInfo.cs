﻿// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.WorldHistoryInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.Game.History
{
  public struct WorldHistoryInfo
  {
    public int generationCount;
    public int firstWrittenIn;
    public int lastWrittenIn;
    public bool fromFuture;
    public bool isLocked;
    public int copyFromReferenceTick;

    public void IncrementGeneration() => ++this.generationCount;
  }
}
