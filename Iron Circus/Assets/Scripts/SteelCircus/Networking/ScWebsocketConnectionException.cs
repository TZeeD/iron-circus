// Decompiled with JetBrains decompiler
// Type: SteelCircus.Networking.ScWebsocketConnectionException
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace SteelCircus.Networking
{
  public class ScWebsocketConnectionException : Exception
  {
    public ScWebsocketConnectionException(string msg)
      : base(msg)
    {
    }

    public ScWebsocketConnectionException(string msg, Exception inner)
      : base(msg, inner)
    {
    }
  }
}
