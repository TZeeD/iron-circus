// Decompiled with JetBrains decompiler
// Type: GameMatcher
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;

public sealed class GameMatcher
{
  private static IMatcher<GameEntity> _matcherAlignViewToBottom;
  private static IMatcher<GameEntity> _matcherAnimationState;
  private static IMatcher<GameEntity> _matcherAreaOfEffect;
  private static IMatcher<GameEntity> _matcherArenaLoaded;
  private static IMatcher<GameEntity> _matcherBall;
  private static IMatcher<GameEntity> _matcherBallFlight;
  private static IMatcher<GameEntity> _matcherBallFlightInfo;
  private static IMatcher<GameEntity> _matcherBallHitDisabled;
  private static IMatcher<GameEntity> _matcherBallHover;
  private static IMatcher<GameEntity> _matcherBallImpulse;
  private static IMatcher<GameEntity> _matcherBallOwner;
  private static IMatcher<GameEntity> _matcherBasicTrainingComplete;
  private static IMatcher<GameEntity> _matcherBumper;
  private static IMatcher<GameEntity> _matcherCameraTarget;
  private static IMatcher<GameEntity> _matcherChampionConfig;
  private static IMatcher<GameEntity> _matcherCollisionEvent;
  private static IMatcher<GameEntity> _matcherCollisionEvents;
  private static IMatcher<GameEntity> _matcherConnectionInfo;
  private static IMatcher<GameEntity> _matcherConstrainedTo2D;
  private static IMatcher<GameEntity> _matcherCountdownAction;
  private static IMatcher<GameEntity> _matcherDeath;
  private static IMatcher<GameEntity> _matcherDebugFlag;
  private static IMatcher<GameEntity> _matcherDeferredCollisionEvents;
  private static IMatcher<GameEntity> _matcherDestroyed;
  private static IMatcher<GameEntity> _matcherEventDispatcher;
  private static IMatcher<GameEntity> _matcherFakePlayer;
  private static IMatcher<GameEntity> _matcherForcefield;
  private static IMatcher<GameEntity> _matcherGamePhysics;
  private static IMatcher<GameEntity> _matcherGlobalTime;
  private static IMatcher<GameEntity> _matcherGoal;
  private static IMatcher<GameEntity> _matcherImi;
  private static IMatcher<GameEntity> _matcherInput;
  private static IMatcher<GameEntity> _matcherLastBallContact;
  private static IMatcher<GameEntity> _matcherLastBallThrow;
  private static IMatcher<GameEntity> _matcherLastGoalScored;
  private static IMatcher<GameEntity> _matcherLastKnownRemoteTick;
  private static IMatcher<GameEntity> _matcherLoadArenaInfo;
  private static IMatcher<GameEntity> _matcherLocalEntity;
  private static IMatcher<GameEntity> _matcherLocalPlayerVisualSmoothing;
  private static IMatcher<GameEntity> _matcherMatchConfig;
  private static IMatcher<GameEntity> _matcherMatchData;
  private static IMatcher<GameEntity> _matcherMatchState;
  private static IMatcher<GameEntity> _matcherMatchStateTransitionEvent;
  private static IMatcher<GameEntity> _matcherMovement;
  private static IMatcher<GameEntity> _matcherPickup;
  private static IMatcher<GameEntity> _matcherPickupConsumed;
  private static IMatcher<GameEntity> _matcherPlayerChampionData;
  private static IMatcher<GameEntity> _matcherPlayer;
  private static IMatcher<GameEntity> _matcherPlayerForfeit;
  private static IMatcher<GameEntity> _matcherPlayerHealth;
  private static IMatcher<GameEntity> _matcherPlayerId;
  private static IMatcher<GameEntity> _matcherPlayerLoadout;
  private static IMatcher<GameEntity> _matcherPlayerPickOrder;
  private static IMatcher<GameEntity> _matcherPlayerRespawning;
  private static IMatcher<GameEntity> _matcherPlayerSpawnPoint;
  private static IMatcher<GameEntity> _matcherPlayerStatistics;
  private static IMatcher<GameEntity> _matcherPlayerTeam;
  private static IMatcher<GameEntity> _matcherPlayerUsername;
  private static IMatcher<GameEntity> _matcherPositionTimeline;
  private static IMatcher<GameEntity> _matcherProjectile;
  private static IMatcher<GameEntity> _matcherRemainingMatchTime;
  private static IMatcher<GameEntity> _matcherRemoteEntityLerpState;
  private static IMatcher<GameEntity> _matcherRemoteTransform;
  private static IMatcher<GameEntity> _matcherReplicate;
  private static IMatcher<GameEntity> _matcherRespawnRigidbody;
  private static IMatcher<GameEntity> _matcherRigidbody;
  private static IMatcher<GameEntity> _matcherScore;
  private static IMatcher<GameEntity> _matcherSkillGraph;
  private static IMatcher<GameEntity> _matcherSkillUi;
  private static IMatcher<GameEntity> _matcherSomeoneScored;
  private static IMatcher<GameEntity> _matcherSpawnPickup;
  private static IMatcher<GameEntity> _matcherSpawnPlayer;
  private static IMatcher<GameEntity> _matcherSpraytag;
  private static IMatcher<GameEntity> _matcherStatusEffect;
  private static IMatcher<GameEntity> _matcherTransform;
  private static IMatcher<GameEntity> _matcherTriggerEnterEvent;
  private static IMatcher<GameEntity> _matcherTriggerEvent;
  private static IMatcher<GameEntity> _matcherTriggerExitEvent;
  private static IMatcher<GameEntity> _matcherTriggerStayEvent;
  private static IMatcher<GameEntity> _matcherUniqueId;
  private static IMatcher<GameEntity> _matcherUnityView;
  private static IMatcher<GameEntity> _matcherVelocityOverride;
  private static IMatcher<GameEntity> _matcherVfx;
  private static IMatcher<GameEntity> _matcherVictorySpawnPoint;
  private static IMatcher<GameEntity> _matcherVisualSmoothing;

