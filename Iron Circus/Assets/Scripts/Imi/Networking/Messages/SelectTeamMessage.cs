// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.SelectTeamMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class SelectTeamMessage : Message
  {
    public Team team;

    public SelectTeamMessage()
      : base(RumpfieldMessageType.SelectTeam)
    {
      this.team = Team.None;
    }

    public SelectTeamMessage(Team team)
      : base(RumpfieldMessageType.SelectTeam)
    {
      this.team = team;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      byte team = (byte) this.team;
      messageSerDes.Byte(ref team);
      this.team = (Team) team;
    }
  }
}
