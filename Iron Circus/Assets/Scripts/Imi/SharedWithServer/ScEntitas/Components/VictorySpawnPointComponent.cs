// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.VictorySpawnPointComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using SharedWithServer.Game;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [global::Game]
  public class VictorySpawnPointComponent : ImiComponent
  {
    public Team team;
    public SpawnPositionType spawnPosition;
    public ulong playerId;
  }
}
