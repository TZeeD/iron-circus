// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.PlayerChampionData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using System;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public struct PlayerChampionData : IEquatable<PlayerChampionData>
  {
    public static readonly PlayerChampionData Default = new PlayerChampionData()
    {
      team = Team.None,
      type = ChampionType.Invalid,
      skinId = 0,
      uniqueId = UniqueId.Invalid,
      isReady = false,
      isFakePlayer = false
    };
    public Team team;
    public ChampionType type;
    public int skinId;
    public bool isReady;
    public bool isFakePlayer;
    public UniqueId uniqueId;

    public override string ToString() => string.Format("Team [{0}], Type [{1}] uId [{2}]", (object) this.team, (object) this.type, (object) this.uniqueId);

    public PlayerChampionData(
      ChampionType type,
      int skinId,
      Team team,
      bool isReady,
      bool isFakePlayer,
      UniqueId uniqueId)
    {
      this.type = type;
      this.skinId = skinId;
      this.team = team;
      this.isReady = isReady;
      this.isFakePlayer = isFakePlayer;
      this.uniqueId = uniqueId;
    }

    public void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      byte team = (byte) this.team;
      messageSerDes.Byte(ref team);
      this.team = (Team) team;
      byte type = (byte) this.type;
      messageSerDes.Byte(ref type);
      this.type = (ChampionType) type;
      byte skinId = (byte) this.skinId;
      messageSerDes.Byte(ref skinId);
      this.skinId = (int) skinId;
      messageSerDes.Bool(ref this.isReady);
      messageSerDes.Bool(ref this.isFakePlayer);
      messageSerDes.UniqueId(ref this.uniqueId);
    }

    public bool Equals(PlayerChampionData other) => this.team == other.team && this.type == other.type && this.skinId == other.skinId && this.isReady == other.isReady && this.isFakePlayer == other.isFakePlayer && this.uniqueId.Equals(other.uniqueId);

    public override bool Equals(object obj) => obj != null && obj is PlayerChampionData other && this.Equals(other);

    public override int GetHashCode() => ((((int) ((ChampionType) ((int) this.team * 397) ^ this.type) * 397 ^ this.skinId) * 397 ^ this.isReady.GetHashCode()) * 397 ^ this.isFakePlayer.GetHashCode()) * 397 ^ this.uniqueId.GetHashCode();
  }
}
