// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamAPI
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

namespace Steamworks
{
  public static class SteamAPI
  {
    public static bool Init()
    {
      InteropHelp.TestIfPlatformSupported();
      bool flag = NativeMethods.SteamAPI_Init();
      if (flag)
        flag = CSteamAPIContext.Init();
      return flag;
    }

    public static void Shutdown()
    {
      InteropHelp.TestIfPlatformSupported();
      NativeMethods.SteamAPI_Shutdown();
    }

    public static bool RestartAppIfNecessary(AppId_t unOwnAppID)
    {
      InteropHelp.TestIfPlatformSupported();
      return NativeMethods.SteamAPI_RestartAppIfNecessary(unOwnAppID);
    }

    public static void ReleaseCurrentThreadMemory()
    {
      InteropHelp.TestIfPlatformSupported();
      NativeMethods.SteamAPI_ReleaseCurrentThreadMemory();
    }

    public static void RunCallbacks()
    {
      InteropHelp.TestIfPlatformSupported();
      NativeMethods.SteamAPI_RunCallbacks();
    }

    public static bool IsSteamRunning()
    {
      InteropHelp.TestIfPlatformSupported();
      return NativeMethods.SteamAPI_IsSteamRunning();
    }

    public static HSteamUser GetHSteamUserCurrent()
    {
      InteropHelp.TestIfPlatformSupported();
      return (HSteamUser) NativeMethods.Steam_GetHSteamUserCurrent();
    }

    public static HSteamPipe GetHSteamPipe()
    {
      InteropHelp.TestIfPlatformSupported();
      return (HSteamPipe) NativeMethods.SteamAPI_GetHSteamPipe();
    }

    public static HSteamUser GetHSteamUser()
    {
      InteropHelp.TestIfPlatformSupported();
      return (HSteamUser) NativeMethods.SteamAPI_GetHSteamUser();
    }
  }
}
