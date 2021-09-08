// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamUnifiedMessages
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

namespace Steamworks
{
  public static class SteamUnifiedMessages
  {
    public static ClientUnifiedMessageHandle SendMethod(
      string pchServiceMethod,
      byte[] pRequestBuffer,
      uint unRequestBufferSize,
      ulong unContext)
    {
      InteropHelp.TestIfAvailableClient();
      using (InteropHelp.UTF8StringHandle pchServiceMethod1 = new InteropHelp.UTF8StringHandle(pchServiceMethod))
        return (ClientUnifiedMessageHandle) NativeMethods.ISteamUnifiedMessages_SendMethod(CSteamAPIContext.GetSteamUnifiedMessages(), pchServiceMethod1, pRequestBuffer, unRequestBufferSize, unContext);
    }

    public static bool GetMethodResponseInfo(
      ClientUnifiedMessageHandle hHandle,
      out uint punResponseSize,
      out EResult peResult)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamUnifiedMessages_GetMethodResponseInfo(CSteamAPIContext.GetSteamUnifiedMessages(), hHandle, out punResponseSize, out peResult);
    }

    public static bool GetMethodResponseData(
      ClientUnifiedMessageHandle hHandle,
      byte[] pResponseBuffer,
      uint unResponseBufferSize,
      bool bAutoRelease)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamUnifiedMessages_GetMethodResponseData(CSteamAPIContext.GetSteamUnifiedMessages(), hHandle, pResponseBuffer, unResponseBufferSize, bAutoRelease);
    }

    public static bool ReleaseMethod(ClientUnifiedMessageHandle hHandle)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamUnifiedMessages_ReleaseMethod(CSteamAPIContext.GetSteamUnifiedMessages(), hHandle);
    }

    public static bool SendNotification(
      string pchServiceNotification,
      byte[] pNotificationBuffer,
      uint unNotificationBufferSize)
    {
      InteropHelp.TestIfAvailableClient();
      using (InteropHelp.UTF8StringHandle pchServiceNotification1 = new InteropHelp.UTF8StringHandle(pchServiceNotification))
        return NativeMethods.ISteamUnifiedMessages_SendNotification(CSteamAPIContext.GetSteamUnifiedMessages(), pchServiceNotification1, pNotificationBuffer, unNotificationBufferSize);
    }
  }
}
