// Decompiled with JetBrains decompiler
// Type: Imi.ScEntitas.PreMatchChangedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;
using System.Collections.Generic;

namespace Imi.ScEntitas
{
  public class PreMatchChangedMessage : Message
  {
    public Dictionary<ulong, PlayerChampionData> preMatchData;
    public float matchStartCountdown;
    public LobbyState lobbyState;
    public bool startGame;

    public PreMatchChangedMessage(
      Dictionary<ulong, PlayerChampionData> preMatchData,
      LobbyState lobbyState,
      bool startGame = false,
      float matchStartCountdown = -1f)
      : base(RumpfieldMessageType.PreMatchDataChanged)
    {
      this.preMatchData = preMatchData;
      this.startGame = startGame;
      this.lobbyState = lobbyState;
      this.matchStartCountdown = matchStartCountdown;
    }

    public PreMatchChangedMessage()
      : base(RumpfieldMessageType.PreMatchDataChanged)
    {
      this.preMatchData = new Dictionary<ulong, PlayerChampionData>();
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Float(ref this.matchStartCountdown);
      byte lobbyState = (byte) this.lobbyState;
      messageSerDes.Byte(ref lobbyState);
      this.lobbyState = (LobbyState) lobbyState;
      messageSerDes.Bool(ref this.startGame);
      if (messageSerDes.IsSerializer())
        this.Serialize(messageSerDes);
      else
        this.Deserialize(messageSerDes);
    }

    private void Serialize(IMessageSerDes messageSerDes)
    {
      byte count = (byte) this.preMatchData.Count;
      messageSerDes.Byte(ref count);
      foreach (KeyValuePair<ulong, PlayerChampionData> keyValuePair in this.preMatchData)
      {
        ulong key = keyValuePair.Key;
        byte team = (byte) keyValuePair.Value.team;
        byte type = (byte) keyValuePair.Value.type;
        byte skinId = (byte) keyValuePair.Value.skinId;
        bool isReady = keyValuePair.Value.isReady;
        bool isFakePlayer = keyValuePair.Value.isFakePlayer;
        UniqueId uniqueId = keyValuePair.Value.uniqueId;
        messageSerDes.ULong(ref key);
        messageSerDes.UniqueId(ref uniqueId);
        messageSerDes.Byte(ref team);
        messageSerDes.Byte(ref type);
        messageSerDes.Byte(ref skinId);
        messageSerDes.Bool(ref isReady);
        messageSerDes.Bool(ref isFakePlayer);
      }
    }

    private void Deserialize(IMessageSerDes messageSerDes)
    {
      byte num1 = 0;
      messageSerDes.Byte(ref num1);
      this.preMatchData = new Dictionary<ulong, PlayerChampionData>();
      for (int index = 0; index < (int) num1; ++index)
      {
        ulong key = 0;
        byte num2 = 0;
        byte num3 = 0;
        byte num4 = 0;
        bool flag1 = false;
        bool flag2 = false;
        UniqueId invalid = UniqueId.Invalid;
        messageSerDes.ULong(ref key);
        messageSerDes.UniqueId(ref invalid);
        messageSerDes.Byte(ref num4);
        messageSerDes.Byte(ref num2);
        messageSerDes.Byte(ref num3);
        messageSerDes.Bool(ref flag1);
        messageSerDes.Bool(ref flag2);
        Team team = (Team) num4;
        ChampionType championType = (ChampionType) num2;
        PlayerChampionData playerChampionData = new PlayerChampionData()
        {
          team = team,
          type = championType,
          skinId = (int) num3,
          isReady = flag1,
          isFakePlayer = flag2,
          uniqueId = invalid
        };
        this.preMatchData.Add(key, playerChampionData);
      }
    }
  }
}
