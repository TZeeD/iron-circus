// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.ChampionSelectionChangedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class ChampionSelectionChangedMessage : Message
  {
    public PlayerChampionData playerChampionData;

    public ChampionSelectionChangedMessage()
      : base(RumpfieldMessageType.PlayerSelectedChampion)
    {
    }

    public ChampionSelectionChangedMessage(PlayerChampionData playerChampionData)
      : base(RumpfieldMessageType.PlayerSelectedChampion)
    {
      this.playerChampionData = playerChampionData;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes) => this.playerChampionData.SerializeOrDeserialize(messageSerDes);
  }
}
