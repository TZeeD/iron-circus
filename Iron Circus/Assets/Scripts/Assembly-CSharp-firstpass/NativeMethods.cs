﻿// Decompiled with JetBrains decompiler
// Type: Steamworks.NativeMethods
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using System.Runtime.InteropServices;
using System.Security;

namespace Steamworks
{
  [SuppressUnmanagedCodeSecurity]
  internal static class NativeMethods
  {
    internal const string NativeLibraryName = "steam_api64";
    internal const string NativeLibrary_SDKEncryptedAppTicket = "sdkencryptedappticket64";

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamAPI_Init();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_Shutdown();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamAPI_RestartAppIfNecessary(AppId_t unOwnAppID);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_ReleaseCurrentThreadMemory();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_WriteMiniDump(
      uint uStructuredExceptionCode,
      IntPtr pvExceptionInfo,
      uint uBuildID);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_SetMiniDumpComment(InteropHelp.UTF8StringHandle pchMsg);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_RunCallbacks();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_RegisterCallback(IntPtr pCallback, int iCallback);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_UnregisterCallback(IntPtr pCallback);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_RegisterCallResult(IntPtr pCallback, ulong hAPICall);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_UnregisterCallResult(IntPtr pCallback, ulong hAPICall);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamAPI_IsSteamRunning();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void Steam_RunCallbacks(HSteamPipe hSteamPipe, [MarshalAs(UnmanagedType.I1)] bool bGameServerCallbacks);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void Steam_RegisterInterfaceFuncs(IntPtr hModule);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern int Steam_GetHSteamUserCurrent();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern int SteamAPI_GetSteamInstallPath();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern int SteamAPI_GetHSteamPipe();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_SetTryCatchCallbacks([MarshalAs(UnmanagedType.I1)] bool bTryCatchCallbacks);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern int SteamAPI_GetHSteamUser();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr SteamInternal_ContextInit(IntPtr pContextInitData);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr SteamInternal_CreateInterface(InteropHelp.UTF8StringHandle ver);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_UseBreakpadCrashHandler(
      InteropHelp.UTF8StringHandle pchVersion,
      InteropHelp.UTF8StringHandle pchDate,
      InteropHelp.UTF8StringHandle pchTime,
      [MarshalAs(UnmanagedType.I1)] bool bFullMemoryDumps,
      IntPtr pvContext,
      IntPtr m_pfnPreMinidumpCallback);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamAPI_SetBreakpadAppID(uint unAppID);

