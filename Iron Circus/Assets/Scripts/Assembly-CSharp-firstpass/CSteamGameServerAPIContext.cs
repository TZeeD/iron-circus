// Decompiled with JetBrains decompiler
// Type: Steamworks.CSteamGameServerAPIContext
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  internal static class CSteamGameServerAPIContext
  {
    private static IntPtr m_pSteamClient;
    private static IntPtr m_pSteamGameServer;
    private static IntPtr m_pSteamUtils;
    private static IntPtr m_pSteamNetworking;
    private static IntPtr m_pSteamGameServerStats;
    private static IntPtr m_pSteamHTTP;
    private static IntPtr m_pSteamInventory;
    private static IntPtr m_pSteamUGC;
    private static IntPtr m_pSteamApps;

    internal static void Clear()
    {
      CSteamGameServerAPIContext.m_pSteamClient = IntPtr.Zero;
      CSteamGameServerAPIContext.m_pSteamGameServer = IntPtr.Zero;
      CSteamGameServerAPIContext.m_pSteamUtils = IntPtr.Zero;
      CSteamGameServerAPIContext.m_pSteamNetworking = IntPtr.Zero;
      CSteamGameServerAPIContext.m_pSteamGameServerStats = IntPtr.Zero;
      CSteamGameServerAPIContext.m_pSteamHTTP = IntPtr.Zero;
      CSteamGameServerAPIContext.m_pSteamInventory = IntPtr.Zero;
      CSteamGameServerAPIContext.m_pSteamUGC = IntPtr.Zero;
      CSteamGameServerAPIContext.m_pSteamApps = IntPtr.Zero;
    }

    internal static bool Init()
    {
      HSteamUser hsteamUser = GameServer.GetHSteamUser();
      HSteamPipe hsteamPipe = GameServer.GetHSteamPipe();
      if (hsteamPipe == (HSteamPipe) 0)
        return false;
      using (InteropHelp.UTF8StringHandle ver = new InteropHelp.UTF8StringHandle("SteamClient017"))
        CSteamGameServerAPIContext.m_pSteamClient = NativeMethods.SteamInternal_CreateInterface(ver);
      if (CSteamGameServerAPIContext.m_pSteamClient == IntPtr.Zero)
        return false;
      CSteamGameServerAPIContext.m_pSteamGameServer = SteamGameServerClient.GetISteamGameServer(hsteamUser, hsteamPipe, "SteamGameServer012");
      if (CSteamGameServerAPIContext.m_pSteamGameServer == IntPtr.Zero)
        return false;
      CSteamGameServerAPIContext.m_pSteamUtils = SteamGameServerClient.GetISteamUtils(hsteamPipe, "SteamUtils009");
      if (CSteamGameServerAPIContext.m_pSteamUtils == IntPtr.Zero)
        return false;
      CSteamGameServerAPIContext.m_pSteamNetworking = SteamGameServerClient.GetISteamNetworking(hsteamUser, hsteamPipe, "SteamNetworking005");
      if (CSteamGameServerAPIContext.m_pSteamNetworking == IntPtr.Zero)
        return false;
      CSteamGameServerAPIContext.m_pSteamGameServerStats = SteamGameServerClient.GetISteamGameServerStats(hsteamUser, hsteamPipe, "SteamGameServerStats001");
      if (CSteamGameServerAPIContext.m_pSteamGameServerStats == IntPtr.Zero)
        return false;
      CSteamGameServerAPIContext.m_pSteamHTTP = SteamGameServerClient.GetISteamHTTP(hsteamUser, hsteamPipe, "STEAMHTTP_INTERFACE_VERSION002");
      if (CSteamGameServerAPIContext.m_pSteamHTTP == IntPtr.Zero)
        return false;
      CSteamGameServerAPIContext.m_pSteamInventory = SteamGameServerClient.GetISteamInventory(hsteamUser, hsteamPipe, "STEAMINVENTORY_INTERFACE_V002");
      if (CSteamGameServerAPIContext.m_pSteamInventory == IntPtr.Zero)
        return false;
      CSteamGameServerAPIContext.m_pSteamUGC = SteamGameServerClient.GetISteamUGC(hsteamUser, hsteamPipe, "STEAMUGC_INTERFACE_VERSION010");
      if (CSteamGameServerAPIContext.m_pSteamUGC == IntPtr.Zero)
        return false;
      CSteamGameServerAPIContext.m_pSteamApps = SteamGameServerClient.GetISteamApps(hsteamUser, hsteamPipe, "STEAMAPPS_INTERFACE_VERSION008");
      return !(CSteamGameServerAPIContext.m_pSteamApps == IntPtr.Zero);
    }

    internal static IntPtr GetSteamClient() => CSteamGameServerAPIContext.m_pSteamClient;

    internal static IntPtr GetSteamGameServer() => CSteamGameServerAPIContext.m_pSteamGameServer;

    internal static IntPtr GetSteamUtils() => CSteamGameServerAPIContext.m_pSteamUtils;

    internal static IntPtr GetSteamNetworking() => CSteamGameServerAPIContext.m_pSteamNetworking;

    internal static IntPtr GetSteamGameServerStats() => CSteamGameServerAPIContext.m_pSteamGameServerStats;

    internal static IntPtr GetSteamHTTP() => CSteamGameServerAPIContext.m_pSteamHTTP;

    internal static IntPtr GetSteamInventory() => CSteamGameServerAPIContext.m_pSteamInventory;

    internal static IntPtr GetSteamUGC() => CSteamGameServerAPIContext.m_pSteamUGC;

    internal static IntPtr GetSteamApps() => CSteamGameServerAPIContext.m_pSteamApps;
  }
}
