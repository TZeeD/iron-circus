// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.OnEventAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Game.Skills
{
  public class OnEventAction : SkillAction
  {
    public Action onTriggerDelegate;
    public OutPlug OnTrigger;

    protected override bool DoOnRepredict => true;

    public OnEventAction() => this.OnTrigger = this.AddOutPlug();

    public SkillGraphEvent EventType
    {
      set => this.skillGraph.AddEventListener(value, new Action(((SkillAction) this).PerformAction));
    }

    protected override void PerformActionInternal()
    {
      if (this.onTriggerDelegate != null)
        this.onTriggerDelegate();
      this.OnTrigger.Fire(this.skillGraph);
    }
  }
}
