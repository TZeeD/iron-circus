// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.ProjectileSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class ProjectileSystem : ExecuteGameSystem
  {
    private IGroup<GameEntity> projectiles;

    public ProjectileSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.projectiles = this.gameContext.GetGroup(GameMatcher.Projectile);
    }

    protected override void GameExecute()
    {
      foreach (GameEntity projectile in this.projectiles)
      {
        this.HandleImpact(projectile);
        if (!projectile.isDestroyed)
          this.HandleMovement(projectile);
      }
    }

    private void HandleMovement(GameEntity projectile)
    {
      if (projectile.isDestroyed)
        return;
      float fixedSimTimeStep = this.gameContext.globalTime.fixedSimTimeStep;
      JVector newPosition = projectile.transform.position + projectile.velocityOverride.value * fixedSimTimeStep;
      projectile.ReplaceTransform(newPosition, projectile.transform.rotation);
      float num = projectile.velocityOverride.value.Length() * fixedSimTimeStep;
      projectile.projectile.traveledDistance += num;
      projectile.projectile.timeAlive += fixedSimTimeStep;
      bool flag = (double) projectile.projectile.lifeTimeLimit > 1.40129846432482E-45 && (double) projectile.projectile.timeAlive > (double) projectile.projectile.lifeTimeLimit;
      if ((((double) projectile.projectile.maxTravelDistance <= 1.40129846432482E-45 ? 0 : ((double) projectile.projectile.traveledDistance >= (double) projectile.projectile.maxTravelDistance ? 1 : 0)) | (flag ? 1 : 0)) == 0)
        return;
      projectile.isDestroyed = true;
    }

    private void HandleImpact(GameEntity projectile)
    {
      if (!projectile.hasRigidbody)
        return;
      foreach (JCollision jcollision in CollisionUtils.GetTriggerEnterForRigidbody(this.gameContext, projectile.rigidbody.value))
      {
        GameEntity entity2 = jcollision.entity2;
        ImpactParameters impactParameters = new ImpactParameters()
        {
          collider = entity2,
          projectilePosition = projectile.transform.position,
          normal = jcollision.normal,
          penetration = jcollision.penetration
        };
        impactParameters.normal.Y = 0.0f;
        impactParameters.normal.Normalize();
        if (projectile.projectile.projectileType == ProjectileType.Shield)
          ProjectileSystem.ShieldThrowProjectileImpact(projectile);
        if (projectile.projectile.projectileType == ProjectileType.CorrosiveSpit)
          this.CorrosiveSpitImpactHandling(projectile);
        Action<ImpactParameters> onImpact = projectile.projectile.onImpact;
        if (onImpact != null)
          onImpact(impactParameters);
        if (projectile.projectile.bounceOnImpact > 0)
        {
          JVector inVector = projectile.velocityOverride.value;
          inVector.Y = 0.0f;
          inVector.Normalize();
          float num = projectile.velocityOverride.value.Length();
          JVector jvector1 = inVector.Reflect(impactParameters.normal);
          projectile.velocityOverride.value = jvector1 * num;
          JVector jvector2 = projectile.transform.position + jvector1 * impactParameters.penetration;
          projectile.transform.position = jvector2;
          if (projectile.projectile.bounces >= projectile.projectile.bounceOnImpact)
          {
            projectile.isDestroyed = true;
            break;
          }
          ++projectile.projectile.bounces;
        }
        else
          projectile.isDestroyed = true;
      }
    }

    private static void ShieldThrowProjectileImpact(GameEntity projectile) => projectile.projectile.traveledDistance = 0.0f;

    private void CorrosiveSpitImpactHandling(GameEntity projectile)
    {
      GameEntity entityWithPlayerId = this.gameContext.GetFirstEntityWithPlayerId(projectile.projectile.owner);
      foreach (GameEntity gameEntity in this.gameContext.GetGroup(GameMatcher.Player))
      {
        if (this.IsTarget(gameEntity, AoETarget.EnemyTeam, entityWithPlayerId.playerTeam.value))
          this.TryApplyEffect(entityWithPlayerId.playerId.value, gameEntity, projectile.projectile.projectileImpactEffect, projectile.transform);
      }
      projectile.isDestroyed = true;
    }

    public bool IsTarget(GameEntity player, AoETarget target, Team ownerTeam) => target == AoETarget.OwnTeam && player.playerTeam.value == ownerTeam || target == AoETarget.EnemyTeam && player.playerTeam.value != ownerTeam;

    private void TryApplyEffect(
      ulong ownerPlayerId,
      GameEntity affectedPlayer,
      ProjectileImpactEffect impactEffect,
      TransformComponent aoeTransform)
    {
      if (!impactEffect.aoe.IsInRange2D(aoeTransform, affectedPlayer.rigidbody.value))
        return;
      affectedPlayer.playerHealth.modifyHealthEvents.Add(new ModifyHealth(ownerPlayerId, -impactEffect.damage));
    }
  }
}
