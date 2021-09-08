// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Core.EntitasSystemsBuilder
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.ScEntitas.Systems.Gameplay;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay.Pickup;
using Imi.SharedWithServer.ScEntitas.Systems.Player;
using Imi.SharedWithServer.ScEntitas.Systems.Utility;
using SharedWithServer.ScEntitas.Systems.Gameplay;

namespace Imi.SteelCircus.Core
{
  public class EntitasSystemsBuilder
  {
    private Entitas.Systems systems;
    private InitializeGlobalEntitiesSystem initializeGlobalEntitiesSystem;
    private CollisionEventSystem collisionEventSystem;
    private PhysicsTickSystem physicsTickSystem;
    private TriggerLeaveSystem triggerLeaveSystem;
    private MatchStateSystem matchStateSystem;
    private ScoreSystem scoreSystem;
    private SetupPointSystem setupPointSystem;
    private SetupArenaVariationSystem setupArenaVariationSystem;
    private BallUpdateSystem ballUpdateSystem;
    private ProjectileSystem projectileSystem;
    private GoalCollisionSystem goalCollisionSystem;
    private PickupConsumedSystem pickupConsumedSystem;
    private PlayerHealthSystem playerHealthSystem;
    private PlayerMoveSystem playerMoveSystem;
    private PlayerResetSystem playerResetSystem;
    private RespawnTransformSystem respawnTransformSystem;
    private SkillGraphSystem skillGraphSystem;
    private CountdownSystem countdownSystem;
    private PlayerStateDispatchSystem playerStateDispatchSystem;
    private CollisionCleanupSystem collisionCleanupSystem;
    private DestroyEntitySystem destroyEntitySystem;
    private StatusEffectSystem statusEffectSystem;
    private PickupBehaviourSystem pickupBehaviourSystem;
    private ForcefieldUpdateSystem forcefieldUpdateSystem;

    public EntitasSystemsBuilder(Entitas.Systems systems = null)
    {
      if (systems == null)
        systems = new Entitas.Systems();
      this.systems = systems;
    }

    public EntitasSystemsBuilder With(MatchStateSystem matchStateSystem)
    {
      this.matchStateSystem = matchStateSystem;
      return this;
    }

    public EntitasSystemsBuilder With(SetupPointSystem setupPointSystem)
    {
      this.setupPointSystem = setupPointSystem;
      return this;
    }

    public EntitasSystemsBuilder With(
      SetupArenaVariationSystem setupArenaVariationSystem)
    {
      this.setupArenaVariationSystem = setupArenaVariationSystem;
      return this;
    }

    public EntitasSystemsBuilder With(ScoreSystem scoreSystem)
    {
      this.scoreSystem = scoreSystem;
      return this;
    }

    public EntitasSystemsBuilder With(
      InitializeGlobalEntitiesSystem initializeGlobalEntitiesSystem)
    {
      this.initializeGlobalEntitiesSystem = initializeGlobalEntitiesSystem;
      return this;
    }

    public EntitasSystemsBuilder With(PhysicsTickSystem physicsTickSystem)
    {
      this.physicsTickSystem = physicsTickSystem;
      return this;
    }

    public EntitasSystemsBuilder With(CollisionEventSystem collisionEventSystem)
    {
      this.collisionEventSystem = collisionEventSystem;
      return this;
    }

    public EntitasSystemsBuilder With(TriggerLeaveSystem triggerLeaveSystem)
    {
      this.triggerLeaveSystem = triggerLeaveSystem;
      return this;
    }

    public EntitasSystemsBuilder With(ProjectileSystem projectileSystem)
    {
      this.projectileSystem = projectileSystem;
      return this;
    }

    public EntitasSystemsBuilder With(BallUpdateSystem ballUpdateSystem)
    {
      this.ballUpdateSystem = ballUpdateSystem;
      return this;
    }

    public EntitasSystemsBuilder With(GoalCollisionSystem goalCollisionSystem)
    {
      this.goalCollisionSystem = goalCollisionSystem;
      return this;
    }

    public EntitasSystemsBuilder With(PickupConsumedSystem pickupConsumedSystem)
    {
      this.pickupConsumedSystem = pickupConsumedSystem;
      return this;
    }

