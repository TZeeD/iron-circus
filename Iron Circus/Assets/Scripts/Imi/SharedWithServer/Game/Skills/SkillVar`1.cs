// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SkillVar`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SkillVar<T> : SkillVar where T : struct
  {
    private SyncableValue<T> value;
    private SyncableValue<T>[] values;
    private int length;
    private static readonly SyncableValueType VarType = SyncableValueUtils.GetSyncableValueType(typeof (T));
    public Action onModified;

    public int NameHash { get; private set; }

    public int Length => this.length;

    public SkillVar(string name, bool isArray = false)
    {
      this.name = name;
      this.NameHash = name.GetHashCode();
      if (isArray)
      {
        this.values = new SyncableValue<T>[16];
        this.length = 0;
      }
      else
      {
        this.value = new SyncableValue<T>();
        this.value.Set(default (T));
        this.length = 1;
      }
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      if (this.values != null)
      {
        serializationInfo.Add(new SerializedSyncValueInfo()
        {
          type = SyncableValueType.Byte,
          size = 1,
          index = valueIndex,
          name = "[SkillVar] " + this.Name + ".length"
        });
        ++valueIndex;
        for (int index = 0; index < 16; ++index)
          this.values[index].Parse(serializationInfo, ref valueIndex, string.Format("[SkillVar] {0}[{1}]", (object) this.Name, (object) index));
      }
      else
        this.value.Parse(serializationInfo, ref valueIndex, "[SkillVar] " + this.Name);
    }

    public override void Serialize(byte[] target, ref int valueIdx)
    {
      if (this.values != null)
      {
        target[valueIdx++] = (byte) this.length;
        for (int index = 0; index < 16; ++index)
          this.values[index].Serialize(target, ref valueIdx);
      }
      else
        this.value.Serialize(target, ref valueIdx);
    }

    public override void Deserialize(byte[] source, ref int valueIdx)
    {
      if (this.values != null)
      {
        this.length = (int) source[valueIdx++];
        for (int index = 0; index < 16; ++index)
          this.values[index].Deserialize(source, ref valueIdx);
      }
      else
        this.value.Deserialize(source, ref valueIdx);
    }

    public T this[int i]
    {
      get
      {
        if (this.values != null)
          return (T) this.values[i];
        if (i == 0)
          return (T) this.value;
        throw new Exception("SkillVar '" + this.name + "' is not an array but was tried to be accessed as an array");
      }
      set
      {
        if (this.values != null)
        {
          this.values[i].Set(value);
        }
        else
        {
          if (i != 0)
            throw new Exception("SkillVar '" + this.name + "' is not an array but was tried to be accessed as an array");
          this.value.Set(value);
        }
      }
    }

    public void Add(SkillVar<T> other)
    {
      if (this.values != null && other.values != null)
      {
        int num1 = this.length + other.length;
        int num2 = 0;
        for (int length = this.length; length < num1; ++length)
          this.values[length].Set(other[num2++]);
        this.length = num1;
      }
      else
      {
        if (this.values == null)
          return;
        this.values[this.length++] = other.value;
      }
    }

    public void Add(T nValue) => this.values[this.length++].Set(nValue);

    public void Clear()
    {
      for (int index = 0; index < 16; ++index)
        this.values[index].Set(default (T));
      this.length = 0;
    }

    public static implicit operator T(SkillVar<T> skillVar) => skillVar.Get();

    [MethodImpl((MethodImplOptions) 256)]
    public void Set(T value)
    {
      this.value.Set(value);
      Action onModified = this.onModified;
      if (onModified == null)
        return;
      onModified();
    }

    [MethodImpl((MethodImplOptions) 256)]
    public T Get() => this.value.Get();

    [MethodImpl((MethodImplOptions) 256)]
    public void Expression(Func<T> value) => this.value.Expression(value);

    [MethodImpl((MethodImplOptions) 256)]
    public void Set(List<T> values)
    {
      for (int index = 0; index < 16; ++index)
      {
        if (index < values.Count)
          this.values[index].Set(values[index]);
        else
          this.values[index].Set(default (T));
      }
      this.length = values.Count;
    }

    public override string ToString()
    {
      if (this.values == null)
        return "[" + typeof (T).Name + "] " + this.name + ": " + this.value.ToString();
      string str = "[" + typeof (T).Name + "[]] " + this.name + ": [";
      for (int index = 0; index < this.length; ++index)
      {
        T obj = (T) this.values[index];
        str += string.Format("{0}", (object) obj);
        if (index != this.length - 1)
          str += ", ";
      }
      return str + "]";
    }
  }
}
