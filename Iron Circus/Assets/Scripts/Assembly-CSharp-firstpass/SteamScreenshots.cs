// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamScreenshots
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

namespace Steamworks
{
  public static class SteamScreenshots
  {
    public static ScreenshotHandle WriteScreenshot(
      byte[] pubRGB,
      uint cubRGB,
      int nWidth,
      int nHeight)
    {
      InteropHelp.TestIfAvailableClient();
      return (ScreenshotHandle) NativeMethods.ISteamScreenshots_WriteScreenshot(CSteamAPIContext.GetSteamScreenshots(), pubRGB, cubRGB, nWidth, nHeight);
    }

    public static ScreenshotHandle AddScreenshotToLibrary(
      string pchFilename,
      string pchThumbnailFilename,
      int nWidth,
      int nHeight)
    {
      InteropHelp.TestIfAvailableClient();
      using (InteropHelp.UTF8StringHandle pchFilename1 = new InteropHelp.UTF8StringHandle(pchFilename))
      {
        using (InteropHelp.UTF8StringHandle pchThumbnailFilename1 = new InteropHelp.UTF8StringHandle(pchThumbnailFilename))
          return (ScreenshotHandle) NativeMethods.ISteamScreenshots_AddScreenshotToLibrary(CSteamAPIContext.GetSteamScreenshots(), pchFilename1, pchThumbnailFilename1, nWidth, nHeight);
      }
    }

    public static void TriggerScreenshot()
    {
      InteropHelp.TestIfAvailableClient();
      NativeMethods.ISteamScreenshots_TriggerScreenshot(CSteamAPIContext.GetSteamScreenshots());
    }

    public static void HookScreenshots(bool bHook)
    {
      InteropHelp.TestIfAvailableClient();
      NativeMethods.ISteamScreenshots_HookScreenshots(CSteamAPIContext.GetSteamScreenshots(), bHook);
    }

    public static bool SetLocation(ScreenshotHandle hScreenshot, string pchLocation)
    {
      InteropHelp.TestIfAvailableClient();
      using (InteropHelp.UTF8StringHandle pchLocation1 = new InteropHelp.UTF8StringHandle(pchLocation))
        return NativeMethods.ISteamScreenshots_SetLocation(CSteamAPIContext.GetSteamScreenshots(), hScreenshot, pchLocation1);
    }

    public static bool TagUser(ScreenshotHandle hScreenshot, CSteamID steamID)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamScreenshots_TagUser(CSteamAPIContext.GetSteamScreenshots(), hScreenshot, steamID);
    }

    public static bool TagPublishedFile(
      ScreenshotHandle hScreenshot,
      PublishedFileId_t unPublishedFileID)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamScreenshots_TagPublishedFile(CSteamAPIContext.GetSteamScreenshots(), hScreenshot, unPublishedFileID);
    }

    public static bool IsScreenshotsHooked()
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamScreenshots_IsScreenshotsHooked(CSteamAPIContext.GetSteamScreenshots());
    }

    public static ScreenshotHandle AddVRScreenshotToLibrary(
      EVRScreenshotType eType,
      string pchFilename,
      string pchVRFilename)
    {
      InteropHelp.TestIfAvailableClient();
      using (InteropHelp.UTF8StringHandle pchFilename1 = new InteropHelp.UTF8StringHandle(pchFilename))
      {
        using (InteropHelp.UTF8StringHandle pchVRFilename1 = new InteropHelp.UTF8StringHandle(pchVRFilename))
          return (ScreenshotHandle) NativeMethods.ISteamScreenshots_AddVRScreenshotToLibrary(CSteamAPIContext.GetSteamScreenshots(), eType, pchFilename1, pchVRFilename1);
      }
    }
  }
}
