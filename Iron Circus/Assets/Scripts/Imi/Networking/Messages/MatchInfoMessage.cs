// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.MatchInfoMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class MatchInfoMessage : Message
  {
    public string arena = "";
    public string matchId = "";
    public GameType gameType;

    public MatchInfoMessage()
      : base(RumpfieldMessageType.MatchInfo)
    {
    }

    public MatchInfoMessage(string arena, string matchId, GameType gameType)
      : base(RumpfieldMessageType.MatchInfo)
    {
      this.arena = arena;
      this.matchId = matchId;
      this.gameType = gameType;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.String(ref this.arena);
      messageSerDes.String(ref this.matchId);
      byte gameType = (byte) this.gameType;
      messageSerDes.Byte(ref gameType);
      this.gameType = (GameType) gameType;
    }
  }
}
