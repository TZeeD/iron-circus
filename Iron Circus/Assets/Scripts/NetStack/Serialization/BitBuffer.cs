// Decompiled with JetBrains decompiler
// Type: NetStack.Serialization.BitBuffer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Text;

namespace NetStack.Serialization
{
  public class BitBuffer
  {
    private const int defaultCapacity = 8;
    private const int stringLengthMax = 512;
    private const int stringLengthBits = 9;
    private const int bitsASCII = 7;
    private const int growFactor = 2;
    private const int minGrow = 1;
    private int readPosition;
    private int nextPosition;
    private uint[] chunks;

    public BitBuffer(int capacity = 8)
    {
      this.readPosition = 0;
      this.nextPosition = 0;
      this.chunks = new uint[capacity];
    }

    public int Length => (this.nextPosition - 1 >> 3) + 1;

    public bool IsFinished => this.nextPosition == this.readPosition;

    public void Clear()
    {
      this.readPosition = 0;
      this.nextPosition = 0;
    }

    public void Add(int numBits, uint value)
    {
      if (numBits < 0)
        throw new ArgumentOutOfRangeException("Pushing negative bits");
      if (numBits > 32)
        throw new ArgumentOutOfRangeException("Pushing too many bits");
      int index = this.nextPosition >> 5;
      int num1 = this.nextPosition & 31;
      if (index + 1 >= this.chunks.Length)
        this.ExpandArray();
      ulong num2 = (ulong) (1L << num1) - 1UL;
      ulong num3 = (ulong) ((long) this.chunks[index] & (long) num2 | (long) value << num1);
      this.chunks[index] = (uint) num3;
      this.chunks[index + 1] = (uint) (num3 >> 32);
      this.nextPosition += numBits;
    }

    public uint Read(int numBits)
    {
      int num = (int) this.Peek(numBits);
      this.readPosition += numBits;
      return (uint) num;
    }

    public uint Peek(int numBits)
    {
      if (numBits < 0)
        throw new ArgumentOutOfRangeException("Pushing negative bits");
      if (numBits > 32)
        throw new ArgumentOutOfRangeException("Pushing too many bits");
      int index = this.readPosition >> 5;
      int num1 = this.readPosition & 31;
      ulong num2 = (ulong) ((1L << numBits) - 1L << num1);
      ulong chunk = (ulong) this.chunks[index];
      if (index + 1 < this.chunks.Length)
        chunk |= (ulong) this.chunks[index + 1] << 32;
      return (uint) ((chunk & num2) >> num1);
    }

    public int ToArray(byte[] data)
    {
      this.Add(1, 1U);
      int num = (this.nextPosition >> 5) + 1;
      int length = data.Length;
      for (int index1 = 0; index1 < num; ++index1)
      {
        int index2 = index1 * 4;
        uint chunk = this.chunks[index1];
        if (index2 < length)
          data[index2] = (byte) chunk;
        if (index2 + 1 < length)
          data[index2 + 1] = (byte) (chunk >> 8);
        if (index2 + 2 < length)
          data[index2 + 2] = (byte) (chunk >> 16);
        if (index2 + 3 < length)
          data[index2 + 3] = (byte) (chunk >> 24);
      }
      return this.Length;
    }

    public void FromArray(byte[] data, int length)
    {
      int length1 = length / 4 + 1;
      if (this.chunks.Length < length1)
        this.chunks = new uint[length1];
      for (int index1 = 0; index1 < length1; ++index1)
      {
        int index2 = index1 * 4;
        uint num = 0;
        if (index2 < length)
          num = (uint) data[index2];
        if (index2 + 1 < length)
          num |= (uint) data[index2 + 1] << 8;
        if (index2 + 2 < length)
          num |= (uint) data[index2 + 2] << 16;
        if (index2 + 3 < length)
          num |= (uint) data[index2 + 3] << 24;
        this.chunks[index1] = num;
      }
      int highestBitPosition = BitBuffer.FindHighestBitPosition(data[length - 1]);
      this.nextPosition = (length - 1) * 8 + (highestBitPosition - 1);
      this.readPosition = 0;
    }

    public BitBuffer AddBool(bool value)
    {
      this.Add(1, value ? 1U : 0U);
      return this;
    }

    public bool ReadBool() => this.Read(1) > 0U;

    public bool PeekBool() => this.Peek(1) > 0U;

    public BitBuffer AddByte(byte value)
    {
      this.Add(8, (uint) value);
      return this;
    }

    public byte ReadByte() => (byte) this.Read(8);

    public byte PeekByte() => (byte) this.Peek(8);

    public BitBuffer AddShort(short value)
    {
      this.AddInt((int) value);
      return this;
    }

