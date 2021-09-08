// Decompiled with JetBrains decompiler
// Type: Steamworks.UserStatsUnloaded_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [CallbackIdentity(1108)]
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct UserStatsUnloaded_t
  {
    public const int k_iCallback = 1108;
    public CSteamID m_steamIDUser;
  }
}
