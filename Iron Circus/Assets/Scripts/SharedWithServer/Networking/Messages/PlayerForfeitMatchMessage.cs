// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.PlayerForfeitMatchMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace SharedWithServer.Networking.Messages
{
  public class PlayerForfeitMatchMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.ForfeitMatch;
    public ulong playerId;
    public bool forfeit;

    public PlayerForfeitMatchMessage()
      : base(PlayerForfeitMatchMessage.Type, true)
    {
    }

    public PlayerForfeitMatchMessage(ulong playerId, bool forfeit)
      : base(PlayerForfeitMatchMessage.Type, true)
    {
      this.playerId = playerId;
      this.forfeit = forfeit;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      messageSerDes.Bool(ref this.forfeit);
    }
  }
}
