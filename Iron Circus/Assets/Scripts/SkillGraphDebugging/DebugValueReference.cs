// Decompiled with JetBrains decompiler
// Type: SkillGraphDebugging.DebugValueReference
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using System;

namespace SkillGraphDebugging
{
  [Serializable]
  public struct DebugValueReference
  {
    public int idx;
    public SyncableValueType type;

    public string GetString(byte[] data)
    {
      if (this.idx >= data.Length)
        return "IndexOutOfRange";
      switch (this.type)
      {
        case SyncableValueType.Bool:
          return BitConverter.ToBoolean(data, this.idx).ToString();
        case SyncableValueType.Byte:
          return data[this.idx].ToString();
        case SyncableValueType.Int:
          return BitConverter.ToInt32(data, this.idx).ToString();
        case SyncableValueType.ULong:
          return BitConverter.ToUInt64(data, this.idx).ToString();
        case SyncableValueType.Float:
          return BitConverter.ToSingle(data, this.idx).ToString();
        case SyncableValueType.ButtonType:
          return ((ButtonType) BitConverter.ToInt32(data, this.idx)).ToString();
        case SyncableValueType.StatusEffectType:
          return ((StatusEffectType) BitConverter.ToInt32(data, this.idx)).ToString();
        case SyncableValueType.StatusModifier:
          return ((StatusModifier) BitConverter.ToInt32(data, this.idx)).ToString();
        case SyncableValueType.JVector:
          return string.Format("x: {0}, y: {1}, z: {2}", (object) BitConverter.ToSingle(data, this.idx), (object) BitConverter.ToSingle(data, this.idx + 4), (object) BitConverter.ToSingle(data, this.idx + 8));
        case SyncableValueType.UniqueId:
          return BitConverter.ToUInt16(data, this.idx).ToString();
        default:
          return "UNKNOWN_TYPE";
      }
    }
  }
}