    public EntitasSystemsBuilder With(SkillGraphSystem skillGraphSystem)
    {
      this.skillGraphSystem = skillGraphSystem;
      return this;
    }

    public EntitasSystemsBuilder With(PlayerMoveSystem playerMoveSystem)
    {
      this.playerMoveSystem = playerMoveSystem;
      return this;
    }

    public EntitasSystemsBuilder With(PlayerHealthSystem playerHealthSystem)
    {
      this.playerHealthSystem = playerHealthSystem;
      return this;
    }

    public EntitasSystemsBuilder With(
      RespawnTransformSystem respawnTransformSystem)
    {
      this.respawnTransformSystem = respawnTransformSystem;
      return this;
    }

    public EntitasSystemsBuilder With(PlayerResetSystem playerResetSystem)
    {
      this.playerResetSystem = playerResetSystem;
      return this;
    }

    public EntitasSystemsBuilder With(CountdownSystem countdownSystem)
    {
      this.countdownSystem = countdownSystem;
      return this;
    }

    public EntitasSystemsBuilder With(
      PlayerStateDispatchSystem playerStateDispatchSystem)
    {
      this.playerStateDispatchSystem = playerStateDispatchSystem;
      return this;
    }

    public EntitasSystemsBuilder With(
      CollisionCleanupSystem collisionCleanupSystem)
    {
      this.collisionCleanupSystem = collisionCleanupSystem;
      return this;
    }

    public EntitasSystemsBuilder With(DestroyEntitySystem destroyEntitySystem)
    {
      this.destroyEntitySystem = destroyEntitySystem;
      return this;
    }

    public EntitasSystemsBuilder With(StatusEffectSystem statusEffectSystem)
    {
      this.statusEffectSystem = statusEffectSystem;
      return this;
    }

    public EntitasSystemsBuilder With(
      PickupBehaviourSystem pickupBehaviourSystem)
    {
      this.pickupBehaviourSystem = pickupBehaviourSystem;
      return this;
    }

    public EntitasSystemsBuilder With(
      ForcefieldUpdateSystem forcefieldUpdateSystem)
    {
      this.forcefieldUpdateSystem = forcefieldUpdateSystem;
      return this;
    }

    public Entitas.Systems Build()
    {
      this.AddIfNotNull((ISystem) this.initializeGlobalEntitiesSystem);
      this.AddIfNotNull((ISystem) this.forcefieldUpdateSystem);
      this.AddIfNotNull((ISystem) this.countdownSystem);
      this.AddIfNotNull((ISystem) this.matchStateSystem);
      this.AddIfNotNull((ISystem) this.setupPointSystem);
      this.AddIfNotNull((ISystem) this.setupArenaVariationSystem);
      this.AddIfNotNull((ISystem) this.scoreSystem);
      this.AddIfNotNull((ISystem) this.projectileSystem);
      this.AddIfNotNull((ISystem) this.pickupBehaviourSystem);
      this.AddIfNotNull((ISystem) this.goalCollisionSystem);
      this.AddIfNotNull((ISystem) this.pickupConsumedSystem);
      this.AddIfNotNull((ISystem) this.ballUpdateSystem);
      this.AddIfNotNull((ISystem) this.skillGraphSystem);
      this.AddIfNotNull((ISystem) this.playerHealthSystem);
      this.AddIfNotNull((ISystem) this.playerResetSystem);
      this.AddIfNotNull((ISystem) this.respawnTransformSystem);
      this.AddIfNotNull((ISystem) this.statusEffectSystem);
      this.AddIfNotNull((ISystem) this.playerMoveSystem);
      this.AddIfNotNull((ISystem) this.collisionCleanupSystem);
      this.AddIfNotNull((ISystem) this.physicsTickSystem);
      this.AddIfNotNull((ISystem) this.collisionEventSystem);
      this.AddIfNotNull((ISystem) this.triggerLeaveSystem);
      this.AddIfNotNull((ISystem) this.playerStateDispatchSystem);
      this.AddIfNotNull((ISystem) this.destroyEntitySystem);
      return this.systems;
    }

    private void AddIfNotNull(ISystem system)
    {
      if (system == null)
        return;
      this.systems.Add(system);
    }
  }
}
