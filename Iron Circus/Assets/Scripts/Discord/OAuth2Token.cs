// Decompiled with JetBrains decompiler
// Type: Discord.OAuth2Token
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Runtime.InteropServices;

namespace Discord
{
  public struct OAuth2Token
  {
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
    public string AccessToken;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 1024)]
    public string Scopes;
    public long Expires;
  }
}
