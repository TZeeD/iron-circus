// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.DeltaCompressedInputMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.Utils;
using System.Collections.Generic;

namespace Imi.Networking.Messages
{
  public class DeltaCompressedInputMessage : Message
  {
    private byte future = 5;
    private byte past = 5;
    private byte[] data;
    private uint tick;
    private uint combined;
    private List<Input> inputs;
    private int count;
    private uint lastAckServerTick;

    public uint Tick => this.tick;

    public byte Past => this.past;

    public byte Future => this.future;

    public List<Input> Inputs => this.inputs;

    public uint LastAckServerTick => this.lastAckServerTick;

    public byte[] Data => this.data;

    public DeltaCompressedInputMessage()
      : base(RumpfieldMessageType.DeltaInput)
    {
      this.count = 0;
    }

    public DeltaCompressedInputMessage(List<Input> inputs, uint tick, uint lastAckServerTick)
      : base(RumpfieldMessageType.DeltaInput)
    {
      if (inputs.Count == 0)
        return;
      this.data = new byte[inputs.Count * 4];
      this.tick = tick;
      this.inputs = inputs;
      this.lastAckServerTick = lastAckServerTick;
      BitWriter8 bitWriter8 = new BitWriter8();
      bitWriter8.Start(this.data);
      Log.Error("DeltaCompressedInputMessage currently not working");
      uint num1 = 0;
      uint num2 = 0;
      if (inputs.Count > 1)
        bitWriter8.WriteBits(1U, 1);
      else
        bitWriter8.WriteBits(0U, 1);
      bitWriter8.WriteBits(num1, 9);
      bitWriter8.WriteBits(num2, 4);
      bitWriter8.WriteBits((uint) (byte) inputs[0].downButtons, 8);
      for (int index = 1; index < inputs.Count; ++index)
      {
        Input input1 = inputs[index - 1];
        Input input2 = inputs[index];
        uint num3 = 0;
        uint num4 = 0;
        if (index < inputs.Count - 1)
          bitWriter8.WriteBits(1U, 1);
        else
          bitWriter8.WriteBits(0U, 1);
        uint num5 = (int) num1 == (int) num3 ? 1U : 0U;
        uint num6 = (int) num2 == (int) num4 ? 1U : 0U;
        uint num7 = input1.downButtons == input2.downButtons ? 1U : 0U;
        bitWriter8.WriteBits(num5, 1);
        bitWriter8.WriteBits(num6, 1);
        bitWriter8.WriteBits(num7, 1);
        if (num5 == 0U)
          bitWriter8.WriteBits(num3, 9);
        if (num6 == 0U)
          bitWriter8.WriteBits(num4, 4);
        if (num7 == 0U)
          bitWriter8.WriteBits((uint) (byte) input2.downButtons, 8);
        num2 = num4;
        num1 = num3;
      }
      bitWriter8.Finish();
      this.count = bitWriter8.GetBytesWritten();
      this.combined = (uint) ((ulong) (this.count << 26) + (ulong) tick);
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      if (messageSerDes.IsSerializer())
      {
        messageSerDes.UInt(ref this.tick);
        messageSerDes.UInt(ref this.lastAckServerTick);
        messageSerDes.UInt(ref this.combined);
        messageSerDes.Byte(ref this.future);
        messageSerDes.Byte(ref this.past);
        for (int index = 0; index < this.count; ++index)
          messageSerDes.Byte(ref this.data[index]);
      }
      else
      {
        messageSerDes.UInt(ref this.tick);
        messageSerDes.UInt(ref this.lastAckServerTick);
        messageSerDes.UInt(ref this.combined);
        messageSerDes.Byte(ref this.future);
        messageSerDes.Byte(ref this.past);
        this.count = (int) (this.combined >> 26);
        this.tick = this.combined & 67108863U;
        this.data = new byte[this.count];
        for (int index = 0; index < this.count; ++index)
          messageSerDes.Byte(ref this.data[index]);
        this.ReadByteData(ref this.data);
      }
    }

    private void ReadByteData(ref byte[] data)
    {
      BitReader8 bitReader8 = new BitReader8();
      this.inputs = new List<Input>(10);
      bitReader8.Start(data);
      bool flag1 = bitReader8.ReadBits(1) == 1U;
      uint num1 = bitReader8.ReadBits(9);
      uint num2 = bitReader8.ReadBits(4);
      uint num3 = bitReader8.ReadBits(8);
      Log.Error("DeltaCompressedInputMessage currently not working");
      while (flag1)
      {
        flag1 = bitReader8.ReadBits(1) == 1U;
        bool flag2 = bitReader8.ReadBits(1) == 1U;
        bool flag3 = bitReader8.ReadBits(1) == 1U;
        int num4 = bitReader8.ReadBits(1) == 1U ? 1 : 0;
        uint num5 = !flag2 ? bitReader8.ReadBits(9) : num1;
        uint num6 = !flag3 ? bitReader8.ReadBits(4) : num2;
        uint num7 = num4 == 0 ? bitReader8.ReadBits(8) : num3;
        num1 = num5;
        num2 = num6;
        num3 = num7;
      }
      bitReader8.Finish();
    }
  }
}
