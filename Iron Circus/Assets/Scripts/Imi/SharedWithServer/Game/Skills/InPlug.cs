// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.InPlug
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Game.Skills
{
  public struct InPlug
  {
    public int index;
    public object owner;
    public Action plug;

    public InPlug(object owner, int index, Action plug)
    {
      this.owner = owner;
      this.index = index;
      this.plug = plug;
    }
  }
}
