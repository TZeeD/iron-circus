// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.SetupPointSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.Utils;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using System.Collections.Generic;
using System.Linq;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class SetupPointSystem : ReactiveGameSystem
  {
    private readonly JQuaternion spawnDirBall;
    private readonly MatchConfig matchConfig;
    private Events events;
    private MetaContext metaContext;

    public SetupPointSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
      this.matchConfig = entitasSetup.ConfigProvider.matchConfig;
      this.metaContext = entitasSetup.Contexts.meta;
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.MatchState.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity)
    {
      if (!entity.hasMatchState)
        return false;
      return entity.matchState.value == Imi.SharedWithServer.Game.MatchState.StartPoint || entity.matchState.value == Imi.SharedWithServer.Game.MatchState.Intro;
    }

    protected override void Execute(List<GameEntity> entities)
    {
      List<GameEntity> list = ((IEnumerable<GameEntity>) this.gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.Player).AnyOf(GameMatcher.PlayerRespawning, GameMatcher.Death)).GetEntities()).ToList<GameEntity>();
      if (this.gameContext.scoreEntity.score.lastTeamThatScored != Team.None)
        SpawnPointUtils.RotateSpawnpoints(this.gameContext);
      foreach (GameEntity gameEntity in list)
        gameEntity.isPlayerRespawning = true;
      GameEntity[] entities1 = this.gameContext.GetGroup(GameMatcher.Bumper).GetEntities();
      Log.Debug("Adding Bumpers back To World.");
      UniqueId[] bumperIds = new UniqueId[entities1.Length];
      for (int index = 0; index < entities1.Length; ++index)
      {
        bumperIds[index] = entities1[index].uniqueId.id;
        this.gameContext.gamePhysics.world.AddBody(entities1[index].rigidbody.value);
      }
      this.events.FireEventBumperCollisionEnable(ref bumperIds);
    }

    private void ResetBall()
    {
      GameEntity ballEntity = this.gameContext.ballEntity;
      if (ballEntity.hasBallOwner)
        ballEntity.RemoveBallOwner();
      if (ballEntity.hasBallFlight)
        ballEntity.RemoveBallFlight();
      if (!ballEntity.hasBallHover)
        ballEntity.AddBallHover(0.0f);
      if (!this.metaContext.metaMatch.isOvertime && this.gameContext.hasLastGoalScored && this.matchConfig.enableLoserBall && this.metaContext.metaMatch.gameType != GameType.BasicTraining)
      {
        if (this.gameContext.lastGoalScored.team == Team.Alpha)
          ballEntity.ReplaceTransform(new JVector(0.0f, 0.0f, this.matchConfig.loserBallTeamBlue), this.spawnDirBall);
        else
          ballEntity.ReplaceTransform(new JVector(0.0f, 0.0f, this.matchConfig.loserBallTeamOrange), this.spawnDirBall);
      }
      else
        ballEntity.ReplaceTransform(JVector.Zero, this.spawnDirBall);
      ballEntity.ReplaceVelocityOverride(JVector.Zero);
      JRigidbody jrigidbody = ballEntity.rigidbody.value;
      jrigidbody.LinearVelocity = JVector.Zero;
      jrigidbody.AngularVelocity = JVector.Zero;
    }
  }
}
