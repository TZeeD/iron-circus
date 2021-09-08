// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.GameEntityFactory
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.reliable;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SharedWithServer.Game;
using SharedWithServer.ScEvents;
using SteelCircus.Core;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas
{
  public class GameEntityFactory
  {
    private readonly GameContext gameContext;
    private readonly Events events;
    private readonly bool isClient;
    private ConfigProvider configProvider;
    private UniqueId nextId = new UniqueId((ushort) 1000);

    public GameEntityFactory(
      GameContext gameContext,
      Events events,
      ConfigProvider configProvider,
      bool isClient)
    {
      this.gameContext = gameContext;
      this.events = events;
      this.configProvider = configProvider;
      this.isClient = isClient;
    }

    public GameEntity CreateRemotePlayer(
      ulong playerId,
      UniqueId uniqueId,
      ChampionType champType,
      Team team)
    {
      GameEntity entity = this.gameContext.CreateEntity();
      entity.isPlayer = true;
      entity.AddPlayerId(playerId);
      entity.AddUniqueId(uniqueId);
      entity.AddPlayerTeam(team);
      return entity;
    }

    public GameEntity CreatePlayer(ulong playerId)
    {
      GameEntity entityWithUniqueId = this.CreateEntityWithUniqueId();
      entityWithUniqueId.AddPlayerId(playerId);
      entityWithUniqueId.AddPlayerChampionData(new PlayerChampionData()
      {
        uniqueId = entityWithUniqueId.uniqueId.id,
        team = Team.None,
        type = ChampionType.Invalid,
        isReady = false,
        isFakePlayer = false
      });
      entityWithUniqueId.AddConnectionInfo(0.0f, 0, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0, 0, 0);
      return entityWithUniqueId;
    }

    public GameEntity CreateLocalPlayer(ulong playerId)
    {
      GameEntity entity = this.gameContext.CreateEntity();
      entity.isPlayer = true;
      entity.isLocalEntity = true;
      entity.AddPlayerId(playerId);
      entity.AddConnectionInfo(0.0f, 0, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0, 0, 0);
      entity.AddPlayerChampionData(PlayerChampionData.Default);
      return entity;
    }

    public GameEntity CreateEntityWithUniqueId()
    {
      GameEntity entity = this.gameContext.CreateEntity();
      entity.AddUniqueId(this.nextId++);
      return entity;
    }

    public GameEntity CreateEntityWithUniqueId(UniqueId id)
    {
      GameEntity entity = this.gameContext.CreateEntity();
      entity.AddUniqueId(id);
      return entity;
    }

    public virtual GameEntity CreateProjectile(
      ulong owner,
      ProjectileType type,
      float radius,
      float height,
      JVector position,
      JQuaternion orientation,
      JVector velocity,
      ProjectileImpactEffect impactEffect)
    {
      return (GameEntity) null;
    }

    public virtual GameEntity CreatePhysicsEntity(
      ColliderType colliderType,
      JVector colliderDimensions,
      JVector colliderOffset,
      string name = "unnamed")
    {
      GameEntity entityWithUniqueId = this.CreateEntityWithUniqueId();
      Shape shape = (Shape) null;
      if (colliderType == ColliderType.Box)
        shape = (Shape) new BoxShape(colliderDimensions);
      JRigidbody jrigidbody = new JRigidbody(shape);
      jrigidbody.CollisionMask = int.MaxValue;
      jrigidbody.IsKinematic = true;
      jrigidbody.name = name;
      entityWithUniqueId.AddRigidbody(jrigidbody, colliderOffset);
      entityWithUniqueId.AddTransform(JVector.Zero, JQuaternion.LookRotation(JVector.Forward, JVector.Up));
      entityWithUniqueId.AddVelocityOverride(JVector.Zero);
      this.gameContext.gamePhysics.world.AddBody(jrigidbody);
      entityWithUniqueId.isReplicate = true;
      return entityWithUniqueId;
    }

    private static JRigidbody CreatePlayerRigidbody(
      ulong index,
      Team team,
      float height,
      float radius)
    {
      return new JRigidbody((Shape) new CylinderShape(height, radius))
      {
        Position = JVector.Zero,
        name = "Player " + (object) index,
        CollisionLayer = (int) CollisionLayerUtils.GetLayerForTeam(team),
        CollisionMask = (int) CollisionLayerUtils.GetMaskForTeam(team),
        Mass = 1f,
        AffectedByGravity = false,
        AllowDeactivation = false
      };
    }

    public void InitializePlayerEntity(GameEntity gameEntity, ChampionType champType, Team team)
    {
      if (!gameEntity.hasPlayerId)
        throw new Exception("Tried to initialize a player entity without a playerId");
      gameEntity.AddInput(new SequenceBuffer32<Input>(256));
      gameEntity.isPlayer = true;
      gameEntity.isConstrainedTo2D = true;
      ChampionConfig championConfigFor = ChampionTypeHelper.GetChampionConfigFor(champType, this.configProvider);
      gameEntity.ReplacePlayerTeam(team);
      gameEntity.ReplaceLocalPlayerVisualSmoothing(1f, 0.0f, 0.0f, 0.0f, TransformState.Invalid, TransformState.Invalid, TransformState.Invalid, new TimelineVector());
      gameEntity.ReplaceStatusEffect(new List<StatusEffect>(), StatusModifier.None, StatusEffectType.None);
      gameEntity.ReplaceSkillUi(new List<SkillUiStateData>(), true);
      gameEntity.ReplaceAnimationState(new Dictionary<AnimationStateType, AnimationState>(16));
      gameEntity.ReplaceVelocityOverride(JVector.Zero);
      gameEntity.ReplaceMovement(new List<MovementModifier>());
      gameEntity.ReplacePlayerStatistics(gameEntity.playerId.value, new List<ulong>(), new List<ulong>(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
      gameEntity.ReplacePlayerHealth(championConfigFor.maxHealth, new List<ModifyHealth>());
      gameEntity.ReplaceChampionConfig(championConfigFor);
      gameEntity.ReplaceArenaLoaded(false);
      gameEntity.ReplaceLastBallThrow(0, JVector.Zero, JVector.Zero);
      float height = 2f;
      JRigidbody playerRigidbody = GameEntityFactory.CreatePlayerRigidbody(gameEntity.playerId.value, team, height, championConfigFor.colliderRadius);
      this.gameContext.gamePhysics.world.AddBody(playerRigidbody);
      gameEntity.ReplaceTransform(playerRigidbody.Position, JQuaternion.LookForward);
      gameEntity.ReplaceRigidbody(playerRigidbody, JVector.Up * (float) -((double) height / 2.0));
      if (!gameEntity.isLocalEntity)
        gameEntity.rigidbody.value.IsTrigger = true;
      int length = championConfigFor.playerSkillGraphs.Length;
      SerializedSkillGraphInfo[] serializedSkillGraphInfoArray = new SerializedSkillGraphInfo[length + 1];
      GraphVarList newOwnerVars = new GraphVarList("OwnerVars", gameEntity.uniqueId.id, byte.MaxValue);
      using (new ConfigValueChangeAllowed())
      {
        newOwnerVars.AddVar<float>("Stamina").Set(championConfigFor.stamina.amount);
        newOwnerVars.AddVar<bool>("RestartStaminaRecharge");
      }
      serializedSkillGraphInfoArray[length] = newOwnerVars.Parse();
      gameEntity.ReplaceSkillGraph((SkillGraphConfig[]) null, (SerializedSkillGraphInfo[]) null, (SkillGraph[]) null, -1, newOwnerVars);
      SkillGraph[] skillGraphArray = new SkillGraph[length];
      SkillGraphConfig[] skillGraphConfigArray = new SkillGraphConfig[length];
      for (int instanceIdx = 0; instanceIdx < length; ++instanceIdx)
      {
        SkillGraph stateMachine = championConfigFor.playerSkillGraphs[instanceIdx].CreateStateMachine(gameEntity.playerId.value, instanceIdx, this.gameContext, this, this.events, this.isClient);
        skillGraphArray[instanceIdx] = stateMachine;
        skillGraphConfigArray[instanceIdx] = stateMachine.GetConfig();
        serializedSkillGraphInfoArray[instanceIdx] = skillGraphConfigArray[instanceIdx].serializationInfo;
      }
      gameEntity.skillGraph.skillGraphs = skillGraphArray;
      gameEntity.skillGraph.skillGraphConfigs = skillGraphConfigArray;
      gameEntity.skillGraph.serializationLayout = serializedSkillGraphInfoArray;
    }

    public void UpdateChampionData(GameEntity gameEntity, ChampionType champType)
    {
      ChampionConfig championConfigFor = ChampionTypeHelper.GetChampionConfigFor(champType, this.configProvider);
      gameEntity.ReplaceChampionConfig(championConfigFor);
    }

    public GameEntity InitializeProjectile(
      GameEntity projectileEntity,
      ulong owner,
      ProjectileType type,
      float radius,
      float height,
      JVector position,
      JQuaternion rotation,
      JVector velocity,
      ProjectileImpactEffect impactEffect)
    {
      JRigidbody newValue = new JRigidbody((Shape) new CapsuleShape(height, radius));
      newValue.Orientation = JMatrix.CreateFromQuaternion(rotation);
      newValue.Position = position;
      newValue.IsTrigger = true;
      newValue.IsKinematic = false;
      newValue.AffectedByGravity = false;
      newValue.AllowDeactivation = false;
      Team team = this.gameContext.GetFirstEntityWithPlayerId(owner).playerTeam.value;
      newValue.CollisionLayer = (int) CollisionLayerUtils.GetProjectileLayerForTeam(team);
      newValue.CollisionMask = (int) CollisionLayerUtils.GetProjectileMaskForTeam(team);
      projectileEntity.AddRigidbody(newValue, JVector.Zero);
      projectileEntity.AddTransform(position, rotation);
      projectileEntity.AddVelocityOverride(velocity);
      projectileEntity.AddProjectile(type, owner, impactEffect, 0.0f, 0, 0, 0.0f, 0.0f, 0.0f, 0.0f, (Action<ImpactParameters>) null, (Action) null);
      return projectileEntity;
    }

    public GameEntity CreateAoE(
      AreaOfEffect aoe,
      Team team,
      JVector position,
      JQuaternion rotation)
    {
      GameEntity entity = this.gameContext.CreateEntity();
      entity.AddTransform(position, rotation);
      entity.AddAreaOfEffect(aoe, team);
      return entity;
    }

    public void ResetConfig(ConfigProvider configProviderNew) => this.configProvider = configProviderNew;

    public void SetNextId(UniqueId newNextId) => this.nextId = newNextId;

    public UniqueId GetUniqueId() => this.nextId++;

    public void Reset() => this.nextId = new UniqueId((ushort) 1000);
  }
}
