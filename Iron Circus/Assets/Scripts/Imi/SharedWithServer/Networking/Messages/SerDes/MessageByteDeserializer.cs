// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SerDes.MessageByteDeserializer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.IO;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Networking.Messages.SerDes
{
  public class MessageByteDeserializer : IMessageSerDes
  {
    private BinaryReader binaryReader;

    public MessageByteDeserializer(byte[] buffer)
    {
      this.binaryReader = new BinaryReader((Stream) new MemoryStream(buffer));
      this.Begin(buffer.Length);
    }

    public void Begin(int size)
    {
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void Finish()
    {
    }

    public bool IsSerializer() => false;

    public void Bool(ref bool value) => value = this.binaryReader.ReadBoolean();

    public void Byte(ref byte value) => value = this.binaryReader.ReadByte();

    public void Byte(ref byte value, int bits) => this.Byte(ref value);

    public void Byte(ref byte value, byte min, byte max) => this.Byte(ref value);

    public void SByte(ref sbyte value) => value = this.binaryReader.ReadSByte();

    public void SByte(ref sbyte value, sbyte min, sbyte max) => this.SByte(ref value);

    public void UShort(ref ushort value) => value = this.binaryReader.ReadUInt16();

    public void UShort(ref ushort value, int bits) => this.UShort(ref value);

    public void UShort(ref ushort value, ushort min, ushort max) => this.UShort(ref value);

    public void Short(ref short value) => value = this.binaryReader.ReadInt16();

    public void Short(ref short value, short min, short max) => this.Short(ref value);

    public void UInt(ref uint value) => value = this.binaryReader.ReadUInt32();

    public void UInt(ref uint value, int bits) => this.UInt(ref value);

    public void UInt(ref uint value, uint min, uint max) => this.UInt(ref value);

    public void Int(ref int value) => value = this.binaryReader.ReadInt32();

    public void Int(ref int value, int min, int max) => this.Int(ref value);

    public void Float(ref float value) => value = this.binaryReader.ReadSingle();

    public void ByteArray(ref byte[] bytes)
    {
      int count = this.binaryReader.ReadInt32();
      if (count > 0)
        bytes = this.binaryReader.ReadBytes(count);
      else
        bytes = (byte[]) null;
    }

    public void ByteArray(ref byte[] bytes, int length)
    {
      int count = this.binaryReader.ReadInt32();
      if (count > 0)
        bytes = this.binaryReader.ReadBytes(count);
      else
        bytes = (byte[]) null;
    }

    public void CharArray(ref char[] chars, int count) => chars = this.binaryReader.ReadChars(count);

    public void String(ref string value) => value = this.binaryReader.ReadString();

    public void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value) => value = (Imi.SharedWithServer.Game.UniqueId) this.binaryReader.ReadUInt16();

    public void JQuaternion(ref Jitter.LinearMath.JQuaternion value)
    {
      value.X = this.binaryReader.ReadSingle();
      value.Y = this.binaryReader.ReadSingle();
      value.Z = this.binaryReader.ReadSingle();
      value.W = this.binaryReader.ReadSingle();
    }

    public void JVector(ref Jitter.LinearMath.JVector value)
    {
      value.X = this.binaryReader.ReadSingle();
      value.Y = this.binaryReader.ReadSingle();
      value.Z = this.binaryReader.ReadSingle();
    }

    public void ULong(ref ulong value) => value = this.binaryReader.ReadUInt64();

    public void Long(ref long value) => value = this.binaryReader.ReadInt64();

    public void VarInt(ref int value)
    {
      bool flag = true;
      int num1 = 0;
      while (flag)
      {
        byte num2 = this.binaryReader.ReadByte();
        flag = ((uint) num2 & 128U) > 0U;
        value |= ((int) num2 & (int) sbyte.MaxValue) << num1;
        num1 += 7;
      }
    }
  }
}
