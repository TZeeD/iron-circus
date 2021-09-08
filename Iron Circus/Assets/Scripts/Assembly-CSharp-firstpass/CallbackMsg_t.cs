// Decompiled with JetBrains decompiler
// Type: Steamworks.CallbackMsg_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using System.Runtime.InteropServices;

namespace Steamworks
{
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct CallbackMsg_t
  {
    public int m_hSteamUser;
    public int m_iCallback;
    public IntPtr m_pubParam;
    public int m_cubParam;
  }
}
