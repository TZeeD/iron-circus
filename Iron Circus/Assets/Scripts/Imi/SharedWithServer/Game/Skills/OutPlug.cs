// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.OutPlug
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public struct OutPlug
  {
    public int index;
    public List<InPlug> inPlugs;

    public void Add(InPlug inPlug)
    {
      if (this.inPlugs == null)
        this.inPlugs = new List<InPlug>();
      this.inPlugs.Add(inPlug);
    }

    public void Fire(SkillGraph skillGraph)
    {
      if (skillGraph.IsSyncing() || skillGraph.IsDestroyed() || this.inPlugs == null)
        return;
      foreach (InPlug inPlug in this.inPlugs)
        inPlug.plug();
    }

    public static OutPlug operator +(OutPlug outPlug, InPlug inPlug)
    {
      outPlug.Add(inPlug);
      return outPlug;
    }
  }
}
