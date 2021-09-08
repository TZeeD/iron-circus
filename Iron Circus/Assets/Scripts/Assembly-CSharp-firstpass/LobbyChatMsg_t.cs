// Decompiled with JetBrains decompiler
// Type: Steamworks.LobbyChatMsg_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [CallbackIdentity(507)]
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct LobbyChatMsg_t
  {
    public const int k_iCallback = 507;
    public ulong m_ulSteamIDLobby;
    public ulong m_ulSteamIDUser;
    public byte m_eChatEntryType;
    public uint m_iChatID;
  }
}
