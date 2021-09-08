// Decompiled with JetBrains decompiler
// Type: Steamworks.CCallbackBase
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using System.Runtime.InteropServices;

namespace Steamworks
{
  [StructLayout(LayoutKind.Sequential)]
  internal class CCallbackBase
  {
    public const byte k_ECallbackFlagsRegistered = 1;
    public const byte k_ECallbackFlagsGameServer = 2;
    public IntPtr m_vfptr;
    public byte m_nCallbackFlags;
    public int m_iCallback;
  }
}
