// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SkillDebugUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using SkillGraphDebugging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Imi.SharedWithServer.Game.Skills
{
  public static class SkillDebugUtils
  {
    public const string ActiveColorString = "#00ff00";
    public const string SyncedColorString = "#e3b520";
    public const string HeaderColor = "#6888bd";
    private static Dictionary<Type, DebugInfo> typeDebugInfo = new Dictionary<Type, DebugInfo>();
    private static StringBuilder builder = new StringBuilder();

    private static void Setup(Type type)
    {
      DebugInfo debugInfo = new DebugInfo();
      debugInfo.typeName = SkillDebugUtils.GetDebugTypeName(type);
      List<FieldInfo> fieldInfoList = new List<FieldInfo>();
      foreach (FieldInfo field in type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic))
      {
        Type fieldType = field.FieldType;
        if (fieldType.IsPrimitive || fieldType.Name.Contains("Plug") || fieldType.Name.Contains("SubStates") || fieldType.Name.Contains("ConfigValue") || fieldType.Name.Contains("SyncableValue"))
          fieldInfoList.Add(field);
      }
      debugInfo.fields = fieldInfoList.ToArray();
      SkillDebugUtils.typeDebugInfo[type] = debugInfo;
    }

    private static DebugInfo GetDebugInfo(object instance)
    {
      Type type = instance.GetType();
      if (!SkillDebugUtils.typeDebugInfo.ContainsKey(type))
        SkillDebugUtils.Setup(type);
      return SkillDebugUtils.typeDebugInfo[type];
    }

    public static string GetDebugInfoString(object instance)
    {
      DebugInfo debugInfo = SkillDebugUtils.GetDebugInfo(instance);
      SkillDebugUtils.builder.Clear();
      string str = "";
      switch (instance)
      {
        case SkillState _:
          str = (instance as SkillState).Name;
          break;
        case SkillAction _:
          str = (instance as SkillAction).Name;
          break;
      }
      SkillDebugUtils.builder.Append("[" + debugInfo.typeName + "] " + str + ":\n");
      foreach (FieldInfo field in debugInfo.fields)
      {
        object obj = field.GetValue(instance);
        if (CustomAttributeExtensions.IsDefined((MemberInfo) field, typeof (SyncValueAttribute)))
          SkillDebugUtils.builder.Append(string.Format("<color={0}>- {1}: {2}</color>\n", (object) "#e3b520", (object) field.Name, obj));
        else
          SkillDebugUtils.builder.Append(string.Format("- {0}: {1}\n", (object) field.Name, obj));
      }
      return SkillDebugUtils.builder.ToString();
    }

    public static SkillGraphDebugNode ToDebugNode(
      SkillGraph skillGraph,
      object instance,
      int startIdx,
      out int endIdx)
    {
      DebugInfo debugInfo = SkillDebugUtils.GetDebugInfo(instance);
      SkillGraphDebugNode skillGraphDebugNode = new SkillGraphDebugNode();
      string str = "";
      int length1 = 0;
      int length2 = 0;
      switch (instance)
      {
        case SkillState skillState:
          str = skillState.Name;
          length1 = skillState.inPlugs.Count;
          length2 = skillState.outPlugs.Count;
          break;
        case SkillAction skillAction:
          str = skillAction.Name;
          length1 = skillAction.inPlugs.Count;
          length2 = skillAction.outPlugs.Count;
          break;
      }
      SkillGraphDebugPlug[] skillGraphDebugPlugArray1 = new SkillGraphDebugPlug[length1];
      SkillGraphDebugPlug[] skillGraphDebugPlugArray2 = new SkillGraphDebugPlug[length2];
      skillGraphDebugNode.subStates = new List<SkillGraphDebugPlug>();
      foreach (FieldInfo field in debugInfo.fields)
      {
        Type fieldType = field.FieldType;
        SkillGraphDebugPlug skillGraphDebugPlug1;
        if (fieldType == typeof (InPlug))
        {
          SkillGraphDebugPlug[] skillGraphDebugPlugArray3 = skillGraphDebugPlugArray1;
          int index = ((InPlug) field.GetValue(instance)).index;
          skillGraphDebugPlug1 = new SkillGraphDebugPlug();
          skillGraphDebugPlug1.displayName = field.Name ?? "";
          SkillGraphDebugPlug skillGraphDebugPlug2 = skillGraphDebugPlug1;
          skillGraphDebugPlugArray3[index] = skillGraphDebugPlug2;
        }
        else if (fieldType == typeof (OutPlug))
        {
          OutPlug outPlug = (OutPlug) field.GetValue(instance);
          List<PlugAddress> plugAddressList1 = new List<PlugAddress>();
          if (outPlug.inPlugs != null)
          {
            for (int index = 0; index < outPlug.inPlugs.Count; ++index)
            {
              InPlug inPlug = outPlug.inPlugs[index];
              PlugAddress plugAddress1;
              if (inPlug.owner is SkillState owner18)
              {
                List<PlugAddress> plugAddressList2 = plugAddressList1;
                plugAddress1 = new PlugAddress();
                plugAddress1.nodeIndex = skillGraph.GetDebugNodeIdx(owner18);
                plugAddress1.plugIndex = inPlug.index;
                PlugAddress plugAddress2 = plugAddress1;
                plugAddressList2.Add(plugAddress2);
              }
              else if (inPlug.owner is SkillAction owner19)
              {
                List<PlugAddress> plugAddressList3 = plugAddressList1;
                plugAddress1 = new PlugAddress();
                plugAddress1.nodeIndex = skillGraph.GetDebugNodeIdx(owner19);
                plugAddress1.plugIndex = inPlug.index;
                PlugAddress plugAddress3 = plugAddress1;
                plugAddressList3.Add(plugAddress3);
              }
            }
          }
          SkillGraphDebugPlug[] skillGraphDebugPlugArray4 = skillGraphDebugPlugArray2;
          int index1 = outPlug.index;
          skillGraphDebugPlug1 = new SkillGraphDebugPlug();
          skillGraphDebugPlug1.displayName = field.Name ?? "";
          skillGraphDebugPlug1.targets = plugAddressList1;
          SkillGraphDebugPlug skillGraphDebugPlug3 = skillGraphDebugPlug1;
          skillGraphDebugPlugArray4[index1] = skillGraphDebugPlug3;
        }
        else if (fieldType.Name.Contains("SubStates"))
        {
          List<SkillGraphDebugPlug> subStates = skillGraphDebugNode.subStates;
          skillGraphDebugPlug1 = new SkillGraphDebugPlug();
          skillGraphDebugPlug1.displayName = field.Name ?? "";
          SkillGraphDebugPlug skillGraphDebugPlug4 = skillGraphDebugPlug1;
          subStates.Add(skillGraphDebugPlug4);
        }
      }
      skillGraphDebugNode.inPlugs = ((IEnumerable<SkillGraphDebugPlug>) skillGraphDebugPlugArray1).ToList<SkillGraphDebugPlug>();
      skillGraphDebugNode.outPlugs = ((IEnumerable<SkillGraphDebugPlug>) skillGraphDebugPlugArray2).ToList<SkillGraphDebugPlug>();
      skillGraphDebugNode.displayName = "[" + debugInfo.typeName + "] " + str;
      skillGraphDebugNode.nodeVariables = new List<SkillGraphDebugVar>();
      foreach (FieldInfo field in debugInfo.fields)
      {
        Type type = field.FieldType;
        SyncableValueType syncableValueType = SyncableValueType.Unknown;
        int num = 0;
        if (type.IsGenericType && type.Name.StartsWith("SyncableValue"))
          type = type.GetGenericArguments()[0];
        if (type == typeof (bool))
        {
          syncableValueType = SyncableValueType.Bool;
          num = 1;
        }
        if (type == typeof (float))
        {
          syncableValueType = SyncableValueType.Float;
          num = 4;
        }
        if (type == typeof (JVector))
        {
          syncableValueType = SyncableValueType.JVector;
          num = 12;
        }
        if (syncableValueType != SyncableValueType.Unknown)
          skillGraphDebugNode.nodeVariables.Add(new SkillGraphDebugVar()
          {
            name = field.Name,
            debugValueRef = new DebugValueReference()
            {
              idx = startIdx,
              type = syncableValueType
            }
          });
        startIdx += num;
      }
      endIdx = startIdx;
      return skillGraphDebugNode;
    }

    private static string GetDebugTypeName(Type type)
    {
      string str;
      if (type.IsGenericType)
      {
        Type[] genericArguments = type.GetGenericArguments();
        str = genericArguments.Length != 1 ? type.Name.Remove(type.Name.IndexOf('`')) + "<NumTypeParams != 1>" : type.Name.Remove(type.Name.IndexOf('`')) + "<" + genericArguments[0].Name + ">";
      }
      else
        str = type.Name;
      return str;
    }

    public static void SerializeDebugDataInto(
      object instance,
      byte[] destination,
      int startIdx,
      out int endIdx)
    {
      DebugInfo debugInfo = SkillDebugUtils.GetDebugInfo(instance);
      if (debugInfo.fields == null || debugInfo.fields.Length == 0)
      {
        endIdx = startIdx;
      }
      else
      {
        for (int index = 0; index < debugInfo.fields.Length; ++index)
        {
          FieldInfo field = debugInfo.fields[index];
          Type type = field.FieldType;
          FieldInfo fieldInfo = field;
          object obj = instance;
          int length = 0;
          byte[] numArray = (byte[]) null;
          if (type.IsGenericType && type.Name.StartsWith("SyncableValue"))
          {
            fieldInfo = type.GetField("value", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
            type = type.GetGenericArguments()[0];
            obj = field.GetValue(instance);
          }
          if (type == typeof (bool))
          {
            length = 1;
            numArray = BitConverter.GetBytes((bool) fieldInfo.GetValue(obj));
          }
          if (type == typeof (float))
          {
            length = 4;
            numArray = BitConverter.GetBytes((float) fieldInfo.GetValue(obj));
          }
          if (type == typeof (JVector))
          {
            length = 12;
            JVector jvector = (JVector) fieldInfo.GetValue(obj);
            numArray = new byte[12];
            byte[] bytes1 = BitConverter.GetBytes(jvector.X);
            byte[] bytes2 = BitConverter.GetBytes(jvector.Y);
            byte[] bytes3 = BitConverter.GetBytes(jvector.Z);
            numArray[0] = bytes1[0];
            numArray[1] = bytes1[1];
            numArray[2] = bytes1[2];
            numArray[3] = bytes1[3];
            numArray[4] = bytes2[0];
            numArray[5] = bytes2[1];
            numArray[6] = bytes2[2];
            numArray[7] = bytes2[3];
            numArray[8] = bytes3[0];
            numArray[9] = bytes3[1];
            numArray[10] = bytes3[2];
            numArray[11] = bytes3[3];
          }
          if (numArray != null && length > 0)
            Array.Copy((Array) numArray, 0, (Array) destination, startIdx, length);
          startIdx += length;
        }
        endIdx = startIdx;
      }
    }
  }
}
