// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamVideo
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using System.Runtime.InteropServices;

namespace Steamworks
{
  public static class SteamVideo
  {
    public static void GetVideoURL(AppId_t unVideoAppID)
    {
      InteropHelp.TestIfAvailableClient();
      NativeMethods.ISteamVideo_GetVideoURL(CSteamAPIContext.GetSteamVideo(), unVideoAppID);
    }

    public static bool IsBroadcasting(out int pnNumViewers)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamVideo_IsBroadcasting(CSteamAPIContext.GetSteamVideo(), out pnNumViewers);
    }

    public static void GetOPFSettings(AppId_t unVideoAppID)
    {
      InteropHelp.TestIfAvailableClient();
      NativeMethods.ISteamVideo_GetOPFSettings(CSteamAPIContext.GetSteamVideo(), unVideoAppID);
    }

    public static bool GetOPFStringForApp(
      AppId_t unVideoAppID,
      out string pchBuffer,
      ref int pnBufferSize)
    {
      InteropHelp.TestIfAvailableClient();
      IntPtr num = Marshal.AllocHGlobal(pnBufferSize);
      bool opfStringForApp = NativeMethods.ISteamVideo_GetOPFStringForApp(CSteamAPIContext.GetSteamVideo(), unVideoAppID, num, ref pnBufferSize);
      pchBuffer = opfStringForApp ? InteropHelp.PtrToStringUTF8(num) : (string) null;
      Marshal.FreeHGlobal(num);
      return opfStringForApp;
    }
  }
}
