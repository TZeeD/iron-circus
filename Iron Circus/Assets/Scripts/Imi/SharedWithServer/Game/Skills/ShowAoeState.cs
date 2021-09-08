// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ShowAoeState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ShowAoeState : SkillState
  {
    public ConfigValue<bool> showOnlyForLocalPlayer;
    public ConfigValue<AreaOfEffect> aoe;
    [SyncValue]
    public SyncableValue<JVector> offset;
    [SyncValue]
    public SyncableValue<JVector> position;
    [SyncValue]
    public SyncableValue<JVector> lookDir = (SyncableValue<JVector>) JVector.Forward;
    [SyncValue]
    public SyncableValue<bool> trackOwnerPosition;
    [SyncValue]
    private SyncableValue<bool> wasParentedAtSomePoint;
    [SyncValue]
    public SyncableValue<JVector> onUnparentPosition;
    [SyncValue]
    public SyncableValue<JVector> onUnparentLookDir;
    public bool overrideOwnerPosition;
    public bool overrideOwnerLookDir;
    public bool updateAoE;
    private static VfxPrefab defaultAoePrefab = VfxManager.DefaultAoePrefab;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.offset.Parse(serializationInfo, ref valueIndex, this.Name + ".offset");
      this.position.Parse(serializationInfo, ref valueIndex, this.Name + ".position");
      this.lookDir.Parse(serializationInfo, ref valueIndex, this.Name + ".lookDir");
      this.trackOwnerPosition.Parse(serializationInfo, ref valueIndex, this.Name + ".trackOwnerPosition");
      this.wasParentedAtSomePoint.Parse(serializationInfo, ref valueIndex, this.Name + ".wasParentedAtSomePoint");
      this.onUnparentPosition.Parse(serializationInfo, ref valueIndex, this.Name + ".onUnparentPosition");
      this.onUnparentLookDir.Parse(serializationInfo, ref valueIndex, this.Name + ".onUnparentLookDir");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.offset.Serialize(target, ref valueIndex);
      this.position.Serialize(target, ref valueIndex);
      this.lookDir.Serialize(target, ref valueIndex);
      this.trackOwnerPosition.Serialize(target, ref valueIndex);
      this.wasParentedAtSomePoint.Serialize(target, ref valueIndex);
      this.onUnparentPosition.Serialize(target, ref valueIndex);
      this.onUnparentLookDir.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.offset.Deserialize(target, ref valueIndex);
      this.position.Deserialize(target, ref valueIndex);
      this.lookDir.Deserialize(target, ref valueIndex);
      this.trackOwnerPosition.Deserialize(target, ref valueIndex);
      this.wasParentedAtSomePoint.Deserialize(target, ref valueIndex);
      this.onUnparentPosition.Deserialize(target, ref valueIndex);
      this.onUnparentLookDir.Deserialize(target, ref valueIndex);
    }

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    protected override void OnBecameActiveThisTick()
    {
      if (this.SkipExecution())
        return;
      bool flag = this.trackOwnerPosition.Get();
      this.wasParentedAtSomePoint = (SyncableValue<bool>) flag;
      JVector zero = JVector.Zero;
      if (flag)
        zero = this.offset.Get();
      VfxManager.StartAoeVfx(this.skillGraph, this.GetPreviewPrefab(), this.aoe.Get(), zero, JVector.Forward, this.trackOwnerPosition.Get());
      this.UpdateAoeVfx();
    }

    private bool SkipExecution()
    {
      if (this.skillGraph.IsRepredicting())
        return true;
      return this.skillGraph.IsClient() && this.showOnlyForLocalPlayer.Get() && !this.skillGraph.GetOwner().isLocalEntity;
    }

    protected override void TickDerived()
    {
      if (this.SkipExecution())
        return;
      this.UpdateAoeVfx();
    }

    private void UpdateAoeVfx()
    {
      VfxPrefab previewPrefab = this.GetPreviewPrefab();
      bool flag1 = this.trackOwnerPosition.Get();
      bool flag2 = !flag1 && !this.wasParentedAtSomePoint.Get();
      bool flag3 = VfxManager.IsVfxParented(this.skillGraph, previewPrefab);
      JVector forward = JVector.Forward;
      if (this.overrideOwnerLookDir | flag2)
      {
        forward = this.lookDir.Get();
        VfxManager.UpdateRotationVfx(this.skillGraph, previewPrefab, forward, false);
      }
      else if (!flag1 && this.wasParentedAtSomePoint.Get())
      {
        forward = this.onUnparentLookDir.Get();
        VfxManager.UpdateRotationVfx(this.skillGraph, previewPrefab, forward, false);
      }
      if (this.overrideOwnerPosition | flag2)
      {
        JVector jvector = JVector.Transform(this.offset.Get(), JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(forward, JVector.Up)));
        JVector position = this.position.Get() + jvector;
        VfxManager.UpdateVfx(this.skillGraph, previewPrefab, position, false);
      }
      else if (!flag1 && this.wasParentedAtSomePoint.Get())
      {
        JVector jvector = JVector.Transform(this.offset.Get(), JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(forward, JVector.Up)));
        JVector position = this.onUnparentPosition.Get() + jvector;
        VfxManager.UpdateVfx(this.skillGraph, previewPrefab, position, false);
      }
      if (flag1 && !flag3)
      {
        VfxManager.ParentVfx(this.skillGraph, previewPrefab);
        VfxManager.UpdateVfx(this.skillGraph, previewPrefab, this.offset.Get(), true);
        this.wasParentedAtSomePoint = (SyncableValue<bool>) true;
      }
      else if (!flag1 & flag3)
        VfxManager.UnparentVfx(this.skillGraph, previewPrefab);
      if (!this.updateAoE)
        return;
      VfxManager.UpdateVfxAoe(this.skillGraph, previewPrefab, this.aoe.Get());
    }

    private VfxPrefab GetPreviewPrefab()
    {
      AreaOfEffect areaOfEffect = this.aoe.Get();
      return areaOfEffect.vfxPrefab.HasValue ? areaOfEffect.vfxPrefab : ShowAoeState.defaultAoePrefab;
    }

    protected override void OnBecameInactiveThisTick()
    {
      if (this.SkipExecution())
        return;
      VfxManager.StopVfx(this.skillGraph, this.GetPreviewPrefab());
    }
  }
}
