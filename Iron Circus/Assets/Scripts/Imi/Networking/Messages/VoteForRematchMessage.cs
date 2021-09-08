// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.VoteForRematchMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class VoteForRematchMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.VoteForRematch;
    public ulong playerId;
    public bool wantsRematch;

    public VoteForRematchMessage()
      : base(VoteForRematchMessage.Type, true)
    {
    }

    public VoteForRematchMessage(ulong playerId, bool wantsRematch)
      : base(VoteForRematchMessage.Type, true)
    {
      this.playerId = playerId;
      this.wantsRematch = wantsRematch;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      messageSerDes.Bool(ref this.wantsRematch);
    }
  }
}
