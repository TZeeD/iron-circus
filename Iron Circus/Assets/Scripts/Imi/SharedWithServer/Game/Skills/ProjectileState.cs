// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ProjectileState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ProjectileState : SkillState
  {
    public ConfigValue<JVector> spawnOffset;
    public ConfigValue<float> initialSpeed;
    public ConfigValue<float> maxLifeTime;
    public ConfigValue<float> maxTravelDistance;
    public ConfigValue<int> numBounces;
    public ConfigValue<int> impactDamage;
    public ConfigValue<float> stunDuration;
    public ConfigValue<float> pushDistance;
    public ConfigValue<float> pushDuration;
    public ConfigValue<float> collisionRadius;
    public ConfigValue<float> collisionHeight;
    public ConfigValue<float> rotationSpeed;
    public ConfigValue<GameObject> prefab;
    public SkillVar<UniqueId> hitEntity;
    public SkillVar<JVector> projectilePosition;
    public SkillVar<JVector> throwDir;
    [SyncValue]
    public SyncableValue<JVector> serverPosition;
    [SyncValue]
    public SyncableValue<JVector> serverVelocity;
    [SyncValue]
    public SyncableValue<UniqueId> projectileId;
    public Action<GameEntity> onProjectileCreated;
    public Action<GameEntity> onBeforeProjectileDestroy;
    public Action<ImpactParameters> onImpactDelegate;
    public OutPlug OnImpact;
    private GameEntity projectile;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.serverPosition.Parse(serializationInfo, ref valueIndex, this.Name + ".serverPosition");
      this.serverVelocity.Parse(serializationInfo, ref valueIndex, this.Name + ".serverVelocity");
      this.projectileId.Parse(serializationInfo, ref valueIndex, this.Name + ".projectileId");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.serverPosition.Serialize(target, ref valueIndex);
      this.serverVelocity.Serialize(target, ref valueIndex);
      this.projectileId.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.serverPosition.Deserialize(target, ref valueIndex);
      this.serverVelocity.Deserialize(target, ref valueIndex);
      this.projectileId.Deserialize(target, ref valueIndex);
    }

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    public ProjectileState()
    {
      this.OnImpact = this.AddOutPlug();
      this.projectileId.Set(UniqueId.Invalid);
    }

    protected override void EnterDerived()
    {
      if (!this.skillGraph.IsServer())
        return;
      TransformComponent transform = this.skillGraph.GetOwner().transform;
      JVector jvector = JVector.Transform(this.spawnOffset.Get(), JMatrix.CreateFromQuaternion(JQuaternion.LookRotation((JVector) this.throwDir, JVector.Up)));
      this.serverPosition.Set(transform.position + jvector);
      if (this.throwDir != null)
        this.serverVelocity.Set(((JVector) this.throwDir).Normalized() * this.initialSpeed.Get());
      else
        this.serverVelocity.Set(transform.Forward * this.initialSpeed.Get());
      this.projectile = this.CreateProjectile();
      this.projectileId.Set(this.projectile.uniqueId.id);
    }

    protected override void TickDerived()
    {
      if (this.projectilePosition != null && this.projectile != null)
        this.projectilePosition.Set(this.projectile.transform.Position2D);
      if (this.skillGraph.IsClient())
      {
        if (this.skillGraph.IsRepredicting() || !this.IsIdSet() || this.projectile != null)
          return;
        this.projectile = this.CreateProjectile();
      }
      else
      {
        if (this.projectile != null && this.projectile.isEnabled)
          this.serverPosition.Set(this.projectile.transform.position);
        if (this.projectile != null && this.projectile.isEnabled && !this.projectile.isDestroyed)
          return;
        this.Exit_();
      }
    }

    protected override void OnBecameInactiveThisTick()
    {
      if (this.skillGraph.IsServer())
      {
        this.projectileId.Set(UniqueId.Invalid);
      }
      else
      {
        if (this.projectile == null)
          return;
        if (this.projectile.isEnabled && !this.projectile.isDestroyed)
          this.projectile.isDestroyed = true;
        this.projectile = (GameEntity) null;
      }
    }

    private bool IsIdSet() => this.projectileId.Get() != UniqueId.Invalid;

    private GameEntity CreateProjectile()
    {
      GameEntity projectileEntity;
      if (this.skillGraph.IsClient())
      {
        projectileEntity = this.skillGraph.GetContext().CreateEntity();
        projectileEntity.AddUniqueId(this.projectileId.Get());
      }
      else
        projectileEntity = this.skillGraph.GetEntityFactory().CreateEntityWithUniqueId();
      this.skillGraph.GetEntityFactory().InitializeProjectile(projectileEntity, this.skillGraph.GetOwnerId(), ProjectileType.Shield, this.collisionRadius.Get(), this.collisionHeight.Get(), this.serverPosition.Get(), JQuaternion.LookRotation(this.serverVelocity.Get().Normalized(), JVector.Up), this.serverVelocity.Get(), new ProjectileImpactEffect());
      projectileEntity.projectile.onImpact = new Action<ImpactParameters>(this.ImpactCallback);
      projectileEntity.projectile.bounceOnImpact = this.numBounces.Get();
      projectileEntity.projectile.maxTravelDistance = this.maxTravelDistance.Get();
      projectileEntity.projectile.lifeTimeLimit = this.maxLifeTime.Get();
      projectileEntity.projectile.spinSpeed = this.rotationSpeed.Get();
      this.skillGraph.GetContext().gamePhysics.world.AddBody(projectileEntity.rigidbody.value);
      projectileEntity.transform.position = this.serverPosition.Get();
      if ((UnityEngine.Object) this.prefab.Get() != (UnityEngine.Object) null)
      {
        GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.prefab.Get());
        projectileEntity.ReplaceUnityView(gameObject);
        gameObject.Link((IEntity) projectileEntity, (IContext) this.skillGraph.GetContext());
        gameObject.transform.position = projectileEntity.transform.position.ToVector3();
        gameObject.transform.localRotation = projectileEntity.transform.rotation.ToQuaternion();
      }
      projectileEntity.isReplicate = true;
      Action<GameEntity> projectileCreated = this.onProjectileCreated;
      if (projectileCreated != null)
        projectileCreated(projectileEntity);
      return projectileEntity;
    }

    public void ImpactCallback(ImpactParameters impactParams)
    {
      GameEntity collider = impactParams.collider;
      if (collider != null && collider.hasUniqueId && this.hitEntity != null)
        this.hitEntity.Set(impactParams.collider.uniqueId.id);
      if (this.skillGraph.IsServer() && collider != null && collider.isPlayer && collider.playerTeam.value != this.skillGraph.GetOwner().playerTeam.value)
      {
        JVector direction = this.projectile.velocityOverride.value.Normalized();
        ulong instigatorPlayerId = this.skillGraph.GetOwner().playerId.value;
        if ((double) this.stunDuration.Get() > 0.0)
          collider.AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Stun(instigatorPlayerId, this.stunDuration.Get()));
        if ((double) this.pushDistance.Get() > 0.0 && (double) this.pushDuration.Get() > 0.0)
          collider.AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Push(instigatorPlayerId, direction, this.pushDistance.Get(), this.pushDuration.Get()));
        this.impactDamage.Get();
      }
      this.OnImpact.Fire(this.skillGraph);
      Action<ImpactParameters> onImpactDelegate = this.onImpactDelegate;
      if (onImpactDelegate == null)
        return;
      onImpactDelegate(impactParams);
    }
  }
}
