// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SerializedSkillGraphs
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.Utils.Extensions;
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SerializedSkillGraphs
  {
    public const int NumBytesReservedForArraySize = 2;
    private static byte[] buffer = new byte[4096];
    public byte[] serializedGraphs;
    public SerializedSkillGraphInfo[] serializationLayouts;
    public bool isDiff;

    public int DataSize { get; private set; }

    public SerializedSkillGraphs(SerializedSkillGraphInfo[] serializationLayouts = null, bool isDiff = false)
    {
      this.serializationLayouts = serializationLayouts;
      this.isDiff = isDiff;
    }

    [MethodImpl((MethodImplOptions) 256)]
    private static int GetDataSizeInBytes(byte[] serializedSkills) => (int) BitConverter.ToInt16(serializedSkills, 0);

    public void SerializeOrDeserialize(IMessageSerDes sd)
    {
      int length = 0;
      if (sd.IsSerializer() && this.serializedGraphs != null)
        length = SerializedSkillGraphs.GetDataSizeInBytes(this.serializedGraphs) + 2;
      sd.ByteArray(ref this.serializedGraphs, length);
    }

    public void ApplyTo(GameEntity entity)
    {
      int readIndex = 2;
      foreach (SkillGraph skillStateMachine in entity.GetAllSkillStateMachines())
        skillStateMachine.Deserialize(this.serializedGraphs, ref readIndex);
      entity.skillGraph.ownerVars.Deserialize(this.serializedGraphs, ref readIndex);
    }

    public static SerializedSkillGraphs GetCachableSerializedSkillGraph(
      SerializedSkillGraphInfo[] serLayouts = null)
    {
      return new SerializedSkillGraphs(serLayouts)
      {
        serializedGraphs = new byte[2048]
      };
    }

    private static SerializedSkillGraphs CreateFrom(GameEntity entity)
    {
      SerializedSkillGraphs serializedSkillGraphs = new SerializedSkillGraphs(entity.GetAllSkillSerializationLayouts());
      Array.Clear((Array) SerializedSkillGraphs.buffer, 0, SerializedSkillGraphs.buffer.Length);
      SerializedSkillGraphs.CreateFrom(entity, SerializedSkillGraphs.buffer);
      int length = SerializedSkillGraphs.GetDataSizeInBytes(SerializedSkillGraphs.buffer) + 2;
      byte[] numArray = new byte[length];
      Unsafe.CopyBlockUnaligned(ref numArray[0], ref SerializedSkillGraphs.buffer[0], (uint) length);
      serializedSkillGraphs.DataSize = length + 2;
      serializedSkillGraphs.serializedGraphs = numArray;
      return serializedSkillGraphs;
    }

    public static SerializedSkillGraphs CreateFrom(
      GameEntity entity,
      byte[] targetBuffer)
    {
      SerializedSkillGraphs serializedSkillGraphs = new SerializedSkillGraphs(entity.GetAllSkillSerializationLayouts());
      Array.Clear((Array) targetBuffer, 0, targetBuffer.Length);
      int writeIndex = 2;
      foreach (SkillGraph skillStateMachine in entity.GetAllSkillStateMachines())
        skillStateMachine.Serialize(targetBuffer, ref writeIndex);
      entity.skillGraph.ownerVars.Serialize(targetBuffer, ref writeIndex);
      int source = writeIndex - 2;
      Unsafe.CopyBlockUnaligned(ref targetBuffer[0], ref Unsafe.As<int, byte>(ref source), 2U);
      serializedSkillGraphs.DataSize = source + 2;
      serializedSkillGraphs.serializedGraphs = targetBuffer;
      return serializedSkillGraphs;
    }

    public static SerializedSkillGraphs CalcDiff(
      byte[] previous,
      GameEntity entity)
    {
      byte[] serializedGraphs = SerializedSkillGraphs.CreateFrom(entity).serializedGraphs;
      if (previous == null)
        previous = new byte[serializedGraphs.Length];
      SerializedSkillGraphInfo[] serializationLayouts = entity.GetAllSkillSerializationLayouts();
      SerializedSkillGraphs serializedSkillGraphs = new SerializedSkillGraphs(serializationLayouts);
      double num1;
      int num2 = (int) (num1 = (double) serializationLayouts.Length / 8.0);
      int num3 = num2;
      double num4 = (double) num2;
      if (num1 - num4 > 0.0)
        ++num3;
      Array.Clear((Array) SerializedSkillGraphs.buffer, 0, SerializedSkillGraphs.buffer.Length);
      int readIndex = 2;
      int writeIndex = readIndex + num3;
      for (int index1 = 0; index1 < serializationLayouts.Length; ++index1)
      {
        int num5 = writeIndex;
        SerializedSkillGraphs.CalcDiff(previous, serializedGraphs, serializationLayouts[index1], ref readIndex, SerializedSkillGraphs.buffer, ref writeIndex);
        int num6 = writeIndex;
        if (num5 != num6)
        {
          int index2 = 2 + index1 / 8;
          int num7 = index1 % 8;
          SerializedSkillGraphs.buffer[index2] |= (byte) (1 << num7);
        }
      }
      int source = writeIndex - 2;
      Unsafe.CopyBlockUnaligned(ref SerializedSkillGraphs.buffer[0], ref Unsafe.As<int, byte>(ref source), 2U);
      int length = writeIndex;
      byte[] numArray = new byte[length];
      Unsafe.CopyBlockUnaligned(ref numArray[0], ref SerializedSkillGraphs.buffer[0], (uint) length);
      serializedSkillGraphs.DataSize = length;
      serializedSkillGraphs.serializedGraphs = numArray;
      serializedSkillGraphs.isDiff = true;
      return serializedSkillGraphs;
    }

    [MethodImpl((MethodImplOptions) 256)]
    private static void CalcDiff(
      byte[] previous,
      byte[] current,
      SerializedSkillGraphInfo serLayout,
      ref int readIndex,
      byte[] result,
      ref int writeIndex)
    {
      int num1 = writeIndex;
      writeIndex += serLayout.numDirtyBytes;
      List<SerializedSyncValueInfo> serializedSyncValueInfos = serLayout.serializedSyncValueInfos;
      for (int index1 = 0; index1 < serLayout.serializedSyncValueInfos.Count; ++index1)
      {
        int size = serializedSyncValueInfos[index1].size;
        bool flag = false;
        for (int index2 = 0; index2 < size; ++index2)
        {
          int index3 = readIndex + index2;
          if ((int) previous[index3] != (int) current[index3])
          {
            flag = true;
            break;
          }
        }
        if (flag)
        {
          Unsafe.CopyBlockUnaligned(ref result[writeIndex], ref current[readIndex], (uint) size);
          int index4 = num1 + index1 / 8;
          int num2 = index1 % 8;
          result[index4] |= (byte) (1 << num2);
          writeIndex += size;
        }
        readIndex += size;
      }
      if (writeIndex != num1 + serLayout.numDirtyBytes)
        return;
      writeIndex -= serLayout.numDirtyBytes;
    }

    public static void ApplyDiff(byte[] serializedGraphs, byte[] diff, GameEntity entity)
    {
      SerializedSkillGraphInfo[] serializationLayouts = entity.GetAllSkillSerializationLayouts();
      double num1;
      int num2 = (int) (num1 = (double) serializationLayouts.Length / 8.0);
      int num3 = num2;
      double num4 = (double) num2;
      if (num1 - num4 > 0.0)
        ++num3;
      int writeIndex = 2;
      int readIndexDiff = writeIndex + num3;
      for (int index1 = 0; index1 < serializationLayouts.Length; ++index1)
      {
        int index2 = 2 + index1 / 8;
        int num5 = index1 % 8;
        bool isGraphDirty = ((uint) diff[index2] & (uint) (byte) (1 << num5)) > 0U;
        SerializedSkillGraphs.MergeInto(serializedGraphs, diff, ref readIndexDiff, serializationLayouts[index1], ref writeIndex, isGraphDirty);
      }
    }

    [MethodImpl((MethodImplOptions) 256)]
    private static void MergeInto(
      byte[] serializedGraph,
      byte[] diff,
      ref int readIndexDiff,
      SerializedSkillGraphInfo serInfo,
      ref int writeIndex,
      bool isGraphDirty)
    {
      int num1 = readIndexDiff;
      if (isGraphDirty)
        readIndexDiff += serInfo.numDirtyBytes;
      List<SerializedSyncValueInfo> serializedSyncValueInfos = serInfo.serializedSyncValueInfos;
      if (isGraphDirty)
      {
        for (int index1 = 0; index1 < serInfo.serializedSyncValueInfos.Count; ++index1)
        {
          int size = serializedSyncValueInfos[index1].size;
          int index2 = num1 + index1 / 8;
          int num2 = index1 % 8;
          if (((uint) diff[index2] & (uint) (byte) (1 << num2)) > 0U)
          {
            Unsafe.CopyBlockUnaligned(ref serializedGraph[writeIndex], ref diff[readIndexDiff], (uint) size);
            readIndexDiff += size;
          }
          writeIndex += size;
        }
      }
      else
      {
        for (int index = 0; index < serInfo.serializedSyncValueInfos.Count; ++index)
          writeIndex += serializedSyncValueInfos[index].size;
      }
    }

    public override string ToString()
    {
      if (this.serializedGraphs == null)
        return "Data is Null!";
      if (this.serializationLayouts == null)
        return "Configs are Null!";
      string str1 = "";
      string str2;
      if (this.isDiff)
      {
        str2 = str1 + string.Format("DataSize [{0}], ArraySize [{1}]\n", (object) SerializedSkillGraphs.GetDataSizeInBytes(this.serializedGraphs), (object) this.serializedGraphs.Length);
        double num1;
        int num2 = (int) (num1 = (double) this.serializationLayouts.Length / 8.0);
        int num3 = num2;
        double num4 = (double) num2;
        if (num1 - num4 > 0.0)
          ++num3;
        int startIndex = 2 + num3;
        for (int index1 = 0; index1 < this.serializationLayouts.Length; ++index1)
        {
          SerializedSkillGraphInfo serializationLayout = this.serializationLayouts[index1];
          SerializedSkillGraphInfo serializedSkillGraphInfo = serializationLayout;
          str2 += string.Format("[{0}]:  (startIndex = {1})\n", (object) serializationLayout.name, (object) startIndex);
          if (((uint) this.serializedGraphs[2 + index1 / 8] & (uint) (byte) (1 << index1 % 8)) > 0U)
          {
            int num5 = startIndex;
            startIndex += serializedSkillGraphInfo.numDirtyBytes;
            List<SerializedSyncValueInfo> serializedSyncValueInfos = serializedSkillGraphInfo.serializedSyncValueInfos;
            for (int index2 = 0; index2 < serializedSyncValueInfos.Count; ++index2)
            {
              SerializedSyncValueInfo serializedSyncValueInfo = serializedSyncValueInfos[index2];
              if (((uint) this.serializedGraphs[num5 + index2 / 8] & (uint) (byte) (1 << index2 % 8)) > 0U)
              {
                string str3 = SyncableValueUtils.ReadSerializedValueString(this.serializedGraphs, startIndex, serializedSyncValueInfo.type);
                str2 += string.Format("- [{0}][{1}] = {2}\n", (object) serializedSyncValueInfo.type, (object) serializedSyncValueInfo.name, (object) str3);
                startIndex += serializedSyncValueInfo.size;
              }
            }
          }
        }
      }
      else
      {
        int startIndex = 2;
        str2 = str1 + string.Format("ArraySize [{0}], DataSize [{1}]\n", (object) this.serializedGraphs.Length, (object) SerializedSkillGraphs.GetDataSizeInBytes(this.serializedGraphs));
        foreach (SerializedSkillGraphInfo serializationLayout in this.serializationLayouts)
        {
          SerializedSkillGraphInfo serializedSkillGraphInfo = serializationLayout;
          str2 += string.Format("[{0}]:  (startIndex = {1})\n", (object) serializationLayout.name, (object) startIndex);
          foreach (SerializedSyncValueInfo serializedSyncValueInfo in serializedSkillGraphInfo.serializedSyncValueInfos)
          {
            str2 += string.Format("- [{0}][{1}] = {2}\n", (object) serializedSyncValueInfo.type, (object) serializedSyncValueInfo.name, (object) SyncableValueUtils.ReadSerializedValueString(this.serializedGraphs, startIndex, serializedSyncValueInfo.type));
            startIndex += serializedSyncValueInfo.size;
          }
        }
      }
      return str2;
    }
  }
}
