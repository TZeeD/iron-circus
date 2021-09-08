// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.SerDes.MessageBitSerializer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.Utils;
using System;
using System.Text;

namespace Imi.Networking.Messages.SerDes
{
  public class MessageBitSerializer : IMessageSerDes, ISerDesBuffer
  {
    private BitWriterStream bitWriter;
    private byte[] buffer;

    public int GetBitsRequired() => this.bitWriter.GetBitsProcessed();

    public int GetBytesRequired() => (this.GetBitsRequired() + 7) / 8;

    public void Begin(int size)
    {
      this.bitWriter = new BitWriterStream();
      this.buffer = new byte[size];
      this.bitWriter.Start(this.buffer);
    }

    public void Begin(byte[] targetBuffer)
    {
      this.bitWriter = new BitWriterStream();
      this.buffer = targetBuffer;
      this.bitWriter.Start(this.buffer);
    }

    public void Reset() => this.bitWriter.Start(this.buffer);

    public void Finish() => this.bitWriter.Finish();

    public bool IsSerializer() => true;

    public void Bool(ref bool value) => this.bitWriter.SerializeBit(value);

    public void Byte(ref byte value) => this.bitWriter.SerializeBits(value, 8);

    public void Byte(ref byte value, int bits) => this.bitWriter.SerializeBits(value, bits);

    public void Byte(ref byte value, byte min, byte max) => this.bitWriter.SerializeUnsignedInteger((uint) value, (uint) min, (uint) max);

    public void SByte(ref sbyte value) => this.bitWriter.SerializeSignedInteger((int) value, (int) sbyte.MinValue, (int) sbyte.MaxValue);

    public void SByte(ref sbyte value, sbyte min, sbyte max) => this.bitWriter.SerializeSignedInteger((int) value, (int) min, (int) max);

    public void UShort(ref ushort value) => this.bitWriter.SerializeBits(value, 16);

    public void UShort(ref ushort value, int bits) => this.bitWriter.SerializeBits(value, bits);

    public void UShort(ref ushort value, ushort min, ushort max) => this.bitWriter.SerializeUnsignedShort(value, min, max);

    public void Short(ref short value) => this.bitWriter.SerializeSignedShort(value, short.MinValue, short.MaxValue);

    public void Short(ref short value, short min, short max) => this.bitWriter.SerializeSignedShort(value, min, max);

    public void UInt(ref uint value) => this.bitWriter.SerializeBits(value, 32);

    public void UInt(ref uint value, int bits) => this.bitWriter.SerializeBits(value, bits);

    public void UInt(ref uint value, uint min, uint max) => this.bitWriter.SerializeUnsignedInteger(value, min, max);

    public void Int(ref int value) => this.bitWriter.SerializeSignedInteger(value, int.MinValue, int.MaxValue);

    public void Int(ref int value, int min, int max) => this.bitWriter.SerializeSignedInteger(value, min, max);

    public void Float(ref float value) => this.bitWriter.SerializeFloat(value);

    public void ByteArray(ref byte[] bytes)
    {
      if (bytes == null || bytes.Length == 0)
      {
        this.bitWriter.SerializeSignedInteger(0, 0, 65536);
      }
      else
      {
        this.bitWriter.SerializeSignedInteger(bytes.Length, 0, 65536);
        this.bitWriter.SerializeBytes(bytes, bytes.Length);
      }
    }

    public void ByteArray(ref byte[] bytes, int length)
    {
      if (bytes == null || length == 0)
      {
        this.bitWriter.SerializeSignedInteger(0, 0, 65536);
      }
      else
      {
        this.bitWriter.SerializeSignedInteger(length, 0, 65536);
        this.bitWriter.SerializeBytes(bytes, length);
      }
    }

    public void CharArray(ref char[] chars, int count)
    {
      int byteCount = Encoding.ASCII.GetByteCount(chars, 0, count);
      this.bitWriter.SerializeBytes(Encoding.ASCII.GetBytes(chars), byteCount);
    }

    public void String(ref string value)
    {
      byte[] bytes = Encoding.UTF8.GetBytes(value);
      this.bitWriter.SerializeBits((byte) bytes.Length, 8);
      this.bitWriter.SerializeBytes(bytes, bytes.Length);
    }

    public void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value) => this.bitWriter.SerializeBits(value.Value(), 16);

    public void JQuaternion(ref Jitter.LinearMath.JQuaternion value)
    {
      this.bitWriter.SerializeFloat(value.X);
      this.bitWriter.SerializeFloat(value.Y);
      this.bitWriter.SerializeFloat(value.Z);
      this.bitWriter.SerializeFloat(value.W);
    }

    public void JVector(ref Jitter.LinearMath.JVector value)
    {
      this.bitWriter.SerializeFloat(value.X);
      this.bitWriter.SerializeFloat(value.Y);
      this.bitWriter.SerializeFloat(value.Z);
    }

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
        this.bitWriter.SerializeBits(num2, 8);
      }
    }

    public void ULong(ref ulong value) => this.bitWriter.SerializeBits(value, 64);

    public void Long(ref long value) => this.bitWriter.SerializeBits(value, 64);

    public int GetBufferByteLen() => this.buffer.Length;

    public byte[] GetBuffer() => this.buffer;
  }
}
