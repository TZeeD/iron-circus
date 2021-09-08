// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamParentalSettings
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

namespace Steamworks
{
  public static class SteamParentalSettings
  {
    public static bool BIsParentalLockEnabled()
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamParentalSettings_BIsParentalLockEnabled(CSteamAPIContext.GetSteamParentalSettings());
    }

    public static bool BIsParentalLockLocked()
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamParentalSettings_BIsParentalLockLocked(CSteamAPIContext.GetSteamParentalSettings());
    }

    public static bool BIsAppBlocked(AppId_t nAppID)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamParentalSettings_BIsAppBlocked(CSteamAPIContext.GetSteamParentalSettings(), nAppID);
    }

    public static bool BIsAppInBlockList(AppId_t nAppID)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamParentalSettings_BIsAppInBlockList(CSteamAPIContext.GetSteamParentalSettings(), nAppID);
    }

    public static bool BIsFeatureBlocked(EParentalFeature eFeature)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamParentalSettings_BIsFeatureBlocked(CSteamAPIContext.GetSteamParentalSettings(), eFeature);
    }

    public static bool BIsFeatureInBlockList(EParentalFeature eFeature)
    {
      InteropHelp.TestIfAvailableClient();
      return NativeMethods.ISteamParentalSettings_BIsFeatureInBlockList(CSteamAPIContext.GetSteamParentalSettings(), eFeature);
    }
  }
}
