// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamItemInstanceID_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Serializable]
  public struct SteamItemInstanceID_t : 
    IEquatable<SteamItemInstanceID_t>,
    IComparable<SteamItemInstanceID_t>
  {
    public static readonly SteamItemInstanceID_t Invalid = new SteamItemInstanceID_t(ulong.MaxValue);
    public ulong m_SteamItemInstanceID;

    public SteamItemInstanceID_t(ulong value) => this.m_SteamItemInstanceID = value;

    public override string ToString() => this.m_SteamItemInstanceID.ToString();

    public override bool Equals(object other) => other is SteamItemInstanceID_t steamItemInstanceIdT && this == steamItemInstanceIdT;

    public override int GetHashCode() => this.m_SteamItemInstanceID.GetHashCode();

    public static bool operator ==(SteamItemInstanceID_t x, SteamItemInstanceID_t y) => (long) x.m_SteamItemInstanceID == (long) y.m_SteamItemInstanceID;

    public static bool operator !=(SteamItemInstanceID_t x, SteamItemInstanceID_t y) => !(x == y);

    public static explicit operator SteamItemInstanceID_t(ulong value) => new SteamItemInstanceID_t(value);

    public static explicit operator ulong(SteamItemInstanceID_t that) => that.m_SteamItemInstanceID;

    public bool Equals(SteamItemInstanceID_t other) => (long) this.m_SteamItemInstanceID == (long) other.m_SteamItemInstanceID;

    public int CompareTo(SteamItemInstanceID_t other) => this.m_SteamItemInstanceID.CompareTo(other.m_SteamItemInstanceID);
  }
}
