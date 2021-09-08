// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.PlayVfxState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class PlayVfxState : SkillState
  {
    public VfxPrefab vfxPrefab;
    [SyncValue]
    public SyncableValue<JVector> position = (SyncableValue<JVector>) JVector.Zero;
    public SyncableValue<JVector> lookDir = (SyncableValue<JVector>) JVector.Forward;
    public bool parentToOwner = true;
    public bool deferDestructionToEffect;
    public object args;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.position.Parse(serializationInfo, ref valueIndex, this.Name + ".position");

    public override void Serialize(byte[] target, ref int valueIndex) => this.position.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.position.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    protected override void OnBecameActiveThisTick() => VfxManager.StartVfx(this.skillGraph, this.vfxPrefab, this.position.Get(), (JVector) this.lookDir, this.parentToOwner, this.args);

    protected override void OnBecameInactiveThisTick() => VfxManager.StopVfx(this.skillGraph, this.vfxPrefab, this.deferDestructionToEffect);
  }
}
