// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SerDes.IMessageSerDes
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.Networking.Messages.SerDes
{
  public interface IMessageSerDes
  {
    void Begin(int size);

    void Finish();

    bool IsSerializer();

    void Bool(ref bool value);

    void Byte(ref byte value);

    void Byte(ref byte value, int bits);

    void Byte(ref byte value, byte min, byte max);

    void SByte(ref sbyte value);

    void SByte(ref sbyte value, sbyte min, sbyte max);

    void UShort(ref ushort value);

    void UShort(ref ushort value, int bits);

    void UShort(ref ushort value, ushort min, ushort max);

    void Short(ref short value);

    void Short(ref short value, short min, short max);

    void UInt(ref uint value);

    void UInt(ref uint value, int bits);

    void UInt(ref uint value, uint min, uint max);

    void Int(ref int value);

    void Int(ref int value, int min, int max);

    void Float(ref float value);

    void ByteArray(ref byte[] bytes);

    void ByteArray(ref byte[] bytes, int length);

    void CharArray(ref char[] chars, int count);

    void String(ref string value);

    void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value);

    void JQuaternion(ref Jitter.LinearMath.JQuaternion value);

    void JVector(ref Jitter.LinearMath.JVector value);

    void VarInt(ref int value);

    void ULong(ref ulong value);

    void Long(ref long value);
  }
}
