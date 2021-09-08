// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Utilities.StringReference
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

namespace Newtonsoft.Json.Utilities
{
  internal readonly struct StringReference
  {
    private readonly char[] _chars;
    private readonly int _startIndex;
    private readonly int _length;

    public char this[int i] => this._chars[i];

    public char[] Chars => this._chars;

    public int StartIndex => this._startIndex;

    public int Length => this._length;

    public StringReference(char[] chars, int startIndex, int length)
    {
      this._chars = chars;
      this._startIndex = startIndex;
      this._length = length;
    }

    public override string ToString() => new string(this._chars, this._startIndex, this._length);
  }
}
