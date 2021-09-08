// Decompiled with JetBrains decompiler
// Type: Imi.Diagnostics.Log
// Assembly: ImiDiagnostics, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9CCF0324-3C3A-43B7-BFB6-8D5767C31D69
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\ImiDiagnostics.dll

using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Threading;

namespace Imi.Diagnostics
{
  public class Log
  {
    private static readonly ThreadLocal<Log> logTL = new ThreadLocal<Log>();
    public readonly string Name;

    public static void Api(string msg) => Log.DefaultLog.LogDebug(LogCategory.Api, msg);

    private static Log DefaultLog => Log.logTL.Value ?? (Log.logTL.Value = LogFactory.GetLogger(nameof (Log)));

    public event Log.LogDelegate OnLog;

    public Log(string name) => this.Name = name;

    public void LogError(string msg)
    {
      Log.DecorateMsg(ref msg);
      UnityEngine.Debug.LogError((object) msg);
      Log.LogDelegate onLog = this.OnLog;
      if (onLog == null)
        return;
      onLog(msg);
    }

    public void LogWarning(string msg)
    {
      Log.DecorateMsg(ref msg);
      UnityEngine.Debug.LogWarning((object) msg);
      Log.LogDelegate onLog = this.OnLog;
      if (onLog == null)
        return;
      onLog(msg);
    }

    public void LogDebug(LogCategory category, string msg)
    {
      if (category == LogCategory.Debug)
        Log.DecorateMsg(ref msg);
      else
        Log.DecorateMsg(ref msg, category.ToString().ToUpper());
      UnityEngine.Debug.Log((object) msg);
      Log.LogDelegate onLog = this.OnLog;
      if (onLog == null)
        return;
      onLog(msg);
    }

    public static void Volatile(string msg) => Log.DefaultLog.LogDebug(LogCategory.Debug, msg);

    public static void Debug(string msg) => Log.DefaultLog.LogDebug(LogCategory.Debug, msg);

    public static void Warning(string msg) => Log.DefaultLog.LogWarning(msg);

    public static void Error(string msg) => Log.DefaultLog.LogError(msg);

    [Conditional("DECORATE_LOGS")]
    private static void DecorateMsg(ref string msg, string category = null)
    {
      category = category != null ? "[" + category + "]" : "";
      msg = DateTime.UtcNow.ToString("H:mm:ss.fff") + ": " + category + " " + msg;
    }

    [MethodImpl((MethodImplOptions) 256)]
    private static string GetStackTrace()
    {
      StackTrace stackTrace = new StackTrace(true);
      string str = "";
      for (int index = 0; index < stackTrace.FrameCount; ++index)
      {
        StackFrame frame = stackTrace.GetFrame(index);
        str += string.Format("\nMethod: {0}, {1}", (object) frame.GetMethod(), (object) frame.GetFileLineNumber());
      }
      return str;
    }

    public static void Netcode(string msg) => Log.DefaultLog.LogDebug(LogCategory.Netcode, msg);

    [Conditional("FALSE")]
    public static void NetcodeTrace(string msg) => Log.DefaultLog.LogDebug(LogCategory.NetcodeTrace, msg);

    [Conditional("FALSE")]
    public static void Skills(string msg) => Log.DefaultLog.LogDebug(LogCategory.Skills, msg);

    public delegate void LogDelegate(string message);
  }
}
