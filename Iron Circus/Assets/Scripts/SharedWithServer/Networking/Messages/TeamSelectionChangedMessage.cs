// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.TeamSelectionChangedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace SharedWithServer.Networking.Messages
{
  public class TeamSelectionChangedMessage : Message
  {
    public Team SelectedTeam;

    public TeamSelectionChangedMessage()
      : base(RumpfieldMessageType.PlayerSelectedTeam)
    {
    }

    public TeamSelectionChangedMessage(Team selectedTeam)
      : base(RumpfieldMessageType.PlayerSelectedTeam)
    {
      this.SelectedTeam = selectedTeam;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      byte selectedTeam = (byte) this.SelectedTeam;
      messageSerDes.Byte(ref selectedTeam);
      this.SelectedTeam = (Team) selectedTeam;
    }
  }
}
