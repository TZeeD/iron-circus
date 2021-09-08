// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.PlayersVoteUpdateMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using System.Collections.Generic;

namespace Imi.Networking.Messages
{
  public class PlayersVoteUpdateMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.PlayersVoteUpdate;
    public Dictionary<ulong, int> PlayerVotes = new Dictionary<ulong, int>();

    public PlayersVoteUpdateMessage()
      : base(PlayersVoteUpdateMessage.Type)
    {
    }

    public PlayersVoteUpdateMessage(Dictionary<ulong, int> playerVotes)
      : base(PlayersVoteUpdateMessage.Type)
    {
      this.PlayerVotes = playerVotes;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      if (messageSerDes.IsSerializer())
        this.SerializeDictionaryPairs(messageSerDes);
      else
        this.DeserializeDictionaryPairs(messageSerDes);
    }

    private void DeserializeDictionaryPairs(IMessageSerDes messageSerDes)
    {
      byte num = 0;
      messageSerDes.Byte(ref num);
      this.PlayerVotes = new Dictionary<ulong, int>();
      for (int index = 0; index < (int) num; ++index)
        this.DeserializeDictionaryPair(messageSerDes);
    }

    private void DeserializeDictionaryPair(IMessageSerDes messageSerDes)
    {
      ulong key = 0;
      int num = 0;
      messageSerDes.ULong(ref key);
      messageSerDes.Int(ref num);
      this.PlayerVotes.Add(key, num);
    }

    private void SerializeDictionaryPairs(IMessageSerDes messageSerDes)
    {
      byte count = (byte) this.PlayerVotes.Count;
      messageSerDes.Byte(ref count);
      foreach (KeyValuePair<ulong, int> playerVote in this.PlayerVotes)
        this.SerializeDictionaryPair(messageSerDes, playerVote);
    }

    private void SerializeDictionaryPair(
      IMessageSerDes messageSerDes,
      KeyValuePair<ulong, int> pair)
    {
      ulong key = pair.Key;
      int num = pair.Value;
      messageSerDes.ULong(ref key);
      messageSerDes.Int(ref num);
    }
  }
}
