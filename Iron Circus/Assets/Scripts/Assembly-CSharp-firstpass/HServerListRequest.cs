﻿// Decompiled with JetBrains decompiler
// Type: Steamworks.HServerListRequest
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Serializable]
  public struct HServerListRequest : IEquatable<HServerListRequest>
  {
    public static readonly HServerListRequest Invalid = new HServerListRequest(IntPtr.Zero);
    public IntPtr m_HServerListRequest;

    public HServerListRequest(IntPtr value) => this.m_HServerListRequest = value;

    public override string ToString() => this.m_HServerListRequest.ToString();

    public override bool Equals(object other) => other is HServerListRequest hserverListRequest && this == hserverListRequest;

    public override int GetHashCode() => this.m_HServerListRequest.GetHashCode();

    public static bool operator ==(HServerListRequest x, HServerListRequest y) => x.m_HServerListRequest == y.m_HServerListRequest;

    public static bool operator !=(HServerListRequest x, HServerListRequest y) => !(x == y);

    public static explicit operator HServerListRequest(IntPtr value) => new HServerListRequest(value);

    public static explicit operator IntPtr(HServerListRequest that) => that.m_HServerListRequest;

    public bool Equals(HServerListRequest other) => this.m_HServerListRequest == other.m_HServerListRequest;
  }
}
