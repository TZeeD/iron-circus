// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ChangeCollisionLayerMaskState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ChangeCollisionLayerMaskState : SkillState
  {
    [SyncValue]
    public SyncableValue<UniqueId> targetEntityId;
    public CollisionLayer setToLayer;
    public CollisionLayer setToMask;
    private int originalLayer;
    private int originalMask;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.targetEntityId.Parse(serializationInfo, ref valueIndex, this.Name + ".targetEntityId");

    public override void Serialize(byte[] target, ref int valueIndex) => this.targetEntityId.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.targetEntityId.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    protected override void EnterDerived()
    {
      GameEntity entity = this.skillGraph.GetEntity(this.targetEntityId.Get());
      if (entity == null || !entity.hasRigidbody)
        return;
      if (entity.isPlayer)
      {
        this.originalLayer = (int) CollisionLayerUtils.GetLayerForTeam(entity.playerTeam.value);
        this.originalMask = (int) CollisionLayerUtils.GetMaskForTeam(entity.playerTeam.value);
      }
      else
      {
        this.originalLayer = entity.rigidbody.value.CollisionLayer;
        this.originalMask = entity.rigidbody.value.CollisionMask;
      }
      entity.rigidbody.value.CollisionLayer = (int) this.setToLayer;
      entity.rigidbody.value.CollisionMask = (int) this.setToMask;
    }

    protected override void ExitDerived()
    {
      GameEntity entity = this.skillGraph.GetEntity(this.targetEntityId.Get());
      if (entity == null || !entity.hasRigidbody)
        return;
      entity.rigidbody.value.CollisionLayer = this.originalLayer;
      entity.rigidbody.value.CollisionMask = this.originalMask;
    }
  }
}
