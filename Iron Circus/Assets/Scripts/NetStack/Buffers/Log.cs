// Decompiled with JetBrains decompiler
// Type: NetStack.Buffers.Log
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace NetStack.Buffers
{
  internal static class Log
  {
    private static string Output(string module, string message) => DateTime.Now.ToString("[HH:mm:ss]") + " [NetStack." + module + "] " + message;

    public static void Info(string module, string message) => Debug.Log((object) Log.Output(module, message));

    public static void Warning(string module, string message) => Debug.LogWarning((object) Log.Output(module, message));
  }
}
