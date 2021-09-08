// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.Pickup.PickupBehaviourSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.EntitasShared.Components.Pickup;
using Imi.SharedWithServer.Game;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay.Pickup
{
  public class PickupBehaviourSystem : ExecuteGameSystem
  {
    private const string PickupString = "Pickup";
    private readonly IGroup<GameEntity> pickupEntities;
    private readonly Events events;
    private Random rnd;

    public PickupBehaviourSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.pickupEntities = this.gameContext.GetGroup(GameMatcher.Pickup);
      this.events = entitasSetup.Events;
      this.rnd = new Random();
    }

    protected override void GameExecute()
    {
      if (this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.StartPoint || this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress)
      {
        foreach (JCollision jcollision in this.gameContext.collisionEvents.triggerEnter)
        {
          if (jcollision.entity1 != null && jcollision.entity2 != null)
          {
            GameEntity player;
            GameEntity pickup;
            if (jcollision.entity1.isPlayer && jcollision.entity2.hasPickup)
            {
              player = jcollision.entity1;
              pickup = jcollision.entity2;
            }
            else if (jcollision.entity2.isPlayer && jcollision.entity1.hasPickup)
            {
              player = jcollision.entity2;
              pickup = jcollision.entity1;
            }
            else
              continue;
            if (pickup.pickup.isActive)
              this.ConsumePickup(player, pickup);
          }
        }
      }
      foreach (GameEntity pickupEntity in this.pickupEntities)
      {
        PickupComponent pickup = pickupEntity.pickup;
        if (pickup.isActiveOnStart && this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress)
        {
          this.CreatePickupView(pickupEntity);
          pickup.isActiveOnStart = false;
        }
        if (!pickup.isActive && (double) pickup.currentDuration > (double) pickup.respawnDuration)
          this.CreatePickupView(pickupEntity);
        else if (!pickup.isActive && this.gameContext.hasMatchState && this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress)
        {
          pickup.currentDuration += this.gameContext.globalTime.fixedSimTimeStep;
          if ((double) Math.Abs(pickup.currentDuration - (pickup.respawnDuration - 5f)) < 0.025000000372529)
          {
            PickupType pickupType = this.DrawRandomPickup(pickupEntity);
            pickupEntity.pickup.nextActiveType = pickupType;
            this.events.FireEventPickupWillSpawn(pickupEntity.uniqueId.id, pickup.nextActiveType, 5f);
          }
        }
      }
    }

    public static void ResetAllPickups(GameContext gameContext, Events events)
    {
      foreach (GameEntity gameEntity in gameContext.GetGroup(GameMatcher.Pickup))
      {
        PickupComponent pickup = gameEntity.pickup;
        pickup.isActive = false;
        pickup.currentDuration = 0.0f;
        events.FireEventPickupReset(gameEntity.uniqueId.id);
      }
    }

    private void CreatePickupView(GameEntity entity)
    {
      entity.pickup.isActive = true;
      entity.pickup.currentDuration = 0.0f;
      entity.pickup.activeType = entity.pickup.nextActiveType;
      entity.ReplaceRigidbody(this.CreateRigidbody(entity.transform.position, 1f, "Pickup"), JVector.Zero);
      this.events.FireEventSpawnPickup(entity.uniqueId.id, entity.pickup.activeType, JVector.Zero);
    }

    private void ConsumePickup(GameEntity player, GameEntity pickup)
    {
      if (pickup.pickup.activeType != PickupType.RegainHealth)
        PickupBehaviourSystem.AddPickupToPlayer(player, pickup);
      this.gameContext.eventDispatcher.value.EnqueuePickupCollected(player.playerId.value);
      pickup.pickup.isActive = false;
      pickup.pickup.currentDuration = 0.0f;
      this.events.FireEventPickupConsumed(pickup.uniqueId.id, player.uniqueId.id);
    }

    private static void AddPickupToPlayer(GameEntity player, GameEntity pickup) => player.ReplacePickupConsumed(pickup.pickup.activeType);

    private PickupType GetNextPickupTypeRandom(PickupType possiblePickupsToSpawn)
    {
      List<PickupType> pickupTypeList = new List<PickupType>();
      if (this.HasFlag(possiblePickupsToSpawn, PickupType.RegainHealth))
        pickupTypeList.Add(PickupType.RegainHealth);
      if (this.HasFlag(possiblePickupsToSpawn, PickupType.RefreshSkills))
        pickupTypeList.Add(PickupType.RefreshSkills);
      if (this.HasFlag(possiblePickupsToSpawn, PickupType.RefreshSprint))
        pickupTypeList.Add(PickupType.RefreshSprint);
      return pickupTypeList[this.rnd.Next(pickupTypeList.Count)];
    }

    private bool HasFlag(PickupType a, PickupType b) => (a & b) == b;

    private JRigidbody CreateRigidbody(JVector position, float radius, string name)
    {
      JRigidbody body = new JRigidbody((Shape) new SphereShape(radius));
      body.name = name;
      body.Position = position;
      body.IsTrigger = true;
      body.AffectedByGravity = false;
      body.CollisionLayer = 64;
      body.CollisionMask = 0;
      this.gameContext.gamePhysics.world.AddBody(body);
      return body;
    }

    private PickupType DrawRandomPickup(GameEntity pickup)
    {
      List<PickupData> pickupsToSpawn = pickup.pickup.pickupsToSpawn;
      int maxValue = 0;
      foreach (PickupData pickupData in pickup.pickup.pickupsToSpawn)
        maxValue += pickupData.spawnChance;
      int num = this.rnd.Next(0, maxValue);
      for (int index = 0; index < pickupsToSpawn.Count; ++index)
      {
        if (num <= pickupsToSpawn[index].spawnChance)
          return pickupsToSpawn[index].type;
        num -= pickupsToSpawn[index].spawnChance;
      }
      return PickupType.RegainHealth;
    }
  }
}