    [DllImport("steam_api64", EntryPoint = "SteamGameServer_InitSafe", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamGameServer_Init(
      uint unIP,
      ushort usSteamPort,
      ushort usGamePort,
      ushort usQueryPort,
      EServerMode eServerMode,
      InteropHelp.UTF8StringHandle pchVersionString);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamGameServer_Shutdown();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamGameServer_RunCallbacks();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamGameServer_ReleaseCurrentThreadMemory();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamGameServer_BSecure();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong SteamGameServer_GetSteamID();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern int SteamGameServer_GetHSteamPipe();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern int SteamGameServer_GetHSteamUser();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamInternal_GameServer_Init(
      uint unIP,
      ushort usPort,
      ushort usGamePort,
      ushort usQueryPort,
      EServerMode eServerMode,
      InteropHelp.UTF8StringHandle pchVersionString);

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr SteamClient();

    [DllImport("steam_api64", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr SteamGameServerClient();

    [DllImport("sdkencryptedappticket64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamEncryptedAppTicket_BDecryptTicket(
      byte[] rgubTicketEncrypted,
      uint cubTicketEncrypted,
      byte[] rgubTicketDecrypted,
      ref uint pcubTicketDecrypted,
      [MarshalAs(UnmanagedType.LPArray, SizeConst = 32)] byte[] rgubKey,
      int cubKey);

    [DllImport("sdkencryptedappticket64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamEncryptedAppTicket_BIsTicketForApp(
      byte[] rgubTicketDecrypted,
      uint cubTicketDecrypted,
      AppId_t nAppID);

    [DllImport("sdkencryptedappticket64", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint SteamEncryptedAppTicket_GetTicketIssueTime(
      byte[] rgubTicketDecrypted,
      uint cubTicketDecrypted);

    [DllImport("sdkencryptedappticket64", CallingConvention = CallingConvention.Cdecl)]
    public static extern void SteamEncryptedAppTicket_GetTicketSteamID(
      byte[] rgubTicketDecrypted,
      uint cubTicketDecrypted,
      out CSteamID psteamID);

    [DllImport("sdkencryptedappticket64", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint SteamEncryptedAppTicket_GetTicketAppID(
      byte[] rgubTicketDecrypted,
      uint cubTicketDecrypted);

    [DllImport("sdkencryptedappticket64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamEncryptedAppTicket_BUserOwnsAppInTicket(
      byte[] rgubTicketDecrypted,
      uint cubTicketDecrypted,
      AppId_t nAppID);

    [DllImport("sdkencryptedappticket64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool SteamEncryptedAppTicket_BUserIsVacBanned(
      byte[] rgubTicketDecrypted,
      uint cubTicketDecrypted);

    [DllImport("sdkencryptedappticket64", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr SteamEncryptedAppTicket_GetUserVariableData(
      byte[] rgubTicketDecrypted,
      uint cubTicketDecrypted,
      out uint pcubUserData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamAppList_GetNumInstalledApps", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamAppList_GetNumInstalledApps(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamAppList_GetInstalledApps", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamAppList_GetInstalledApps(
      IntPtr instancePtr,
      [In, Out] AppId_t[] pvecAppID,
      uint unMaxAppIDs);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamAppList_GetAppName", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamAppList_GetAppName(
      IntPtr instancePtr,
      AppId_t nAppID,
      IntPtr pchName,
      int cchNameMax);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamAppList_GetAppInstallDir", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamAppList_GetAppInstallDir(
      IntPtr instancePtr,
      AppId_t nAppID,
      IntPtr pchDirectory,
      int cchNameMax);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamAppList_GetAppBuildId", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamAppList_GetAppBuildId(IntPtr instancePtr, AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BIsSubscribed", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BIsSubscribed(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BIsLowViolence", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BIsLowViolence(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BIsCybercafe", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BIsCybercafe(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BIsVACBanned", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BIsVACBanned(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetCurrentGameLanguage", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamApps_GetCurrentGameLanguage(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetAvailableGameLanguages", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamApps_GetAvailableGameLanguages(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BIsSubscribedApp", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BIsSubscribedApp(IntPtr instancePtr, AppId_t appID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BIsDlcInstalled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BIsDlcInstalled(IntPtr instancePtr, AppId_t appID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetEarliestPurchaseUnixTime", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamApps_GetEarliestPurchaseUnixTime(
      IntPtr instancePtr,
      AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BIsSubscribedFromFreeWeekend", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BIsSubscribedFromFreeWeekend(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetDLCCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamApps_GetDLCCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BGetDLCDataByIndex", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BGetDLCDataByIndex(
      IntPtr instancePtr,
      int iDLC,
      out AppId_t pAppID,
      out bool pbAvailable,
      IntPtr pchName,
      int cchNameBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_InstallDLC", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamApps_InstallDLC(IntPtr instancePtr, AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_UninstallDLC", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamApps_UninstallDLC(IntPtr instancePtr, AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_RequestAppProofOfPurchaseKey", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamApps_RequestAppProofOfPurchaseKey(
      IntPtr instancePtr,
      AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetCurrentBetaName", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_GetCurrentBetaName(
      IntPtr instancePtr,
      IntPtr pchName,
      int cchNameBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_MarkContentCorrupt", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_MarkContentCorrupt(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bMissingFilesOnly);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetInstalledDepots", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamApps_GetInstalledDepots(
      IntPtr instancePtr,
      AppId_t appID,
      [In, Out] DepotId_t[] pvecDepots,
      uint cMaxDepots);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetAppInstallDir", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamApps_GetAppInstallDir(
      IntPtr instancePtr,
      AppId_t appID,
      IntPtr pchFolder,
      uint cchFolderBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_BIsAppInstalled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_BIsAppInstalled(IntPtr instancePtr, AppId_t appID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetAppOwner", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamApps_GetAppOwner(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetLaunchQueryParam", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamApps_GetLaunchQueryParam(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchKey);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetDlcDownloadProgress", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamApps_GetDlcDownloadProgress(
      IntPtr instancePtr,
      AppId_t nAppID,
      out ulong punBytesDownloaded,
      out ulong punBytesTotal);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetAppBuildId", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamApps_GetAppBuildId(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_RequestAllProofOfPurchaseKeys", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamApps_RequestAllProofOfPurchaseKeys(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamApps_GetFileDetails", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamApps_GetFileDetails(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszFileName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_CreateSteamPipe", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamClient_CreateSteamPipe(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_BReleaseSteamPipe", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamClient_BReleaseSteamPipe(
      IntPtr instancePtr,
      HSteamPipe hSteamPipe);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_ConnectToGlobalUser", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamClient_ConnectToGlobalUser(
      IntPtr instancePtr,
      HSteamPipe hSteamPipe);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_CreateLocalUser", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamClient_CreateLocalUser(
      IntPtr instancePtr,
      out HSteamPipe phSteamPipe,
      EAccountType eAccountType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_ReleaseUser", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamClient_ReleaseUser(
      IntPtr instancePtr,
      HSteamPipe hSteamPipe,
      HSteamUser hUser);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamUser", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamUser(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamGameServer", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamGameServer(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_SetLocalIPBinding", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamClient_SetLocalIPBinding(
      IntPtr instancePtr,
      uint unIP,
      ushort usPort);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamFriends", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamFriends(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamUtils", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamUtils(
      IntPtr instancePtr,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamMatchmaking", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamMatchmaking(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamMatchmakingServers", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamMatchmakingServers(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamGenericInterface", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamGenericInterface(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamUserStats", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamUserStats(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamGameServerStats", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamGameServerStats(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamApps", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamApps(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamNetworking", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamNetworking(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamRemoteStorage", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamRemoteStorage(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamScreenshots", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamScreenshots(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetIPCCallCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamClient_GetIPCCallCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_SetWarningMessageHook", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamClient_SetWarningMessageHook(
      IntPtr instancePtr,
      SteamAPIWarningMessageHook_t pFunction);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_BShutdownIfAllPipesClosed", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamClient_BShutdownIfAllPipesClosed(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamHTTP", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamHTTP(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamUnifiedMessages", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamUnifiedMessages(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamController", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamController(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamUGC", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamUGC(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamAppList", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamAppList(
      IntPtr instancePtr,
      HSteamUser hSteamUser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamMusic", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamMusic(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamMusicRemote", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamMusicRemote(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamHTMLSurface", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamHTMLSurface(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamInventory", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamInventory(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamVideo", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamVideo(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamClient_GetISteamParentalSettings", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamClient_GetISteamParentalSettings(
      IntPtr instancePtr,
      HSteamUser hSteamuser,
      HSteamPipe hSteamPipe,
      InteropHelp.UTF8StringHandle pchVersion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_Init", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamController_Init(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_Shutdown", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamController_Shutdown(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_RunFrame", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamController_RunFrame(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetConnectedControllers", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamController_GetConnectedControllers(
      IntPtr instancePtr,
      [In, Out] ControllerHandle_t[] handlesOut);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_ShowBindingPanel", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamController_ShowBindingPanel(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetActionSetHandle", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamController_GetActionSetHandle(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszActionSetName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_ActivateActionSet", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamController_ActivateActionSet(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ControllerActionSetHandle_t actionSetHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetCurrentActionSet", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamController_GetCurrentActionSet(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetDigitalActionHandle", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamController_GetDigitalActionHandle(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszActionName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetDigitalActionData", CallingConvention = CallingConvention.Cdecl)]
    public static extern ControllerDigitalActionData_t ISteamController_GetDigitalActionData(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ControllerDigitalActionHandle_t digitalActionHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetDigitalActionOrigins", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamController_GetDigitalActionOrigins(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ControllerActionSetHandle_t actionSetHandle,
      ControllerDigitalActionHandle_t digitalActionHandle,
      [In, Out] EControllerActionOrigin[] originsOut);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetAnalogActionHandle", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamController_GetAnalogActionHandle(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszActionName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetAnalogActionData", CallingConvention = CallingConvention.Cdecl)]
    public static extern ControllerAnalogActionData_t ISteamController_GetAnalogActionData(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ControllerAnalogActionHandle_t analogActionHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetAnalogActionOrigins", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamController_GetAnalogActionOrigins(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ControllerActionSetHandle_t actionSetHandle,
      ControllerAnalogActionHandle_t analogActionHandle,
      [In, Out] EControllerActionOrigin[] originsOut);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_StopAnalogActionMomentum", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamController_StopAnalogActionMomentum(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ControllerAnalogActionHandle_t eAction);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_TriggerHapticPulse", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamController_TriggerHapticPulse(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ESteamControllerPad eTargetPad,
      ushort usDurationMicroSec);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_TriggerRepeatedHapticPulse", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamController_TriggerRepeatedHapticPulse(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ESteamControllerPad eTargetPad,
      ushort usDurationMicroSec,
      ushort usOffMicroSec,
      ushort unRepeat,
      uint nFlags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_TriggerVibration", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamController_TriggerVibration(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ushort usLeftSpeed,
      ushort usRightSpeed);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_SetLEDColor", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamController_SetLEDColor(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      byte nColorR,
      byte nColorG,
      byte nColorB,
      uint nFlags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetGamepadIndexForController", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamController_GetGamepadIndexForController(
      IntPtr instancePtr,
      ControllerHandle_t ulControllerHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetControllerForGamepadIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamController_GetControllerForGamepadIndex(
      IntPtr instancePtr,
      int nIndex);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetMotionData", CallingConvention = CallingConvention.Cdecl)]
    public static extern ControllerMotionData_t ISteamController_GetMotionData(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_ShowDigitalActionOrigins", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamController_ShowDigitalActionOrigins(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ControllerDigitalActionHandle_t digitalActionHandle,
      float flScale,
      float flXPosition,
      float flYPosition);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_ShowAnalogActionOrigins", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamController_ShowAnalogActionOrigins(
      IntPtr instancePtr,
      ControllerHandle_t controllerHandle,
      ControllerAnalogActionHandle_t analogActionHandle,
      float flScale,
      float flXPosition,
      float flYPosition);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetStringForActionOrigin", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamController_GetStringForActionOrigin(
      IntPtr instancePtr,
      EControllerActionOrigin eOrigin);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamController_GetGlyphForActionOrigin", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamController_GetGlyphForActionOrigin(
      IntPtr instancePtr,
      EControllerActionOrigin eOrigin);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetPersonaName", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetPersonaName(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_SetPersonaName", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_SetPersonaName(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchPersonaName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetPersonaState", CallingConvention = CallingConvention.Cdecl)]
    public static extern EPersonaState ISteamFriends_GetPersonaState(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetFriendCount(
      IntPtr instancePtr,
      EFriendFlags iFriendFlags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_GetFriendByIndex(
      IntPtr instancePtr,
      int iFriend,
      EFriendFlags iFriendFlags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendRelationship", CallingConvention = CallingConvention.Cdecl)]
    public static extern EFriendRelationship ISteamFriends_GetFriendRelationship(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendPersonaState", CallingConvention = CallingConvention.Cdecl)]
    public static extern EPersonaState ISteamFriends_GetFriendPersonaState(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendPersonaName", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetFriendPersonaName(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendGamePlayed", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_GetFriendGamePlayed(
      IntPtr instancePtr,
      CSteamID steamIDFriend,
      out FriendGameInfo_t pFriendGameInfo);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendPersonaNameHistory", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetFriendPersonaNameHistory(
      IntPtr instancePtr,
      CSteamID steamIDFriend,
      int iPersonaName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendSteamLevel", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetFriendSteamLevel(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetPlayerNickname", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetPlayerNickname(
      IntPtr instancePtr,
      CSteamID steamIDPlayer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendsGroupCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetFriendsGroupCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendsGroupIDByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern short ISteamFriends_GetFriendsGroupIDByIndex(IntPtr instancePtr, int iFG);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendsGroupName", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetFriendsGroupName(
      IntPtr instancePtr,
      FriendsGroupID_t friendsGroupID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendsGroupMembersCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetFriendsGroupMembersCount(
      IntPtr instancePtr,
      FriendsGroupID_t friendsGroupID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendsGroupMembersList", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_GetFriendsGroupMembersList(
      IntPtr instancePtr,
      FriendsGroupID_t friendsGroupID,
      [In, Out] CSteamID[] pOutSteamIDMembers,
      int nMembersCount);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_HasFriend", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_HasFriend(
      IntPtr instancePtr,
      CSteamID steamIDFriend,
      EFriendFlags iFriendFlags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetClanCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_GetClanByIndex(IntPtr instancePtr, int iClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanName", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetClanName(
      IntPtr instancePtr,
      CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanTag", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetClanTag(
      IntPtr instancePtr,
      CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanActivityCounts", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_GetClanActivityCounts(
      IntPtr instancePtr,
      CSteamID steamIDClan,
      out int pnOnline,
      out int pnInGame,
      out int pnChatting);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_DownloadClanActivityCounts", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_DownloadClanActivityCounts(
      IntPtr instancePtr,
      [In, Out] CSteamID[] psteamIDClans,
      int cClansToRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendCountFromSource", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetFriendCountFromSource(
      IntPtr instancePtr,
      CSteamID steamIDSource);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendFromSourceByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_GetFriendFromSourceByIndex(
      IntPtr instancePtr,
      CSteamID steamIDSource,
      int iFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_IsUserInSource", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_IsUserInSource(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      CSteamID steamIDSource);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_SetInGameVoiceSpeaking", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_SetInGameVoiceSpeaking(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      [MarshalAs(UnmanagedType.I1)] bool bSpeaking);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_ActivateGameOverlay", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_ActivateGameOverlay(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchDialog);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_ActivateGameOverlayToUser", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_ActivateGameOverlayToUser(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchDialog,
      CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_ActivateGameOverlayToWebPage", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_ActivateGameOverlayToWebPage(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchURL);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_ActivateGameOverlayToStore", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_ActivateGameOverlayToStore(
      IntPtr instancePtr,
      AppId_t nAppID,
      EOverlayToStoreFlag eFlag);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_SetPlayedWith", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_SetPlayedWith(
      IntPtr instancePtr,
      CSteamID steamIDUserPlayedWith);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_ActivateGameOverlayInviteDialog", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_ActivateGameOverlayInviteDialog(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetSmallFriendAvatar", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetSmallFriendAvatar(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetMediumFriendAvatar", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetMediumFriendAvatar(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetLargeFriendAvatar", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetLargeFriendAvatar(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_RequestUserInformation", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_RequestUserInformation(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      [MarshalAs(UnmanagedType.I1)] bool bRequireNameOnly);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_RequestClanOfficerList", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_RequestClanOfficerList(
      IntPtr instancePtr,
      CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanOwner", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_GetClanOwner(IntPtr instancePtr, CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanOfficerCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetClanOfficerCount(
      IntPtr instancePtr,
      CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanOfficerByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_GetClanOfficerByIndex(
      IntPtr instancePtr,
      CSteamID steamIDClan,
      int iOfficer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetUserRestrictions", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamFriends_GetUserRestrictions(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_SetRichPresence", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_SetRichPresence(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchKey,
      InteropHelp.UTF8StringHandle pchValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_ClearRichPresence", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_ClearRichPresence(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendRichPresence", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetFriendRichPresence(
      IntPtr instancePtr,
      CSteamID steamIDFriend,
      InteropHelp.UTF8StringHandle pchKey);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendRichPresenceKeyCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetFriendRichPresenceKeyCount(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendRichPresenceKeyByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamFriends_GetFriendRichPresenceKeyByIndex(
      IntPtr instancePtr,
      CSteamID steamIDFriend,
      int iKey);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_RequestFriendRichPresence", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamFriends_RequestFriendRichPresence(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_InviteUserToGame", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_InviteUserToGame(
      IntPtr instancePtr,
      CSteamID steamIDFriend,
      InteropHelp.UTF8StringHandle pchConnectString);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetCoplayFriendCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetCoplayFriendCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetCoplayFriend", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_GetCoplayFriend(IntPtr instancePtr, int iCoplayFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendCoplayTime", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetFriendCoplayTime(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendCoplayGame", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamFriends_GetFriendCoplayGame(
      IntPtr instancePtr,
      CSteamID steamIDFriend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_JoinClanChatRoom", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_JoinClanChatRoom(
      IntPtr instancePtr,
      CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_LeaveClanChatRoom", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_LeaveClanChatRoom(
      IntPtr instancePtr,
      CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanChatMemberCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetClanChatMemberCount(
      IntPtr instancePtr,
      CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetChatMemberByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_GetChatMemberByIndex(
      IntPtr instancePtr,
      CSteamID steamIDClan,
      int iUser);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_SendClanChatMessage", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_SendClanChatMessage(
      IntPtr instancePtr,
      CSteamID steamIDClanChat,
      InteropHelp.UTF8StringHandle pchText);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetClanChatMessage", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetClanChatMessage(
      IntPtr instancePtr,
      CSteamID steamIDClanChat,
      int iMessage,
      IntPtr prgchText,
      int cchTextMax,
      out EChatEntryType peChatEntryType,
      out CSteamID psteamidChatter);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_IsClanChatAdmin", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_IsClanChatAdmin(
      IntPtr instancePtr,
      CSteamID steamIDClanChat,
      CSteamID steamIDUser);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_IsClanChatWindowOpenInSteam", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_IsClanChatWindowOpenInSteam(
      IntPtr instancePtr,
      CSteamID steamIDClanChat);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_OpenClanChatWindowInSteam", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_OpenClanChatWindowInSteam(
      IntPtr instancePtr,
      CSteamID steamIDClanChat);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_CloseClanChatWindowInSteam", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_CloseClanChatWindowInSteam(
      IntPtr instancePtr,
      CSteamID steamIDClanChat);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_SetListenForFriendsMessages", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_SetListenForFriendsMessages(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bInterceptEnabled);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_ReplyToFriendMessage", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamFriends_ReplyToFriendMessage(
      IntPtr instancePtr,
      CSteamID steamIDFriend,
      InteropHelp.UTF8StringHandle pchMsgToSend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFriendMessage", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamFriends_GetFriendMessage(
      IntPtr instancePtr,
      CSteamID steamIDFriend,
      int iMessageID,
      IntPtr pvData,
      int cubData,
      out EChatEntryType peChatEntryType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_GetFollowerCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_GetFollowerCount(IntPtr instancePtr, CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_IsFollowing", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_IsFollowing(IntPtr instancePtr, CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamFriends_EnumerateFollowingList", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamFriends_EnumerateFollowingList(
      IntPtr instancePtr,
      uint unStartIndex);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_InitGameServer", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServer_InitGameServer(
      IntPtr instancePtr,
      uint unIP,
      ushort usGamePort,
      ushort usQueryPort,
      uint unFlags,
      AppId_t nGameAppId,
      InteropHelp.UTF8StringHandle pchVersionString);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetProduct", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetProduct(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszProduct);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetGameDescription", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetGameDescription(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszGameDescription);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetModDir", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetModDir(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszModDir);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetDedicatedServer", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetDedicatedServer(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bDedicated);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_LogOn", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_LogOn(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszToken);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_LogOnAnonymous", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_LogOnAnonymous(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_LogOff", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_LogOff(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_BLoggedOn", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServer_BLoggedOn(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_BSecure", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServer_BSecure(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_GetSteamID", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamGameServer_GetSteamID(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_WasRestartRequested", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServer_WasRestartRequested(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetMaxPlayerCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetMaxPlayerCount(
      IntPtr instancePtr,
      int cPlayersMax);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetBotPlayerCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetBotPlayerCount(
      IntPtr instancePtr,
      int cBotplayers);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetServerName", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetServerName(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszServerName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetMapName", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetMapName(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszMapName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetPasswordProtected", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetPasswordProtected(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bPasswordProtected);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetSpectatorPort", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetSpectatorPort(
      IntPtr instancePtr,
      ushort unSpectatorPort);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetSpectatorServerName", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetSpectatorServerName(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszSpectatorServerName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_ClearAllKeyValues", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_ClearAllKeyValues(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetKeyValue", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetKeyValue(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pKey,
      InteropHelp.UTF8StringHandle pValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetGameTags", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetGameTags(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchGameTags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetGameData", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetGameData(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchGameData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetRegion", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetRegion(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pszRegion);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SendUserConnectAndAuthenticate", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServer_SendUserConnectAndAuthenticate(
      IntPtr instancePtr,
      uint unIPClient,
      byte[] pvAuthBlob,
      uint cubAuthBlobSize,
      out CSteamID pSteamIDUser);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_CreateUnauthenticatedUserConnection", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamGameServer_CreateUnauthenticatedUserConnection(
      IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SendUserDisconnect", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SendUserDisconnect(
      IntPtr instancePtr,
      CSteamID steamIDUser);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_BUpdateUserData", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServer_BUpdateUserData(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchPlayerName,
      uint uScore);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_GetAuthSessionTicket", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamGameServer_GetAuthSessionTicket(
      IntPtr instancePtr,
      byte[] pTicket,
      int cbMaxTicket,
      out uint pcbTicket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_BeginAuthSession", CallingConvention = CallingConvention.Cdecl)]
    public static extern EBeginAuthSessionResult ISteamGameServer_BeginAuthSession(
      IntPtr instancePtr,
      byte[] pAuthTicket,
      int cbAuthTicket,
      CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_EndAuthSession", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_EndAuthSession(IntPtr instancePtr, CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_CancelAuthTicket", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_CancelAuthTicket(
      IntPtr instancePtr,
      HAuthTicket hAuthTicket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_UserHasLicenseForApp", CallingConvention = CallingConvention.Cdecl)]
    public static extern EUserHasLicenseForAppResult ISteamGameServer_UserHasLicenseForApp(
      IntPtr instancePtr,
      CSteamID steamID,
      AppId_t appID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_RequestUserGroupStatus", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServer_RequestUserGroupStatus(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      CSteamID steamIDGroup);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_GetGameplayStats", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_GetGameplayStats(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_GetServerReputation", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamGameServer_GetServerReputation(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_GetPublicIP", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamGameServer_GetPublicIP(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_HandleIncomingPacket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServer_HandleIncomingPacket(
      IntPtr instancePtr,
      byte[] pData,
      int cbData,
      uint srcIP,
      ushort srcPort);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_GetNextOutgoingPacket", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamGameServer_GetNextOutgoingPacket(
      IntPtr instancePtr,
      byte[] pOut,
      int cbMaxOut,
      out uint pNetAdr,
      out ushort pPort);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_EnableHeartbeats", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_EnableHeartbeats(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bActive);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_SetHeartbeatInterval", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_SetHeartbeatInterval(
      IntPtr instancePtr,
      int iHeartbeatInterval);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_ForceHeartbeat", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamGameServer_ForceHeartbeat(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_AssociateWithClan", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamGameServer_AssociateWithClan(
      IntPtr instancePtr,
      CSteamID steamIDClan);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServer_ComputeNewPlayerCompatibility", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamGameServer_ComputeNewPlayerCompatibility(
      IntPtr instancePtr,
      CSteamID steamIDNewPlayer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_RequestUserStats", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamGameServerStats_RequestUserStats(
      IntPtr instancePtr,
      CSteamID steamIDUser);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_GetUserStat", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServerStats_GetUserStat(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      out int pData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_GetUserStat0", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServerStats_GetUserStat0(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      out float pData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_GetUserAchievement", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServerStats_GetUserAchievement(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      out bool pbAchieved);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_SetUserStat", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServerStats_SetUserStat(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      int nData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_SetUserStat0", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServerStats_SetUserStat0(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      float fData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_UpdateUserAvgRateStat", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServerStats_UpdateUserAvgRateStat(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      float flCountThisSession,
      double dSessionLength);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_SetUserAchievement", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServerStats_SetUserAchievement(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_ClearUserAchievement", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamGameServerStats_ClearUserAchievement(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamGameServerStats_StoreUserStats", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamGameServerStats_StoreUserStats(
      IntPtr instancePtr,
      CSteamID steamIDUser);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_Init", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTMLSurface_Init(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_Shutdown", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTMLSurface_Shutdown(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_CreateBrowser", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamHTMLSurface_CreateBrowser(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchUserAgent,
      InteropHelp.UTF8StringHandle pchUserCSS);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_RemoveBrowser", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_RemoveBrowser(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_LoadURL", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_LoadURL(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      InteropHelp.UTF8StringHandle pchURL,
      InteropHelp.UTF8StringHandle pchPostData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_SetSize", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_SetSize(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      uint unWidth,
      uint unHeight);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_StopLoad", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_StopLoad(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_Reload", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_Reload(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_GoBack", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_GoBack(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_GoForward", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_GoForward(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_AddHeader", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_AddHeader(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      InteropHelp.UTF8StringHandle pchKey,
      InteropHelp.UTF8StringHandle pchValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_ExecuteJavascript", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_ExecuteJavascript(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      InteropHelp.UTF8StringHandle pchScript);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_MouseUp", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_MouseUp(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      EHTMLMouseButton eMouseButton);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_MouseDown", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_MouseDown(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      EHTMLMouseButton eMouseButton);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_MouseDoubleClick", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_MouseDoubleClick(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      EHTMLMouseButton eMouseButton);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_MouseMove", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_MouseMove(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      int x,
      int y);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_MouseWheel", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_MouseWheel(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      int nDelta);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_KeyDown", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_KeyDown(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      uint nNativeKeyCode,
      EHTMLKeyModifiers eHTMLKeyModifiers);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_KeyUp", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_KeyUp(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      uint nNativeKeyCode,
      EHTMLKeyModifiers eHTMLKeyModifiers);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_KeyChar", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_KeyChar(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      uint cUnicodeChar,
      EHTMLKeyModifiers eHTMLKeyModifiers);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_SetHorizontalScroll", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_SetHorizontalScroll(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      uint nAbsolutePixelScroll);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_SetVerticalScroll", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_SetVerticalScroll(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      uint nAbsolutePixelScroll);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_SetKeyFocus", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_SetKeyFocus(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      [MarshalAs(UnmanagedType.I1)] bool bHasKeyFocus);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_ViewSource", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_ViewSource(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_CopyToClipboard", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_CopyToClipboard(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_PasteFromClipboard", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_PasteFromClipboard(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_Find", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_Find(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      InteropHelp.UTF8StringHandle pchSearchStr,
      [MarshalAs(UnmanagedType.I1)] bool bCurrentlyInFind,
      [MarshalAs(UnmanagedType.I1)] bool bReverse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_StopFind", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_StopFind(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_GetLinkAtPosition", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_GetLinkAtPosition(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      int x,
      int y);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_SetCookie", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_SetCookie(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchHostname,
      InteropHelp.UTF8StringHandle pchKey,
      InteropHelp.UTF8StringHandle pchValue,
      InteropHelp.UTF8StringHandle pchPath,
      uint nExpires,
      [MarshalAs(UnmanagedType.I1)] bool bSecure,
      [MarshalAs(UnmanagedType.I1)] bool bHTTPOnly);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_SetPageScaleFactor", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_SetPageScaleFactor(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      float flZoom,
      int nPointX,
      int nPointY);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_SetBackgroundMode", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_SetBackgroundMode(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      [MarshalAs(UnmanagedType.I1)] bool bBackgroundMode);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_SetDPIScalingFactor", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_SetDPIScalingFactor(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      float flDPIScaling);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_AllowStartRequest", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_AllowStartRequest(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      [MarshalAs(UnmanagedType.I1)] bool bAllowed);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_JSDialogResponse", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_JSDialogResponse(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      [MarshalAs(UnmanagedType.I1)] bool bResult);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTMLSurface_FileLoadDialogResponse", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamHTMLSurface_FileLoadDialogResponse(
      IntPtr instancePtr,
      HHTMLBrowser unBrowserHandle,
      IntPtr pchSelectedFiles);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_CreateHTTPRequest", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamHTTP_CreateHTTPRequest(
      IntPtr instancePtr,
      EHTTPMethod eHTTPRequestMethod,
      InteropHelp.UTF8StringHandle pchAbsoluteURL);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestContextValue", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestContextValue(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      ulong ulContextValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestNetworkActivityTimeout", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestNetworkActivityTimeout(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      uint unTimeoutSeconds);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestHeaderValue", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestHeaderValue(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      InteropHelp.UTF8StringHandle pchHeaderName,
      InteropHelp.UTF8StringHandle pchHeaderValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestGetOrPostParameter", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestGetOrPostParameter(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      InteropHelp.UTF8StringHandle pchParamName,
      InteropHelp.UTF8StringHandle pchParamValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SendHTTPRequest", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SendHTTPRequest(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      out SteamAPICall_t pCallHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SendHTTPRequestAndStreamResponse", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SendHTTPRequestAndStreamResponse(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      out SteamAPICall_t pCallHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_DeferHTTPRequest", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_DeferHTTPRequest(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_PrioritizeHTTPRequest", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_PrioritizeHTTPRequest(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_GetHTTPResponseHeaderSize", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_GetHTTPResponseHeaderSize(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      InteropHelp.UTF8StringHandle pchHeaderName,
      out uint unResponseHeaderSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_GetHTTPResponseHeaderValue", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_GetHTTPResponseHeaderValue(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      InteropHelp.UTF8StringHandle pchHeaderName,
      byte[] pHeaderValueBuffer,
      uint unBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_GetHTTPResponseBodySize", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_GetHTTPResponseBodySize(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      out uint unBodySize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_GetHTTPResponseBodyData", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_GetHTTPResponseBodyData(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      byte[] pBodyDataBuffer,
      uint unBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_GetHTTPStreamingResponseBodyData", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_GetHTTPStreamingResponseBodyData(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      uint cOffset,
      byte[] pBodyDataBuffer,
      uint unBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_ReleaseHTTPRequest", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_ReleaseHTTPRequest(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_GetHTTPDownloadProgressPct", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_GetHTTPDownloadProgressPct(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      out float pflPercentOut);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestRawPostBody", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestRawPostBody(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      InteropHelp.UTF8StringHandle pchContentType,
      byte[] pubBody,
      uint unBodyLen);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_CreateCookieContainer", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamHTTP_CreateCookieContainer(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bAllowResponsesToModify);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_ReleaseCookieContainer", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_ReleaseCookieContainer(
      IntPtr instancePtr,
      HTTPCookieContainerHandle hCookieContainer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetCookie", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetCookie(
      IntPtr instancePtr,
      HTTPCookieContainerHandle hCookieContainer,
      InteropHelp.UTF8StringHandle pchHost,
      InteropHelp.UTF8StringHandle pchUrl,
      InteropHelp.UTF8StringHandle pchCookie);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestCookieContainer", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestCookieContainer(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      HTTPCookieContainerHandle hCookieContainer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestUserAgentInfo", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestUserAgentInfo(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      InteropHelp.UTF8StringHandle pchUserAgentInfo);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestRequiresVerifiedCertificate", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestRequiresVerifiedCertificate(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      [MarshalAs(UnmanagedType.I1)] bool bRequireVerifiedCertificate);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_SetHTTPRequestAbsoluteTimeoutMS", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_SetHTTPRequestAbsoluteTimeoutMS(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      uint unMilliseconds);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamHTTP_GetHTTPRequestWasTimedOut", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamHTTP_GetHTTPRequestWasTimedOut(
      IntPtr instancePtr,
      HTTPRequestHandle hRequest,
      out bool pbWasTimedOut);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetResultStatus", CallingConvention = CallingConvention.Cdecl)]
    public static extern EResult ISteamInventory_GetResultStatus(
      IntPtr instancePtr,
      SteamInventoryResult_t resultHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetResultItems", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GetResultItems(
      IntPtr instancePtr,
      SteamInventoryResult_t resultHandle,
      [In, Out] SteamItemDetails_t[] pOutItemsArray,
      ref uint punOutItemsArraySize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetResultItemProperty", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GetResultItemProperty(
      IntPtr instancePtr,
      SteamInventoryResult_t resultHandle,
      uint unItemIndex,
      InteropHelp.UTF8StringHandle pchPropertyName,
      IntPtr pchValueBuffer,
      ref uint punValueBufferSizeOut);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetResultTimestamp", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamInventory_GetResultTimestamp(
      IntPtr instancePtr,
      SteamInventoryResult_t resultHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_CheckResultSteamID", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_CheckResultSteamID(
      IntPtr instancePtr,
      SteamInventoryResult_t resultHandle,
      CSteamID steamIDExpected);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_DestroyResult", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamInventory_DestroyResult(
      IntPtr instancePtr,
      SteamInventoryResult_t resultHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetAllItems", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GetAllItems(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetItemsByID", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GetItemsByID(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      [In, Out] SteamItemInstanceID_t[] pInstanceIDs,
      uint unCountInstanceIDs);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_SerializeResult", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_SerializeResult(
      IntPtr instancePtr,
      SteamInventoryResult_t resultHandle,
      byte[] pOutBuffer,
      out uint punOutBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_DeserializeResult", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_DeserializeResult(
      IntPtr instancePtr,
      out SteamInventoryResult_t pOutResultHandle,
      byte[] pBuffer,
      uint unBufferSize,
      [MarshalAs(UnmanagedType.I1)] bool bRESERVED_MUST_BE_FALSE);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GenerateItems", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GenerateItems(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      [In, Out] SteamItemDef_t[] pArrayItemDefs,
      [In, Out] uint[] punArrayQuantity,
      uint unArrayLength);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GrantPromoItems", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GrantPromoItems(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_AddPromoItem", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_AddPromoItem(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      SteamItemDef_t itemDef);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_AddPromoItems", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_AddPromoItems(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      [In, Out] SteamItemDef_t[] pArrayItemDefs,
      uint unArrayLength);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_ConsumeItem", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_ConsumeItem(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      SteamItemInstanceID_t itemConsume,
      uint unQuantity);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_ExchangeItems", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_ExchangeItems(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      [In, Out] SteamItemDef_t[] pArrayGenerate,
      [In, Out] uint[] punArrayGenerateQuantity,
      uint unArrayGenerateLength,
      [In, Out] SteamItemInstanceID_t[] pArrayDestroy,
      [In, Out] uint[] punArrayDestroyQuantity,
      uint unArrayDestroyLength);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_TransferItemQuantity", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_TransferItemQuantity(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      SteamItemInstanceID_t itemIdSource,
      uint unQuantity,
      SteamItemInstanceID_t itemIdDest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_SendItemDropHeartbeat", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamInventory_SendItemDropHeartbeat(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_TriggerItemDrop", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_TriggerItemDrop(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      SteamItemDef_t dropListDefinition);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_TradeItems", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_TradeItems(
      IntPtr instancePtr,
      out SteamInventoryResult_t pResultHandle,
      CSteamID steamIDTradePartner,
      [In, Out] SteamItemInstanceID_t[] pArrayGive,
      [In, Out] uint[] pArrayGiveQuantity,
      uint nArrayGiveLength,
      [In, Out] SteamItemInstanceID_t[] pArrayGet,
      [In, Out] uint[] pArrayGetQuantity,
      uint nArrayGetLength);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_LoadItemDefinitions", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_LoadItemDefinitions(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetItemDefinitionIDs", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GetItemDefinitionIDs(
      IntPtr instancePtr,
      [In, Out] SteamItemDef_t[] pItemDefIDs,
      out uint punItemDefIDsArraySize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetItemDefinitionProperty", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GetItemDefinitionProperty(
      IntPtr instancePtr,
      SteamItemDef_t iDefinition,
      InteropHelp.UTF8StringHandle pchPropertyName,
      IntPtr pchValueBuffer,
      ref uint punValueBufferSizeOut);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_RequestEligiblePromoItemDefinitionsIDs", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamInventory_RequestEligiblePromoItemDefinitionsIDs(
      IntPtr instancePtr,
      CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamInventory_GetEligiblePromoItemDefinitionIDs", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamInventory_GetEligiblePromoItemDefinitionIDs(
      IntPtr instancePtr,
      CSteamID steamID,
      [In, Out] SteamItemDef_t[] pItemDefIDs,
      ref uint punItemDefIDsArraySize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetFavoriteGameCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmaking_GetFavoriteGameCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetFavoriteGame", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_GetFavoriteGame(
      IntPtr instancePtr,
      int iGame,
      out AppId_t pnAppID,
      out uint pnIP,
      out ushort pnConnPort,
      out ushort pnQueryPort,
      out uint punFlags,
      out uint pRTime32LastPlayedOnServer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_AddFavoriteGame", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmaking_AddFavoriteGame(
      IntPtr instancePtr,
      AppId_t nAppID,
      uint nIP,
      ushort nConnPort,
      ushort nQueryPort,
      uint unFlags,
      uint rTime32LastPlayedOnServer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_RemoveFavoriteGame", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_RemoveFavoriteGame(
      IntPtr instancePtr,
      AppId_t nAppID,
      uint nIP,
      ushort nConnPort,
      ushort nQueryPort,
      uint unFlags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_RequestLobbyList", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamMatchmaking_RequestLobbyList(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_AddRequestLobbyListStringFilter", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_AddRequestLobbyListStringFilter(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchKeyToMatch,
      InteropHelp.UTF8StringHandle pchValueToMatch,
      ELobbyComparison eComparisonType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_AddRequestLobbyListNumericalFilter", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_AddRequestLobbyListNumericalFilter(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchKeyToMatch,
      int nValueToMatch,
      ELobbyComparison eComparisonType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_AddRequestLobbyListNearValueFilter", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_AddRequestLobbyListNearValueFilter(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchKeyToMatch,
      int nValueToBeCloseTo);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_AddRequestLobbyListFilterSlotsAvailable", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_AddRequestLobbyListFilterSlotsAvailable(
      IntPtr instancePtr,
      int nSlotsAvailable);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_AddRequestLobbyListDistanceFilter", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_AddRequestLobbyListDistanceFilter(
      IntPtr instancePtr,
      ELobbyDistanceFilter eLobbyDistanceFilter);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_AddRequestLobbyListResultCountFilter", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_AddRequestLobbyListResultCountFilter(
      IntPtr instancePtr,
      int cMaxResults);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_AddRequestLobbyListCompatibleMembersFilter", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_AddRequestLobbyListCompatibleMembersFilter(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamMatchmaking_GetLobbyByIndex(IntPtr instancePtr, int iLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_CreateLobby", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamMatchmaking_CreateLobby(
      IntPtr instancePtr,
      ELobbyType eLobbyType,
      int cMaxMembers);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_JoinLobby", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamMatchmaking_JoinLobby(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_LeaveLobby", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_LeaveLobby(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_InviteUserToLobby", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_InviteUserToLobby(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      CSteamID steamIDInvitee);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetNumLobbyMembers", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmaking_GetNumLobbyMembers(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyMemberByIndex", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamMatchmaking_GetLobbyMemberByIndex(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      int iMember);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyData", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmaking_GetLobbyData(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      InteropHelp.UTF8StringHandle pchKey);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SetLobbyData", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_SetLobbyData(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      InteropHelp.UTF8StringHandle pchKey,
      InteropHelp.UTF8StringHandle pchValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyDataCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmaking_GetLobbyDataCount(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyDataByIndex", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_GetLobbyDataByIndex(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      int iLobbyData,
      IntPtr pchKey,
      int cchKeyBufferSize,
      IntPtr pchValue,
      int cchValueBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_DeleteLobbyData", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_DeleteLobbyData(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      InteropHelp.UTF8StringHandle pchKey);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyMemberData", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmaking_GetLobbyMemberData(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchKey);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SetLobbyMemberData", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_SetLobbyMemberData(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      InteropHelp.UTF8StringHandle pchKey,
      InteropHelp.UTF8StringHandle pchValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SendLobbyChatMsg", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_SendLobbyChatMsg(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      byte[] pvMsgBody,
      int cubMsgBody);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyChatEntry", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmaking_GetLobbyChatEntry(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      int iChatID,
      out CSteamID pSteamIDUser,
      byte[] pvData,
      int cubData,
      out EChatEntryType peChatEntryType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_RequestLobbyData", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_RequestLobbyData(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SetLobbyGameServer", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmaking_SetLobbyGameServer(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      uint unGameServerIP,
      ushort unGameServerPort,
      CSteamID steamIDGameServer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyGameServer", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_GetLobbyGameServer(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      out uint punGameServerIP,
      out ushort punGameServerPort,
      out CSteamID psteamIDGameServer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SetLobbyMemberLimit", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_SetLobbyMemberLimit(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      int cMaxMembers);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyMemberLimit", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmaking_GetLobbyMemberLimit(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SetLobbyType", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_SetLobbyType(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      ELobbyType eLobbyType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SetLobbyJoinable", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_SetLobbyJoinable(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      [MarshalAs(UnmanagedType.I1)] bool bLobbyJoinable);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_GetLobbyOwner", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamMatchmaking_GetLobbyOwner(
      IntPtr instancePtr,
      CSteamID steamIDLobby);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SetLobbyOwner", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_SetLobbyOwner(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      CSteamID steamIDNewOwner);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmaking_SetLinkedLobby", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmaking_SetLinkedLobby(
      IntPtr instancePtr,
      CSteamID steamIDLobby,
      CSteamID steamIDLobbyDependent);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_RequestInternetServerList", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmakingServers_RequestInternetServerList(
      IntPtr instancePtr,
      AppId_t iApp,
      IntPtr ppchFilters,
      uint nFilters,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_RequestLANServerList", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmakingServers_RequestLANServerList(
      IntPtr instancePtr,
      AppId_t iApp,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_RequestFriendsServerList", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmakingServers_RequestFriendsServerList(
      IntPtr instancePtr,
      AppId_t iApp,
      IntPtr ppchFilters,
      uint nFilters,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_RequestFavoritesServerList", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmakingServers_RequestFavoritesServerList(
      IntPtr instancePtr,
      AppId_t iApp,
      IntPtr ppchFilters,
      uint nFilters,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_RequestHistoryServerList", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmakingServers_RequestHistoryServerList(
      IntPtr instancePtr,
      AppId_t iApp,
      IntPtr ppchFilters,
      uint nFilters,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_RequestSpectatorServerList", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmakingServers_RequestSpectatorServerList(
      IntPtr instancePtr,
      AppId_t iApp,
      IntPtr ppchFilters,
      uint nFilters,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_ReleaseRequest", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmakingServers_ReleaseRequest(
      IntPtr instancePtr,
      HServerListRequest hServerListRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_GetServerDetails", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamMatchmakingServers_GetServerDetails(
      IntPtr instancePtr,
      HServerListRequest hRequest,
      int iServer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_CancelQuery", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmakingServers_CancelQuery(
      IntPtr instancePtr,
      HServerListRequest hRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_RefreshQuery", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmakingServers_RefreshQuery(
      IntPtr instancePtr,
      HServerListRequest hRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_IsRefreshing", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMatchmakingServers_IsRefreshing(
      IntPtr instancePtr,
      HServerListRequest hRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_GetServerCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmakingServers_GetServerCount(
      IntPtr instancePtr,
      HServerListRequest hRequest);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_RefreshServer", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmakingServers_RefreshServer(
      IntPtr instancePtr,
      HServerListRequest hRequest,
      int iServer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_PingServer", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmakingServers_PingServer(
      IntPtr instancePtr,
      uint unIP,
      ushort usPort,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_PlayerDetails", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmakingServers_PlayerDetails(
      IntPtr instancePtr,
      uint unIP,
      ushort usPort,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_ServerRules", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamMatchmakingServers_ServerRules(
      IntPtr instancePtr,
      uint unIP,
      ushort usPort,
      IntPtr pRequestServersResponse);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMatchmakingServers_CancelServerQuery", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMatchmakingServers_CancelServerQuery(
      IntPtr instancePtr,
      HServerQuery hServerQuery);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_BIsEnabled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusic_BIsEnabled(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_BIsPlaying", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusic_BIsPlaying(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_GetPlaybackStatus", CallingConvention = CallingConvention.Cdecl)]
    public static extern AudioPlayback_Status ISteamMusic_GetPlaybackStatus(
      IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_Play", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMusic_Play(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_Pause", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMusic_Pause(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_PlayPrevious", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMusic_PlayPrevious(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_PlayNext", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMusic_PlayNext(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_SetVolume", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamMusic_SetVolume(IntPtr instancePtr, float flVolume);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusic_GetVolume", CallingConvention = CallingConvention.Cdecl)]
    public static extern float ISteamMusic_GetVolume(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_RegisterSteamMusicRemote", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_RegisterSteamMusicRemote(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_DeregisterSteamMusicRemote", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_DeregisterSteamMusicRemote(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_BIsCurrentMusicRemote", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_BIsCurrentMusicRemote(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_BActivationSuccess", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_BActivationSuccess(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_SetDisplayName", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_SetDisplayName(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchDisplayName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_SetPNGIcon_64x64", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_SetPNGIcon_64x64(
      IntPtr instancePtr,
      byte[] pvBuffer,
      uint cbBufferLength);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_EnablePlayPrevious", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_EnablePlayPrevious(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_EnablePlayNext", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_EnablePlayNext(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_EnableShuffled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_EnableShuffled(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_EnableLooped", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_EnableLooped(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_EnableQueue", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_EnableQueue(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_EnablePlaylists", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_EnablePlaylists(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_UpdatePlaybackStatus", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_UpdatePlaybackStatus(
      IntPtr instancePtr,
      AudioPlayback_Status nStatus);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_UpdateShuffled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_UpdateShuffled(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_UpdateLooped", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_UpdateLooped(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_UpdateVolume", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_UpdateVolume(IntPtr instancePtr, float flValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_CurrentEntryWillChange", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_CurrentEntryWillChange(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_CurrentEntryIsAvailable", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_CurrentEntryIsAvailable(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bAvailable);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_UpdateCurrentEntryText", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_UpdateCurrentEntryText(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchText);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_UpdateCurrentEntryElapsedSeconds", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_UpdateCurrentEntryElapsedSeconds(
      IntPtr instancePtr,
      int nValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_UpdateCurrentEntryCoverArt", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_UpdateCurrentEntryCoverArt(
      IntPtr instancePtr,
      byte[] pvBuffer,
      uint cbBufferLength);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_CurrentEntryDidChange", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_CurrentEntryDidChange(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_QueueWillChange", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_QueueWillChange(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_ResetQueueEntries", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_ResetQueueEntries(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_SetQueueEntry", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_SetQueueEntry(
      IntPtr instancePtr,
      int nID,
      int nPosition,
      InteropHelp.UTF8StringHandle pchEntryText);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_SetCurrentQueueEntry", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_SetCurrentQueueEntry(IntPtr instancePtr, int nID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_QueueDidChange", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_QueueDidChange(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_PlaylistWillChange", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_PlaylistWillChange(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_ResetPlaylistEntries", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_ResetPlaylistEntries(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_SetPlaylistEntry", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_SetPlaylistEntry(
      IntPtr instancePtr,
      int nID,
      int nPosition,
      InteropHelp.UTF8StringHandle pchEntryText);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_SetCurrentPlaylistEntry", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_SetCurrentPlaylistEntry(IntPtr instancePtr, int nID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamMusicRemote_PlaylistDidChange", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamMusicRemote_PlaylistDidChange(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_SendP2PPacket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_SendP2PPacket(
      IntPtr instancePtr,
      CSteamID steamIDRemote,
      byte[] pubData,
      uint cubData,
      EP2PSend eP2PSendType,
      int nChannel);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_IsP2PPacketAvailable", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_IsP2PPacketAvailable(
      IntPtr instancePtr,
      out uint pcubMsgSize,
      int nChannel);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_ReadP2PPacket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_ReadP2PPacket(
      IntPtr instancePtr,
      byte[] pubDest,
      uint cubDest,
      out uint pcubMsgSize,
      out CSteamID psteamIDRemote,
      int nChannel);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_AcceptP2PSessionWithUser", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_AcceptP2PSessionWithUser(
      IntPtr instancePtr,
      CSteamID steamIDRemote);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_CloseP2PSessionWithUser", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_CloseP2PSessionWithUser(
      IntPtr instancePtr,
      CSteamID steamIDRemote);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_CloseP2PChannelWithUser", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_CloseP2PChannelWithUser(
      IntPtr instancePtr,
      CSteamID steamIDRemote,
      int nChannel);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_GetP2PSessionState", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_GetP2PSessionState(
      IntPtr instancePtr,
      CSteamID steamIDRemote,
      out P2PSessionState_t pConnectionState);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_AllowP2PPacketRelay", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_AllowP2PPacketRelay(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bAllow);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_CreateListenSocket", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamNetworking_CreateListenSocket(
      IntPtr instancePtr,
      int nVirtualP2PPort,
      uint nIP,
      ushort nPort,
      [MarshalAs(UnmanagedType.I1)] bool bAllowUseOfPacketRelay);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_CreateP2PConnectionSocket", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamNetworking_CreateP2PConnectionSocket(
      IntPtr instancePtr,
      CSteamID steamIDTarget,
      int nVirtualPort,
      int nTimeoutSec,
      [MarshalAs(UnmanagedType.I1)] bool bAllowUseOfPacketRelay);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_CreateConnectionSocket", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamNetworking_CreateConnectionSocket(
      IntPtr instancePtr,
      uint nIP,
      ushort nPort,
      int nTimeoutSec);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_DestroySocket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_DestroySocket(
      IntPtr instancePtr,
      SNetSocket_t hSocket,
      [MarshalAs(UnmanagedType.I1)] bool bNotifyRemoteEnd);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_DestroyListenSocket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_DestroyListenSocket(
      IntPtr instancePtr,
      SNetListenSocket_t hSocket,
      [MarshalAs(UnmanagedType.I1)] bool bNotifyRemoteEnd);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_SendDataOnSocket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_SendDataOnSocket(
      IntPtr instancePtr,
      SNetSocket_t hSocket,
      byte[] pubData,
      uint cubData,
      [MarshalAs(UnmanagedType.I1)] bool bReliable);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_IsDataAvailableOnSocket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_IsDataAvailableOnSocket(
      IntPtr instancePtr,
      SNetSocket_t hSocket,
      out uint pcubMsgSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_RetrieveDataFromSocket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_RetrieveDataFromSocket(
      IntPtr instancePtr,
      SNetSocket_t hSocket,
      byte[] pubDest,
      uint cubDest,
      out uint pcubMsgSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_IsDataAvailable", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_IsDataAvailable(
      IntPtr instancePtr,
      SNetListenSocket_t hListenSocket,
      out uint pcubMsgSize,
      out SNetSocket_t phSocket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_RetrieveData", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_RetrieveData(
      IntPtr instancePtr,
      SNetListenSocket_t hListenSocket,
      byte[] pubDest,
      uint cubDest,
      out uint pcubMsgSize,
      out SNetSocket_t phSocket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_GetSocketInfo", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_GetSocketInfo(
      IntPtr instancePtr,
      SNetSocket_t hSocket,
      out CSteamID pSteamIDRemote,
      out int peSocketStatus,
      out uint punIPRemote,
      out ushort punPortRemote);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_GetListenSocketInfo", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamNetworking_GetListenSocketInfo(
      IntPtr instancePtr,
      SNetListenSocket_t hListenSocket,
      out uint pnIP,
      out ushort pnPort);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_GetSocketConnectionType", CallingConvention = CallingConvention.Cdecl)]
    public static extern ESNetSocketConnectionType ISteamNetworking_GetSocketConnectionType(
      IntPtr instancePtr,
      SNetSocket_t hSocket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamNetworking_GetMaxPacketSize", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamNetworking_GetMaxPacketSize(
      IntPtr instancePtr,
      SNetSocket_t hSocket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamParentalSettings_BIsParentalLockEnabled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamParentalSettings_BIsParentalLockEnabled(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamParentalSettings_BIsParentalLockLocked", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamParentalSettings_BIsParentalLockLocked(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamParentalSettings_BIsAppBlocked", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamParentalSettings_BIsAppBlocked(
      IntPtr instancePtr,
      AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamParentalSettings_BIsAppInBlockList", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamParentalSettings_BIsAppInBlockList(
      IntPtr instancePtr,
      AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamParentalSettings_BIsFeatureBlocked", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamParentalSettings_BIsFeatureBlocked(
      IntPtr instancePtr,
      EParentalFeature eFeature);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamParentalSettings_BIsFeatureInBlockList", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamParentalSettings_BIsFeatureInBlockList(
      IntPtr instancePtr,
      EParentalFeature eFeature);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileWrite", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FileWrite(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile,
      byte[] pvData,
      int cubData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileRead", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamRemoteStorage_FileRead(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile,
      byte[] pvData,
      int cubDataToRead);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileWriteAsync", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_FileWriteAsync(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile,
      byte[] pvData,
      uint cubData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileReadAsync", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_FileReadAsync(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile,
      uint nOffset,
      uint cubToRead);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileReadAsyncComplete", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FileReadAsyncComplete(
      IntPtr instancePtr,
      SteamAPICall_t hReadCall,
      byte[] pvBuffer,
      uint cubToRead);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileForget", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FileForget(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileDelete", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FileDelete(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileShare", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_FileShare(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_SetSyncPlatforms", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_SetSyncPlatforms(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile,
      ERemoteStoragePlatform eRemoteStoragePlatform);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileWriteStreamOpen", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_FileWriteStreamOpen(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileWriteStreamWriteChunk", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FileWriteStreamWriteChunk(
      IntPtr instancePtr,
      UGCFileWriteStreamHandle_t writeHandle,
      byte[] pvData,
      int cubData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileWriteStreamClose", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FileWriteStreamClose(
      IntPtr instancePtr,
      UGCFileWriteStreamHandle_t writeHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileWriteStreamCancel", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FileWriteStreamCancel(
      IntPtr instancePtr,
      UGCFileWriteStreamHandle_t writeHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FileExists", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FileExists(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_FilePersisted", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_FilePersisted(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetFileSize", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamRemoteStorage_GetFileSize(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetFileTimestamp", CallingConvention = CallingConvention.Cdecl)]
    public static extern long ISteamRemoteStorage_GetFileTimestamp(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetSyncPlatforms", CallingConvention = CallingConvention.Cdecl)]
    public static extern ERemoteStoragePlatform ISteamRemoteStorage_GetSyncPlatforms(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetFileCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamRemoteStorage_GetFileCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetFileNameAndSize", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamRemoteStorage_GetFileNameAndSize(
      IntPtr instancePtr,
      int iFile,
      out int pnFileSizeInBytes);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetQuota", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_GetQuota(
      IntPtr instancePtr,
      out ulong pnTotalBytes,
      out ulong puAvailableBytes);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_IsCloudEnabledForAccount", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_IsCloudEnabledForAccount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_IsCloudEnabledForApp", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_IsCloudEnabledForApp(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_SetCloudEnabledForApp", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamRemoteStorage_SetCloudEnabledForApp(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bEnabled);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UGCDownload", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_UGCDownload(
      IntPtr instancePtr,
      UGCHandle_t hContent,
      uint unPriority);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetUGCDownloadProgress", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_GetUGCDownloadProgress(
      IntPtr instancePtr,
      UGCHandle_t hContent,
      out int pnBytesDownloaded,
      out int pnBytesExpected);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetUGCDetails", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_GetUGCDetails(
      IntPtr instancePtr,
      UGCHandle_t hContent,
      out AppId_t pnAppID,
      out IntPtr ppchName,
      out int pnFileSizeInBytes,
      out CSteamID pSteamIDOwner);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UGCRead", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamRemoteStorage_UGCRead(
      IntPtr instancePtr,
      UGCHandle_t hContent,
      byte[] pvData,
      int cubDataToRead,
      uint cOffset,
      EUGCReadAction eAction);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetCachedUGCCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamRemoteStorage_GetCachedUGCCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetCachedUGCHandle", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_GetCachedUGCHandle(
      IntPtr instancePtr,
      int iCachedContent);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_PublishWorkshopFile", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_PublishWorkshopFile(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFile,
      InteropHelp.UTF8StringHandle pchPreviewFile,
      AppId_t nConsumerAppId,
      InteropHelp.UTF8StringHandle pchTitle,
      InteropHelp.UTF8StringHandle pchDescription,
      ERemoteStoragePublishedFileVisibility eVisibility,
      IntPtr pTags,
      EWorkshopFileType eWorkshopFileType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_CreatePublishedFileUpdateRequest", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_CreatePublishedFileUpdateRequest(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileFile", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_UpdatePublishedFileFile(
      IntPtr instancePtr,
      PublishedFileUpdateHandle_t updateHandle,
      InteropHelp.UTF8StringHandle pchFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UpdatePublishedFilePreviewFile", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_UpdatePublishedFilePreviewFile(
      IntPtr instancePtr,
      PublishedFileUpdateHandle_t updateHandle,
      InteropHelp.UTF8StringHandle pchPreviewFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileTitle", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_UpdatePublishedFileTitle(
      IntPtr instancePtr,
      PublishedFileUpdateHandle_t updateHandle,
      InteropHelp.UTF8StringHandle pchTitle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileDescription", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_UpdatePublishedFileDescription(
      IntPtr instancePtr,
      PublishedFileUpdateHandle_t updateHandle,
      InteropHelp.UTF8StringHandle pchDescription);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileVisibility", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_UpdatePublishedFileVisibility(
      IntPtr instancePtr,
      PublishedFileUpdateHandle_t updateHandle,
      ERemoteStoragePublishedFileVisibility eVisibility);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileTags", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_UpdatePublishedFileTags(
      IntPtr instancePtr,
      PublishedFileUpdateHandle_t updateHandle,
      IntPtr pTags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_CommitPublishedFileUpdate", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_CommitPublishedFileUpdate(
      IntPtr instancePtr,
      PublishedFileUpdateHandle_t updateHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetPublishedFileDetails", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_GetPublishedFileDetails(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId,
      uint unMaxSecondsOld);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_DeletePublishedFile", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_DeletePublishedFile(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_EnumerateUserPublishedFiles", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_EnumerateUserPublishedFiles(
      IntPtr instancePtr,
      uint unStartIndex);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_SubscribePublishedFile", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_SubscribePublishedFile(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_EnumerateUserSubscribedFiles", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_EnumerateUserSubscribedFiles(
      IntPtr instancePtr,
      uint unStartIndex);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UnsubscribePublishedFile", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_UnsubscribePublishedFile(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileSetChangeDescription", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamRemoteStorage_UpdatePublishedFileSetChangeDescription(
      IntPtr instancePtr,
      PublishedFileUpdateHandle_t updateHandle,
      InteropHelp.UTF8StringHandle pchChangeDescription);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetPublishedItemVoteDetails", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_GetPublishedItemVoteDetails(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UpdateUserPublishedItemVote", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_UpdateUserPublishedItemVote(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId,
      [MarshalAs(UnmanagedType.I1)] bool bVoteUp);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_GetUserPublishedItemVoteDetails", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_GetUserPublishedItemVoteDetails(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_EnumerateUserSharedWorkshopFiles", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_EnumerateUserSharedWorkshopFiles(
      IntPtr instancePtr,
      CSteamID steamId,
      uint unStartIndex,
      IntPtr pRequiredTags,
      IntPtr pExcludedTags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_PublishVideo", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_PublishVideo(
      IntPtr instancePtr,
      EWorkshopVideoProvider eVideoProvider,
      InteropHelp.UTF8StringHandle pchVideoAccount,
      InteropHelp.UTF8StringHandle pchVideoIdentifier,
      InteropHelp.UTF8StringHandle pchPreviewFile,
      AppId_t nConsumerAppId,
      InteropHelp.UTF8StringHandle pchTitle,
      InteropHelp.UTF8StringHandle pchDescription,
      ERemoteStoragePublishedFileVisibility eVisibility,
      IntPtr pTags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_SetUserPublishedFileAction", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_SetUserPublishedFileAction(
      IntPtr instancePtr,
      PublishedFileId_t unPublishedFileId,
      EWorkshopFileAction eAction);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_EnumeratePublishedFilesByUserAction", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_EnumeratePublishedFilesByUserAction(
      IntPtr instancePtr,
      EWorkshopFileAction eAction,
      uint unStartIndex);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_EnumeratePublishedWorkshopFiles", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_EnumeratePublishedWorkshopFiles(
      IntPtr instancePtr,
      EWorkshopEnumerationType eEnumerationType,
      uint unStartIndex,
      uint unCount,
      uint unDays,
      IntPtr pTags,
      IntPtr pUserTags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamRemoteStorage_UGCDownloadToLocation", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamRemoteStorage_UGCDownloadToLocation(
      IntPtr instancePtr,
      UGCHandle_t hContent,
      InteropHelp.UTF8StringHandle pchLocation,
      uint unPriority);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_WriteScreenshot", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamScreenshots_WriteScreenshot(
      IntPtr instancePtr,
      byte[] pubRGB,
      uint cubRGB,
      int nWidth,
      int nHeight);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_AddScreenshotToLibrary", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamScreenshots_AddScreenshotToLibrary(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchFilename,
      InteropHelp.UTF8StringHandle pchThumbnailFilename,
      int nWidth,
      int nHeight);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_TriggerScreenshot", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamScreenshots_TriggerScreenshot(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_HookScreenshots", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamScreenshots_HookScreenshots(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bHook);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_SetLocation", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamScreenshots_SetLocation(
      IntPtr instancePtr,
      ScreenshotHandle hScreenshot,
      InteropHelp.UTF8StringHandle pchLocation);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_TagUser", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamScreenshots_TagUser(
      IntPtr instancePtr,
      ScreenshotHandle hScreenshot,
      CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_TagPublishedFile", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamScreenshots_TagPublishedFile(
      IntPtr instancePtr,
      ScreenshotHandle hScreenshot,
      PublishedFileId_t unPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_IsScreenshotsHooked", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamScreenshots_IsScreenshotsHooked(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamScreenshots_AddVRScreenshotToLibrary", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamScreenshots_AddVRScreenshotToLibrary(
      IntPtr instancePtr,
      EVRScreenshotType eType,
      InteropHelp.UTF8StringHandle pchFilename,
      InteropHelp.UTF8StringHandle pchVRFilename);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_CreateQueryUserUGCRequest", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_CreateQueryUserUGCRequest(
      IntPtr instancePtr,
      AccountID_t unAccountID,
      EUserUGCList eListType,
      EUGCMatchingUGCType eMatchingUGCType,
      EUserUGCListSortOrder eSortOrder,
      AppId_t nCreatorAppID,
      AppId_t nConsumerAppID,
      uint unPage);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_CreateQueryAllUGCRequest", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_CreateQueryAllUGCRequest(
      IntPtr instancePtr,
      EUGCQuery eQueryType,
      EUGCMatchingUGCType eMatchingeMatchingUGCTypeFileType,
      AppId_t nCreatorAppID,
      AppId_t nConsumerAppID,
      uint unPage);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_CreateQueryUGCDetailsRequest", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_CreateQueryUGCDetailsRequest(
      IntPtr instancePtr,
      [In, Out] PublishedFileId_t[] pvecPublishedFileID,
      uint unNumPublishedFileIDs);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SendQueryUGCRequest", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_SendQueryUGCRequest(
      IntPtr instancePtr,
      UGCQueryHandle_t handle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCResult", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetQueryUGCResult(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index,
      out SteamUGCDetails_t pDetails);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCPreviewURL", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetQueryUGCPreviewURL(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index,
      IntPtr pchURL,
      uint cchURLSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCMetadata", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetQueryUGCMetadata(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index,
      IntPtr pchMetadata,
      uint cchMetadatasize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCChildren", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetQueryUGCChildren(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index,
      [In, Out] PublishedFileId_t[] pvecPublishedFileID,
      uint cMaxEntries);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCStatistic", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetQueryUGCStatistic(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index,
      EItemStatistic eStatType,
      out ulong pStatValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCNumAdditionalPreviews", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUGC_GetQueryUGCNumAdditionalPreviews(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCAdditionalPreview", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetQueryUGCAdditionalPreview(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index,
      uint previewIndex,
      IntPtr pchURLOrVideoID,
      uint cchURLSize,
      IntPtr pchOriginalFileName,
      uint cchOriginalFileNameSize,
      out EItemPreviewType pPreviewType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCNumKeyValueTags", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUGC_GetQueryUGCNumKeyValueTags(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetQueryUGCKeyValueTag", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetQueryUGCKeyValueTag(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint index,
      uint keyValueTagIndex,
      IntPtr pchKey,
      uint cchKeySize,
      IntPtr pchValue,
      uint cchValueSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_ReleaseQueryUGCRequest", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_ReleaseQueryUGCRequest(
      IntPtr instancePtr,
      UGCQueryHandle_t handle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddRequiredTag", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_AddRequiredTag(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      InteropHelp.UTF8StringHandle pTagName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddExcludedTag", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_AddExcludedTag(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      InteropHelp.UTF8StringHandle pTagName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetReturnOnlyIDs", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetReturnOnlyIDs(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      [MarshalAs(UnmanagedType.I1)] bool bReturnOnlyIDs);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetReturnKeyValueTags", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetReturnKeyValueTags(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      [MarshalAs(UnmanagedType.I1)] bool bReturnKeyValueTags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetReturnLongDescription", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetReturnLongDescription(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      [MarshalAs(UnmanagedType.I1)] bool bReturnLongDescription);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetReturnMetadata", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetReturnMetadata(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      [MarshalAs(UnmanagedType.I1)] bool bReturnMetadata);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetReturnChildren", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetReturnChildren(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      [MarshalAs(UnmanagedType.I1)] bool bReturnChildren);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetReturnAdditionalPreviews", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetReturnAdditionalPreviews(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      [MarshalAs(UnmanagedType.I1)] bool bReturnAdditionalPreviews);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetReturnTotalOnly", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetReturnTotalOnly(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      [MarshalAs(UnmanagedType.I1)] bool bReturnTotalOnly);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetReturnPlaytimeStats", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetReturnPlaytimeStats(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint unDays);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetLanguage", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetLanguage(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      InteropHelp.UTF8StringHandle pchLanguage);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetAllowCachedResponse", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetAllowCachedResponse(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint unMaxAgeSeconds);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetCloudFileNameFilter", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetCloudFileNameFilter(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      InteropHelp.UTF8StringHandle pMatchCloudFileName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetMatchAnyTag", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetMatchAnyTag(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      [MarshalAs(UnmanagedType.I1)] bool bMatchAnyTag);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetSearchText", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetSearchText(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      InteropHelp.UTF8StringHandle pSearchText);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetRankedByTrendDays", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetRankedByTrendDays(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      uint unDays);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddRequiredKeyValueTag", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_AddRequiredKeyValueTag(
      IntPtr instancePtr,
      UGCQueryHandle_t handle,
      InteropHelp.UTF8StringHandle pKey,
      InteropHelp.UTF8StringHandle pValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_RequestUGCDetails", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_RequestUGCDetails(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID,
      uint unMaxAgeSeconds);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_CreateItem", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_CreateItem(
      IntPtr instancePtr,
      AppId_t nConsumerAppId,
      EWorkshopFileType eFileType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_StartItemUpdate", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_StartItemUpdate(
      IntPtr instancePtr,
      AppId_t nConsumerAppId,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetItemTitle", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetItemTitle(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pchTitle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetItemDescription", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetItemDescription(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pchDescription);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetItemUpdateLanguage", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetItemUpdateLanguage(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pchLanguage);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetItemMetadata", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetItemMetadata(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pchMetaData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetItemVisibility", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetItemVisibility(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      ERemoteStoragePublishedFileVisibility eVisibility);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetItemTags", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetItemTags(
      IntPtr instancePtr,
      UGCUpdateHandle_t updateHandle,
      IntPtr pTags);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetItemContent", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetItemContent(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pszContentFolder);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetItemPreview", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_SetItemPreview(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pszPreviewFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_RemoveItemKeyValueTags", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_RemoveItemKeyValueTags(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pchKey);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddItemKeyValueTag", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_AddItemKeyValueTag(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pchKey,
      InteropHelp.UTF8StringHandle pchValue);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddItemPreviewFile", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_AddItemPreviewFile(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pszPreviewFile,
      EItemPreviewType type);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddItemPreviewVideo", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_AddItemPreviewVideo(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pszVideoID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_UpdateItemPreviewFile", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_UpdateItemPreviewFile(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      uint index,
      InteropHelp.UTF8StringHandle pszPreviewFile);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_UpdateItemPreviewVideo", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_UpdateItemPreviewVideo(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      uint index,
      InteropHelp.UTF8StringHandle pszVideoID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_RemoveItemPreview", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_RemoveItemPreview(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      uint index);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SubmitItemUpdate", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_SubmitItemUpdate(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      InteropHelp.UTF8StringHandle pchChangeNote);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetItemUpdateProgress", CallingConvention = CallingConvention.Cdecl)]
    public static extern EItemUpdateStatus ISteamUGC_GetItemUpdateProgress(
      IntPtr instancePtr,
      UGCUpdateHandle_t handle,
      out ulong punBytesProcessed,
      out ulong punBytesTotal);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SetUserItemVote", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_SetUserItemVote(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID,
      [MarshalAs(UnmanagedType.I1)] bool bVoteUp);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetUserItemVote", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_GetUserItemVote(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddItemToFavorites", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_AddItemToFavorites(
      IntPtr instancePtr,
      AppId_t nAppId,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_RemoveItemFromFavorites", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_RemoveItemFromFavorites(
      IntPtr instancePtr,
      AppId_t nAppId,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SubscribeItem", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_SubscribeItem(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_UnsubscribeItem", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_UnsubscribeItem(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetNumSubscribedItems", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUGC_GetNumSubscribedItems(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetSubscribedItems", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUGC_GetSubscribedItems(
      IntPtr instancePtr,
      [In, Out] PublishedFileId_t[] pvecPublishedFileID,
      uint cMaxEntries);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetItemState", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUGC_GetItemState(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetItemInstallInfo", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetItemInstallInfo(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID,
      out ulong punSizeOnDisk,
      IntPtr pchFolder,
      uint cchFolderSize,
      out uint punTimeStamp);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetItemDownloadInfo", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_GetItemDownloadInfo(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID,
      out ulong punBytesDownloaded,
      out ulong punBytesTotal);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_DownloadItem", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_DownloadItem(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID,
      [MarshalAs(UnmanagedType.I1)] bool bHighPriority);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_BInitWorkshopForGameServer", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUGC_BInitWorkshopForGameServer(
      IntPtr instancePtr,
      DepotId_t unWorkshopDepotID,
      InteropHelp.UTF8StringHandle pszFolder);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_SuspendDownloads", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUGC_SuspendDownloads(IntPtr instancePtr, [MarshalAs(UnmanagedType.I1)] bool bSuspend);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_StartPlaytimeTracking", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_StartPlaytimeTracking(
      IntPtr instancePtr,
      [In, Out] PublishedFileId_t[] pvecPublishedFileID,
      uint unNumPublishedFileIDs);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_StopPlaytimeTracking", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_StopPlaytimeTracking(
      IntPtr instancePtr,
      [In, Out] PublishedFileId_t[] pvecPublishedFileID,
      uint unNumPublishedFileIDs);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_StopPlaytimeTrackingForAllItems", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_StopPlaytimeTrackingForAllItems(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddDependency", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_AddDependency(
      IntPtr instancePtr,
      PublishedFileId_t nParentPublishedFileID,
      PublishedFileId_t nChildPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_RemoveDependency", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_RemoveDependency(
      IntPtr instancePtr,
      PublishedFileId_t nParentPublishedFileID,
      PublishedFileId_t nChildPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_AddAppDependency", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_AddAppDependency(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID,
      AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_RemoveAppDependency", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_RemoveAppDependency(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID,
      AppId_t nAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_GetAppDependencies", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_GetAppDependencies(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUGC_DeleteItem", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUGC_DeleteItem(
      IntPtr instancePtr,
      PublishedFileId_t nPublishedFileID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUnifiedMessages_SendMethod", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUnifiedMessages_SendMethod(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchServiceMethod,
      byte[] pRequestBuffer,
      uint unRequestBufferSize,
      ulong unContext);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUnifiedMessages_GetMethodResponseInfo", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUnifiedMessages_GetMethodResponseInfo(
      IntPtr instancePtr,
      ClientUnifiedMessageHandle hHandle,
      out uint punResponseSize,
      out EResult peResult);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUnifiedMessages_GetMethodResponseData", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUnifiedMessages_GetMethodResponseData(
      IntPtr instancePtr,
      ClientUnifiedMessageHandle hHandle,
      byte[] pResponseBuffer,
      uint unResponseBufferSize,
      [MarshalAs(UnmanagedType.I1)] bool bAutoRelease);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUnifiedMessages_ReleaseMethod", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUnifiedMessages_ReleaseMethod(
      IntPtr instancePtr,
      ClientUnifiedMessageHandle hHandle);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUnifiedMessages_SendNotification", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUnifiedMessages_SendNotification(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchServiceNotification,
      byte[] pNotificationBuffer,
      uint unNotificationBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetHSteamUser", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUser_GetHSteamUser(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_BLoggedOn", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUser_BLoggedOn(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetSteamID", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUser_GetSteamID(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_InitiateGameConnection", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUser_InitiateGameConnection(
      IntPtr instancePtr,
      byte[] pAuthBlob,
      int cbMaxAuthBlob,
      CSteamID steamIDGameServer,
      uint unIPServer,
      ushort usPortServer,
      [MarshalAs(UnmanagedType.I1)] bool bSecure);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_TerminateGameConnection", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUser_TerminateGameConnection(
      IntPtr instancePtr,
      uint unIPServer,
      ushort usPortServer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_TrackAppUsageEvent", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUser_TrackAppUsageEvent(
      IntPtr instancePtr,
      CGameID gameID,
      int eAppUsageEvent,
      InteropHelp.UTF8StringHandle pchExtraInfo);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetUserDataFolder", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUser_GetUserDataFolder(
      IntPtr instancePtr,
      IntPtr pchBuffer,
      int cubBuffer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_StartVoiceRecording", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUser_StartVoiceRecording(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_StopVoiceRecording", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUser_StopVoiceRecording(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetAvailableVoice", CallingConvention = CallingConvention.Cdecl)]
    public static extern EVoiceResult ISteamUser_GetAvailableVoice(
      IntPtr instancePtr,
      out uint pcbCompressed,
      IntPtr pcbUncompressed_Deprecated,
      uint nUncompressedVoiceDesiredSampleRate_Deprecated);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetVoice", CallingConvention = CallingConvention.Cdecl)]
    public static extern EVoiceResult ISteamUser_GetVoice(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bWantCompressed,
      byte[] pDestBuffer,
      uint cbDestBufferSize,
      out uint nBytesWritten,
      [MarshalAs(UnmanagedType.I1)] bool bWantUncompressed_Deprecated,
      IntPtr pUncompressedDestBuffer_Deprecated,
      uint cbUncompressedDestBufferSize_Deprecated,
      IntPtr nUncompressBytesWritten_Deprecated,
      uint nUncompressedVoiceDesiredSampleRate_Deprecated);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_DecompressVoice", CallingConvention = CallingConvention.Cdecl)]
    public static extern EVoiceResult ISteamUser_DecompressVoice(
      IntPtr instancePtr,
      byte[] pCompressed,
      uint cbCompressed,
      byte[] pDestBuffer,
      uint cbDestBufferSize,
      out uint nBytesWritten,
      uint nDesiredSampleRate);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetVoiceOptimalSampleRate", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUser_GetVoiceOptimalSampleRate(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetAuthSessionTicket", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUser_GetAuthSessionTicket(
      IntPtr instancePtr,
      byte[] pTicket,
      int cbMaxTicket,
      out uint pcbTicket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_BeginAuthSession", CallingConvention = CallingConvention.Cdecl)]
    public static extern EBeginAuthSessionResult ISteamUser_BeginAuthSession(
      IntPtr instancePtr,
      byte[] pAuthTicket,
      int cbAuthTicket,
      CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_EndAuthSession", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUser_EndAuthSession(IntPtr instancePtr, CSteamID steamID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_CancelAuthTicket", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUser_CancelAuthTicket(
      IntPtr instancePtr,
      HAuthTicket hAuthTicket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_UserHasLicenseForApp", CallingConvention = CallingConvention.Cdecl)]
    public static extern EUserHasLicenseForAppResult ISteamUser_UserHasLicenseForApp(
      IntPtr instancePtr,
      CSteamID steamID,
      AppId_t appID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_BIsBehindNAT", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUser_BIsBehindNAT(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_AdvertiseGame", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUser_AdvertiseGame(
      IntPtr instancePtr,
      CSteamID steamIDGameServer,
      uint unIPServer,
      ushort usPortServer);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_RequestEncryptedAppTicket", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUser_RequestEncryptedAppTicket(
      IntPtr instancePtr,
      byte[] pDataToInclude,
      int cbDataToInclude);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetEncryptedAppTicket", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUser_GetEncryptedAppTicket(
      IntPtr instancePtr,
      byte[] pTicket,
      int cbMaxTicket,
      out uint pcbTicket);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetGameBadgeLevel", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUser_GetGameBadgeLevel(
      IntPtr instancePtr,
      int nSeries,
      [MarshalAs(UnmanagedType.I1)] bool bFoil);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_GetPlayerSteamLevel", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUser_GetPlayerSteamLevel(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_RequestStoreAuthURL", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUser_RequestStoreAuthURL(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchRedirectURL);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_BIsPhoneVerified", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUser_BIsPhoneVerified(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_BIsTwoFactorEnabled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUser_BIsTwoFactorEnabled(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_BIsPhoneIdentifying", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUser_BIsPhoneIdentifying(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUser_BIsPhoneRequiringVerification", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUser_BIsPhoneRequiringVerification(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_RequestCurrentStats", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_RequestCurrentStats(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetStat", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetStat(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      out int pData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetStat0", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetStat0(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      out float pData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_SetStat", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_SetStat(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      int nData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_SetStat0", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_SetStat0(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      float fData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_UpdateAvgRateStat", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_UpdateAvgRateStat(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      float flCountThisSession,
      double dSessionLength);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetAchievement", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetAchievement(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      out bool pbAchieved);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_SetAchievement", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_SetAchievement(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_ClearAchievement", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_ClearAchievement(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetAchievementAndUnlockTime", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetAchievementAndUnlockTime(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      out bool pbAchieved,
      out uint punUnlockTime);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_StoreStats", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_StoreStats(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetAchievementIcon", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUserStats_GetAchievementIcon(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetAchievementDisplayAttribute", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamUserStats_GetAchievementDisplayAttribute(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      InteropHelp.UTF8StringHandle pchKey);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_IndicateAchievementProgress", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_IndicateAchievementProgress(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      uint nCurProgress,
      uint nMaxProgress);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetNumAchievements", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUserStats_GetNumAchievements(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetAchievementName", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamUserStats_GetAchievementName(
      IntPtr instancePtr,
      uint iAchievement);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_RequestUserStats", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_RequestUserStats(
      IntPtr instancePtr,
      CSteamID steamIDUser);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetUserStat", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetUserStat(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      out int pData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetUserStat0", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetUserStat0(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      out float pData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetUserAchievement", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetUserAchievement(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      out bool pbAchieved);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetUserAchievementAndUnlockTime", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetUserAchievementAndUnlockTime(
      IntPtr instancePtr,
      CSteamID steamIDUser,
      InteropHelp.UTF8StringHandle pchName,
      out bool pbAchieved,
      out uint punUnlockTime);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_ResetAllStats", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_ResetAllStats(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bAchievementsToo);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_FindOrCreateLeaderboard", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_FindOrCreateLeaderboard(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchLeaderboardName,
      ELeaderboardSortMethod eLeaderboardSortMethod,
      ELeaderboardDisplayType eLeaderboardDisplayType);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_FindLeaderboard", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_FindLeaderboard(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchLeaderboardName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetLeaderboardName", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamUserStats_GetLeaderboardName(
      IntPtr instancePtr,
      SteamLeaderboard_t hSteamLeaderboard);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetLeaderboardEntryCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUserStats_GetLeaderboardEntryCount(
      IntPtr instancePtr,
      SteamLeaderboard_t hSteamLeaderboard);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetLeaderboardSortMethod", CallingConvention = CallingConvention.Cdecl)]
    public static extern ELeaderboardSortMethod ISteamUserStats_GetLeaderboardSortMethod(
      IntPtr instancePtr,
      SteamLeaderboard_t hSteamLeaderboard);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetLeaderboardDisplayType", CallingConvention = CallingConvention.Cdecl)]
    public static extern ELeaderboardDisplayType ISteamUserStats_GetLeaderboardDisplayType(
      IntPtr instancePtr,
      SteamLeaderboard_t hSteamLeaderboard);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_DownloadLeaderboardEntries", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_DownloadLeaderboardEntries(
      IntPtr instancePtr,
      SteamLeaderboard_t hSteamLeaderboard,
      ELeaderboardDataRequest eLeaderboardDataRequest,
      int nRangeStart,
      int nRangeEnd);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_DownloadLeaderboardEntriesForUsers", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_DownloadLeaderboardEntriesForUsers(
      IntPtr instancePtr,
      SteamLeaderboard_t hSteamLeaderboard,
      [In, Out] CSteamID[] prgUsers,
      int cUsers);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetDownloadedLeaderboardEntry", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetDownloadedLeaderboardEntry(
      IntPtr instancePtr,
      SteamLeaderboardEntries_t hSteamLeaderboardEntries,
      int index,
      out LeaderboardEntry_t pLeaderboardEntry,
      [In, Out] int[] pDetails,
      int cDetailsMax);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_UploadLeaderboardScore", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_UploadLeaderboardScore(
      IntPtr instancePtr,
      SteamLeaderboard_t hSteamLeaderboard,
      ELeaderboardUploadScoreMethod eLeaderboardUploadScoreMethod,
      int nScore,
      [In, Out] int[] pScoreDetails,
      int cScoreDetailsCount);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_AttachLeaderboardUGC", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_AttachLeaderboardUGC(
      IntPtr instancePtr,
      SteamLeaderboard_t hSteamLeaderboard,
      UGCHandle_t hUGC);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetNumberOfCurrentPlayers", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_GetNumberOfCurrentPlayers(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_RequestGlobalAchievementPercentages", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_RequestGlobalAchievementPercentages(
      IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetMostAchievedAchievementInfo", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUserStats_GetMostAchievedAchievementInfo(
      IntPtr instancePtr,
      IntPtr pchName,
      uint unNameBufLen,
      out float pflPercent,
      out bool pbAchieved);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetNextMostAchievedAchievementInfo", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUserStats_GetNextMostAchievedAchievementInfo(
      IntPtr instancePtr,
      int iIteratorPrevious,
      IntPtr pchName,
      uint unNameBufLen,
      out float pflPercent,
      out bool pbAchieved);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetAchievementAchievedPercent", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetAchievementAchievedPercent(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchName,
      out float pflPercent);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_RequestGlobalStats", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUserStats_RequestGlobalStats(
      IntPtr instancePtr,
      int nHistoryDays);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetGlobalStat", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetGlobalStat(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchStatName,
      out long pData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetGlobalStat0", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUserStats_GetGlobalStat0(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchStatName,
      out double pData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetGlobalStatHistory", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUserStats_GetGlobalStatHistory(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchStatName,
      [In, Out] long[] pData,
      uint cubData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUserStats_GetGlobalStatHistory0", CallingConvention = CallingConvention.Cdecl)]
    public static extern int ISteamUserStats_GetGlobalStatHistory0(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle pchStatName,
      [In, Out] double[] pData,
      uint cubData);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetSecondsSinceAppActive", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUtils_GetSecondsSinceAppActive(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetSecondsSinceComputerActive", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUtils_GetSecondsSinceComputerActive(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetConnectedUniverse", CallingConvention = CallingConvention.Cdecl)]
    public static extern EUniverse ISteamUtils_GetConnectedUniverse(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetServerRealTime", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUtils_GetServerRealTime(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetIPCountry", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamUtils_GetIPCountry(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetImageSize", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_GetImageSize(
      IntPtr instancePtr,
      int iImage,
      out uint pnWidth,
      out uint pnHeight);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetImageRGBA", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_GetImageRGBA(
      IntPtr instancePtr,
      int iImage,
      byte[] pubDest,
      int nDestBufferSize);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetCSERIPPort", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_GetCSERIPPort(
      IntPtr instancePtr,
      out uint unIP,
      out ushort usPort);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetCurrentBatteryPower", CallingConvention = CallingConvention.Cdecl)]
    public static extern byte ISteamUtils_GetCurrentBatteryPower(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetAppID", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUtils_GetAppID(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_SetOverlayNotificationPosition", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUtils_SetOverlayNotificationPosition(
      IntPtr instancePtr,
      ENotificationPosition eNotificationPosition);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_IsAPICallCompleted", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_IsAPICallCompleted(
      IntPtr instancePtr,
      SteamAPICall_t hSteamAPICall,
      out bool pbFailed);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetAPICallFailureReason", CallingConvention = CallingConvention.Cdecl)]
    public static extern ESteamAPICallFailure ISteamUtils_GetAPICallFailureReason(
      IntPtr instancePtr,
      SteamAPICall_t hSteamAPICall);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetAPICallResult", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_GetAPICallResult(
      IntPtr instancePtr,
      SteamAPICall_t hSteamAPICall,
      IntPtr pCallback,
      int cubCallback,
      int iCallbackExpected,
      out bool pbFailed);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetIPCCallCount", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUtils_GetIPCCallCount(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_SetWarningMessageHook", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUtils_SetWarningMessageHook(
      IntPtr instancePtr,
      SteamAPIWarningMessageHook_t pFunction);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_IsOverlayEnabled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_IsOverlayEnabled(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_BOverlayNeedsPresent", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_BOverlayNeedsPresent(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_CheckFileSignature", CallingConvention = CallingConvention.Cdecl)]
    public static extern ulong ISteamUtils_CheckFileSignature(
      IntPtr instancePtr,
      InteropHelp.UTF8StringHandle szFileName);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_ShowGamepadTextInput", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_ShowGamepadTextInput(
      IntPtr instancePtr,
      EGamepadTextInputMode eInputMode,
      EGamepadTextInputLineMode eLineInputMode,
      InteropHelp.UTF8StringHandle pchDescription,
      uint unCharMax,
      InteropHelp.UTF8StringHandle pchExistingText);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetEnteredGamepadTextLength", CallingConvention = CallingConvention.Cdecl)]
    public static extern uint ISteamUtils_GetEnteredGamepadTextLength(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetEnteredGamepadTextInput", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_GetEnteredGamepadTextInput(
      IntPtr instancePtr,
      IntPtr pchText,
      uint cchText);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_GetSteamUILanguage", CallingConvention = CallingConvention.Cdecl)]
    public static extern IntPtr ISteamUtils_GetSteamUILanguage(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_IsSteamRunningInVR", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_IsSteamRunningInVR(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_SetOverlayNotificationInset", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUtils_SetOverlayNotificationInset(
      IntPtr instancePtr,
      int nHorizontalInset,
      int nVerticalInset);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_IsSteamInBigPictureMode", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_IsSteamInBigPictureMode(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_StartVRDashboard", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUtils_StartVRDashboard(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_IsVRHeadsetStreamingEnabled", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamUtils_IsVRHeadsetStreamingEnabled(IntPtr instancePtr);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamUtils_SetVRHeadsetStreamingEnabled", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamUtils_SetVRHeadsetStreamingEnabled(
      IntPtr instancePtr,
      [MarshalAs(UnmanagedType.I1)] bool bEnabled);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamVideo_GetVideoURL", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamVideo_GetVideoURL(IntPtr instancePtr, AppId_t unVideoAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamVideo_IsBroadcasting", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamVideo_IsBroadcasting(IntPtr instancePtr, out int pnNumViewers);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamVideo_GetOPFSettings", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ISteamVideo_GetOPFSettings(IntPtr instancePtr, AppId_t unVideoAppID);

    [DllImport("steam_api64", EntryPoint = "SteamAPI_ISteamVideo_GetOPFStringForApp", CallingConvention = CallingConvention.Cdecl)]
    [return: MarshalAs(UnmanagedType.I1)]
    public static extern bool ISteamVideo_GetOPFStringForApp(
      IntPtr instancePtr,
      AppId_t unVideoAppID,
      IntPtr pchBuffer,
      ref int pnBufferSize);
  }
}
