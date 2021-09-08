// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ConditionAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ConditionAction : SkillAction
  {
    public Func<bool> condition;
    public Action onTrue;
    public Action onFalse;
    public OutPlug OnTrue;
    public OutPlug OnFalse;

    protected override bool DoOnRepredict => true;

    public ConditionAction()
    {
      this.OnTrue = this.AddOutPlug();
      this.OnFalse = this.AddOutPlug();
    }

    protected override void PerformActionInternal()
    {
      if (this.condition != null && this.condition())
      {
        Action onTrue = this.onTrue;
        if (onTrue != null)
          onTrue();
        this.OnTrue.Fire(this.skillGraph);
      }
      else
      {
        Action onFalse = this.onFalse;
        if (onFalse != null)
          onFalse();
        this.OnFalse.Fire(this.skillGraph);
      }
    }
  }
}
