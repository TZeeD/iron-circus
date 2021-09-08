// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.GameLiftPlayerSessionMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class GameLiftPlayerSessionMessage : Message
  {
    public string playerSessionId = "";

    public GameLiftPlayerSessionMessage()
      : base(RumpfieldMessageType.GameLiftPlayerSession)
    {
    }

    public GameLiftPlayerSessionMessage(string playerSessionId)
      : base(RumpfieldMessageType.GameLiftPlayerSession)
    {
      this.playerSessionId = playerSessionId;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes) => messageSerDes.String(ref this.playerSessionId);
  }
}
