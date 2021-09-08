// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.QuickChatMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace SharedWithServer.Networking.Messages
{
  public class QuickChatMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.QuickChatMessage;
    public ulong PlayerId;
    public int MsgType;

    public QuickChatMessage()
      : base(QuickChatMessage.Type, true)
    {
    }

    public QuickChatMessage(ulong playerId, int msg)
      : base(QuickChatMessage.Type, true)
    {
      this.PlayerId = playerId;
      this.MsgType = msg;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.PlayerId);
      messageSerDes.Int(ref this.MsgType);
    }
  }
}
