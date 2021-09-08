// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ApplyScrambleAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ApplyScrambleAction : SkillAction
  {
    public SkillVar<UniqueId> targetEntities;
    [SyncValue]
    public SyncableValue<float> duration;

    protected override void PerformActionInternal()
    {
      if (!this.skillGraph.IsServer())
        return;
      for (int i = 0; i < this.targetEntities.Length; ++i)
        this.skillGraph.GetEntity(this.targetEntities[i])?.AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Scramble(this.skillGraph.GetOwnerId(), this.duration.Get()));
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.duration.Parse(serializationInfo, ref valueIndex, this.Name + ".duration");

    public override void Serialize(byte[] target, ref int valueIndex) => this.duration.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.duration.Deserialize(target, ref valueIndex);
  }
}
