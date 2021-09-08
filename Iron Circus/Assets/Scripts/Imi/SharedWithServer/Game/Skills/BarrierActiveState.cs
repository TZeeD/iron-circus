// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.BarrierActiveState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using Imi.SharedWithServer.Config;
using Imi.SteelCircus.JitterUnity;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SharedWithServer.Game;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SharedWithServer.Game.Skills
{
  public class BarrierActiveState : SkillState
  {
    public ConfigValue<JVector> barrierDimensions;
    public ConfigValue<GameObject> prefab;
    public Func<JVector> barrierPosition;
    public Func<JVector> barrierLookDir;
    [SyncValue]
    public SyncableValue<JVector> cachedPos;
    [SyncValue]
    public SyncableValue<JVector> cachedLookDir;
    [SyncValue]
    public SyncableValue<UniqueId> barrierEntityId;
    private GameEntity barrierEntity;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.cachedPos.Parse(serializationInfo, ref valueIndex, this.Name + ".cachedPos");
      this.cachedLookDir.Parse(serializationInfo, ref valueIndex, this.Name + ".cachedLookDir");
      this.barrierEntityId.Parse(serializationInfo, ref valueIndex, this.Name + ".barrierEntityId");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.cachedPos.Serialize(target, ref valueIndex);
      this.cachedLookDir.Serialize(target, ref valueIndex);
      this.barrierEntityId.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.cachedPos.Deserialize(target, ref valueIndex);
      this.cachedLookDir.Deserialize(target, ref valueIndex);
      this.barrierEntityId.Deserialize(target, ref valueIndex);
    }

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    public BarrierActiveState() => this.barrierEntityId.Set(UniqueId.Invalid);

    protected override void EnterDerived()
    {
      if (!this.skillGraph.IsServer())
        return;
      if (this.barrierEntity != null)
      {
        this.barrierEntity.isDestroyed = true;
        this.barrierEntity = (GameEntity) null;
      }
      this.cachedPos = (SyncableValue<JVector>) this.barrierPosition();
      this.cachedLookDir = (SyncableValue<JVector>) this.barrierLookDir();
      JVector colliderOffset = this.barrierDimensions.Get();
      colliderOffset.X = colliderOffset.Z = 0.0f;
      colliderOffset.Y /= -2f;
      this.barrierEntity = this.skillGraph.GetEntityFactory().CreatePhysicsEntity(ColliderType.Box, this.barrierDimensions.Get(), colliderOffset, "ServitorBarrier");
      JQuaternion jquaternion = JQuaternion.LookRotation(this.cachedLookDir.Get(), JVector.Up);
      this.barrierEntity.ReplaceTransform(this.cachedPos.Get(), jquaternion);
      this.barrierEntity.rigidbody.value.Position = this.cachedPos.Get();
      this.barrierEntity.rigidbody.value.Orientation = JMatrix.CreateFromQuaternion(jquaternion);
      this.barrierEntityId.Set(this.barrierEntity.uniqueId.id);
    }

    protected override void TickDerived()
    {
      if (!this.skillGraph.IsClient() || this.skillGraph.IsSyncing() || this.skillGraph.IsRepredicting() || this.barrierEntity != null || !(this.barrierEntityId.Get() != UniqueId.Invalid))
        return;
      JVector colliderOffset = this.barrierDimensions.Get();
      colliderOffset.X = colliderOffset.Z = 0.0f;
      colliderOffset.Y /= -2f;
      this.barrierEntity = this.skillGraph.GetEntityFactory().CreatePhysicsEntity(ColliderType.Box, this.barrierDimensions.Get(), colliderOffset, "ServitorBarrier");
      JQuaternion jquaternion = JQuaternion.LookRotation(this.cachedLookDir.Get(), JVector.Up);
      this.barrierEntity.ReplaceTransform(this.cachedPos.Get(), jquaternion);
      this.barrierEntity.rigidbody.value.Position = this.cachedPos.Get();
      this.barrierEntity.rigidbody.value.Orientation = JMatrix.CreateFromQuaternion(jquaternion);
      this.barrierEntity.ReplaceUniqueId(this.barrierEntityId.Get());
      if (!((UnityEngine.Object) this.prefab.Get() != (UnityEngine.Object) null))
        return;
      GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.prefab.Get());
      gameObject.transform.localPosition = this.cachedPos.Get().ToVector3();
      gameObject.transform.rotation = this.barrierEntity.transform.rotation.ToQuaternion();
      gameObject.transform.localScale = this.barrierDimensions.Get().ToVector3();
      this.barrierEntity.AddUnityView(gameObject);
      gameObject.Link((IEntity) this.barrierEntity, (IContext) this.skillGraph.GetContext());
      gameObject.transform.position = this.barrierEntity.transform.position.ToVector3();
      gameObject.transform.localRotation = this.barrierEntity.transform.rotation.ToQuaternion();
    }

    protected override void ExitDerived()
    {
      if (this.barrierEntity != null)
      {
        JRigidbody body = this.barrierEntity.rigidbody.value;
        if (body != null)
          this.skillGraph.GetContext().gamePhysics.world.RemoveBody(body);
        this.barrierEntity.isDestroyed = true;
        this.barrierEntity = (GameEntity) null;
      }
      this.barrierEntityId.Set(UniqueId.Invalid);
    }
  }
}
