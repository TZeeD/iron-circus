// Decompiled with JetBrains decompiler
// Type: Steamworks.LobbyKicked_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [CallbackIdentity(512)]
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct LobbyKicked_t
  {
    public const int k_iCallback = 512;
    public ulong m_ulSteamIDLobby;
    public ulong m_ulSteamIDAdmin;
    public byte m_bKickedDueToDisconnect;
  }
}
