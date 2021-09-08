// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.ForfeitMatchOverMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class ForfeitMatchOverMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.ForfeitMatchOver;
    public ulong playerId;
    public Team team;

    public ForfeitMatchOverMessage()
      : base(ForfeitMatchOverMessage.Type, true)
    {
    }

    public ForfeitMatchOverMessage(ulong playerId, Team team)
      : base(ForfeitMatchOverMessage.Type, true)
    {
      this.playerId = playerId;
      this.team = team;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      byte team = (byte) this.team;
      messageSerDes.Byte(ref team);
      this.team = (Team) team;
    }
  }
}
