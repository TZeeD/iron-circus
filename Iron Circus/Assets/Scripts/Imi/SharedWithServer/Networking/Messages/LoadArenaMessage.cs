// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.LoadArenaMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class LoadArenaMessage : Message
  {
    public string arenaName = "";
    public int numPlayers;

    public LoadArenaMessage()
      : base(RumpfieldMessageType.LoadArena)
    {
    }

    public LoadArenaMessage(string arenaName, int numPlayers)
      : base(RumpfieldMessageType.LoadArena)
    {
      this.arenaName = arenaName;
      this.numPlayers = numPlayers;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Int(ref this.numPlayers);
      messageSerDes.String(ref this.arenaName);
    }
  }
}
