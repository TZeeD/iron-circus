// Decompiled with JetBrains decompiler
// Type: ClockStone.Playlist
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace ClockStone
{
  [Serializable]
  public class Playlist
  {
    public string name;
    public string[] playlistItems;

    public Playlist()
    {
      this.name = "Default";
      this.playlistItems = (string[]) null;
    }

    public Playlist(string name, string[] playlistItems)
    {
      this.name = name;
      this.playlistItems = playlistItems;
    }
  }
}
