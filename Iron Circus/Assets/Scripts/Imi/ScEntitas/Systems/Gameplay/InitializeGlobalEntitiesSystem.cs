// Decompiled with JetBrains decompiler
// Type: Imi.ScEntitas.Systems.Gameplay.InitializeGlobalEntitiesSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Jitter;
using Jitter.Collision;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.ScEntitas.Systems.Gameplay
{
  public class InitializeGlobalEntitiesSystem : IInitializeSystem, ISystem
  {
    private readonly GameContext gameContext;
    private readonly int numPlayers;
    private readonly PhysicsEngineConfig physicsConfig;
    private readonly MatchConfig matchConfig;

    public InitializeGlobalEntitiesSystem(EntitasSetup entitasSetup)
    {
      this.gameContext = entitasSetup.Contexts.game;
      this.numPlayers = entitasSetup.NumPlayers;
      this.physicsConfig = entitasSetup.ConfigProvider.physicsEngineConfig;
      this.matchConfig = entitasSetup.ConfigProvider.matchConfig;
    }

    public void Initialize()
    {
      this.gameContext.ReplaceMatchData(MatchTypeUtils.GetMatchType(this.numPlayers), this.numPlayers);
      this.gameContext.ReplaceGlobalTime(0.0f, 0.0f, 0, 0, 0.0f, false);
      this.gameContext.ReplaceMatchState(Imi.SharedWithServer.Game.MatchState.WaitingForPlayers);
      this.gameContext.ReplaceScore(Team.None, 0UL, TeamExtensions.TeamWithIntegers());
      this.gameContext.SetGamePhysics(this.CreateWorld(), (Action<int, int, GameEntity, Action>) null);
      this.gameContext.ReplaceCameraTarget(JVector.Zero, false);
      this.gameContext.ReplaceMatchConfig(this.matchConfig);
      this.gameContext.ReplaceCollisionEvents(new List<JCollision>(), new List<JCollision>(), new List<JCollision>());
      this.gameContext.ReplaceDeferredCollisionEvents(new List<JCollision>(), new List<JCollision>(), new List<JCollision>());
    }

    private World CreateWorld(bool createBruteForceSystem = false)
    {
      Log.Debug("Create Physics World");
      World world = new World(createBruteForceSystem ? (CollisionSystem) new CollisionSystemBrute() : (CollisionSystem) new CollisionSystemSAP());
      ContactSettings contactSettings = world.ContactSettings;
      contactSettings.BiasFactor = this.physicsConfig.bias;
      contactSettings.MaximumBias = this.physicsConfig.maximumBias;
      contactSettings.MinimumVelocity = this.physicsConfig.minVelocity;
      contactSettings.AllowedPenetration = this.physicsConfig.allowedPenetration;
      contactSettings.BreakThreshold = this.physicsConfig.breakThreshold;
      return world;
    }
  }
}