  public static IMatcher<GameEntity> AlignViewToBottom
  {
    get
    {
      if (GameMatcher._matcherAlignViewToBottom == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(80);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherAlignViewToBottom = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherAlignViewToBottom;
    }
  }

  public static IMatcher<GameEntity> AnimationState
  {
    get
    {
      if (GameMatcher._matcherAnimationState == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(5);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherAnimationState = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherAnimationState;
    }
  }

  public static IMatcher<GameEntity> AreaOfEffect
  {
    get
    {
      if (GameMatcher._matcherAreaOfEffect == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(6);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherAreaOfEffect = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherAreaOfEffect;
    }
  }

  public static IMatcher<GameEntity> ArenaLoaded
  {
    get
    {
      if (GameMatcher._matcherArenaLoaded == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(7);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherArenaLoaded = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherArenaLoaded;
    }
  }

  public static IMatcher<GameEntity> Ball
  {
    get
    {
      if (GameMatcher._matcherBall == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(8);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBall = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBall;
    }
  }

  public static IMatcher<GameEntity> BallFlight
  {
    get
    {
      if (GameMatcher._matcherBallFlight == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(9);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBallFlight = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBallFlight;
    }
  }

  public static IMatcher<GameEntity> BallFlightInfo
  {
    get
    {
      if (GameMatcher._matcherBallFlightInfo == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(10);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBallFlightInfo = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBallFlightInfo;
    }
  }

  public static IMatcher<GameEntity> BallHitDisabled
  {
    get
    {
      if (GameMatcher._matcherBallHitDisabled == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(11);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBallHitDisabled = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBallHitDisabled;
    }
  }

  public static IMatcher<GameEntity> BallHover
  {
    get
    {
      if (GameMatcher._matcherBallHover == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(12);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBallHover = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBallHover;
    }
  }

  public static IMatcher<GameEntity> BallImpulse
  {
    get
    {
      if (GameMatcher._matcherBallImpulse == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(13);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBallImpulse = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBallImpulse;
    }
  }

  public static IMatcher<GameEntity> BallOwner
  {
    get
    {
      if (GameMatcher._matcherBallOwner == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(14);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBallOwner = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBallOwner;
    }
  }

  public static IMatcher<GameEntity> BasicTrainingComplete
  {
    get
    {
      if (GameMatcher._matcherBasicTrainingComplete == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(15);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBasicTrainingComplete = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBasicTrainingComplete;
    }
  }

  public static IMatcher<GameEntity> Bumper
  {
    get
    {
      if (GameMatcher._matcherBumper == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(1);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherBumper = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherBumper;
    }
  }

  public static IMatcher<GameEntity> CameraTarget
  {
    get
    {
      if (GameMatcher._matcherCameraTarget == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(16);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherCameraTarget = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherCameraTarget;
    }
  }

  public static IMatcher<GameEntity> ChampionConfig
  {
    get
    {
      if (GameMatcher._matcherChampionConfig == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(17);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherChampionConfig = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherChampionConfig;
    }
  }

  public static IMatcher<GameEntity> CollisionEvent
  {
    get
    {
      if (GameMatcher._matcherCollisionEvent == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(18);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherCollisionEvent = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherCollisionEvent;
    }
  }

  public static IMatcher<GameEntity> CollisionEvents
  {
    get
    {
      if (GameMatcher._matcherCollisionEvents == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(19);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherCollisionEvents = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherCollisionEvents;
    }
  }

  public static IMatcher<GameEntity> ConnectionInfo
  {
    get
    {
      if (GameMatcher._matcherConnectionInfo == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(20);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherConnectionInfo = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherConnectionInfo;
    }
  }

  public static IMatcher<GameEntity> ConstrainedTo2D
  {
    get
    {
      if (GameMatcher._matcherConstrainedTo2D == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(21);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherConstrainedTo2D = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherConstrainedTo2D;
    }
  }

  public static IMatcher<GameEntity> CountdownAction
  {
    get
    {
      if (GameMatcher._matcherCountdownAction == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(22);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherCountdownAction = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherCountdownAction;
    }
  }

  public static IMatcher<GameEntity> Death
  {
    get
    {
      if (GameMatcher._matcherDeath == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(23);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherDeath = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherDeath;
    }
  }

  public static IMatcher<GameEntity> DebugFlag
  {
    get
    {
      if (GameMatcher._matcherDebugFlag == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(24);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherDebugFlag = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherDebugFlag;
    }
  }

  public static IMatcher<GameEntity> DeferredCollisionEvents
  {
    get
    {
      if (GameMatcher._matcherDeferredCollisionEvents == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(25);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherDeferredCollisionEvents = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherDeferredCollisionEvents;
    }
  }

  public static IMatcher<GameEntity> Destroyed
  {
    get
    {
      if (GameMatcher._matcherDestroyed == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(26);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherDestroyed = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherDestroyed;
    }
  }

  public static IMatcher<GameEntity> EventDispatcher
  {
    get
    {
      if (GameMatcher._matcherEventDispatcher == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(new int[1]);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherEventDispatcher = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherEventDispatcher;
    }
  }

  public static IMatcher<GameEntity> FakePlayer
  {
    get
    {
      if (GameMatcher._matcherFakePlayer == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(27);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherFakePlayer = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherFakePlayer;
    }
  }

  public static IMatcher<GameEntity> Forcefield
  {
    get
    {
      if (GameMatcher._matcherForcefield == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(28);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherForcefield = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherForcefield;
    }
  }

  public static IMatcher<GameEntity> GamePhysics
  {
    get
    {
      if (GameMatcher._matcherGamePhysics == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(29);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherGamePhysics = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherGamePhysics;
    }
  }

  public static IMatcher<GameEntity> GlobalTime
  {
    get
    {
      if (GameMatcher._matcherGlobalTime == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(30);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherGlobalTime = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherGlobalTime;
    }
  }

  public static IMatcher<GameEntity> Goal
  {
    get
    {
      if (GameMatcher._matcherGoal == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(31);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherGoal = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherGoal;
    }
  }

  public static IMatcher<GameEntity> Imi
  {
    get
    {
      if (GameMatcher._matcherImi == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(32);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherImi = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherImi;
    }
  }

  public static IMatcher<GameEntity> Input
  {
    get
    {
      if (GameMatcher._matcherInput == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(33);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherInput = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherInput;
    }
  }

  public static IMatcher<GameEntity> LastBallContact
  {
    get
    {
      if (GameMatcher._matcherLastBallContact == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(34);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherLastBallContact = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherLastBallContact;
    }
  }

  public static IMatcher<GameEntity> LastBallThrow
  {
    get
    {
      if (GameMatcher._matcherLastBallThrow == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(35);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherLastBallThrow = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherLastBallThrow;
    }
  }

  public static IMatcher<GameEntity> LastGoalScored
  {
    get
    {
      if (GameMatcher._matcherLastGoalScored == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(36);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherLastGoalScored = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherLastGoalScored;
    }
  }

  public static IMatcher<GameEntity> LastKnownRemoteTick
  {
    get
    {
      if (GameMatcher._matcherLastKnownRemoteTick == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(37);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherLastKnownRemoteTick = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherLastKnownRemoteTick;
    }
  }

  public static IMatcher<GameEntity> LoadArenaInfo
  {
    get
    {
      if (GameMatcher._matcherLoadArenaInfo == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(38);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherLoadArenaInfo = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherLoadArenaInfo;
    }
  }

  public static IMatcher<GameEntity> LocalEntity
  {
    get
    {
      if (GameMatcher._matcherLocalEntity == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(39);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherLocalEntity = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherLocalEntity;
    }
  }

  public static IMatcher<GameEntity> LocalPlayerVisualSmoothing
  {
    get
    {
      if (GameMatcher._matcherLocalPlayerVisualSmoothing == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(40);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherLocalPlayerVisualSmoothing = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherLocalPlayerVisualSmoothing;
    }
  }

  public static IMatcher<GameEntity> MatchConfig
  {
    get
    {
      if (GameMatcher._matcherMatchConfig == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(41);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherMatchConfig = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherMatchConfig;
    }
  }

  public static IMatcher<GameEntity> MatchData
  {
    get
    {
      if (GameMatcher._matcherMatchData == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(42);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherMatchData = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherMatchData;
    }
  }

  public static IMatcher<GameEntity> MatchState
  {
    get
    {
      if (GameMatcher._matcherMatchState == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(43);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherMatchState = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherMatchState;
    }
  }

  public static IMatcher<GameEntity> MatchStateTransitionEvent
  {
    get
    {
      if (GameMatcher._matcherMatchStateTransitionEvent == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(44);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherMatchStateTransitionEvent = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherMatchStateTransitionEvent;
    }
  }

  public static IMatcher<GameEntity> Movement
  {
    get
    {
      if (GameMatcher._matcherMovement == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(45);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherMovement = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherMovement;
    }
  }

  public static IMatcher<GameEntity> Pickup
  {
    get
    {
      if (GameMatcher._matcherPickup == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(2);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPickup = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPickup;
    }
  }

  public static IMatcher<GameEntity> PickupConsumed
  {
    get
    {
      if (GameMatcher._matcherPickupConsumed == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(3);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPickupConsumed = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPickupConsumed;
    }
  }

  public static IMatcher<GameEntity> PlayerChampionData
  {
    get
    {
      if (GameMatcher._matcherPlayerChampionData == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(46);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerChampionData = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerChampionData;
    }
  }

  public static IMatcher<GameEntity> Player
  {
    get
    {
      if (GameMatcher._matcherPlayer == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(47);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayer = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayer;
    }
  }

  public static IMatcher<GameEntity> PlayerForfeit
  {
    get
    {
      if (GameMatcher._matcherPlayerForfeit == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(48);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerForfeit = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerForfeit;
    }
  }

  public static IMatcher<GameEntity> PlayerHealth
  {
    get
    {
      if (GameMatcher._matcherPlayerHealth == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(49);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerHealth = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerHealth;
    }
  }

  public static IMatcher<GameEntity> PlayerId
  {
    get
    {
      if (GameMatcher._matcherPlayerId == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(50);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerId = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerId;
    }
  }

  public static IMatcher<GameEntity> PlayerLoadout
  {
    get
    {
      if (GameMatcher._matcherPlayerLoadout == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(51);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerLoadout = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerLoadout;
    }
  }

  public static IMatcher<GameEntity> PlayerPickOrder
  {
    get
    {
      if (GameMatcher._matcherPlayerPickOrder == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(52);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerPickOrder = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerPickOrder;
    }
  }

  public static IMatcher<GameEntity> PlayerRespawning
  {
    get
    {
      if (GameMatcher._matcherPlayerRespawning == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(53);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerRespawning = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerRespawning;
    }
  }

  public static IMatcher<GameEntity> PlayerSpawnPoint
  {
    get
    {
      if (GameMatcher._matcherPlayerSpawnPoint == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(54);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerSpawnPoint = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerSpawnPoint;
    }
  }

  public static IMatcher<GameEntity> PlayerStatistics
  {
    get
    {
      if (GameMatcher._matcherPlayerStatistics == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(55);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerStatistics = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerStatistics;
    }
  }

  public static IMatcher<GameEntity> PlayerTeam
  {
    get
    {
      if (GameMatcher._matcherPlayerTeam == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(56);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerTeam = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerTeam;
    }
  }

  public static IMatcher<GameEntity> PlayerUsername
  {
    get
    {
      if (GameMatcher._matcherPlayerUsername == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(57);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPlayerUsername = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPlayerUsername;
    }
  }

  public static IMatcher<GameEntity> PositionTimeline
  {
    get
    {
      if (GameMatcher._matcherPositionTimeline == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(58);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherPositionTimeline = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherPositionTimeline;
    }
  }

  public static IMatcher<GameEntity> Projectile
  {
    get
    {
      if (GameMatcher._matcherProjectile == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(59);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherProjectile = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherProjectile;
    }
  }

  public static IMatcher<GameEntity> RemainingMatchTime
  {
    get
    {
      if (GameMatcher._matcherRemainingMatchTime == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(60);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherRemainingMatchTime = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherRemainingMatchTime;
    }
  }

  public static IMatcher<GameEntity> RemoteEntityLerpState
  {
    get
    {
      if (GameMatcher._matcherRemoteEntityLerpState == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(84);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherRemoteEntityLerpState = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherRemoteEntityLerpState;
    }
  }

  public static IMatcher<GameEntity> RemoteTransform
  {
    get
    {
      if (GameMatcher._matcherRemoteTransform == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(83);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherRemoteTransform = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherRemoteTransform;
    }
  }

  public static IMatcher<GameEntity> Replicate
  {
    get
    {
      if (GameMatcher._matcherReplicate == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(61);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherReplicate = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherReplicate;
    }
  }

  public static IMatcher<GameEntity> RespawnRigidbody
  {
    get
    {
      if (GameMatcher._matcherRespawnRigidbody == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(62);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherRespawnRigidbody = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherRespawnRigidbody;
    }
  }

  public static IMatcher<GameEntity> Rigidbody
  {
    get
    {
      if (GameMatcher._matcherRigidbody == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(63);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherRigidbody = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherRigidbody;
    }
  }

  public static IMatcher<GameEntity> Score
  {
    get
    {
      if (GameMatcher._matcherScore == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(64);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherScore = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherScore;
    }
  }

  public static IMatcher<GameEntity> SkillGraph
  {
    get
    {
      if (GameMatcher._matcherSkillGraph == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(65);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherSkillGraph = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherSkillGraph;
    }
  }

  public static IMatcher<GameEntity> SkillUi
  {
    get
    {
      if (GameMatcher._matcherSkillUi == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(66);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherSkillUi = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherSkillUi;
    }
  }

  public static IMatcher<GameEntity> SomeoneScored
  {
    get
    {
      if (GameMatcher._matcherSomeoneScored == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(67);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherSomeoneScored = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherSomeoneScored;
    }
  }

  public static IMatcher<GameEntity> SpawnPickup
  {
    get
    {
      if (GameMatcher._matcherSpawnPickup == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(4);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherSpawnPickup = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherSpawnPickup;
    }
  }

  public static IMatcher<GameEntity> SpawnPlayer
  {
    get
    {
      if (GameMatcher._matcherSpawnPlayer == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(68);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherSpawnPlayer = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherSpawnPlayer;
    }
  }

  public static IMatcher<GameEntity> Spraytag
  {
    get
    {
      if (GameMatcher._matcherSpraytag == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(69);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherSpraytag = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherSpraytag;
    }
  }

  public static IMatcher<GameEntity> StatusEffect
  {
    get
    {
      if (GameMatcher._matcherStatusEffect == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(70);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherStatusEffect = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherStatusEffect;
    }
  }

  public static IMatcher<GameEntity> Transform
  {
    get
    {
      if (GameMatcher._matcherTransform == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(71);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherTransform = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherTransform;
    }
  }

  public static IMatcher<GameEntity> TriggerEnterEvent
  {
    get
    {
      if (GameMatcher._matcherTriggerEnterEvent == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(72);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherTriggerEnterEvent = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherTriggerEnterEvent;
    }
  }

  public static IMatcher<GameEntity> TriggerEvent
  {
    get
    {
      if (GameMatcher._matcherTriggerEvent == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(73);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherTriggerEvent = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherTriggerEvent;
    }
  }

  public static IMatcher<GameEntity> TriggerExitEvent
  {
    get
    {
      if (GameMatcher._matcherTriggerExitEvent == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(74);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherTriggerExitEvent = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherTriggerExitEvent;
    }
  }

  public static IMatcher<GameEntity> TriggerStayEvent
  {
    get
    {
      if (GameMatcher._matcherTriggerStayEvent == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(75);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherTriggerStayEvent = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherTriggerStayEvent;
    }
  }

  public static IMatcher<GameEntity> UniqueId
  {
    get
    {
      if (GameMatcher._matcherUniqueId == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(82);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherUniqueId = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherUniqueId;
    }
  }

  public static IMatcher<GameEntity> UnityView
  {
    get
    {
      if (GameMatcher._matcherUnityView == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(81);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherUnityView = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherUnityView;
    }
  }

  public static IMatcher<GameEntity> VelocityOverride
  {
    get
    {
      if (GameMatcher._matcherVelocityOverride == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(76);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherVelocityOverride = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherVelocityOverride;
    }
  }

  public static IMatcher<GameEntity> Vfx
  {
    get
    {
      if (GameMatcher._matcherVfx == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(77);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherVfx = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherVfx;
    }
  }

  public static IMatcher<GameEntity> VictorySpawnPoint
  {
    get
    {
      if (GameMatcher._matcherVictorySpawnPoint == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(78);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherVictorySpawnPoint = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherVictorySpawnPoint;
    }
  }

  public static IMatcher<GameEntity> VisualSmoothing
  {
    get
    {
      if (GameMatcher._matcherVisualSmoothing == null)
      {
        Matcher<GameEntity> matcher = (Matcher<GameEntity>) Matcher<GameEntity>.AllOf(79);
        matcher.componentNames = GameComponentsLookup.componentNames;
        GameMatcher._matcherVisualSmoothing = (IMatcher<GameEntity>) matcher;
      }
      return GameMatcher._matcherVisualSmoothing;
    }
  }

  public static IAllOfMatcher<GameEntity> AllOf(params int[] indices) => Matcher<GameEntity>.AllOf(indices);

  public static IAllOfMatcher<GameEntity> AllOf(
    params IMatcher<GameEntity>[] matchers)
  {
    return Matcher<GameEntity>.AllOf(matchers);
  }

  public static IAnyOfMatcher<GameEntity> AnyOf(params int[] indices) => Matcher<GameEntity>.AnyOf(indices);

  public static IAnyOfMatcher<GameEntity> AnyOf(
    params IMatcher<GameEntity>[] matchers)
  {
    return Matcher<GameEntity>.AnyOf(matchers);
  }
}
