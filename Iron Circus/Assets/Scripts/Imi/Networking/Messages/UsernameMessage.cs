// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.UsernameMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class UsernameMessage : Message
  {
    public ulong playerId;
    public string username;
    public bool isTwitchUser;
    public string twitchUsername;
    public int twitchViewerCount;

    public UsernameMessage(
      ulong playerId,
      string username,
      bool isTwitchUser,
      string twitchUsername,
      int twitchViewerCount)
      : base(RumpfieldMessageType.Username)
    {
      this.playerId = playerId;
      this.username = username;
      this.isTwitchUser = isTwitchUser;
      this.twitchUsername = twitchUsername;
      this.twitchViewerCount = twitchViewerCount;
    }

    public UsernameMessage(ulong playerId, string username)
      : base(RumpfieldMessageType.Username)
    {
      this.playerId = playerId;
      this.username = username;
    }

    public UsernameMessage()
      : base(RumpfieldMessageType.Username)
    {
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      messageSerDes.String(ref this.username);
      messageSerDes.Bool(ref this.isTwitchUser);
      messageSerDes.String(ref this.twitchUsername);
      messageSerDes.Int(ref this.twitchViewerCount);
    }
  }
}
