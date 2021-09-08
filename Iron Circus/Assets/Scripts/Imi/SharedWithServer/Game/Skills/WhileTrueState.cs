// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.WhileTrueState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Game.Skills
{
  public class WhileTrueState : SkillState
  {
    public Func<bool> condition;

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickOnlyLocalEntity;

    protected override void TickDerived()
    {
      if (this.condition())
        return;
      this.Exit_();
    }
  }
}
