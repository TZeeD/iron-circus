// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.RumbleControllerMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class RumbleControllerMessage : Message
  {
    public float duration = 1f;
    public ulong playerToRumbleId;
    public float strength = 1f;

    public RumbleControllerMessage(ulong playerToRumbleId, float strength, float duration)
      : base(RumpfieldMessageType.RumbleController)
    {
      this.playerToRumbleId = playerToRumbleId;
      this.duration = duration;
      this.strength = strength;
    }

    public RumbleControllerMessage()
      : base(RumpfieldMessageType.RumbleController)
    {
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerToRumbleId);
      messageSerDes.Float(ref this.duration);
      messageSerDes.Float(ref this.strength);
    }
  }
}
