// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.PlayerFinishedPickingMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class PlayerFinishedPickingMessage : Message
  {
    public ulong playerId;
    public ChampionType type;

    public PlayerFinishedPickingMessage()
      : base(RumpfieldMessageType.PlayerFinishedPicking, true)
    {
    }

    public PlayerFinishedPickingMessage(ulong playerId, ChampionType type)
      : base(RumpfieldMessageType.PlayerFinishedPicking, true)
    {
      this.playerId = playerId;
      this.type = type;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      byte type = (byte) this.type;
      messageSerDes.Byte(ref type);
      this.type = (ChampionType) type;
    }
  }
}
