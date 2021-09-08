// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SerDes.MessageByteSizeReader
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Runtime.CompilerServices;
using System.Text;

namespace Imi.SharedWithServer.Networking.Messages.SerDes
{
  public class MessageByteSizeReader : IMessageSerDes
  {
    private int size;

    public int GetBitsRequired() => this.size * 8;

    public int GetBytesRequired() => this.size;

    public void Begin(int size) => this.size = 0;

    [MethodImpl((MethodImplOptions) 256)]
    public void Finish()
    {
    }

    public bool IsSerializer() => true;

    public void Bool(ref bool value) => ++this.size;

    public void Byte(ref byte value) => ++this.size;

    public void Byte(ref byte value, int bits) => ++this.size;

    public void Byte(ref byte value, byte min, byte max) => ++this.size;

    public void SByte(ref sbyte value) => ++this.size;

    public void SByte(ref sbyte value, sbyte min, sbyte max) => ++this.size;

    public void UShort(ref ushort value) => this.size += 2;

    public void UShort(ref ushort value, int bits) => this.size += 2;

    public void UShort(ref ushort value, ushort min, ushort max) => this.size += 2;

    public void Short(ref short value) => this.size += 2;

    public void Short(ref short value, short min, short max) => this.size += 2;

    public void UInt(ref uint value) => this.size += 4;

    public void UInt(ref uint value, int bits) => this.size += 4;

    public void UInt(ref uint value, uint min, uint max) => this.size += 4;

    public void Int(ref int value) => this.size += 4;

    public void Int(ref int value, int min, int max) => this.size += 4;

    public void Float(ref float value) => this.size += 4;

    public void ByteArray(ref byte[] bytes)
    {
      if (bytes != null)
        this.size += 4 + bytes.Length;
      else
        this.size += 4;
    }

    public void ByteArray(ref byte[] bytes, int length)
    {
      if (bytes != null)
        this.size += 4 + length;
      else
        this.size += 4;
    }

    public void CharArray(ref char[] chars, int count) => this.size += count;

    public void String(ref string value)
    {
      int byteCount = Encoding.UTF8.GetByteCount(value);
      for (uint index = (uint) byteCount; index >= 128U; index >>= 7)
        ++byteCount;
      this.size += byteCount + 1;
    }

    public void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value) => this.size += 2;

    public void JQuaternion(ref Jitter.LinearMath.JQuaternion value) => this.size += 16;

    public void JVector(ref Jitter.LinearMath.JVector value) => this.size += 12;

    public void ULong(ref ulong value) => this.size += 8;

    public void Long(ref long value) => this.size += 8;

    public void VarInt(ref int value)
    {
      if (value < 0)
        throw new ArgumentOutOfRangeException(nameof (value), (object) value, "value must be 0 or greater");
      int num = value;
      bool flag = true;
      while (flag || num > 0)
      {
        flag = false;
        num >>= 7;
        ++this.size;
      }
    }
  }
}
