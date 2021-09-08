// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.Logging.Appenders.FileAppender
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.IO;

namespace Imi.SharedWithServer.Utils.Logging.Appenders
{
  public class FileAppender
  {
    private readonly StreamWriter writer;

    public FileAppender(string logFileBaseName, string postfix) => this.writer = File.AppendText(FileAppender.FullFilenameFor(logFileBaseName, postfix));

    public static string FullFilenameFor(string logFileBaseName, string postfix) => string.IsNullOrEmpty(postfix) ? logFileBaseName + ".log" : logFileBaseName + "_" + postfix + ".log";

    public void Log(string message)
    {
      this.writer.WriteLine(message);
      this.writer.Flush();
    }
  }
}
