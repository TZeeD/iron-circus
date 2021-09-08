// Decompiled with JetBrains decompiler
// Type: Imi.ScEntitas.Components.MetaChampionsUnlockedComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using System.Collections.Generic;

namespace Imi.ScEntitas.Components
{
  [Meta]
  public class MetaChampionsUnlockedComponent : ImiComponent
  {
    public Dictionary<ChampionType, bool> championLockStateDict;
    public Dictionary<ChampionType, bool> championRotationStateDict;
  }
}
