// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.WaitWithLagCompensation
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class WaitWithLagCompensation : SkillState
  {
    public ConfigValue<float> minDuration;
    public Action onEarlyServerExit;
    public OutPlug OnServerExit;
    [SyncValue]
    private SyncableValue<int> progressInTicks;
    private SyncableValue<int> durationInTicks;
    private bool earlyServerExitCalled;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.progressInTicks.Parse(serializationInfo, ref valueIndex, this.Name + ".progressInTicks");

    public override void Serialize(byte[] target, ref int valueIndex) => this.progressInTicks.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.progressInTicks.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickOnlyLocalEntity;

    public WaitWithLagCompensation() => this.OnServerExit = this.AddOutPlug();

    protected override void EnterDerived()
    {
      this.progressInTicks.Set(0);
      this.earlyServerExitCalled = false;
      float fixedTimeStep = this.skillGraph.GetFixedTimeStep();
      this.durationInTicks.Set((int) Math.Ceiling((double) this.minDuration.Get() / (double) fixedTimeStep));
      int rttt = this.skillGraph.GetRttt();
      if (rttt <= this.durationInTicks.Get())
        return;
      this.durationInTicks.Set(rttt);
    }

    protected override void ExitDerived()
    {
      this.progressInTicks.Set(0);
      this.earlyServerExitCalled = false;
    }

    protected override void TickDerived()
    {
      this.progressInTicks.Set(this.progressInTicks.Get() + 1);
      if (this.skillGraph.IsServer() && !this.earlyServerExitCalled && this.progressInTicks.Get() >= this.GetEarlyServerExitDuration())
      {
        Action onEarlyServerExit = this.onEarlyServerExit;
        if (onEarlyServerExit != null)
          onEarlyServerExit();
        this.OnServerExit.Fire(this.skillGraph);
        this.earlyServerExitCalled = true;
      }
      if (this.progressInTicks.Get() < this.durationInTicks.Get())
        return;
      this.Exit_();
    }

    private int GetEarlyServerExitDuration() => this.durationInTicks.Get() - this.skillGraph.GetRttt();
  }
}
