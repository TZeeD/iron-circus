// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SerDes.MessageByteSerializer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.IO;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Networking.Messages.SerDes
{
  public class MessageByteSerializer : IMessageSerDes
  {
    private BinaryWriter binaryWriter;
    private MemoryStream memoryStream;
    private byte[] buffer;

    public void Begin(int size)
    {
      this.buffer = new byte[size];
      this.memoryStream = new MemoryStream(this.buffer);
      this.binaryWriter = new BinaryWriter((Stream) this.memoryStream);
    }

    public void Begin(byte[] target)
    {
      this.buffer = target;
      this.memoryStream = new MemoryStream(this.buffer);
      this.binaryWriter = new BinaryWriter((Stream) this.memoryStream);
    }

    public void Reset() => this.memoryStream.Position = 0L;

    [MethodImpl((MethodImplOptions) 256)]
    public void Finish()
    {
    }

    public bool IsSerializer() => true;

    public void Bool(ref bool value) => this.binaryWriter.Write(value);

    public void Byte(ref byte value) => this.binaryWriter.Write(value);

    public void Byte(ref byte value, int bits) => this.Byte(ref value);

    public void Byte(ref byte value, byte min, byte max) => this.Byte(ref value);

    public void SByte(ref sbyte value) => this.binaryWriter.Write(value);

    public void SByte(ref sbyte value, int bits) => this.SByte(ref value);

    public void SByte(ref sbyte value, sbyte min, sbyte max) => this.SByte(ref value);

    public void UShort(ref ushort value) => this.binaryWriter.Write(value);

    public void UShort(ref ushort value, int bits) => this.UShort(ref value);

    public void UShort(ref ushort value, ushort min, ushort max) => this.UShort(ref value);

    public void Short(ref short value) => this.binaryWriter.Write(value);

    public void Short(ref short value, short min, short max) => this.Short(ref value);

    public void UInt(ref uint value) => this.binaryWriter.Write(value);

    public void UInt(ref uint value, int bits) => this.UInt(ref value);

    public void UInt(ref uint value, uint min, uint max) => this.UInt(ref value);

    public void Int(ref int value) => this.binaryWriter.Write(value);

    public void Int(ref int value, int min, int max) => this.Int(ref value);

    public void Float(ref float value) => this.binaryWriter.Write(value);

    public void ByteArray(ref byte[] bytes)
    {
      if (bytes != null && bytes.Length != 0)
      {
        this.binaryWriter.Write(bytes.Length);
        this.binaryWriter.Write(bytes);
      }
      else
        this.binaryWriter.Write(0);
    }

    public void ByteArray(ref byte[] bytes, int length)
    {
      if (bytes != null && length > 0)
      {
        this.binaryWriter.Write(length);
        this.binaryWriter.Write(bytes);
      }
      else
        this.binaryWriter.Write(0);
    }

    public void CharArray(ref char[] chars, int count) => this.binaryWriter.Write(chars, 0, count);

    public void String(ref string value) => this.binaryWriter.Write(value);

    public void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value) => this.binaryWriter.Write(value.Value());

    public void JQuaternion(ref Jitter.LinearMath.JQuaternion value)
    {
      this.binaryWriter.Write(value.X);
      this.binaryWriter.Write(value.Y);
      this.binaryWriter.Write(value.Z);
      this.binaryWriter.Write(value.W);
    }

    public void JVector(ref Jitter.LinearMath.JVector value)
    {
      this.binaryWriter.Write(value.X);
      this.binaryWriter.Write(value.Y);
      this.binaryWriter.Write(value.Z);
    }

    public void ULong(ref ulong value) => this.binaryWriter.Write(value);

    public void Long(ref long value) => this.binaryWriter.Write(value);

    public byte[] GetBuffer() => this.buffer;

    public int GetBytesRequired() => (int) this.memoryStream.Position;

    public void VarInt(ref int value)
    {
      if (value < 0)
        throw new ArgumentOutOfRangeException(nameof (value), (object) value, "value must be 0 or greater");
      int num1 = value;
      bool flag = true;
      while (flag || num1 > 0)
      {
        flag = false;
        byte num2 = (byte) (num1 & (int) sbyte.MaxValue);
        num1 >>= 7;
        if (num1 > 0)
          num2 |= (byte) 128;
        this.binaryWriter.Write(num2);
      }
    }
  }
}
