// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.SerializedStatusEffects
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Imi.SharedWithServer.Game
{
  public class SerializedStatusEffects : IEquatable<SerializedStatusEffects>
  {
    public StatusEffect[] effects;
    public byte[] refIndices;

    public bool IsDiff => this.refIndices != null;

    public void CalcModifierStack(
      out StatusEffectType effectStack,
      out StatusModifier modifierStack)
    {
      StatusEffect.CalcModifierStack((IEnumerable<StatusEffect>) this.effects, out effectStack, out modifierStack);
    }

    public int Find(StatusEffect needle)
    {
      if (this.effects == null)
        return -1;
      for (int index = 0; index < this.effects.Length; ++index)
      {
        if (this.effects[index].Equals(needle))
          return index;
      }
      return -1;
    }

    public void SerializeOrDeserialize(IMessageSerDes sd)
    {
      bool flag = this.refIndices == null;
      sd.Bool(ref flag);
      sd.ByteArray(ref this.refIndices);
      if (!sd.IsSerializer())
      {
        if (flag)
          this.refIndices = (byte[]) null;
        else if (this.refIndices == null)
          this.refIndices = new byte[0];
      }
      if (sd.IsSerializer())
      {
        byte num = this.effects == null ? (byte) 0 : (byte) this.effects.Length;
        sd.Byte(ref num);
        if (this.effects == null)
          return;
        foreach (StatusEffect effect in this.effects)
          effect.SerializeOrDeserialize(sd);
      }
      else
      {
        byte num = 0;
        sd.Byte(ref num);
        if (this.effects == null || this.effects.Length != (int) num)
          this.effects = new StatusEffect[(int) num];
        for (int index = 0; index < (int) num; ++index)
          this.effects[index] = StatusEffect.Deserialize(sd);
      }
    }

    private static bool IsEqualArray(byte[] a, byte[] b)
    {
      if (a == null && b == null)
        return true;
      if (a == null || b == null || a.Length != b.Length)
        return false;
      for (int index = 0; index < a.Length; ++index)
      {
        if ((int) a[index] != (int) b[index])
          return false;
      }
      return true;
    }

    public bool Equals(SerializedStatusEffects other)
    {
      if (other == null || this.refIndices == null != (other.refIndices == null) || this.refIndices != null && other.refIndices != null && !SerializedStatusEffects.IsEqualArray(this.refIndices, other.refIndices))
        return false;
      if (other.effects == null && this.effects == null)
        return true;
      if (other.effects == null || this.effects == null || other.effects.Length != this.effects.Length)
        return false;
      for (int index = 0; index < this.effects.Length; ++index)
      {
        if (!this.effects[index].Equals(other.effects[index]))
          return false;
      }
      return true;
    }

    public bool IsEmpty()
    {
      if (this.refIndices == null)
      {
        if (this.effects == null || this.effects.Length == 0)
          return true;
      }
      else if (this.refIndices.Length == 0)
        return true;
      return false;
    }

    public static SerializedStatusEffects CreateFrom(
      List<StatusEffect> source)
    {
      SerializedStatusEffects serializedStatusEffects = new SerializedStatusEffects();
      if (source == null)
        return serializedStatusEffects;
      int length = 0;
      for (int index = 0; index < source.Count; ++index)
      {
        if (source[index] != null)
          ++length;
      }
      serializedStatusEffects.effects = new StatusEffect[length];
      int num = 0;
      for (int index = 0; index < source.Count; ++index)
      {
        if (source[index] != null)
          serializedStatusEffects.effects[num++] = new StatusEffect(source[index]);
      }
      return serializedStatusEffects;
    }

    public List<StatusEffect> ToList() => this.effects == null ? new List<StatusEffect>() : ((IEnumerable<StatusEffect>) this.effects).ToList<StatusEffect>();

    public static SerializedStatusEffects CalcDiff(
      SerializedStatusEffects prev,
      SerializedStatusEffects current)
    {
      SerializedStatusEffects serializedStatusEffects = new SerializedStatusEffects();
      if (prev == null)
      {
        serializedStatusEffects.effects = current.effects;
        return serializedStatusEffects;
      }
      serializedStatusEffects.refIndices = new byte[current.effects.Length];
      List<StatusEffect> statusEffectList = new List<StatusEffect>(32);
      for (int index = 0; index < current.effects.Length && prev.effects != null; ++index)
      {
        int num = prev.Find(current.effects[index]);
        if (num < 0)
        {
          statusEffectList.Add(current.effects[index]);
          serializedStatusEffects.refIndices[index] = (byte) (statusEffectList.Count - 1);
        }
        else
          serializedStatusEffects.refIndices[index] = (byte) (128 + num);
      }
      serializedStatusEffects.effects = statusEffectList.ToArray();
      return serializedStatusEffects;
    }

    public static SerializedStatusEffects Merge(
      SerializedStatusEffects prev,
      SerializedStatusEffects diff,
      out bool shouldHaveCrashed)
    {
      shouldHaveCrashed = false;
      if (prev == null)
        prev = new SerializedStatusEffects();
      if (diff == null)
        return prev;
      if (!diff.IsDiff)
        return diff;
      SerializedStatusEffects serializedStatusEffects = new SerializedStatusEffects();
      serializedStatusEffects.effects = new StatusEffect[diff.refIndices.Length];
      for (int index1 = 0; index1 < diff.refIndices.Length; ++index1)
      {
        byte refIndex = diff.refIndices[index1];
        if (refIndex < (byte) 128)
        {
          serializedStatusEffects.effects[index1] = diff.effects[(int) refIndex];
        }
        else
        {
          int index2 = (int) refIndex - 128;
          if (prev.effects == null || index2 >= prev.effects.Length)
          {
            Log.Error(string.Format("Error merging StatusEffects for existing index {0}! \nPREV: {1}\nDIFF: {2}\n\n", (object) index2, (object) prev, (object) diff));
            shouldHaveCrashed = true;
          }
          else
            serializedStatusEffects.effects[index1] = prev.effects[index2];
        }
      }
      return serializedStatusEffects;
    }

    public override string ToString()
    {
      string str1 = "" + (this.IsDiff ? "[diff, " : "[abs, ");
      if (this.refIndices != null)
      {
        string str2 = str1 + string.Format("indices: {0}, effects: {1}] {{", (object) this.refIndices.Length, (object) this.effects.Length);
        foreach (byte refIndex in this.refIndices)
        {
          bool flag = refIndex < (byte) 128;
          int index = flag ? (int) refIndex : (int) refIndex - 128;
          str2 = this.effects == null || this.effects.Length <= index ? (this.effects != null ? (this.effects.Length >= index ? str2 + string.Format("effect[{0} ({1})], ", (object) index, (object) refIndex) : str2 + string.Format("effect[{0} ({1})] out of range, ", (object) index, (object) refIndex)) : str2 + "null, ") : (!flag ? str2 + string.Format("ref: {0}, ", (object) index) : str2 + string.Format("new: {0}, ", (object) this.effects[index]));
        }
        str1 = str2 + "}";
      }
      else if (this.effects != null)
      {
        string str3 = str1 + string.Format("indices: null, effects: {0}] {{", (object) this.effects.Length);
        foreach (StatusEffect effect in this.effects)
          str3 = effect == null ? str3 + "null, " : str3 + string.Format("eff: {0}, ", (object) effect);
        str1 = str3 + "}";
      }
      return str1;
    }
  }
}
