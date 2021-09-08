// Decompiled with JetBrains decompiler
// Type: Steamworks.FriendGameInfo_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct FriendGameInfo_t
  {
    public CGameID m_gameID;
    public uint m_unGameIP;
    public ushort m_usGamePort;
    public ushort m_usQueryPort;
    public CSteamID m_steamIDLobby;
  }
}
