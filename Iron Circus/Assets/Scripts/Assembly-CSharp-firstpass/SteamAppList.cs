// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamAppList
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using System.Runtime.InteropServices;

namespace Steamworks
{
  public static class SteamAppList
  {
    public static uint GetNumInstalledApps()
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamAppList_GetNumInstalledApps(CSteamAPIContext.GetSteamAppList());
    }

    public static uint GetInstalledApps(AppId_t[] pvecAppID, uint unMaxAppIDs)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamAppList_GetInstalledApps(CSteamAPIContext.GetSteamAppList(), pvecAppID, unMaxAppIDs);
    }

    public static int GetAppName(AppId_t nAppID, out string pchName, int cchNameMax)
    {
      InteropHelp.TestIfAvailableClient();
      IntPtr num = Marshal.AllocHGlobal(cchNameMax);
      int appName = NativeMethods.ISteamAppList_GetAppName(CSteamAPIContext.GetSteamAppList(), nAppID, num, cchNameMax);
      pchName = appName != -1 ? InteropHelp.PtrToStringUTF8(num) : (string) null;
      Marshal.FreeHGlobal(num);
      return appName;
    }

    public static int GetAppInstallDir(AppId_t nAppID, out string pchDirectory, int cchNameMax)
    {
      InteropHelp.TestIfAvailableClient();
      IntPtr num = Marshal.AllocHGlobal(cchNameMax);
      int appInstallDir = NativeMethods.ISteamAppList_GetAppInstallDir(CSteamAPIContext.GetSteamAppList(), nAppID, num, cchNameMax);
      pchDirectory = appInstallDir != -1 ? InteropHelp.PtrToStringUTF8(num) : (string) null;
      Marshal.FreeHGlobal(num);
      return appInstallDir;
    }

    public static int GetAppBuildId(AppId_t nAppID)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamAppList_GetAppBuildId(CSteamAPIContext.GetSteamAppList(), nAppID);
    }
  }
}
