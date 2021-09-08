// Decompiled with JetBrains decompiler
// Type: Steamworks.GSClientDeny_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [CallbackIdentity(202)]
  [StructLayout(LayoutKind.Sequential, Pack = 4)]
  public struct GSClientDeny_t
  {
    public const int k_iCallback = 202;
    public CSteamID m_SteamID;
    public EDenyReason m_eDenyReason;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
    public string m_rgchOptionalText;
  }
}
