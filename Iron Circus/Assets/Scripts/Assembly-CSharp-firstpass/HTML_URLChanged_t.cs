// Decompiled with JetBrains decompiler
// Type: Steamworks.HTML_URLChanged_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [CallbackIdentity(4505)]
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct HTML_URLChanged_t
  {
    public const int k_iCallback = 4505;
    public HHTMLBrowser unBrowserHandle;
    public string pchURL;
    public string pchPostData;
    [MarshalAs(UnmanagedType.I1)]
    public bool bIsRedirect;
    public string pchPageTitle;
    [MarshalAs(UnmanagedType.I1)]
    public bool bNewNavigation;
  }
}
