// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.SimpleDeltaInputMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class SimpleDeltaInputMessage : Message
  {
    public int clientTick;
    public int serverTick;
    public TickInput inputTickMinus2;
    public TickInput inputTickMinus1;
    public TickInput inputTick;
    public TickInput inputTickPlus1;
    public TickInput inputTickPlus2;
    public TickInput inputTickPlus3;
    public TickInput inputTickPlus4;

    public SimpleDeltaInputMessage()
      : base(RumpfieldMessageType.Input_SimpleDelta)
    {
    }

    public SimpleDeltaInputMessage(
      int clientTick,
      int serverTick,
      TickInput inputTickMinus2,
      TickInput inputTickMinus1,
      TickInput inputTick,
      TickInput inputTickPlus1,
      TickInput inputTickPlus2,
      TickInput inputTickPlus3,
      TickInput inputTickPlus4)
      : base(RumpfieldMessageType.Input_SimpleDelta)
    {
      this.clientTick = clientTick;
      this.serverTick = serverTick;
      this.inputTickMinus2 = inputTickMinus2;
      this.inputTickMinus1 = inputTickMinus1;
      this.inputTick = inputTick;
      this.inputTickPlus1 = inputTickPlus1;
      this.inputTickPlus2 = inputTickPlus2;
      this.inputTickPlus3 = inputTickPlus3;
      this.inputTickPlus4 = inputTickPlus4;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Int(ref this.clientTick);
      messageSerDes.Int(ref this.serverTick);
      this.inputTickMinus2.SerializeOrDeserialize(messageSerDes);
      this.inputTickMinus1.SerializeOrDeserialize(messageSerDes);
      this.inputTick.SerializeOrDeserialize(messageSerDes);
      this.inputTickPlus1.SerializeOrDeserialize(messageSerDes);
      this.inputTickPlus2.SerializeOrDeserialize(messageSerDes);
      this.inputTickPlus3.SerializeOrDeserialize(messageSerDes);
      this.inputTickPlus4.SerializeOrDeserialize(messageSerDes);
    }
  }
}
