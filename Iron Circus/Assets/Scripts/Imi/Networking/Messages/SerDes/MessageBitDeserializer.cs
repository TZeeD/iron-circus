// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.SerDes.MessageBitDeserializer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.Utils;
using System.Text;

namespace Imi.Networking.Messages.SerDes
{
  public class MessageBitDeserializer : IMessageSerDes
  {
    private BitReaderStream bitReader;

    public MessageBitDeserializer(byte[] buffer)
    {
      this.bitReader = new BitReaderStream();
      this.bitReader.Start(buffer);
      this.Begin(buffer.Length);
    }

    public void BeginNew(byte[] buffer)
    {
      this.bitReader.Start(buffer);
      this.Begin(buffer.Length);
    }

    public int GetBitsRequired() => this.bitReader.GetBitsProcessed();

    public int GetBytesProcessed() => this.bitReader.GetBytesProcessed();

    public int GetBytesRequired() => (this.GetBitsRequired() + 7) / 8;

    public void Begin(int size)
    {
    }

    public void Finish() => this.bitReader.Finish();

    public bool IsSerializer() => false;

    public bool SerializeAlign() => this.bitReader.SerializeAlign();

    public void Bool(ref bool value) => this.bitReader.SerializeBit(out value);

    public void Byte(ref byte value) => this.bitReader.SerializeBits(out value, 8);

    public void Byte(ref byte value, int bits) => this.bitReader.SerializeBits(out value, bits);

    public void Byte(ref byte value, byte min, byte max)
    {
      uint num;
      this.bitReader.SerializeUnsignedInteger(out num, (uint) min, (uint) max);
      value = (byte) num;
    }

    public void SByte(ref sbyte value)
    {
      int num;
      this.bitReader.SerializeSignedInteger(out num, (int) sbyte.MinValue, (int) sbyte.MaxValue);
      value = (sbyte) num;
    }

    public void SByte(ref sbyte value, sbyte min, sbyte max)
    {
      int num;
      this.bitReader.SerializeSignedInteger(out num, (int) min, (int) max);
      value = (sbyte) num;
    }

    public void UShort(ref ushort value) => this.bitReader.SerializeBits(out value, 16);

    public void UShort(ref ushort value, int bits) => this.bitReader.SerializeBits(out value, bits);

    public void UShort(ref ushort value, ushort min, ushort max) => this.bitReader.SerializeUnsignedShort(out value, min, max);

    public void Short(ref short value) => this.bitReader.SerializeSignedShort(out value, short.MinValue, short.MaxValue);

    public void Short(ref short value, short min, short max) => this.bitReader.SerializeSignedShort(out value, min, max);

    public void UInt(ref uint value) => this.bitReader.SerializeBits(out value, 32);

    public void UInt(ref uint value, int bits) => this.bitReader.SerializeBits(out value, bits);

    public void UInt(ref uint value, uint min, uint max) => this.bitReader.SerializeUnsignedInteger(out value, min, max);

    public void Int(ref int value) => this.bitReader.SerializeSignedInteger(out value, int.MinValue, int.MaxValue);

    public void Int(ref int value, int min, int max) => this.bitReader.SerializeSignedInteger(out value, min, max);

    public void Float(ref float value) => this.bitReader.SerializeFloat(out value);

    public void ByteArray(ref byte[] bytes)
    {
      int bytes1 = 0;
      this.bitReader.SerializeSignedInteger(out bytes1, 0, 65536);
      if (bytes1 == 0)
      {
        bytes = (byte[]) null;
      }
      else
      {
        bytes = new byte[bytes1];
        this.bitReader.SerializeBytes(bytes, bytes1);
      }
    }

    public void ByteArray(ref byte[] bytes, int length)
    {
      int bytes1 = length;
      this.bitReader.SerializeSignedInteger(out bytes1, 0, 65536);
      if (bytes1 == 0)
      {
        bytes = (byte[]) null;
      }
      else
      {
        bytes = new byte[bytes1];
        this.bitReader.SerializeBytes(bytes, bytes1);
      }
    }

    public void CharArray(ref char[] chars, int count)
    {
      byte[] numArray = new byte[count];
      this.bitReader.SerializeBytes(numArray, count);
      chars = Encoding.ASCII.GetChars(numArray, 0, count);
    }

    public void String(ref string value)
    {
      byte num = 0;
      this.bitReader.SerializeBits(out num, 8);
      byte[] numArray = new byte[(int) num];
      this.bitReader.SerializeBytes(numArray, (int) num);
      value = Encoding.UTF8.GetString(numArray, 0, (int) num);
    }

    public void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value)
    {
      ushort num = value.Value();
      this.bitReader.SerializeBits(out num, 16);
      value = (Imi.SharedWithServer.Game.UniqueId) num;
    }

    public void JQuaternion(ref Jitter.LinearMath.JQuaternion value)
    {
      this.bitReader.SerializeFloat(out value.X);
      this.bitReader.SerializeFloat(out value.Y);
      this.bitReader.SerializeFloat(out value.Z);
      this.bitReader.SerializeFloat(out value.W);
    }

    public void JVector(ref Jitter.LinearMath.JVector value)
    {
      this.bitReader.SerializeFloat(out value.X);
      this.bitReader.SerializeFloat(out value.Y);
      this.bitReader.SerializeFloat(out value.Z);
    }

    public void VarInt(ref int value)
    {
      bool flag = true;
      int num1 = 0;
      while (flag)
      {
        byte num2;
        this.bitReader.SerializeBits(out num2, 8);
        flag = ((uint) num2 & 128U) > 0U;
        value |= ((int) num2 & (int) sbyte.MaxValue) << num1;
        num1 += 7;
      }
    }

    public void ULong(ref ulong value) => this.bitReader.SerializeBits(out value, 64);

    public void Long(ref long value) => this.bitReader.SerializeBits(out value, 64);

    public void Ulong(ref ulong value, int bits) => this.bitReader.SerializeBits(out value, bits);

    public void Bytes(byte[] target, int numBytes) => this.bitReader.SerializeBytes(target, numBytes);

    public void Bytes(byte[] target, int targetOffset, int numBytes) => this.bitReader.SerializeBytes(target, targetOffset, numBytes);
  }
}
