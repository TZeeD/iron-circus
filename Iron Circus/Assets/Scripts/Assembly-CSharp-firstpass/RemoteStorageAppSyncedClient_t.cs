// Decompiled with JetBrains decompiler
// Type: Steamworks.RemoteStorageAppSyncedClient_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [CallbackIdentity(1301)]
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct RemoteStorageAppSyncedClient_t
  {
    public const int k_iCallback = 1301;
    public AppId_t m_nAppID;
    public EResult m_eResult;
    public int m_unNumDownloads;
  }
}
