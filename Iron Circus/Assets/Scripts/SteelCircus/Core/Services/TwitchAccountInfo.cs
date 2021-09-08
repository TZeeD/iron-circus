// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.TwitchAccountInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace SteelCircus.Core.Services
{
  public class TwitchAccountInfo
  {
    public ulong playerId;
    public string twitchAccountName;
    public string twitchDisplayName;
    public bool showViewerCount;
    public int viewerCount;

    public TwitchAccountInfo(
      ulong playerId,
      string twitchAccountName,
      string twitchDisplayName,
      bool showViewerCount,
      int viewerCount)
    {
      this.playerId = playerId;
      this.twitchAccountName = twitchAccountName;
      this.twitchDisplayName = twitchDisplayName;
      this.showViewerCount = showViewerCount;
      this.viewerCount = viewerCount;
    }
  }
}
