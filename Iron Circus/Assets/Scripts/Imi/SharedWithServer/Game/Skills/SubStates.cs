// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SubStates
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public struct SubStates
  {
    public List<SkillState> states;

    public void AddState(SkillState state)
    {
      if (this.states == null)
        this.states = new List<SkillState>();
      if (this.states.Contains(state))
        return;
      this.states.Add(state);
    }

    public void Fire(SkillGraph skillGraph)
    {
      if (skillGraph.IsSyncing() || skillGraph.IsDestroyed() || this.states == null)
        return;
      foreach (SkillState state in this.states)
        state.Enter_();
    }

    public void Abort(SkillGraph skillGraph)
    {
      if (skillGraph.IsSyncing() || skillGraph.IsDestroyed() || this.states == null)
        return;
      foreach (SkillState state in this.states)
        state.Exit_();
    }

    public static SubStates operator +(SubStates plug, SkillState state)
    {
      plug.AddState(state);
      return plug;
    }

    public override string ToString()
    {
      string str = "";
      if (this.states != null)
      {
        foreach (SkillState state in this.states)
          str = str + "[" + state.Name + "], ";
      }
      return str;
    }
  }
}
