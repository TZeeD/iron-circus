// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.TrackingEventMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.ScEvents;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class TrackingEventMessage : Message
  {
    public ulong playerId;
    public Statistics statistics;
    public float value;

    public TrackingEventMessage()
      : base(RumpfieldMessageType.TrackingEvent, true)
    {
    }

    public TrackingEventMessage(ulong playerId, Statistics type, float value)
      : base(RumpfieldMessageType.TrackingEvent, true)
    {
      this.playerId = playerId;
      this.statistics = type;
      this.value = value;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      byte statistics = (byte) this.statistics;
      messageSerDes.Byte(ref statistics);
      this.statistics = (Statistics) statistics;
      messageSerDes.Float(ref this.value);
    }
  }
}
