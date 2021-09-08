// Decompiled with JetBrains decompiler
// Type: Steamworks.ClientUnifiedMessageHandle
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Serializable]
  public struct ClientUnifiedMessageHandle : 
    IEquatable<ClientUnifiedMessageHandle>,
    IComparable<ClientUnifiedMessageHandle>
  {
    public static readonly ClientUnifiedMessageHandle Invalid = new ClientUnifiedMessageHandle(0UL);
    public ulong m_ClientUnifiedMessageHandle;

    public ClientUnifiedMessageHandle(ulong value) => this.m_ClientUnifiedMessageHandle = value;

    public override string ToString() => this.m_ClientUnifiedMessageHandle.ToString();

    public override bool Equals(object other) => other is ClientUnifiedMessageHandle unifiedMessageHandle && this == unifiedMessageHandle;

    public override int GetHashCode() => this.m_ClientUnifiedMessageHandle.GetHashCode();

    public static bool operator ==(ClientUnifiedMessageHandle x, ClientUnifiedMessageHandle y) => (long) x.m_ClientUnifiedMessageHandle == (long) y.m_ClientUnifiedMessageHandle;

    public static bool operator !=(ClientUnifiedMessageHandle x, ClientUnifiedMessageHandle y) => !(x == y);

    public static explicit operator ClientUnifiedMessageHandle(ulong value) => new ClientUnifiedMessageHandle(value);

    public static explicit operator ulong(ClientUnifiedMessageHandle that) => that.m_ClientUnifiedMessageHandle;

    public bool Equals(ClientUnifiedMessageHandle other) => (long) this.m_ClientUnifiedMessageHandle == (long) other.m_ClientUnifiedMessageHandle;

    public int CompareTo(ClientUnifiedMessageHandle other) => this.m_ClientUnifiedMessageHandle.CompareTo(other.m_ClientUnifiedMessageHandle);
  }
}
