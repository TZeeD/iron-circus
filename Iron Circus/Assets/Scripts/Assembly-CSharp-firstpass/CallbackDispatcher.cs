// Decompiled with JetBrains decompiler
// Type: Steamworks.CallbackDispatcher
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using UnityEngine;

namespace Steamworks
{
  public static class CallbackDispatcher
  {
    public static void ExceptionHandler(Exception e) => Debug.LogException(e);
  }
}
