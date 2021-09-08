// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SyncableValue`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Game.Skills
{
  [Serializable]
  public struct SyncableValue<T> where T : struct
  {
    private static Type valueType = typeof (T);
    private static readonly SyncableValueType SyncableValueType;
    private static readonly uint sizeOfT = (uint) Unsafe.SizeOf<T>();
    private T value;
    private Func<T> expression;

    static SyncableValue() => SyncableValue<T>.SyncableValueType = SyncableValueUtils.GetSyncableValueType(SyncableValue<T>.valueType);

    [MethodImpl((MethodImplOptions) 256)]
    public void Set(T value) => this.value = value;

    [MethodImpl((MethodImplOptions) 256)]
    public T Get()
    {
      if (this.expression != null)
        this.value = this.expression();
      return this.value;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public void Expression(Func<T> expression) => this.expression = expression;

    public static implicit operator T(SyncableValue<T> netVal) => netVal.Get();

    public static implicit operator SyncableValue<T>(T value)
    {
      SyncableValue<T> syncableValue = new SyncableValue<T>();
      syncableValue.Set(value);
      return syncableValue;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public bool IsExpression() => this.expression != null;

    public void SerializeOrDeserialize(IMessageSerDes sd)
    {
      if (this.IsExpression())
        return;
      this.SerDesNoExpressionCheck(sd);
    }

    [MethodImpl((MethodImplOptions) 256)]
    private void SerDesNoExpressionCheck(IMessageSerDes sd)
    {
      switch (SyncableValue<T>.SyncableValueType)
      {
        case SyncableValueType.Bool:
          sd.Bool(ref Unsafe.As<T, bool>(ref this.value));
          break;
        case SyncableValueType.Byte:
          sd.Byte(ref Unsafe.As<T, byte>(ref this.value));
          break;
        case SyncableValueType.Int:
          sd.Int(ref Unsafe.As<T, int>(ref this.value));
          break;
        case SyncableValueType.ULong:
          sd.ULong(ref Unsafe.As<T, ulong>(ref this.value));
          break;
        case SyncableValueType.Float:
          sd.Float(ref Unsafe.As<T, float>(ref this.value));
          break;
        case SyncableValueType.ButtonType:
        case SyncableValueType.StatusEffectType:
        case SyncableValueType.StatusModifier:
        case SyncableValueType.UniqueId:
          sd.UShort(ref Unsafe.As<T, ushort>(ref this.value));
          break;
        case SyncableValueType.JVector:
          sd.JVector(ref Unsafe.As<T, JVector>(ref this.value));
          break;
        default:
          throw new ArgumentOutOfRangeException();
      }
    }

    public void Parse(
      List<SerializedSyncValueInfo> serializationInfo,
      ref int valueIndex,
      string name = null)
    {
      if (this.IsExpression())
        return;
      serializationInfo.Add(new SerializedSyncValueInfo()
      {
        type = SyncableValue<T>.SyncableValueType,
        size = (int) SyncableValue<T>.sizeOfT,
        index = valueIndex,
        name = name
      });
      valueIndex += (int) SyncableValue<T>.sizeOfT;
    }

    public void Serialize(byte[] target, ref int valueIdx)
    {
      if (this.IsExpression())
        return;
      if (SyncableValue<T>.SyncableValueType == SyncableValueType.JVector)
      {
        JVector source = Unsafe.As<T, JVector>(ref this.value) * 1000f;
        source = new JVector((float) (int) source.X / 1000f, (float) (int) source.Y / 1000f, (float) (int) source.Z / 1000f);
        this.value = Unsafe.As<JVector, T>(ref source);
      }
      Unsafe.CopyBlockUnaligned(ref target[valueIdx], ref Unsafe.As<T, byte>(ref this.value), SyncableValue<T>.sizeOfT);
      valueIdx += (int) SyncableValue<T>.sizeOfT;
    }

    public void Deserialize(byte[] source, ref int valueIdx)
    {
      if (this.IsExpression())
        return;
      this.value = Unsafe.As<byte, T>(ref source[valueIdx]);
      valueIdx += (int) SyncableValue<T>.sizeOfT;
    }

    [MethodImpl((MethodImplOptions) 256)]
    public override bool Equals(object obj) => obj != null && object.Equals((object) this.value, (object) ((SyncableValue<T>) obj).value);

    public static bool operator ==(SyncableValue<T> a, SyncableValue<T> b)
    {
      switch (SyncableValue<T>.SyncableValueType)
      {
        case SyncableValueType.Bool:
          return Unsafe.As<T, bool>(ref a.value) == Unsafe.As<T, bool>(ref b.value);
        case SyncableValueType.Byte:
          return (int) Unsafe.As<T, byte>(ref a.value) == (int) Unsafe.As<T, byte>(ref b.value);
        case SyncableValueType.Int:
          return Unsafe.As<T, int>(ref a.value) == Unsafe.As<T, int>(ref b.value);
        case SyncableValueType.ULong:
          return (long) Unsafe.As<T, ulong>(ref a.value) == (long) Unsafe.As<T, ulong>(ref b.value);
        case SyncableValueType.Float:
          return (double) Math.Abs(Unsafe.As<T, float>(ref a.value) - Unsafe.As<T, float>(ref b.value)) <= 1.40129846432482E-45;
        case SyncableValueType.ButtonType:
        case SyncableValueType.StatusEffectType:
        case SyncableValueType.StatusModifier:
        case SyncableValueType.UniqueId:
          return (int) Unsafe.As<T, ushort>(ref a.value) == (int) Unsafe.As<T, ushort>(ref b.value);
        case SyncableValueType.JVector:
          return Unsafe.As<T, JVector>(ref a.value) == Unsafe.As<T, JVector>(ref b.value);
        default:
          throw new ArgumentOutOfRangeException();
      }
    }

    public static bool operator !=(SyncableValue<T> a, SyncableValue<T> b) => !(a == b);

    public override int GetHashCode() => this.value.GetHashCode();

    public override string ToString() => this.expression != null ? string.Format("{0} (exp: {1})", (object) this.value, (object) this.expression()) : this.value.ToString();
  }
}
