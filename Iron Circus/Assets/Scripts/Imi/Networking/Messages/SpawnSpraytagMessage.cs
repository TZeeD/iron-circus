// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.SpawnSpraytagMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.Networking.Messages
{
  public class SpawnSpraytagMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.SpawnSpraytag;
    public int spraytagSlot;
    public ulong playerID;
    public float x;
    public float z;

    public SpawnSpraytagMessage()
      : base(SpawnSpraytagMessage.Type, true)
    {
    }

    public SpawnSpraytagMessage(ulong playerId, JVector position, int spraySlot)
      : base(SpawnSpraytagMessage.Type, true)
    {
      this.x = position.X;
      this.z = position.Z;
      this.playerID = playerId;
      this.spraytagSlot = spraySlot;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Float(ref this.x);
      messageSerDes.Float(ref this.z);
      messageSerDes.ULong(ref this.playerID);
      messageSerDes.Int(ref this.spraytagSlot);
    }
  }
}
