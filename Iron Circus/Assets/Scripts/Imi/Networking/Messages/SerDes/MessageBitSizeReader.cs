// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.SerDes.MessageBitSizeReader
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.Utils;
using System;
using System.Runtime.CompilerServices;
using System.Text;

namespace Imi.Networking.Messages.SerDes
{
  public class MessageBitSizeReader : IMessageSerDes
  {
    private int bits;

    public int GetBitsRequired() => this.bits;

    public int GetBytesRequired() => (this.bits + 7) / 8;

    [MethodImpl((MethodImplOptions) 256)]
    public void Finish()
    {
    }

    public bool IsSerializer() => true;

    public void Bool(ref bool value) => ++this.bits;

    public void Begin(int bufferSize) => this.bits = 0;

    public void Byte(ref byte value) => this.bits += 8;

    public void Byte(ref byte value, int bits) => this.bits += bits;

    public void Byte(ref byte value, byte min, byte max) => this.bits += BitUtils.BitsRequired((int) min, (int) max);

    public void SByte(ref sbyte value) => this.bits += 8;

    public void SByte(ref sbyte value, sbyte min, sbyte max) => this.bits += BitUtils.BitsRequired((int) min, (int) max);

    public void UShort(ref ushort value) => this.bits += 16;

    public void UShort(ref ushort value, int bits) => this.bits += bits;

    public void UShort(ref ushort value, ushort min, ushort max) => this.bits += BitUtils.BitsRequired((int) min, (int) max);

    public void Short(ref short value) => this.bits += 16;

    public void Short(ref short value, short min, short max) => this.bits += BitUtils.BitsRequired((int) min, (int) max);

    public void UInt(ref uint value) => this.bits += 32;

    public void UInt(ref uint value, int bits) => this.bits += bits;

    public void UInt(ref uint value, uint min, uint max) => this.bits += BitUtils.BitsRequired(min, max);

    public void Int(ref int value) => this.bits += 32;

    public void Int(ref int value, int min, int max) => this.bits += BitUtils.BitsRequired(min, max);

    public void Float(ref float value) => this.bits += 32;

    public void ByteArray(ref byte[] bytes)
    {
      if (bytes != null)
        this.bits += 32 + 8 * bytes.Length;
      else
        this.bits += 32;
    }

    public void ByteArray(ref byte[] bytes, int length)
    {
      if (bytes != null)
        this.bits += 32 + 8 * length;
      else
        this.bits += 32;
    }

    public void CharArray(ref char[] chars, int count) => this.bits += 16 * count;

    public void String(ref string value)
    {
      int byteCount = Encoding.UTF8.GetByteCount(value);
      for (uint index = (uint) byteCount; index >= 128U; index >>= 7)
        ++byteCount;
      this.bits += (byteCount + 1) * 8;
    }

    public void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value) => this.bits += 16;

    public void JQuaternion(ref Jitter.LinearMath.JQuaternion value) => this.bits += 128;

    public void JVector(ref Jitter.LinearMath.JVector value) => this.bits += 96;

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
        this.bits += 8;
      }
    }

    public void ULong(ref ulong value) => this.bits += 64;

    public void Long(ref long value) => this.bits += 64;
  }
}
