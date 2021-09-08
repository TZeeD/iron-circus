﻿// Decompiled with JetBrains decompiler
// Type: Steamworks.HServerQuery
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Serializable]
  public struct HServerQuery : IEquatable<HServerQuery>, IComparable<HServerQuery>
  {
    public static readonly HServerQuery Invalid = new HServerQuery(-1);
    public int m_HServerQuery;

    public HServerQuery(int value) => this.m_HServerQuery = value;

    public override string ToString() => this.m_HServerQuery.ToString();

    public override bool Equals(object other) => other is HServerQuery hserverQuery && this == hserverQuery;

    public override int GetHashCode() => this.m_HServerQuery.GetHashCode();

    public static bool operator ==(HServerQuery x, HServerQuery y) => x.m_HServerQuery == y.m_HServerQuery;

    public static bool operator !=(HServerQuery x, HServerQuery y) => !(x == y);

    public static explicit operator HServerQuery(int value) => new HServerQuery(value);

    public static explicit operator int(HServerQuery that) => that.m_HServerQuery;

    public bool Equals(HServerQuery other) => this.m_HServerQuery == other.m_HServerQuery;

    public int CompareTo(HServerQuery other) => this.m_HServerQuery.CompareTo(other.m_HServerQuery);
  }
}
