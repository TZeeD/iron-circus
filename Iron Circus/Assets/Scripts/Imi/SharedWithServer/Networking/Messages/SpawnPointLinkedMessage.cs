// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SpawnPointLinkedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class SpawnPointLinkedMessage : Message
  {
    public int matchType;
    public ulong playerId;
    public Team team;
    public UniqueId uniqueId;

    public SpawnPointLinkedMessage()
      : base(RumpfieldMessageType.SpawnPointLinked, true)
    {
    }

    public SpawnPointLinkedMessage(int matchType, ulong playerId, Team team, UniqueId uniqueId)
      : base(RumpfieldMessageType.SpawnPointLinked, true)
    {
      this.matchType = matchType;
      this.playerId = playerId;
      this.team = team;
      this.uniqueId = uniqueId;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      byte team = (byte) this.team;
      messageSerDes.Int(ref this.matchType);
      messageSerDes.ULong(ref this.playerId);
      messageSerDes.Byte(ref team);
      this.team = (Team) team;
      messageSerDes.UniqueId(ref this.uniqueId);
    }
  }
}