    public short ReadShort() => (short) this.ReadInt();

    public short PeekShort() => (short) this.PeekInt();

    public BitBuffer AddUShort(ushort value)
    {
      this.AddUInt((uint) value);
      return this;
    }

    public ushort ReadUShort() => (ushort) this.ReadUInt();

    public ushort PeekUShort() => (ushort) this.PeekUInt();

    public BitBuffer AddInt(int value)
    {
      this.AddUInt((uint) (value << 1 ^ value >> 31));
      return this;
    }

    public int ReadInt()
    {
      uint num = this.ReadUInt();
      return (int) ((long) (num >> 1) ^ (long) -((int) num & 1));
    }

    public int PeekInt()
    {
      uint num = this.PeekUInt();
      return (int) ((long) (num >> 1) ^ (long) -((int) num & 1));
    }

    public BitBuffer AddUInt(uint value)
    {
      do
      {
        uint num = value & (uint) sbyte.MaxValue;
        value >>= 7;
        if (value > 0U)
          num |= 128U;
        this.Add(8, num);
      }
      while (value > 0U);
      return this;
    }

    public uint ReadUInt()
    {
      uint num1 = 0;
      int num2 = 0;
      uint num3;
      do
      {
        num3 = this.Read(8);
        num1 |= (uint) (((int) num3 & (int) sbyte.MaxValue) << num2);
        num2 += 7;
      }
      while ((num3 & 128U) > 0U);
      return num1;
    }

    public uint PeekUInt()
    {
      int readPosition = this.readPosition;
      int num = (int) this.ReadUInt();
      this.readPosition = readPosition;
      return (uint) num;
    }

    public BitBuffer AddLong(long value)
    {
      this.AddInt((int) (value & (long) uint.MaxValue));
      this.AddInt((int) (value >> 32));
      return this;
    }

    public long ReadLong()
    {
      int num = this.ReadInt();
      return (long) this.ReadInt() << 32 | (long) (uint) num;
    }

    public long PeekLong()
    {
      int readPosition = this.readPosition;
      long num = this.ReadLong();
      this.readPosition = readPosition;
      return num;
    }

    public BitBuffer AddULong(ulong value)
    {
      this.AddUInt((uint) (value & (ulong) uint.MaxValue));
      this.AddUInt((uint) (value >> 32));
      return this;
    }

    public ulong ReadULong()
    {
      uint num = this.ReadUInt();
      return (ulong) this.ReadUInt() << 32 | (ulong) num;
    }

    public ulong PeekULong()
    {
      int readPosition = this.readPosition;
      long num = (long) this.ReadULong();
      this.readPosition = readPosition;
      return (ulong) num;
    }

    public BitBuffer AddString(string value)
    {
      uint num = value != null ? (uint) value.Length : throw new ArgumentNullException(nameof (value));
      if (num > 512U)
        num = 512U;
      this.Add(9, num);
      for (int index = 0; (long) index < (long) num; ++index)
        this.Add(7, (uint) BitBuffer.ToASCII(value[index]));
      return this;
    }

    public string ReadString()
    {
      StringBuilder stringBuilder = new StringBuilder();
      uint num = this.Read(9);
      for (int index = 0; (long) index < (long) num; ++index)
        stringBuilder.Append((char) this.Read(7));
      return stringBuilder.ToString();
    }

    public override string ToString()
    {
      StringBuilder stringBuilder1 = new StringBuilder();
      for (int index = this.chunks.Length - 1; index >= 0; --index)
        stringBuilder1.Append(Convert.ToString((long) this.chunks[index], 2).PadLeft(32, '0'));
      StringBuilder stringBuilder2 = new StringBuilder();
      for (int index = 0; index < stringBuilder1.Length; ++index)
      {
        stringBuilder2.Append(stringBuilder1[index]);
        if ((index + 1) % 8 == 0)
          stringBuilder2.Append(" ");
      }
      return stringBuilder2.ToString();
    }

    private void ExpandArray()
    {
      uint[] numArray = new uint[this.chunks.Length * 2 + 1];
      Array.Copy((Array) this.chunks, (Array) numArray, this.chunks.Length);
      this.chunks = numArray;
    }

    private static int FindHighestBitPosition(byte data)
    {
      int num = 0;
      while (data > (byte) 0)
      {
        data >>= 1;
        ++num;
      }
      return num;
    }

    private static byte ToASCII(char character)
    {
      byte num;
      try
      {
        num = Convert.ToByte(character);
      }
      catch (OverflowException ex)
      {
        throw new Exception("Cannot convert to ASCII: " + character.ToString());
      }
      return num <= (byte) 127 ? num : throw new Exception("Cannot convert to ASCII: " + character.ToString());
    }
  }
}
