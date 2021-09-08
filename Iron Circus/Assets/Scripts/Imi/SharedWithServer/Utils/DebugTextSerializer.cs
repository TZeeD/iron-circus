// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.DebugTextSerializer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using System.Collections.Generic;
using System.Text;

namespace Imi.SharedWithServer.Utils
{
  public class DebugTextSerializer : IMessageSerDes
  {
    private List<string> lines = new List<string>();

    public void Begin(int size) => this.lines = new List<string>();

    public void Finish()
    {
    }

    public bool IsSerializer() => true;

    public void Bool(ref bool value) => this.lines.Add("Bool: " + (value ? "true" : "false"));

    public void Byte(ref byte value) => this.lines.Add("Byte: " + value.ToString());

    public void Byte(ref byte value, int bits) => this.lines.Add(string.Format("Byte: {0} : {1} bits", (object) value.ToString(), (object) bits));

    public void Byte(ref byte value, byte min, byte max) => this.lines.Add(string.Format("Byte: {0}, min {1}, max {2}", (object) value.ToString(), (object) min, (object) max));

    public void SByte(ref sbyte value) => this.lines.Add("SByte: " + value.ToString());

    public void SByte(ref sbyte value, int bits) => this.lines.Add(string.Format("SByte: {0}, {1} bits", (object) value.ToString(), (object) bits));

    public void SByte(ref sbyte value, sbyte min, sbyte max) => this.lines.Add(string.Format("SByte: {0}, min {1}, max {2}", (object) value.ToString(), (object) min, (object) max));

    public void UShort(ref ushort value) => this.lines.Add("UShort: " + value.ToString());

    public void UShort(ref ushort value, int bits) => this.lines.Add(string.Format("UShort: {0}, {1} bits", (object) value.ToString(), (object) bits));

    public void UShort(ref ushort value, ushort min, ushort max) => this.lines.Add(string.Format("UShort: {0}, min {1}, max {2}", (object) value.ToString(), (object) min, (object) max));

    public void Short(ref short value) => this.lines.Add("Short: " + value.ToString());

    public void Short(ref short value, short min, short max) => this.lines.Add(string.Format("Short : {0}, min {1}, max {2}", (object) value.ToString(), (object) min, (object) max));

    public void UInt(ref uint value) => this.lines.Add("UInt: " + value.ToString());

    public void UInt(ref uint value, int bits) => this.lines.Add(string.Format("UInt: {0}, {1} bits", (object) value.ToString(), (object) bits));

    public void UInt(ref uint value, uint min, uint max) => this.lines.Add(string.Format("UInt: {0}, min {1}, max {2}", (object) value.ToString(), (object) min, (object) max));

    public void Int(ref int value) => this.lines.Add("Int: " + value.ToString());

    public void Int(ref int value, int min, int max) => this.lines.Add(string.Format("Int: {0}, min {1}, max {2}", (object) value.ToString(), (object) min, (object) max));

    public void Float(ref float value) => this.lines.Add("Float: " + value.ToString());

    public void ByteArray(ref byte[] bytes)
    {
      if (bytes != null)
      {
        StringBuilder stringBuilder = new StringBuilder(bytes.Length * 2);
        foreach (byte num in bytes)
          stringBuilder.AppendFormat("0x{0:x2},", (object) num);
        string str = stringBuilder.ToString();
        this.lines.Add("BA: (" + bytes.Length.ToString() + ") [" + str + "]");
      }
      else
        this.lines.Add("BA: null");
    }

    public void ByteArray(ref byte[] bytes, int length)
    {
      if (bytes != null)
      {
        StringBuilder stringBuilder = new StringBuilder(length * 2);
        foreach (byte num in bytes)
          stringBuilder.AppendFormat("0x{0:x2},", (object) num);
        string str = stringBuilder.ToString();
        this.lines.Add(string.Format("BA: ({0}, {1}) [{2}]", (object) bytes.Length.ToString(), (object) length, (object) str));
      }
      else
        this.lines.Add("BA: null");
    }

    public void CharArray(ref char[] chars, int count)
    {
      if (chars != null)
        this.lines.Add("CharArray: " + chars.ToString() + ", count " + count.ToString());
      else
        this.lines.Add("CharArray: null, count " + count.ToString());
    }

    public void String(ref string value) => this.lines.Add("String: " + value);

    public void UniqueId(ref Imi.SharedWithServer.Game.UniqueId value) => this.lines.Add("UniqueId: " + value.Value().ToString());

    public void JQuaternion(ref Jitter.LinearMath.JQuaternion value) => this.lines.Add("JQuaternion: " + value.ToString());

    public void JVector(ref Jitter.LinearMath.JVector value) => this.lines.Add("JVector: " + value.ToString());

    public void ULong(ref ulong value) => this.lines.Add("ULong: " + value.ToString());

    public void Long(ref long value) => this.lines.Add("Long: " + value.ToString());

    public string GetText() => string.Join("\n", (IEnumerable<string>) this.lines);

    public void VarInt(ref int value) => this.lines.Add("VarInt: " + value.ToString());
  }
}
