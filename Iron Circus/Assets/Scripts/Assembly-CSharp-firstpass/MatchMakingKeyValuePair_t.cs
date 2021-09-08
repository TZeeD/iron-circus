// Decompiled with JetBrains decompiler
// Type: Steamworks.MatchMakingKeyValuePair_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  public struct MatchMakingKeyValuePair_t
  {
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]
    public string m_szKey;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]
    public string m_szValue;

    private MatchMakingKeyValuePair_t(string strKey, string strValue)
    {
      this.m_szKey = strKey;
      this.m_szValue = strValue;
    }
  }
}
