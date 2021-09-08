// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ApplyStatusMofifierToOwnerState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ApplyStatusMofifierToOwnerState : SkillState
  {
    public StatusModifier modifier;
    [SyncValue]
    public SyncableValue<float> duration;
    [SyncValue]
    private SyncableValue<int> startTick;
    private SkillVar<bool> stop;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.duration.Parse(serializationInfo, ref valueIndex, this.Name + ".duration");
      this.startTick.Parse(serializationInfo, ref valueIndex, this.Name + ".startTick");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.duration.Serialize(target, ref valueIndex);
      this.startTick.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.duration.Deserialize(target, ref valueIndex);
      this.startTick.Deserialize(target, ref valueIndex);
    }

    public override void Initialize()
    {
      this.stop = this.skillGraph.AddVar<bool>("[ApplyStatusModifier] " + this.name + ".StopStatusEffect");
      this.duration.Set(-1f);
    }

    protected override void EnterDerived()
    {
      this.stop.Set(false);
      this.startTick.Set(this.skillGraph.GetTick());
      if ((double) this.duration.Get() <= 0.0)
        this.skillGraph.GetOwner().AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Custom(this.skillGraph.GetOwnerId(), this.modifier, 1000f, this.stop));
      else
        this.skillGraph.GetOwner().AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Custom(this.skillGraph.GetOwnerId(), this.modifier, this.duration.Get(), this.stop));
    }

    protected override void TickDerived()
    {
      if ((double) this.duration.Get() <= 0.0 || (double) (this.skillGraph.GetTick() - (int) this.startTick) * (double) this.skillGraph.GetFixedTimeStep() < (double) this.duration.Get())
        return;
      this.Exit_();
    }

    protected override void ExitDerived() => this.stop.Set(true);
  }
}
