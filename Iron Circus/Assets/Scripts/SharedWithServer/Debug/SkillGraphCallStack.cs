// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Debug.SkillGraphCallStack
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using System.Diagnostics;

namespace SharedWithServer.Debug
{
  public static class SkillGraphCallStack
  {
    private static List<SkillGraphCallStackEntry> callStack = new List<SkillGraphCallStackEntry>();
    private static int currentDepth = 0;

    public static List<SkillGraphCallStackEntry> CallStack => SkillGraphCallStack.callStack;

    public static int Depth => SkillGraphCallStack.currentDepth;

    [Conditional("SKILL_CALL_STACK")]
    public static void Clear()
    {
      SkillGraphCallStack.callStack.Clear();
      SkillGraphCallStack.currentDepth = 0;
    }

    [Conditional("SKILL_CALL_STACK")]
    public static void Push(SkillGraphCallType type, string info)
    {
      SkillGraphCallStackEntry graphCallStackEntry = new SkillGraphCallStackEntry()
      {
        type = type,
        info = info
      };
      SkillGraphCallStack.callStack.Add(graphCallStackEntry);
      ++SkillGraphCallStack.currentDepth;
    }

    [Conditional("SKILL_CALL_STACK")]
    public static void Pop()
    {
      SkillGraphCallStack.callStack.Add(new SkillGraphCallStackEntry()
      {
        type = SkillGraphCallType.Pop,
        info = ""
      });
      --SkillGraphCallStack.currentDepth;
    }

    public static string GetString()
    {
      string str = "";
      int num = 0;
      foreach (SkillGraphCallStackEntry call in SkillGraphCallStack.callStack)
      {
        if (call.type == SkillGraphCallType.Pop)
        {
          --num;
        }
        else
        {
          for (int index = 0; index < num; ++index)
            str += "\t";
          str += string.Format("[{0}] {1}\n", (object) call.type, (object) call.info);
          ++num;
        }
      }
      return str;
    }
  }
}
