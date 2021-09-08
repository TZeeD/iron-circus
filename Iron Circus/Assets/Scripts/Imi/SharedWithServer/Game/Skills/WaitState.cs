// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.WaitState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class WaitState : SkillState
  {
    public ConfigValue<float> duration;
    public Action<float> onUpdate;
    public Action onFinishDelegate;
    public OutPlug OnFinish;
    [SyncValue]
    private SyncableValue<int> startTick;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.startTick.Parse(serializationInfo, ref valueIndex, this.Name + ".startTick");

    public override void Serialize(byte[] target, ref int valueIndex) => this.startTick.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.startTick.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickOnlyLocalEntity;

    public float NormalizedProgress { private set; get; }

    public WaitState() => this.OnFinish = this.AddOutPlug();

    protected override void EnterDerived() => this.startTick = (SyncableValue<int>) this.skillGraph.GetTick();

    protected override void TickDerived()
    {
      this.NormalizedProgress = (double) this.duration.Get() <= 0.0 ? 1f : JMath.Clamp01((float) (this.skillGraph.GetTick() - (int) this.startTick) * this.skillGraph.GetFixedTimeStep() / this.duration.Get());
      if ((double) this.NormalizedProgress >= 1.0)
      {
        this.UpdateListeners(1f);
        this.Exit_();
        Action onFinishDelegate = this.onFinishDelegate;
        if (onFinishDelegate != null)
          onFinishDelegate();
        this.OnFinish.Fire(this.skillGraph);
      }
      else
        this.UpdateListeners(this.NormalizedProgress);
    }

    private void UpdateListeners(float t)
    {
      if (this.onUpdate == null)
        return;
      this.onUpdate(t);
    }
  }
}
