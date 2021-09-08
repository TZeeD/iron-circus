// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.ScoreMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class ScoreMessage : Message
  {
    public Dictionary<Team, int> score;
    public ulong playerId;
    public Team lastTeamThatScored;
    public bool isReset;

    public ScoreMessage()
      : base(RumpfieldMessageType.Score)
    {
      this.score = TeamExtensions.TeamWithIntegers();
    }

    public ScoreMessage(
      Team lastTeamThatScored,
      ulong playerId,
      Dictionary<Team, int> score,
      bool isReset)
      : base(RumpfieldMessageType.Score)
    {
      this.lastTeamThatScored = lastTeamThatScored;
      this.playerId = playerId;
      this.score = score;
      this.isReset = isReset;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Bool(ref this.isReset);
      if (this.isReset)
        return;
      byte lastTeamThatScored = (byte) this.lastTeamThatScored;
      byte score1 = (byte) TeamExtensions.GetScore(this.score, Team.None);
      byte score2 = (byte) TeamExtensions.GetScore(this.score, Team.Alpha);
      byte score3 = (byte) TeamExtensions.GetScore(this.score, Team.Beta);
      messageSerDes.Byte(ref lastTeamThatScored);
      messageSerDes.ULong(ref this.playerId);
      messageSerDes.Byte(ref score1);
      messageSerDes.Byte(ref score2);
      messageSerDes.Byte(ref score3);
      this.lastTeamThatScored = (Team) lastTeamThatScored;
      this.score[Team.None] = (int) score1;
      this.score[Team.Alpha] = (int) score2;
      this.score[Team.Beta] = (int) score3;
    }
  }
}
