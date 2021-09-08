// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.CreatePlayerMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace SharedWithServer.Networking.Messages
{
  public class CreatePlayerMessage : Message
  {
    public JVector position;
    public JQuaternion rotation;
    public ulong playerId;
    public PlayerChampionData playerChampionData;

    public CreatePlayerMessage()
      : base(RumpfieldMessageType.CreatePlayerMessage, true)
    {
    }

    public CreatePlayerMessage(
      ulong playerId,
      PlayerChampionData playerChampionData,
      JVector position,
      JQuaternion rotation)
      : base(RumpfieldMessageType.CreatePlayerMessage, true)
    {
      this.playerId = playerId;
      this.playerChampionData = playerChampionData;
      this.position = position;
      this.rotation = rotation;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      byte team = (byte) this.playerChampionData.team;
      byte type = (byte) this.playerChampionData.type;
      byte skinId = (byte) this.playerChampionData.skinId;
      bool isReady = this.playerChampionData.isReady;
      bool isFakePlayer = this.playerChampionData.isFakePlayer;
      UniqueId uniqueId = this.playerChampionData.uniqueId;
      float angle2D = this.rotation.ToAngle2D();
      messageSerDes.ULong(ref this.playerId);
      messageSerDes.JVector(ref this.position);
      messageSerDes.Float(ref angle2D);
      messageSerDes.UniqueId(ref uniqueId);
      messageSerDes.Byte(ref team);
      messageSerDes.Byte(ref type);
      messageSerDes.Byte(ref skinId);
      messageSerDes.Bool(ref isReady);
      messageSerDes.Bool(ref isFakePlayer);
      if (messageSerDes.IsSerializer())
        return;
      this.playerChampionData = new PlayerChampionData()
      {
        team = (Team) team,
        type = (ChampionType) type,
        skinId = (int) skinId,
        isReady = isReady,
        isFakePlayer = isFakePlayer,
        uniqueId = uniqueId
      };
      this.rotation = JQuaternion.From2DAngle(angle2D);
    }
  }
}
