// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.AICache
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.AI.Collisions;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.AI
{
  public class AICache
  {
    private int lastValidated = -1;
    private GameContext context;
    private List<GameEntity> allGoals = new List<GameEntity>();
    private List<BaseAI> users = new List<BaseAI>(6);
    private List<GameEntity> allPlayers = new List<GameEntity>(6);
    private List<GameEntity> bumpers = new List<GameEntity>(16);
    private Dictionary<GameEntity, List<GameEntity>> teamMates = new Dictionary<GameEntity, List<GameEntity>>(6);
    private Dictionary<GameEntity, List<GameEntity>> opponents = new Dictionary<GameEntity, List<GameEntity>>(6);
    private Dictionary<GameEntity, GameEntity> enemyGoal = new Dictionary<GameEntity, GameEntity>(3);
    private Dictionary<GameEntity, GameEntity> ownGoal = new Dictionary<GameEntity, GameEntity>(3);
    private Dictionary<GameEntity, JVector> goalTopCorners = new Dictionary<GameEntity, JVector>(2);
    private Dictionary<GameEntity, JVector> goalBottomCorners = new Dictionary<GameEntity, JVector>(2);
    private Dictionary<GameEntity, AICache.BallInterceptData> ballInterceptDataNoSprint = new Dictionary<GameEntity, AICache.BallInterceptData>(6);
    private Dictionary<GameEntity, AICache.BallInterceptData> ballInterceptDataSprint = new Dictionary<GameEntity, AICache.BallInterceptData>(6);
    private Dictionary<GameEntity, SkillGraph> throwGraphs = new Dictionary<GameEntity, SkillGraph>(6);
    private Dictionary<GameEntity, SkillGraph> sprintGraphs = new Dictionary<GameEntity, SkillGraph>(6);
    private Dictionary<GameEntity, SkillGraph> tackleDodgeGraphs = new Dictionary<GameEntity, SkillGraph>(6);
    private Dictionary<GameEntity, SkillVar<float>> sprintChargeVars = new Dictionary<GameEntity, SkillVar<float>>(6);
    private Dictionary<GameEntity, SkillVar<bool>> canUseTackleOrDodgeVars = new Dictionary<GameEntity, SkillVar<bool>>(6);
    private BallConfig ballConfig;
    private GameEntity ball;
    private GameEntity ballOwner;
    private float arenaSizeZ = 66f;
    private float arenaSizeX = 31f;
    private AICollisionSystem collisionSystem;
    private bool initialized;

    public GameContext Context => this.context;

    public List<GameEntity> AllPlayers => this.allPlayers;

    public List<GameEntity> Bumpers => this.bumpers;

    public BallConfig BallConfig => this.ballConfig;

    public GameEntity Ball => this.ball;

    public GameEntity BallOwner => this.ballOwner;

    public float ArenaSizeZ => this.arenaSizeZ;

    public float ArenaSizeX => this.arenaSizeX;

    public AICollisionSystem CollisionSystem => this.collisionSystem;

    public AICache(GameContext context, ConfigProvider configProvider)
    {
      this.context = context;
      this.ballConfig = configProvider.ballConfig;
    }

    public void Initialize()
    {
      if (this.initialized)
        return;
      this.initialized = true;
      this.UpdateBumpers(this.bumpers);
      foreach (GameEntity gameEntity in this.context.GetGroup(GameMatcher.Goal))
        this.allGoals.Add(gameEntity);
      this.CreateCollisionSystem();
    }

    public void RegisterUser(BaseAI user)
    {
      if (this.users.Contains(user))
        return;
      this.users.Add(user);
      GameEntity ownerEntity = user.OwnerEntity;
      this.teamMates[ownerEntity] = new List<GameEntity>(5);
      this.opponents[ownerEntity] = new List<GameEntity>(5);
      Team team1 = ownerEntity.playerTeam.value;
      Team team2 = team1 == Team.Alpha ? Team.Beta : Team.Alpha;
      foreach (GameEntity gameEntity in this.context.GetGroup(GameMatcher.Goal))
      {
        if (gameEntity.goal.team == team1)
          this.enemyGoal[ownerEntity] = gameEntity;
        if (gameEntity.goal.team == team2)
          this.ownGoal[ownerEntity] = gameEntity;
      }
    }

    public void UnregisterUser(BaseAI user)
    {
      if (!this.users.Contains(user))
        return;
      this.users.Remove(user);
      GameEntity ownerEntity = user.OwnerEntity;
      this.teamMates.Remove(ownerEntity);
      this.opponents.Remove(ownerEntity);
      if (this.enemyGoal.ContainsKey(ownerEntity))
        this.enemyGoal.Remove(ownerEntity);
      if (!this.ownGoal.ContainsKey(ownerEntity))
        return;
      this.ownGoal.Remove(ownerEntity);
    }

    public void Validate()
    {
      if (!this.initialized)
        this.Initialize();
      if (this.GetTick() <= this.lastValidated)
        return;
      this.lastValidated = this.GetTick();
      if (this.ball == null)
        this.ball = this.context.ballEntity;
      this.ballOwner = this.UpdateBallOwner();
      this.UpdatePlayers(this.AllPlayers);
      this.UpdateTeamMembersAndOpponents();
      this.UpdateSkillGraphs();
    }

    public int GetTick() => this.context.globalTime.currentTick;

    public List<GameEntity> GetOpponents(GameEntity player) => this.opponents[player];

    public List<GameEntity> GetTeamMates(GameEntity player) => this.teamMates[player];

    public GameEntity GetEnemyGoal(GameEntity player) => this.enemyGoal[player];

    public GameEntity GetOwnGoal(GameEntity player) => this.ownGoal[player];

    public void GetEnemyGoalCorners(
      GameEntity player,
      out JVector topCorner,
      out JVector bottomCorner,
      float colliderRadius = 0.0f)
    {
      this.GetGoalCorners(this.GetEnemyGoal(player), out topCorner, out bottomCorner, colliderRadius);
    }

    public void GetOwnGoalCorners(
      GameEntity player,
      out JVector topCorner,
      out JVector bottomCorner,
      float colliderRadius = 0.0f)
    {
      this.GetGoalCorners(this.GetOwnGoal(player), out topCorner, out bottomCorner, colliderRadius);
    }

    public void GetGoalCorners(
      GameEntity goal,
      out JVector topCorner,
      out JVector bottomCorner,
      float colliderRadius = 0.0f)
    {
      if (this.goalTopCorners.ContainsKey(goal))
      {
        topCorner = this.goalTopCorners[goal];
        bottomCorner = this.goalBottomCorners[goal];
      }
      else
      {
        JBBox boundingBox = goal.rigidbody.value.BoundingBox;
        topCorner = boundingBox.Max;
        bottomCorner = boundingBox.Min;
        topCorner.Z = JMath.Min(JMath.Abs(topCorner.Z), JMath.Abs(bottomCorner.Z)) * JMath.Sign(topCorner.Z);
        bottomCorner.Z = topCorner.Z;
        topCorner.Y = bottomCorner.Y = 0.0f;
        this.goalTopCorners[goal] = topCorner;
        this.goalBottomCorners[goal] = bottomCorner;
      }
      topCorner.X -= colliderRadius;
      bottomCorner.X += colliderRadius;
    }

    public void GetBumperVolume(GameEntity bumper, out JVector pos, out float radius)
    {
      JRigidbody jrigidbody = bumper.rigidbody.value;
      pos = jrigidbody.Position;
      pos.Y = 0.0f;
      radius = ((CapsuleShape) jrigidbody.Shape).Radius;
    }

    public ThrowBallConfig GetThrowBallConfig(GameEntity player) => (ThrowBallConfig) this.throwGraphs[player].GetConfig();

    public float GetCharge(GameEntity player) => this.throwGraphs[player].GetVar<float>("Charge Amount").Get();

    public bool IsCharging(GameEntity player) => (double) this.GetCharge(player) > 0.0;

    public float GetSprintSpeed(GameEntity player) => ((SprintConfig) this.sprintGraphs[player].GetConfig()).speed;

    public float GetSprintCharge(GameEntity player)
    {
      float num;
      if (this.sprintChargeVars.ContainsKey(player))
      {
        num = this.sprintChargeVars[player].Get();
      }
      else
      {
        SkillVar<float> var = this.sprintGraphs[player].GetVar<float>("Stamina");
        num = var.Get();
        this.sprintChargeVars[player] = var;
      }
      return num / player.championConfig.value.stamina.amount;
    }

    public bool CanSprint(GameEntity player) => (double) this.GetSprintCharge(player) > 0.00999999977648258;

    public bool CanTackleOrDodge(GameEntity player)
    {
      if (this.canUseTackleOrDodgeVars.ContainsKey(player))
        return this.canUseTackleOrDodgeVars[player].Get() && (bool) player.skillGraph.GetVar<bool>("CanAffordTackle");
      SkillVar<bool> var = this.tackleDodgeGraphs[player].GetVar<bool>("CanUseTackleOrDodge");
      this.canUseTackleOrDodgeVars[player] = var;
      return var.Get() && (bool) player.skillGraph.GetVar<bool>("CanAffordTackle");
    }

    public float GetTackleDistance(GameEntity player) => ((TackleDodgeConfig) this.tackleDodgeGraphs[player].GetConfig()).tackleDistance;

    public float GetDodgeDistance(GameEntity player) => ((TackleDodgeConfig) this.tackleDodgeGraphs[player].GetConfig()).dodgeDistance;

    public void GetBallInterceptData(
      GameEntity player,
      bool sprinting,
      out bool canIntercept,
      out JVector moveDir,
      out float timeToReach,
      BaseAI aiForEvaluation = null)
    {
      if (aiForEvaluation == null)
        aiForEvaluation = this.users[0];
      Dictionary<GameEntity, AICache.BallInterceptData> dictionary = sprinting ? this.ballInterceptDataSprint : this.ballInterceptDataNoSprint;
      if (!dictionary.ContainsKey(player) || dictionary[player].tick != this.GetTick())
        this.CacheBallInterceptData(player, sprinting, aiForEvaluation);
      AICache.BallInterceptData ballInterceptData = dictionary[player];
      canIntercept = ballInterceptData.canIntercept;
      moveDir = ballInterceptData.moveDir;
      timeToReach = ballInterceptData.timeToReach;
    }

    private void CacheBallInterceptData(GameEntity player, bool sprinting, BaseAI aiForEvaluation)
    {
      Dictionary<GameEntity, AICache.BallInterceptData> dictionary = sprinting ? this.ballInterceptDataSprint : this.ballInterceptDataNoSprint;
      JVector position2D = this.Ball.transform.Position2D;
      JVector ballVelocity = this.Ball.velocityOverride.value;
      JVector moveDir;
      float timeToReach;
      AICache.BallInterceptData ballInterceptData1 = new AICache.BallInterceptData(aiForEvaluation.InterceptBall(player, position2D, ballVelocity, sprinting, out moveDir, out timeToReach), this.GetTick(), moveDir, timeToReach);
      GameEntity key = player;
      AICache.BallInterceptData ballInterceptData2 = ballInterceptData1;
      dictionary[key] = ballInterceptData2;
    }

    private void UpdateSkillGraphs()
    {
      this.throwGraphs.Clear();
      this.sprintGraphs.Clear();
      this.tackleDodgeGraphs.Clear();
      for (int index = 0; index < this.allPlayers.Count; ++index)
      {
        GameEntity allPlayer = this.allPlayers[index];
        foreach (SkillGraph skillGraph in allPlayer.skillGraph.skillGraphs)
        {
          switch (skillGraph.GetConfig())
          {
            case ThrowBallConfig _:
              this.throwGraphs[allPlayer] = skillGraph;
              break;
            case SprintConfig _:
              this.sprintGraphs[allPlayer] = skillGraph;
              break;
            case TackleDodgeConfig _:
              this.tackleDodgeGraphs[allPlayer] = skillGraph;
              break;
          }
        }
      }
    }

    private void UpdateTeamMembersAndOpponents()
    {
      foreach (GameEntity allPlayer in this.AllPlayers)
      {
        if (!this.teamMates.ContainsKey(allPlayer))
          this.teamMates[allPlayer] = new List<GameEntity>(5);
        if (!this.opponents.ContainsKey(allPlayer))
          this.opponents[allPlayer] = new List<GameEntity>(5);
        this.UpdateTeamMembers(allPlayer, this.teamMates[allPlayer]);
        this.UpdateOpponents(allPlayer, this.opponents[allPlayer]);
      }
    }

    private GameEntity UpdateBallOwner() => this.ball == null || !this.ball.hasBallOwner ? (GameEntity) null : this.context.GetFirstEntityWithPlayerId(this.ball.ballOwner.playerId);

    private void UpdateBumpers(List<GameEntity> results)
    {
      results.Clear();
      foreach (GameEntity gameEntity in this.context.GetGroup(GameMatcher.Bumper))
        results.Add(gameEntity);
    }

    private void UpdatePlayers(List<GameEntity> results, Team teamFilter = Team.None)
    {
      results.Clear();
      foreach (GameEntity gameEntity in this.context.GetGroup(GameMatcher.Player))
      {
        if (teamFilter == Team.None || gameEntity.playerTeam.value == teamFilter)
          results.Add(gameEntity);
      }
      for (int index = 0; index < results.Count; ++index)
      {
        GameEntity result = results[index];
        if (result.isDestroyed || result.IsDead())
        {
          results.RemoveAt(index);
          --index;
        }
      }
    }

    private void UpdateTeamMembers(GameEntity player, List<GameEntity> results)
    {
      this.UpdatePlayers(results, player.playerTeam.value == Team.Alpha ? Team.Alpha : Team.Beta);
      results.Remove(player);
    }

    private void UpdateOpponents(GameEntity player, List<GameEntity> results) => this.UpdatePlayers(results, player.playerTeam.value == Team.Beta ? Team.Alpha : Team.Beta);

    private void CreateCollisionSystem()
    {
      this.collisionSystem = new AICollisionSystem();
      this.collisionSystem.CreateArena(this, this.arenaSizeX, this.arenaSizeZ, this.allGoals[0], this.allGoals[1]);
      foreach (GameEntity bumper in this.bumpers)
        this.collisionSystem.CreateBumper(bumper);
      this.collisionSystem.Expand(this.ballConfig.ballColliderRadius);
      Log.Debug("AICache, collision system created and expanded:\n" + this.collisionSystem.ToString());
    }

    private struct BallInterceptData
    {
      public int tick;
      public JVector moveDir;
      public float timeToReach;
      public bool canIntercept;

      public BallInterceptData(bool canIntercept, int tick, JVector moveDir, float timeToReach)
      {
        this.canIntercept = canIntercept;
        this.tick = tick;
        this.moveDir = moveDir;
        this.timeToReach = timeToReach;
      }
    }
  }
}
