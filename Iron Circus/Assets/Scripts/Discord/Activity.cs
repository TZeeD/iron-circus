// Decompiled with JetBrains decompiler
// Type: Discord.Activity
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Runtime.InteropServices;

namespace Discord
{
  public struct Activity
  {
    public ActivityType Type;
    public long ApplicationId;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
    public string Name;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
    public string State;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
    public string Details;
    public ActivityTimestamps Timestamps;
    public ActivityAssets Assets;
    public ActivityParty Party;
    public ActivitySecrets Secrets;
    public bool Instance;
  }
}
