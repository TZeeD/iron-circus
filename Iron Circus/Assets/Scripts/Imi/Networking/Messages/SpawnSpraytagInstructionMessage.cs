// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.SpawnSpraytagInstructionMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class SpawnSpraytagInstructionMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.SpawnSpraytagInstruction;
    private const int nameLength = 24;
    public int spraytagSlot;
    public ulong playerID;

    public SpawnSpraytagInstructionMessage()
      : base(SpawnSpraytagInstructionMessage.Type)
    {
    }

    public SpawnSpraytagInstructionMessage(ulong playerId, int spraySlot)
      : base(SpawnSpraytagInstructionMessage.Type)
    {
      this.playerID = playerId;
      this.spraytagSlot = spraySlot;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerID);
      messageSerDes.Int(ref this.spraytagSlot);
    }
  }
}
