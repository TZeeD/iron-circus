// Decompiled with JetBrains decompiler
// Type: Steamworks.EFriendFlags
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Flags]
  public enum EFriendFlags
  {
    k_EFriendFlagNone = 0,
    k_EFriendFlagBlocked = 1,
    k_EFriendFlagFriendshipRequested = 2,
    k_EFriendFlagImmediate = 4,
    k_EFriendFlagClanMember = 8,
    k_EFriendFlagOnGameServer = 16, // 0x00000010
    k_EFriendFlagRequestingFriendship = 128, // 0x00000080
    k_EFriendFlagRequestingInfo = 256, // 0x00000100
    k_EFriendFlagIgnored = 512, // 0x00000200
    k_EFriendFlagIgnoredFriend = 1024, // 0x00000400
    k_EFriendFlagChatMember = 4096, // 0x00001000
    k_EFriendFlagAll = 65535, // 0x0000FFFF
  }
}
