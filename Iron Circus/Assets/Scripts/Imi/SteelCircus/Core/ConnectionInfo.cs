// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Core.ConnectionInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Net;

namespace Imi.SteelCircus.Core
{
  public struct ConnectionInfo
  {
    public IPAddress ip;
    public int port;
    public string username;
    public ulong playerId;
    public byte[] connectToken;
    public string gameLiftPlayerSessionId;

    public override string ToString()
    {
      if (this.ip == null)
        return "No IP";
      return this.ip.ToString() + ":" + (object) this.port + "\nuser: " + this.username + "\nplayerID: " + (object) this.playerId + "\nGameLift: " + this.gameLiftPlayerSessionId;
    }
  }
}
