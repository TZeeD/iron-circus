// Decompiled with JetBrains decompiler
// Type: Steamworks.EAuthSessionResponse
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

namespace Steamworks
{
  public enum EAuthSessionResponse
  {
    k_EAuthSessionResponseOK,
    k_EAuthSessionResponseUserNotConnectedToSteam,
    k_EAuthSessionResponseNoLicenseOrExpired,
    k_EAuthSessionResponseVACBanned,
    k_EAuthSessionResponseLoggedInElseWhere,
    k_EAuthSessionResponseVACCheckTimedOut,
    k_EAuthSessionResponseAuthTicketCanceled,
    k_EAuthSessionResponseAuthTicketInvalidAlreadyUsed,
    k_EAuthSessionResponseAuthTicketInvalid,
    k_EAuthSessionResponsePublisherIssuedBan,
  }
}
