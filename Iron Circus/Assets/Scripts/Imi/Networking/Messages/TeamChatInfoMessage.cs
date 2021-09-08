// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.TeamChatInfoMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class TeamChatInfoMessage : Message
  {
    public string chatServerAddress;
    public string roomId;

    public TeamChatInfoMessage()
      : base(RumpfieldMessageType.TeamChatInfo)
    {
    }

    public TeamChatInfoMessage(string chatServerAddress, string roomId)
      : base(RumpfieldMessageType.TeamChatInfo)
    {
      this.chatServerAddress = chatServerAddress;
      this.roomId = roomId;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.String(ref this.chatServerAddress);
      messageSerDes.String(ref this.roomId);
    }
  }
}
