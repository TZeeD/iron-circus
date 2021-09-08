// Decompiled with JetBrains decompiler
// Type: Steamworks.EChatRoomEnterResponse
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

namespace Steamworks
{
  public enum EChatRoomEnterResponse
  {
    k_EChatRoomEnterResponseSuccess = 1,
    k_EChatRoomEnterResponseDoesntExist = 2,
    k_EChatRoomEnterResponseNotAllowed = 3,
    k_EChatRoomEnterResponseFull = 4,
    k_EChatRoomEnterResponseError = 5,
    k_EChatRoomEnterResponseBanned = 6,
    k_EChatRoomEnterResponseLimited = 7,
    k_EChatRoomEnterResponseClanDisabled = 8,
    k_EChatRoomEnterResponseCommunityBan = 9,
    k_EChatRoomEnterResponseMemberBlockedYou = 10, // 0x0000000A
    k_EChatRoomEnterResponseYouBlockedMember = 11, // 0x0000000B
    k_EChatRoomEnterResponseRatelimitExceeded = 15, // 0x0000000F
  }
}
