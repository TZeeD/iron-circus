// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SkillAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public abstract class SkillAction
  {
    protected string name;
    public Action thenDelegate;
    public OutPlug Then;
    public InPlug Do;
    public List<InPlug> inPlugs = new List<InPlug>();
    public List<OutPlug> outPlugs = new List<OutPlug>();
    protected SkillGraph skillGraph;

    public string Name => this.name;

    public virtual bool IsNetworked => false;

    protected virtual bool DoOnRepredict => false;

    public string GetName() => this.name;

    public SkillAction(SkillGraph skillGraph, string name)
    {
      this.name = name;
      this.skillGraph = skillGraph;
      skillGraph.AddSkillAction(this);
      this.Do = this.AddInPlug(new Action(this.PerformAction));
      this.Then = this.AddOutPlug();
    }

    public SkillAction()
    {
      this.Do = this.AddInPlug(new Action(this.PerformAction));
      this.Then = this.AddOutPlug();
    }

    protected InPlug AddInPlug(Action action)
    {
      InPlug inPlug = new InPlug((object) this, this.inPlugs.Count, action);
      this.inPlugs.Add(inPlug);
      return inPlug;
    }

    protected OutPlug AddOutPlug()
    {
      int count = this.outPlugs.Count;
      OutPlug outPlug = new OutPlug();
      outPlug.index = count;
      this.outPlugs.Add(outPlug);
      return outPlug;
    }

    public void SetUp(SkillGraph skillGraph, string name)
    {
      this.name = name;
      this.skillGraph = skillGraph;
    }

    public void PerformAction()
    {
      if (!this.skillGraph.IsRepredicting() || this.DoOnRepredict)
      {
        this.PerformActionInternal();
        if (this.IsNetworked)
          this.skillGraph.EnqueueAction(this);
      }
      Action thenDelegate = this.thenDelegate;
      if (thenDelegate != null)
        thenDelegate();
      this.Then.Fire(this.skillGraph);
    }

    protected abstract void PerformActionInternal();

    public virtual void SyncedDo()
    {
    }

    public virtual void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
    }

    public virtual void Serialize(byte[] target, ref int valueIndex)
    {
    }

    public virtual void Deserialize(byte[] target, ref int valueIndex)
    {
    }

    public override string ToString() => SkillDebugUtils.GetDebugInfoString((object) this);
  }
}
