// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.AnimationStates
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public class AnimationStates
  {
    public AnimationStates.TypedState[] entries;
    public byte[] typesToRemove;
    private static AnimationStateType maxTypeValue = Enum.GetValues(typeof (AnimationStateType)).Cast<AnimationStateType>().Last<AnimationStateType>();
    private static List<AnimationStates.TypedState> Merge_resultEntries = new List<AnimationStates.TypedState>(16);

    public bool IsDiff => this.typesToRemove != null;

    public bool IsEmpty()
    {
      if (this.entries != null && this.entries.Length != 0)
        return false;
      return this.typesToRemove == null || this.typesToRemove.Length == 0;
    }

    public bool IsToRemove(AnimationStateType t)
    {
      if (this.typesToRemove == null)
        return false;
      for (int index = 0; index < this.typesToRemove.Length; ++index)
      {
        if ((int) this.typesToRemove[index] == (int) (byte) t)
          return true;
      }
      return false;
    }

    public AnimationStates CalcDiff(AnimationStates prev)
    {
      AnimationStates animationStates = new AnimationStates();
      if (prev == null)
      {
        animationStates.entries = this.entries;
        return animationStates;
      }
      List<AnimationStates.TypedState> typedStateList = new List<AnimationStates.TypedState>(16);
      if (this.entries != null)
      {
        for (int index = 0; index < this.entries.Length; ++index)
        {
          AnimationStateType type = this.entries[index].Type;
          int typeIndex = prev.FindTypeIndex(type);
          if (typeIndex < 0)
            typedStateList.Add(this.entries[index]);
          else if (this.entries[index].State.variation != prev.entries[typeIndex].State.variation || (double) this.entries[index].State.normalizedProgress != (double) prev.entries[typeIndex].State.normalizedProgress)
            typedStateList.Add(this.entries[index]);
        }
      }
      animationStates.entries = typedStateList.ToArray();
      List<byte> byteList = new List<byte>(16);
      if (prev.entries != null)
      {
        for (int index = 0; index < prev.entries.Length; ++index)
        {
          AnimationStateType type = prev.entries[index].Type;
          if (this.FindTypeIndex(type) < 0)
            byteList.Add((byte) type);
        }
      }
      animationStates.typesToRemove = byteList.ToArray();
      return animationStates;
    }

    public static AnimationStates Merge(AnimationStates prev, AnimationStates diff)
    {
      if (prev == null)
        prev = new AnimationStates();
      if (diff == null)
        return prev;
      if (!diff.IsDiff)
        return diff;
      AnimationStates.Merge_resultEntries.Clear();
      if (diff.entries != null)
      {
        for (int index = 0; index < diff.entries.Length; ++index)
          AnimationStates.Merge_resultEntries.Add(diff.entries[index]);
      }
      if (prev.entries != null)
      {
        for (int index = 0; index < prev.entries.Length; ++index)
        {
          if (!diff.IsToRemove(prev.entries[index].Type) && diff.FindTypeIndex(prev.entries[index].Type) < 0)
            AnimationStates.Merge_resultEntries.Add(prev.entries[index]);
        }
      }
      return new AnimationStates()
      {
        entries = AnimationStates.Merge_resultEntries.ToArray()
      };
    }

    public void SerializeOrDeserialize(IMessageSerDes sd)
    {
      if (sd.IsSerializer())
      {
        byte num = this.entries == null ? (byte) 0 : (byte) this.entries.Length;
        sd.Byte(ref num);
        if (this.entries != null)
        {
          for (int index = 0; index < this.entries.Length; ++index)
          {
            byte type = (byte) this.entries[index].Type;
            sd.Byte(ref type);
            this.entries[index].State.SerializeDeserialize(sd);
          }
        }
      }
      else
      {
        byte num1 = 0;
        sd.Byte(ref num1);
        if (this.entries == null || this.entries.Length != (int) num1)
          this.entries = new AnimationStates.TypedState[(int) num1];
        for (int index = 0; index < (int) num1; ++index)
        {
          byte num2 = 0;
          sd.Byte(ref num2);
          this.entries[index].Type = (AnimationStateType) num2;
          this.entries[index].State.SerializeDeserialize(sd);
        }
      }
      bool flag = this.typesToRemove == null;
      sd.Bool(ref flag);
      sd.ByteArray(ref this.typesToRemove);
      if (sd.IsSerializer())
        return;
      if (flag)
      {
        this.typesToRemove = (byte[]) null;
      }
      else
      {
        if (this.typesToRemove != null)
          return;
        this.typesToRemove = new byte[0];
      }
    }

    public bool HasType(AnimationStateType t)
    {
      if (this.entries == null)
        return false;
      foreach (AnimationStates.TypedState entry in this.entries)
      {
        if (entry.Type == t)
          return true;
      }
      return false;
    }

    public int FindTypeIndex(AnimationStateType t)
    {
      if (this.entries == null)
        return -1;
      for (int index = 0; index < this.entries.Length; ++index)
      {
        if (this.entries[index].Type == t)
          return index;
      }
      return -1;
    }

    public static AnimationStates CreateFrom(AnimationStateComponent source)
    {
      if (source == null)
        return new AnimationStates();
      int count = source.animationStateData.Count;
      AnimationStates animationStates = new AnimationStates();
      animationStates.entries = new AnimationStates.TypedState[count];
      int num = 0;
      foreach (KeyValuePair<AnimationStateType, AnimationState> keyValuePair in source.animationStateData)
        animationStates.entries[num++] = new AnimationStates.TypedState()
        {
          Type = keyValuePair.Key,
          State = keyValuePair.Value
        };
      return animationStates;
    }

    public void ApplyTo(AnimationStateComponent target)
    {
      if (target == null)
        return;
      if (this.entries == null)
      {
        target.RemoveAll();
      }
      else
      {
        for (int index = 0; (AnimationStateType) index <= AnimationStates.maxTypeValue; ++index)
        {
          AnimationStateType animationStateType = (AnimationStateType) index;
          int typeIndex = this.FindTypeIndex(animationStateType);
          if (typeIndex >= 0)
          {
            if (target.HasType(animationStateType))
              target.animationStateData[animationStateType] = this.entries[typeIndex].State;
            else
              target.animationStateData.Add(animationStateType, this.entries[typeIndex].State);
          }
          else if (target.HasType(animationStateType))
            target.RemoveState(animationStateType);
        }
      }
      if (this.typesToRemove == null)
        return;
      foreach (byte num in this.typesToRemove)
        target.RemoveState((AnimationStateType) num);
    }

    public bool Equals(AnimationStates other)
    {
      if (this.entries == null != (other.entries == null) || this.typesToRemove == null != (other.typesToRemove == null))
        return false;
      if (this.entries != null)
      {
        if (this.entries.Length != other.entries.Length)
          return false;
        for (int index = 0; index < this.entries.Length; ++index)
        {
          int typeIndex = other.FindTypeIndex(this.entries[index].Type);
          if (typeIndex < 0)
            return false;
          float num = Math.Abs(this.entries[index].State.normalizedProgress - other.entries[typeIndex].State.normalizedProgress);
          if (this.entries[index].State.variation != other.entries[typeIndex].State.variation || (double) num > 0.00999999977648258)
            return false;
        }
      }
      if (this.typesToRemove != null)
      {
        if (this.typesToRemove.Length != other.typesToRemove.Length)
          return false;
        for (int index = 0; index < this.typesToRemove.Length; ++index)
        {
          if ((int) this.typesToRemove[index] != (int) other.typesToRemove[index])
            return false;
        }
      }
      return true;
    }

    public override string ToString()
    {
      string str1 = "[";
      if (this.entries == null)
      {
        str1 += "null";
      }
      else
      {
        foreach (AnimationStates.TypedState entry in this.entries)
          str1 += string.Format("[{0}, {1}, {2}]", (object) entry.Type, (object) entry.State.variation, (object) entry.State.normalizedProgress);
      }
      if (this.typesToRemove != null)
      {
        string str2 = str1 + "[toRemove: ";
        foreach (byte num in this.typesToRemove)
          str2 += string.Format("[{0}]", (object) num);
        str1 = str2 + "]";
      }
      return str1 + "]";
    }

    public struct TypedState
    {
      public AnimationStateType Type;
      public AnimationState State;
    }
  }
}
