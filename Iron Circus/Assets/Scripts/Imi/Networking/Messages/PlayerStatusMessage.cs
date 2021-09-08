// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.PlayerStatusMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.Networking.Messages
{
  public class PlayerStatusMessage : Message
  {
    public ulong playerId;
    public StatusEffectComponent statusComponent;

    public PlayerStatusMessage()
      : base(RumpfieldMessageType.PlayerStunned)
    {
    }

    public PlayerStatusMessage(ulong playerId, StatusEffectComponent statusComponent)
      : base(RumpfieldMessageType.PlayerStunned)
    {
      this.playerId = playerId;
      this.statusComponent = statusComponent;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      if (messageSerDes.IsSerializer())
        this.statusComponent.Serialize(messageSerDes);
      else
        this.statusComponent = StatusEffectComponent.Deserialize(messageSerDes);
    }
  }
}
