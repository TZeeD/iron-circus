// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.BallCreateSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SharedWithServer.Utils;
using SteelCircus.Core;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay
{
  public static class BallCreateSystem
  {
    public static void CreateBall(
      GameContext gameContext,
      GameEntityFactory factory,
      BallConfig ballConfig,
      bool addToPhysics = false)
    {
      GameEntity entityWithUniqueId = factory.CreateEntityWithUniqueId(ReservedUniqueIdRegistry.BallId);
      JRigidbody ballRigidBody = BallCreateSystem.CreateBallRigidBody(ballConfig);
      if (addToPhysics)
        gameContext.gamePhysics.world.AddBody(ballRigidBody);
      entityWithUniqueId.isConstrainedTo2D = true;
      entityWithUniqueId.AddBallHover(0.0f);
      entityWithUniqueId.AddTransform(new JVector(0.0f, 2f, 0.0f), JQuaternion.LookRotation(JVector.Forward, JVector.Up));
      entityWithUniqueId.ReplaceVelocityOverride(JVector.Zero);
      entityWithUniqueId.AddBallFlightInfo(0.0f, 0.0f);
      entityWithUniqueId.AddPositionTimeline(new TimelineVector());
      entityWithUniqueId.isBall = true;
      Log.Debug("BallEntity created with UniqueId: " + (object) entityWithUniqueId.uniqueId.id);
      entityWithUniqueId.AddRigidbody(ballRigidBody, JVector.Zero);
    }

    private static JRigidbody CreateBallRigidBody(BallConfig ballConfig)
    {
      JRigidbody ballRb = new JRigidbody((Shape) new SphereShape(ballConfig.ballColliderRadius));
      ballRb.Position = new JVector(0.0f, 2f, 0.0f);
      ballRb.AllowDeactivation = false;
      ballRb.name = "Ball";
      ballRb.IsTrigger = true;
      ballRb.LinearDrag = 0.0f;
      ballRb.AngularDrag = 0.0f;
      ballRb.AffectedByGravity = false;
      BallCreateSystem.SetCollisionLayerAndMask(ballRb);
      return ballRb;
    }

    public static void SetCollisionLayerAndMask(JRigidbody ballRb)
    {
      ballRb.CollisionLayer = 512;
      ballRb.CollisionMask = CollisionLayerUtils.GetBallCollisionMask();
    }
  }
}
