// Decompiled with JetBrains decompiler
// Type: Steamworks.RemoteStorageFileReadAsyncComplete_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [CallbackIdentity(1332)]
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct RemoteStorageFileReadAsyncComplete_t
  {
    public const int k_iCallback = 1332;
    public SteamAPICall_t m_hFileReadAsync;
    public EResult m_eResult;
    public uint m_nOffset;
    public uint m_cubRead;
  }
}
