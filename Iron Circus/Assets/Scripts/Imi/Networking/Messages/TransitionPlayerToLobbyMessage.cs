// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.TransitionPlayerToLobbyMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class TransitionPlayerToLobbyMessage : Message
  {
    public ulong PlayerId;

    public TransitionPlayerToLobbyMessage()
      : base(RumpfieldMessageType.TransitionPlayerToLobby, true)
    {
    }

    public TransitionPlayerToLobbyMessage(ulong playerId)
      : base(RumpfieldMessageType.TransitionPlayerToLobby, true)
    {
      this.PlayerId = playerId;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes) => messageSerDes.ULong(ref this.PlayerId);
  }
}
