// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.VoteForMvpMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class VoteForMvpMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.VoteForMvp;
    public ulong playerId;
    public ulong votedForPlayerId;

    public VoteForMvpMessage()
      : base(VoteForMvpMessage.Type, true)
    {
    }

    public VoteForMvpMessage(ulong playerId, ulong votedForPlayerId)
      : base(VoteForMvpMessage.Type, true)
    {
      this.playerId = playerId;
      this.votedForPlayerId = votedForPlayerId;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      messageSerDes.ULong(ref this.votedForPlayerId);
    }
  }
}
