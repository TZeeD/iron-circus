// Decompiled with JetBrains decompiler
// Type: Imi.Game.PreMatchPlayerData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using System;

namespace Imi.Game
{
  public struct PreMatchPlayerData : IEquatable<PreMatchPlayerData>
  {
    public static PreMatchPlayerData Invalid = new PreMatchPlayerData(Team.None, ChampionType.Invalid, false);
    public readonly Team team;
    public readonly ChampionType type;
    public readonly bool isReady;

    public PreMatchPlayerData(Team team, ChampionType type, bool isReady)
    {
      this.team = team;
      this.type = type;
      this.isReady = isReady;
    }

    public static bool operator ==(PreMatchPlayerData a, PreMatchPlayerData b) => a.Equals(b);

    public static bool operator !=(PreMatchPlayerData a, PreMatchPlayerData b) => !a.Equals(b);

    public bool Equals(PreMatchPlayerData other) => this.team == other.team && this.type == other.type && this.isReady == other.isReady;

    public override bool Equals(object obj) => obj != null && obj is PreMatchPlayerData other && this.Equals(other);

    public override int GetHashCode() => (int) ((ChampionType) ((int) this.team * 397) ^ this.type) * 397 ^ this.isReady.GetHashCode();
  }
}
