// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamLeaderboard_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Serializable]
  public struct SteamLeaderboard_t : IEquatable<SteamLeaderboard_t>, IComparable<SteamLeaderboard_t>
  {
    public ulong m_SteamLeaderboard;

    public SteamLeaderboard_t(ulong value) => this.m_SteamLeaderboard = value;

    public override string ToString() => this.m_SteamLeaderboard.ToString();

    public override bool Equals(object other) => other is SteamLeaderboard_t steamLeaderboardT && this == steamLeaderboardT;

    public override int GetHashCode() => this.m_SteamLeaderboard.GetHashCode();

    public static bool operator ==(SteamLeaderboard_t x, SteamLeaderboard_t y) => (long) x.m_SteamLeaderboard == (long) y.m_SteamLeaderboard;

    public static bool operator !=(SteamLeaderboard_t x, SteamLeaderboard_t y) => !(x == y);

    public static explicit operator SteamLeaderboard_t(ulong value) => new SteamLeaderboard_t(value);

    public static explicit operator ulong(SteamLeaderboard_t that) => that.m_SteamLeaderboard;

    public bool Equals(SteamLeaderboard_t other) => (long) this.m_SteamLeaderboard == (long) other.m_SteamLeaderboard;

    public int CompareTo(SteamLeaderboard_t other) => this.m_SteamLeaderboard.CompareTo(other.m_SteamLeaderboard);
  }
}
