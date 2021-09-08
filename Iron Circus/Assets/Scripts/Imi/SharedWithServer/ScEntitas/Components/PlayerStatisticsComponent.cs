// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.PlayerStatisticsComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public class PlayerStatisticsComponent : ImiComponent
  {
    public ulong playerId;
    public List<ulong> koedPlayers;
    public List<ulong> koedByPlayer;
    public int damageDone;
    public int healingDone;
    public int damageReceived;
    public int healingReceived;
    public int successfulPasses;
    public int assists;
    public int shotsOnGoal;
    public int trickShots;
    public int successfulTackles;
    public int unsuccessfulTackles;
  }
}
