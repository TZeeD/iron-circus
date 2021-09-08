// Decompiled with JetBrains decompiler
// Type: Discord.ResultException
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Discord
{
  public class ResultException : Exception
  {
    public readonly Result Result;

    public ResultException(Result result)
      : base(result.ToString())
    {
    }
  }
}
