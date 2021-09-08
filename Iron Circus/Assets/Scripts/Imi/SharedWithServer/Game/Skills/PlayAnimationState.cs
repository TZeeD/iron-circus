// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.PlayAnimationState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class PlayAnimationState : SkillState
  {
    public ConfigValue<AnimationStateType> animationType;
    [SyncValue]
    public SyncableValue<float> normalizedProgress;
    [SyncValue]
    public SyncableValue<int> variation;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.normalizedProgress.Parse(serializationInfo, ref valueIndex, this.Name + ".normalizedProgress");
      this.variation.Parse(serializationInfo, ref valueIndex, this.Name + ".variation");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.normalizedProgress.Serialize(target, ref valueIndex);
      this.variation.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.normalizedProgress.Deserialize(target, ref valueIndex);
      this.variation.Deserialize(target, ref valueIndex);
    }

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public PlayAnimationState() => this.normalizedProgress.Set(-1f);

    protected override void EnterDerived() => this.UpdateValue();

    protected override void TickDerived() => this.UpdateValue();

    private void UpdateValue() => this.skillGraph.GetOwner().animationState.AddReplaceState(this.animationType.Get(), new AnimationState()
    {
      normalizedProgress = this.normalizedProgress.Get(),
      variation = this.variation.Get()
    });

    protected override void OnBecameInactiveThisTick() => this.skillGraph.GetOwner().animationState.RemoveState(this.animationType.Get());
  }
}
