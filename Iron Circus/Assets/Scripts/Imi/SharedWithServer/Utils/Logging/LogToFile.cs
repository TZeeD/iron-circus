// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.Logging.LogToFile
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

namespace Imi.SharedWithServer.Utils.Logging
{
  public static class LogToFile
  {
    public const string InputLog = "input.txt";
    public const string Debug = "debug_log.txt";
    public const string Skills = "skill_log.txt";
    public static Dictionary<string, StreamWriter> files = new Dictionary<string, StreamWriter>();

    [Conditional("SC_LOG_TO_FILE")]
    public static void Clear(string filePath)
    {
      if (LogToFile.files.ContainsKey(filePath))
      {
        LogToFile.files[filePath].Close();
        LogToFile.files.Remove(filePath);
      }
      if (!File.Exists(filePath))
        return;
      File.Delete(filePath);
    }

    [Conditional("SC_LOG_TO_FILE")]
    public static void AppendLine(string filePath, string text)
    {
      if (!LogToFile.files.ContainsKey(filePath))
        LogToFile.files[filePath] = File.AppendText(filePath);
      LogToFile.files[filePath].Write(text + "\n");
      LogToFile.files[filePath].Flush();
    }

    [Conditional("SC_LOG_TO_FILE")]
    public static void Append(string filePath, string text)
    {
      if (!LogToFile.files.ContainsKey(filePath))
        LogToFile.files[filePath] = File.AppendText(filePath);
      LogToFile.files[filePath].Write(text);
      LogToFile.files[filePath].Flush();
    }

    [Conditional("SC_LOG_TO_FILE")]
    public static void Flush(string filePath) => LogToFile.files[filePath].Flush();

    [Conditional("LOG_SKILL_CALLS")]
    public static void SkillAppend(string text)
    {
      if (!LogToFile.files.ContainsKey("skill_log.txt"))
        LogToFile.files["skill_log.txt"] = File.AppendText("skill_log.txt");
      LogToFile.files["skill_log.txt"].Write(text);
      LogToFile.files["skill_log.txt"].Flush();
    }
  }
}
