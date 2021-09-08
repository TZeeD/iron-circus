// Decompiled with JetBrains decompiler
// Type: Common
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Diagnostics;
using UnityEngine;

public class Common
{
  [Conditional("DEBUG")]
  public static void Log(object message) => UnityEngine.Debug.Log(message);

  [Conditional("DEBUG")]
  public static void Log(string format, params object[] args) => UnityEngine.Debug.Log((object) string.Format(format, args));

  [Conditional("DEBUG")]
  public static void LogWarning(object message, Object context) => UnityEngine.Debug.LogWarning(message, context);

  [Conditional("DEBUG")]
  public static void LogWarning(Object context, string format, params object[] args) => UnityEngine.Debug.LogWarning((object) string.Format(format, args), context);

  [Conditional("DEBUG")]
  public static void Warning(bool condition, object message)
  {
    if (condition)
      return;
    UnityEngine.Debug.LogWarning(message);
  }

  [Conditional("DEBUG")]
  public static void Warning(bool condition, object message, Object context)
  {
    if (condition)
      return;
    UnityEngine.Debug.LogWarning(message, context);
  }

  [Conditional("DEBUG")]
  public static void Warning(bool condition, Object context, string format, params object[] args)
  {
    if (condition)
      return;
    UnityEngine.Debug.LogWarning((object) string.Format(format, args), context);
  }

  [Conditional("ASSERT")]
  public static void Assert(bool condition)
  {
    if (!condition)
      throw new UnityException();
  }

  [Conditional("ASSERT")]
  public static void Assert(bool condition, string message)
  {
    if (!condition)
      throw new UnityException(message);
  }

  [Conditional("ASSERT")]
  public static void Assert(bool condition, string format, params object[] args)
  {
    if (!condition)
      throw new UnityException(string.Format(format, args));
  }
}
