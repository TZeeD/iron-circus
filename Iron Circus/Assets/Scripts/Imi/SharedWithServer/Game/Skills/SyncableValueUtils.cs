// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SyncableValueUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Game.Skills
{
  public static class SyncableValueUtils
  {
    [MethodImpl((MethodImplOptions) 256)]
    public static SyncableValueType GetSyncableValueType(Type t)
    {
      if (t == typeof (bool))
        return SyncableValueType.Bool;
      if (t == typeof (byte))
        return SyncableValueType.Byte;
      if (t == typeof (int))
        return SyncableValueType.Int;
      if (t == typeof (ulong))
        return SyncableValueType.ULong;
      if (t == typeof (float))
        return SyncableValueType.Float;
      if (t == typeof (ButtonType))
        return SyncableValueType.ButtonType;
      if (t == typeof (StatusEffectType))
        return SyncableValueType.StatusEffectType;
      if (t == typeof (StatusModifier))
        return SyncableValueType.StatusModifier;
      if (t == typeof (JVector))
        return SyncableValueType.JVector;
      if (t == typeof (UniqueId))
        return SyncableValueType.UniqueId;
      throw new Exception("SkillVarNode with unknown type '" + t.Name + "' created!");
    }

    public static string ReadSerializedValueString(
      byte[] value,
      int startIndex,
      SyncableValueType t)
    {
      switch (t)
      {
        case SyncableValueType.Bool:
          return (value[startIndex] > (byte) 0).ToString();
        case SyncableValueType.Byte:
          return value[startIndex].ToString();
        case SyncableValueType.Int:
          return BitConverter.ToInt32(value, startIndex).ToString();
        case SyncableValueType.ULong:
          return BitConverter.ToUInt64(value, startIndex).ToString();
        case SyncableValueType.Float:
          return BitConverter.ToSingle(value, startIndex).ToString();
        case SyncableValueType.ButtonType:
          return ((ButtonType) BitConverter.ToUInt16(value, startIndex)).ToString();
        case SyncableValueType.StatusEffectType:
          return ((ButtonType) BitConverter.ToUInt16(value, startIndex)).ToString();
        case SyncableValueType.StatusModifier:
          return ((ButtonType) BitConverter.ToUInt16(value, startIndex)).ToString();
        case SyncableValueType.JVector:
          return new JVector(BitConverter.ToSingle(value, startIndex), BitConverter.ToSingle(value, startIndex + 4), BitConverter.ToSingle(value, startIndex + 8)).ToString();
        case SyncableValueType.UniqueId:
          return BitConverter.ToUInt16(value, startIndex).ToString();
        default:
          throw new NotImplementedException("Unknown dynamic value type: " + (object) t);
      }
    }
  }
}
