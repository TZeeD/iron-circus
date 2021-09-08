// Decompiled with JetBrains decompiler
// Type: Imi.Diagnostics.LogFactory
// Assembly: ImiDiagnostics, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9CCF0324-3C3A-43B7-BFB6-8D5767C31D69
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\ImiDiagnostics.dll

using System.Collections.Generic;
using System.Threading;

namespace Imi.Diagnostics
{
  public static class LogFactory
  {
    private static readonly ThreadLocal<Log.LogDelegate> appendersTL = new ThreadLocal<Log.LogDelegate>();
    private static readonly ThreadLocal<Dictionary<string, Log>> loggersTL = new ThreadLocal<Dictionary<string, Log>>();

    private static Dictionary<string, Log> Loggers
    {
      get => LogFactory.loggersTL.Value ?? (LogFactory.loggersTL.Value = new Dictionary<string, Log>());
      set => LogFactory.loggersTL.Value = value;
    }

    private static Log.LogDelegate Appenders
    {
      get => LogFactory.appendersTL.Value;
      set => LogFactory.appendersTL.Value = value;
    }

    public static void AddAppender(Log.LogDelegate appender)
    {
      LogFactory.Appenders += appender;
      foreach (Log log in LogFactory.Loggers.Values)
        log.OnLog += appender;
    }

    public static void RemoveAppender(Log.LogDelegate appender)
    {
      LogFactory.Appenders -= appender;
      foreach (Log log in LogFactory.Loggers.Values)
        log.OnLog -= appender;
    }

    public static Log GetLogger(string loggerName)
    {
      Log logger;
      if (!LogFactory.Loggers.TryGetValue(loggerName, out logger))
      {
        logger = LogFactory.CreateLogger(loggerName);
        LogFactory.Loggers.Add(loggerName, logger);
      }
      return logger;
    }

    private static Log CreateLogger(string loggerName)
    {
      Log log = new Log(loggerName);
      log.OnLog += LogFactory.Appenders;
      return log;
    }

    public static void Reset()
    {
      LogFactory.Loggers.Clear();
      LogFactory.Appenders = (Log.LogDelegate) null;
    }
  }
}
