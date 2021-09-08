// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SerDes.FastMessageByteSerializer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.IO;
using System.Runtime.CompilerServices;
using System.Text;

namespace Imi.SharedWithServer.Networking.Messages.SerDes
{
  public class FastMessageByteSerializer : IMessageSerDes
  {
    private byte[] buffer;
    private int position;

    public void Begin(int size)
    {
      this.buffer = new byte[size];
      this.position = 0;
    }

    public void Begin(byte[] target)
    {
      this.buffer = target;
      this.position = 0;
    }

    public void Reset() => this.position = 0;

    [MethodImpl((MethodImplOptions) 256)]
    public void Finish()
    {
    }

    public bool IsSerializer() => true;

    [MethodImpl((MethodImplOptions) 256)]
    private void CopyBytesImpl(long value, int bytes, int index)
    {
      for (int index1 = 0; index1 < bytes; ++index1)
      {
        this.buffer[index1 + index] = (byte) ((ulong) value & (ulong) byte.MaxValue);
        value >>= 8;
      }
    }

    [MethodImpl((MethodImplOptions) 256)]
    private static int SingleToInt32Bits(float value) => new Int32SingleUnion(value).AsInt32;

    [MethodImpl((MethodImplOptions) 256)]
    public void Bool(ref bool value) => this.buffer[this.position++] = value ? (byte) 1 : (byte) 0;

    [MethodImpl((MethodImplOptions) 256)]
    public void Byte(ref byte value) => this.buffer[this.position++] = value;

    [MethodImpl((MethodImplOptions) 256)]
    public void Byte(ref byte value, int bits) => this.buffer[this.position++] = value;

    [MethodImpl((MethodImplOptions) 256)]
    public void Byte(ref byte value, byte min, byte max) => this.buffer[this.position++] = value;

    [MethodImpl((MethodImplOptions) 256)]
    public void SByte(ref sbyte value) => this.buffer[this.position++] = (byte) value;

    [MethodImpl((MethodImplOptions) 256)]
    public void SByte(ref sbyte value, int bits) => this.buffer[this.position++] = (byte) value;

    [MethodImpl((MethodImplOptions) 256)]
    public void SByte(ref sbyte value, sbyte min, sbyte max) => this.buffer[this.position++] = (byte) value;

    [MethodImpl((MethodImplOptions) 256)]
    public void UShort(ref ushort value)
    {
      this.buffer[this.position + 1] = (byte) ((uint) value >> 8);
      this.buffer[this.position] = (byte) ((uint) value & (uint) byte.MaxValue);
      this.position += 2;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void UShort(ref ushort value, int bits)
    {
      this.buffer[this.position + 1] = (byte) ((uint) value >> 8);
      this.buffer[this.position] = (byte) ((uint) value & (uint) byte.MaxValue);
      this.position += 2;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void UShort(ref ushort value, ushort min, ushort max)
    {
      this.buffer[this.position + 1] = (byte) ((uint) value >> 8);
      this.buffer[this.position] = (byte) ((uint) value & (uint) byte.MaxValue);
      this.position += 2;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void Short(ref short value)
    {
      this.CopyBytesImpl((long) value, 2, this.position);
      this.position += 2;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void Short(ref short value, short min, short max)
    {
      this.CopyBytesImpl((long) value, 2, this.position);
      this.position += 2;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void UInt(ref uint value)
    {
      this.CopyBytesImpl((long) value, 4, this.position);
      this.position += 4;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void UInt(ref uint value, int bits)
    {
      this.CopyBytesImpl((long) value, 4, this.position);
      this.position += 4;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void UInt(ref uint value, uint min, uint max)
    {
      this.CopyBytesImpl((long) value, 4, this.position);
      this.position += 4;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void Int(ref int value)
    {
      this.CopyBytesImpl((long) value, 4, this.position);
      this.position += 4;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void Int(ref int value, int min, int max)
    {
      this.CopyBytesImpl((long) value, 4, this.position);
      this.position += 4;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void Float(ref float value)
    {
      this.CopyBytesImpl((long) FastMessageByteSerializer.SingleToInt32Bits(value), 4, this.position);
      this.position += 4;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void ByteArray(ref byte[] bytes)
    {
      if (bytes != null && bytes.Length != 0)
      {
        int length = bytes.Length;
        this.CopyBytesImpl((long) length, 4, this.position);
        Array.Copy((Array) bytes, 0, (Array) this.buffer, this.position + 4, length);
        this.position += length + 4;
      }
      else
        this.buffer[this.position++] = (byte) 0;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void ByteArray(ref byte[] bytes, int length)
    {
      if (bytes != null && length > 0)
      {
        int length1 = length;
        this.CopyBytesImpl((long) length1, 4, this.position);
        Array.Copy((Array) bytes, 0, (Array) this.buffer, this.position + 4, length1);
        this.position += length1 + 4;
      }
      else
        this.buffer[this.position++] = (byte) 0;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void CharArray(ref char[] chars, int count)
    {
      int byteCount = Encoding.UTF8.GetByteCount(chars, 0, count);
      Array.Copy((Array) Encoding.UTF8.GetBytes(chars), 0, (Array) this.buffer, this.position, byteCount);
      this.position += byteCount;
    }

    public void String(ref string value)
    {
      MemoryStream memoryStream = new MemoryStream(this.buffer, this.position, this.buffer.Length - this.position);
      new BinaryWriter((Stream) memoryStream, Encoding.UTF8).Write(value);
      this.position += (int) memoryStream.Position;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value)
    {
      this.CopyBytesImpl((long) value.Value(), 2, this.position);
      this.position += 2;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void JQuaternion(ref Jitter.LinearMath.JQuaternion value)
    {
      this.CopyBytesImpl((long) FastMessageByteSerializer.SingleToInt32Bits(value.X), 4, this.position);
      this.CopyBytesImpl((long) FastMessageByteSerializer.SingleToInt32Bits(value.Y), 4, this.position + 4);
      this.CopyBytesImpl((long) FastMessageByteSerializer.SingleToInt32Bits(value.Z), 4, this.position + 8);
      this.CopyBytesImpl((long) FastMessageByteSerializer.SingleToInt32Bits(value.W), 4, this.position + 12);
      this.position += 16;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void JVector(ref Jitter.LinearMath.JVector value)
    {
      this.CopyBytesImpl((long) FastMessageByteSerializer.SingleToInt32Bits(value.X), 4, this.position);
      this.CopyBytesImpl((long) FastMessageByteSerializer.SingleToInt32Bits(value.Y), 4, this.position + 4);
      this.CopyBytesImpl((long) FastMessageByteSerializer.SingleToInt32Bits(value.Z), 4, this.position + 8);
      this.position += 12;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void ULong(ref ulong value)
    {
      this.CopyBytesImpl((long) value, 8, this.position);
      this.position += 8;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void Long(ref long value)
    {
      this.CopyBytesImpl(value, 8, this.position);
      this.position += 8;
    }

    public byte[] GetBuffer() => this.buffer;

    public int GetBytesRequired() => this.position;

    [MethodImpl((MethodImplOptions) 256)]
    public void VarInt(ref int value)
    {
      uint num;
      for (num = (uint) value; num >= 128U; num >>= 7)
        this.buffer[this.position++] = (byte) (num | 128U);
      this.buffer[this.position++] = (byte) num;
    }
  }
}
