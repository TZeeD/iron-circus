// Decompiled with JetBrains decompiler
// Type: GameComponentsLookup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.ScEntitas.Components;
using Imi.SharedWithServer.EntitasShared.Components.Bumper;
using Imi.SharedWithServer.EntitasShared.Components.Pickup;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.ScEntitas.Components;
using server.ScEntitas.Components;
using SharedWithServer.ScEntitas.Components;
using SteelCircus.ScEntitas.Components;
using System;

public static class GameComponentsLookup
{
  public const int EventDispatcher = 0;
  public const int Bumper = 1;
  public const int Pickup = 2;
  public const int PickupConsumed = 3;
  public const int SpawnPickup = 4;
  public const int AnimationState = 5;
  public const int AreaOfEffect = 6;
  public const int ArenaLoaded = 7;
  public const int Ball = 8;
  public const int BallFlight = 9;
  public const int BallFlightInfo = 10;
  public const int BallHitDisabled = 11;
  public const int BallHover = 12;
  public const int BallImpulse = 13;
  public const int BallOwner = 14;
  public const int BasicTrainingComplete = 15;
  public const int CameraTarget = 16;
  public const int ChampionConfig = 17;
  public const int CollisionEvent = 18;
  public const int CollisionEvents = 19;
  public const int ConnectionInfo = 20;
  public const int ConstrainedTo2D = 21;
  public const int CountdownAction = 22;
  public const int Death = 23;
  public const int DebugFlag = 24;
  public const int DeferredCollisionEvents = 25;
  public const int Destroyed = 26;
  public const int FakePlayer = 27;
  public const int Forcefield = 28;
  public const int GamePhysics = 29;
  public const int GlobalTime = 30;
  public const int Goal = 31;
  public const int Imi = 32;
  public const int Input = 33;
  public const int LastBallContact = 34;
  public const int LastBallThrow = 35;
  public const int LastGoalScored = 36;
  public const int LastKnownRemoteTick = 37;
  public const int LoadArenaInfo = 38;
  public const int LocalEntity = 39;
  public const int LocalPlayerVisualSmoothing = 40;
  public const int MatchConfig = 41;
  public const int MatchData = 42;
  public const int MatchState = 43;
  public const int MatchStateTransitionEvent = 44;
  public const int Movement = 45;
  public const int PlayerChampionData = 46;
  public const int Player = 47;
  public const int PlayerForfeit = 48;
  public const int PlayerHealth = 49;
  public const int PlayerId = 50;
  public const int PlayerLoadout = 51;
  public const int PlayerPickOrder = 52;
  public const int PlayerRespawning = 53;
  public const int PlayerSpawnPoint = 54;
  public const int PlayerStatistics = 55;
  public const int PlayerTeam = 56;
  public const int PlayerUsername = 57;
  public const int PositionTimeline = 58;
  public const int Projectile = 59;
  public const int RemainingMatchTime = 60;
  public const int Replicate = 61;
  public const int RespawnRigidbody = 62;
  public const int Rigidbody = 63;
  public const int Score = 64;
  public const int SkillGraph = 65;
  public const int SkillUi = 66;
  public const int SomeoneScored = 67;
  public const int SpawnPlayer = 68;
  public const int Spraytag = 69;
  public const int StatusEffect = 70;
  public const int Transform = 71;
  public const int TriggerEnterEvent = 72;
  public const int TriggerEvent = 73;
  public const int TriggerExitEvent = 74;
  public const int TriggerStayEvent = 75;
  public const int VelocityOverride = 76;
  public const int Vfx = 77;
  public const int VictorySpawnPoint = 78;
  public const int VisualSmoothing = 79;
  public const int AlignViewToBottom = 80;
  public const int UnityView = 81;
  public const int UniqueId = 82;
  public const int RemoteTransform = 83;
  public const int RemoteEntityLerpState = 84;
  public const int TotalComponents = 85;
  public static readonly string[] componentNames = new string[85]
  {
    nameof (EventDispatcher),
    nameof (Bumper),
    nameof (Pickup),
    nameof (PickupConsumed),
    nameof (SpawnPickup),
    nameof (AnimationState),
    nameof (AreaOfEffect),
    nameof (ArenaLoaded),
    nameof (Ball),
    nameof (BallFlight),
    nameof (BallFlightInfo),
    nameof (BallHitDisabled),
    nameof (BallHover),
    nameof (BallImpulse),
    nameof (BallOwner),
    nameof (BasicTrainingComplete),
    nameof (CameraTarget),
    nameof (ChampionConfig),
    nameof (CollisionEvent),
    nameof (CollisionEvents),
    nameof (ConnectionInfo),
    nameof (ConstrainedTo2D),
    nameof (CountdownAction),
    nameof (Death),
    nameof (DebugFlag),
    nameof (DeferredCollisionEvents),
    nameof (Destroyed),
    nameof (FakePlayer),
    nameof (Forcefield),
    nameof (GamePhysics),
    nameof (GlobalTime),
    nameof (Goal),
    nameof (Imi),
    nameof (Input),
    nameof (LastBallContact),
    nameof (LastBallThrow),
    nameof (LastGoalScored),
    nameof (LastKnownRemoteTick),
    nameof (LoadArenaInfo),
    nameof (LocalEntity),
    nameof (LocalPlayerVisualSmoothing),
    nameof (MatchConfig),
    nameof (MatchData),
    nameof (MatchState),
    nameof (MatchStateTransitionEvent),
    nameof (Movement),
    nameof (PlayerChampionData),
    nameof (Player),
    nameof (PlayerForfeit),
    nameof (PlayerHealth),
    nameof (PlayerId),
    nameof (PlayerLoadout),
    nameof (PlayerPickOrder),
    nameof (PlayerRespawning),
    nameof (PlayerSpawnPoint),
    nameof (PlayerStatistics),
    nameof (PlayerTeam),
    nameof (PlayerUsername),
    nameof (PositionTimeline),
    nameof (Projectile),
    nameof (RemainingMatchTime),
    nameof (Replicate),
    nameof (RespawnRigidbody),
    nameof (Rigidbody),
    nameof (Score),
    nameof (SkillGraph),
    nameof (SkillUi),
    nameof (SomeoneScored),
    nameof (SpawnPlayer),
    nameof (Spraytag),
    nameof (StatusEffect),
    nameof (Transform),
    nameof (TriggerEnterEvent),
    nameof (TriggerEvent),
    nameof (TriggerExitEvent),
    nameof (TriggerStayEvent),
    nameof (VelocityOverride),
    nameof (Vfx),
    nameof (VictorySpawnPoint),
    nameof (VisualSmoothing),
    nameof (AlignViewToBottom),
    nameof (UnityView),
    nameof (UniqueId),
    nameof (RemoteTransform),
    nameof (RemoteEntityLerpState)
  };
  public static readonly Type[] componentTypes = new Type[85]
  {
    typeof (EventDispatcherComponent),
    typeof (BumperComponent),
    typeof (PickupComponent),
    typeof (PickupConsumedComponent),
    typeof (SpawnPickupComponent),
    typeof (AnimationStateComponent),
    typeof (AreaOfEffectComponent),
    typeof (ArenaLoadedComponent),
    typeof (BallComponent),
    typeof (BallFlightComponent),
    typeof (BallFlightInfoComponent),
    typeof (BallHitDisabledComponent),
    typeof (BallHoverComponent),
    typeof (BallImpulseComponent),
    typeof (BallOwnerComponent),
    typeof (BasicTrainingCompleteComponent),
    typeof (CameraTargetComponent),
    typeof (ChampionConfigComponent),
    typeof (CollisionEventComponent),
    typeof (CollisionEventsComponent),
    typeof (ConnectionInfoComponent),
    typeof (ConstrainedTo2DComponent),
    typeof (CountdownActionComponent),
    typeof (DeathComponent),
    typeof (DebugFlagComponent),
    typeof (DeferredCollisionEventsComponent),
    typeof (Imi.SharedWithServer.ScEntitas.Components.Destroyed),
    typeof (FakePlayerComponent),
    typeof (ForcefieldComponent),
    typeof (GamePhysicsComponent),
    typeof (GlobalTimeComponent),
    typeof (GoalComponent),
    typeof (ImiComponent),
    typeof (InputComponent),
    typeof (LastBallContactComponent),
    typeof (LastBallThrowComponent),
    typeof (LastGoalScoredComponent),
    typeof (LastKnownRemoteTickComponent),
    typeof (LoadArenaInfoComponent),
    typeof (LocalEntityComponent),
    typeof (Imi.SharedWithServer.ScEntitas.Components.LocalPlayerVisualSmoothing),
    typeof (MatchConfigComponent),
    typeof (MatchDataComponent),
    typeof (MatchStateComponent),
    typeof (MatchStateTransitionEventComponent),
    typeof (MovementComponent),
    typeof (PlayerChampionDataComponent),
    typeof (PlayerComponent),
    typeof (PlayerForfeitComponent),
    typeof (PlayerHealthComponent),
    typeof (PlayerIdComponent),
    typeof (PlayerLoadoutComponent),
    typeof (PlayerPickOrderComponent),
    typeof (PlayerRespawningComponent),
    typeof (PlayerSpawnPointComponent),
    typeof (PlayerStatisticsComponent),
    typeof (PlayerTeamComponent),
    typeof (PlayerUsernameComponent),
    typeof (PositionTimelineComponent),
    typeof (ProjectileComponent),
    typeof (RemainingMatchTimeComponent),
    typeof (ReplicateComponent),
    typeof (RespawnRigidbodyComponent),
    typeof (RigidbodyComponent),
    typeof (ScoreComponent),
    typeof (SkillGraphComponent),
    typeof (SkillUiComponent),
    typeof (SomeoneScoredComponent),
    typeof (SpawnPlayerComponent),
    typeof (SpraytagComponent),
    typeof (StatusEffectComponent),
    typeof (TransformComponent),
    typeof (TriggerEnterEventComponent),
    typeof (TriggerEventComponent),
    typeof (TriggerExitEventComponent),
    typeof (TriggerStayEventComponent),
    typeof (VelocityOverrideComponent),
    typeof (VfxComponent),
    typeof (VictorySpawnPointComponent),
    typeof (VisualSmoothingComponent),
    typeof (Imi.SteelCircus.ScEntitas.Components.AlignViewToBottom),
    typeof (UnityViewComponent),
    typeof (UniqueIdComponent),
    typeof (RemoteTransformComponent),
    typeof (RemoteEntityLerpStateComponent)
  };
}
