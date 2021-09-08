// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.GameStatMatchFinishedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEvents.StatEvents;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class GameStatMatchFinishedMessage : Message
  {
    public string arena = "";
    public string matchId = "";
    public List<GameStatMatchFinishedEvent.MatchResult> matchResults = new List<GameStatMatchFinishedEvent.MatchResult>();

    public GameStatMatchFinishedMessage()
      : base(RumpfieldMessageType.MatchStats)
    {
    }

    public GameStatMatchFinishedMessage(
      string arena,
      string matchId,
      List<GameStatMatchFinishedEvent.MatchResult> matchResults)
      : base(RumpfieldMessageType.MatchStats)
    {
      this.arena = arena;
      this.matchId = matchId;
      this.matchResults = matchResults;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.String(ref this.arena);
      messageSerDes.String(ref this.matchId);
      if (messageSerDes.IsSerializer())
        this.SerializeMatchResults(messageSerDes);
      else
        this.DeserializeMatchResults(messageSerDes);
    }

    private void SerializeMatchResults(IMessageSerDes messageSerDes)
    {
      byte count = (byte) this.matchResults.Count;
      messageSerDes.Byte(ref count);
      foreach (GameStatMatchFinishedEvent.MatchResult matchResult in this.matchResults)
        GameStatMatchFinishedMessage.SerializeMatchResult(messageSerDes, matchResult);
    }

    private void DeserializeMatchResults(IMessageSerDes messageSerDes)
    {
      byte num = 0;
      messageSerDes.Byte(ref num);
      this.matchResults = new List<GameStatMatchFinishedEvent.MatchResult>();
      for (int index = 0; index < (int) num; ++index)
        this.DeserializeMatchResult(messageSerDes);
    }

    private static void SerializeMatchResult(
      IMessageSerDes messageSerDes,
      GameStatMatchFinishedEvent.MatchResult matchResult)
    {
      byte championType = (byte) matchResult.championType;
      byte team = (byte) matchResult.team;
      byte outcome = (byte) matchResult.outcome;
      messageSerDes.ULong(ref matchResult.playerId);
      messageSerDes.Byte(ref championType);
      messageSerDes.Byte(ref team);
      messageSerDes.Byte(ref outcome);
      messageSerDes.Int(ref matchResult.score);
    }

    private void DeserializeMatchResult(IMessageSerDes messageSerDes)
    {
      ulong playerId = 0;
      byte num1 = 0;
      byte num2 = 0;
      byte num3 = 0;
      int score = 0;
      messageSerDes.ULong(ref playerId);
      messageSerDes.Byte(ref num1);
      messageSerDes.Byte(ref num2);
      messageSerDes.Byte(ref num3);
      messageSerDes.Int(ref score);
      this.matchResults.Add(new GameStatMatchFinishedEvent.MatchResult(playerId, (ChampionType) num1, (Team) num2, (MatchOutcome) num3, score));
    }
  }
}
