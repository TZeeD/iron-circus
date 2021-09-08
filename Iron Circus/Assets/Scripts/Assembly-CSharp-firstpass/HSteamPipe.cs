// Decompiled with JetBrains decompiler
// Type: Steamworks.HSteamPipe
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Serializable]
  public struct HSteamPipe : IEquatable<HSteamPipe>, IComparable<HSteamPipe>
  {
    public int m_HSteamPipe;

    public HSteamPipe(int value) => this.m_HSteamPipe = value;

    public override string ToString() => this.m_HSteamPipe.ToString();

    public override bool Equals(object other) => other is HSteamPipe hsteamPipe && this == hsteamPipe;

    public override int GetHashCode() => this.m_HSteamPipe.GetHashCode();

    public static bool operator ==(HSteamPipe x, HSteamPipe y) => x.m_HSteamPipe == y.m_HSteamPipe;

    public static bool operator !=(HSteamPipe x, HSteamPipe y) => !(x == y);

    public static explicit operator HSteamPipe(int value) => new HSteamPipe(value);

    public static explicit operator int(HSteamPipe that) => that.m_HSteamPipe;

    public bool Equals(HSteamPipe other) => this.m_HSteamPipe == other.m_HSteamPipe;

    public int CompareTo(HSteamPipe other) => this.m_HSteamPipe.CompareTo(other.m_HSteamPipe);
  }
}
