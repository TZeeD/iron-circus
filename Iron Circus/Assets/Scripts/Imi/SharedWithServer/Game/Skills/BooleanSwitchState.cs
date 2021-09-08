// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.BooleanSwitchState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class BooleanSwitchState : SkillState
  {
    public Func<bool> condition;
    public Action onTrue;
    public Action onFalse;
    public Action whileTrueDelegate;
    public Action whileFalseDelegate;
    public OutPlug OnTrue;
    public OutPlug OnFalse;
    public SubStates WhileFalseSubState;
    public SubStates WhileTrueSubState;
    [SyncValue]
    private SyncableValue<bool> wasTrue;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.wasTrue.Parse(serializationInfo, ref valueIndex, this.Name + ".wasTrue");

    public override void Serialize(byte[] target, ref int valueIndex) => this.wasTrue.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.wasTrue.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickOnlyLocalEntity;

    public BooleanSwitchState()
    {
      this.OnTrue = this.AddOutPlug();
      this.OnFalse = this.AddOutPlug();
    }

    protected override void EnterDerived()
    {
      this.wasTrue.Set(!this.condition());
      this.TickLogic();
    }

    protected override void TickDerived() => this.TickLogic();

    private void TickLogic()
    {
      bool flag = this.condition();
      if (flag && !(bool) this.wasTrue)
      {
        this.OnTrue.Fire(this.skillGraph);
        this.WhileTrueSubState.Fire(this.skillGraph);
        this.WhileFalseSubState.Abort(this.skillGraph);
        Action onTrue = this.onTrue;
        if (onTrue != null)
          onTrue();
      }
      if (!flag && (bool) this.wasTrue)
      {
        this.OnFalse.Fire(this.skillGraph);
        this.WhileFalseSubState.Fire(this.skillGraph);
        this.WhileTrueSubState.Abort(this.skillGraph);
        Action onFalse = this.onFalse;
        if (onFalse != null)
          onFalse();
      }
      if (flag)
      {
        Action whileTrueDelegate = this.whileTrueDelegate;
        if (whileTrueDelegate != null)
          whileTrueDelegate();
      }
      if (!flag)
      {
        Action whileFalseDelegate = this.whileFalseDelegate;
        if (whileFalseDelegate != null)
          whileFalseDelegate();
      }
      this.wasTrue.Set(flag);
    }

    protected override void ExitDerived()
    {
      this.WhileTrueSubState.Abort(this.skillGraph);
      this.WhileFalseSubState.Abort(this.skillGraph);
      this.wasTrue.Set(false);
    }
  }
}
