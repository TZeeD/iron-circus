// Decompiled with JetBrains decompiler
// Type: PhysicsDebuggingSetup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScEntitas.Systems;
using Imi.SteelCircus.Utils;
using Jitter;
using Jitter.Collision;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using Sandbox.Kaiser.PhysicsDebug;
using SharedWithServer.ScEntitas.Systems.Gameplay;
using SharedWithServer.ScEvents;
using System;
using System.Collections.Generic;
using UnityEngine;

public class PhysicsDebuggingSetup : MonoBehaviour
{
  public ConfigProvider configProvider;
  public float contactPSize = 0.05f;
  public float ballRadius = 0.25f;
  public bool overlapResolve;
  public bool showCapsuleCast;
  public float herz = 60f;
  public float speed = 2f;
  public JVector velocity;
  public JVector ballPos;
  public int tick;
  [Button(true)]
  public bool play;
  [Button(true)]
  public bool step;
  private List<TickInfo> tickInfos = new List<TickInfo>(1000);
  private int currentTick;
  private PhysicsTickSystem physicsSystem;
  private DebugDrawSystem debugDrawSystem;
  private GameContext gameContext;
  private CollisionSystem collisionSystem;
  private JRigidbody ball;
  private float timeStep;
  private JVector currentDirection = new JVector(2f, 0.0f, 3f);
  public ObstacleCheckResult checkResult;
  private JVector cachedV;

  private void Start()
  {
    Events events = new Events();
    GameEntityFactory gameEntityFactory = new GameEntityFactory(Contexts.sharedInstance.game, events, this.configProvider, true);
    World world = this.CreateWorld();
    this.gameContext = Contexts.sharedInstance.game;
    this.gameContext.ReplaceGamePhysics(world, (Action<int, int, GameEntity, Action>) null);
    this.gameContext.ReplaceGlobalTime(this.timeStep, 0.0f, 0, 0, 0.0f, false);
    EntitasSetup entitasSetup = new EntitasSetup(Contexts.sharedInstance, gameEntityFactory, this.configProvider, events, 0);
    this.physicsSystem = new PhysicsTickSystem(entitasSetup);
    this.debugDrawSystem = new DebugDrawSystem(entitasSetup);
    float num1 = 20f;
    float num2 = num1 / 2f;
    float num3 = 5f;
    float num4 = 66f;
    float num5 = 31f;
    float num6 = num4 / 2f;
    double num7 = (double) num5 / 2.0;
    float x1 = 20f;
    float num8 = x1 / 2f;
    JRigidbody box1 = PhysicsDebuggingSetup.CreateBox(new JVector((float) -num7 - num2, 0.0f, 0.0f), new JVector(num1, num3, num4 * 1.5f), "left");
    JRigidbody box2 = PhysicsDebuggingSetup.CreateBox(new JVector((float) num7 + num2, 0.0f, 0.0f), new JVector(num1, num3, num4 * 1.5f), "right");
    JRigidbody box3 = PhysicsDebuggingSetup.CreateBox(new JVector(0.0f, 0.0f, num6 + num2), new JVector(num5 * 1.5f, num3, num1), "top");
    float x2 = num5 * 1.5f;
    float x3 = x2 / 2f;
    JRigidbody box4 = PhysicsDebuggingSetup.CreateBox(new JVector((float) (-(double) x3 / 2.0) - num8, 0.0f, -num6 - num2), new JVector(x3, num3, num1), "bottomL");
    JRigidbody box5 = PhysicsDebuggingSetup.CreateBox(new JVector(x3 / 2f + num8, 0.0f, -num6 - num2), new JVector(x3, num3, num1), "bottomR");
    JRigidbody box6 = PhysicsDebuggingSetup.CreateBox(new JVector(0.0f, 0.0f, (float) (-(double) num6 - (double) num2 - (double) x1 / 2.0)), new JVector(x2, num3, num1), "bottomB");
    JRigidbody box7 = PhysicsDebuggingSetup.CreateBox(new JVector(0.0f, 0.0f, -num6 - num2), new JVector(x1, num3, num1), "bottomT");
    JRigidbody cylinder1 = PhysicsDebuggingSetup.CreateCylinder(new JVector(4f, 0.0f, 6.3f), num3, 0.75f, "obst_1");
    JRigidbody cylinder2 = PhysicsDebuggingSetup.CreateCylinder(new JVector(0.0f, 0.0f, 5f), num3, 0.75f, "obst_2");
    JRigidbody cylinder3 = PhysicsDebuggingSetup.CreateCylinder(new JVector(3f, 0.0f, 22f), num3, 0.75f, "obst_3");
    JRigidbody cylinder4 = PhysicsDebuggingSetup.CreateCylinder(new JVector(-5.5f, 0.0f, -16f), num3, 0.75f, "obst_4");
    JRigidbody cylinder5 = PhysicsDebuggingSetup.CreateCylinder(new JVector(-12.5f, 0.0f, 20f), num3, 0.75f, "obst_5");
    JRigidbody cylinder6 = PhysicsDebuggingSetup.CreateCylinder(new JVector(11.5f, 0.0f, -14f), num3, 0.75f, "obst_6");
    JRigidbody box8 = PhysicsDebuggingSetup.CreateBox(new JVector(1f, 0.0f, -5f), new JVector(4f, num3, 0.5f), "vR", JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(new JVector(-2f, 0.0f, 1f), JVector.Up)));
    JRigidbody box9 = PhysicsDebuggingSetup.CreateBox(new JVector(-1f, 0.0f, -5f), new JVector(4f, num3, 0.5f), "vL", JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(new JVector(2f, 0.0f, 1f), JVector.Up)));
    JRigidbody box10 = PhysicsDebuggingSetup.CreateBox(new JVector(6f, 0.0f, -5f), new JVector(5f, num3, 0.25f), "xR", JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(new JVector(-2.3f, 0.0f, 0.8f), JVector.Up)));
    JRigidbody box11 = PhysicsDebuggingSetup.CreateBox(new JVector(6f, 0.0f, -5f), new JVector(5f, num3, 0.25f), "xL", JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(new JVector(2.8f, 0.0f, 0.8f), JVector.Up)));
    JRigidbody cylinder7 = PhysicsDebuggingSetup.CreateCylinder(new JVector(6.3f, 0.0f, -5.3f), num3, 0.5f, "xCyl");
    JRigidbody box12 = PhysicsDebuggingSetup.CreateBox(new JVector(3f, 0.0f, -5f), new JVector(4f, num3, 0.5f), "iiR", JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(new JVector(1f, 0.0f, 0.0f), JVector.Up)));
    JRigidbody box13 = PhysicsDebuggingSetup.CreateBox(new JVector(3.95f, 0.0f, -5f), new JVector(4f, num3, 0.5f), "iiL", JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(new JVector(1f, 0.0f, 0.0f), JVector.Up)));
    JRigidbody box14 = PhysicsDebuggingSetup.CreateBox(new JVector(-5f, 0.0f, -5f), new JVector(3f, num3, 0.5f), "horR", JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(new JVector(-0.2f, 0.0f, 1f), JVector.Up)));
    JRigidbody box15 = PhysicsDebuggingSetup.CreateBox(new JVector(-7f, 0.0f, -5f), new JVector(3f, num3, 0.5f), "horL", JMatrix.CreateFromQuaternion(JQuaternion.LookRotation(new JVector(0.0f, 0.0f, 1f), JVector.Up)));
    this.ball = this.CreateBall();
    this.ball.name = "ball";
    world.AddBody(box1);
    world.AddBody(box2);
    world.AddBody(box3);
    world.AddBody(box4);
    world.AddBody(box5);
    world.AddBody(box6);
    world.AddBody(box7);
    world.AddBody(cylinder1);
    world.AddBody(cylinder2);
    world.AddBody(cylinder3);
    world.AddBody(cylinder4);
    world.AddBody(cylinder5);
    world.AddBody(cylinder6);
    world.AddBody(box8);
    world.AddBody(box9);
    world.AddBody(box10);
    world.AddBody(box11);
    world.AddBody(cylinder7);
    world.AddBody(box12);
    world.AddBody(box13);
    world.AddBody(box14);
    world.AddBody(box15);
    world.AddBody(this.ball);
    this.UpdateVelocity();
    this.checkResult.sphereCastResults = new List<SphereCastData>();
    this.tickInfos.Add(new TickInfo()
    {
      ballPos = this.ball.Position,
      direction = this.currentDirection,
      speed = this.speed
    });
  }

  private JRigidbody CreateBall()
  {
    GameEntity entity = Contexts.sharedInstance.game.CreateEntity();
    JRigidbody jrigidbody = new JRigidbody((Shape) new SphereShape(this.ballRadius));
    jrigidbody.IsKinematic = true;
    jrigidbody.CollisionLayer = 512;
    jrigidbody.CollisionMask = CollisionLayerUtils.GetBallCollisionMask();
    jrigidbody.Position = JVector.Zero;
    JRigidbody newValue = jrigidbody;
    JVector zero = JVector.Zero;
    entity.AddRigidbody(newValue, zero);
    return jrigidbody;
  }

  private void UpdateVelocity()
  {
    if (!(this.cachedV != this.velocity))
      return;
    this.speed = this.velocity.Length();
    this.currentDirection = this.velocity.Normalized();
    this.cachedV = this.velocity;
  }

  private static JRigidbody CreateBox(JVector position, JVector dimensions, string name) => PhysicsDebuggingSetup.CreateBox(position, dimensions, name, JMatrix.Identity);

  private static JRigidbody CreateBox(
    JVector position,
    JVector dimensions,
    string name,
    JMatrix orientation)
  {
    GameEntity entity = Contexts.sharedInstance.game.CreateEntity();
    JRigidbody body = new JRigidbody((Shape) new BoxShape(dimensions));
    body.name = name;
    body.Position = position;
    body.Orientation = orientation;
    body.IsStatic = true;
    JRigidbody newValue = body;
    JVector zero = JVector.Zero;
    entity.AddRigidbody(newValue, zero);
    new GameObject(name).AddComponent<PhysicsDebugJRigidbody>().SetBody(body);
    return body;
  }

  private static JRigidbody CreateCylinder(
    JVector position,
    float height,
    float radius,
    string name)
  {
    GameEntity entity = Contexts.sharedInstance.game.CreateEntity();
    JRigidbody jrigidbody = new JRigidbody((Shape) new CylinderShape(height, radius));
    jrigidbody.name = name;
    jrigidbody.Position = position;
    jrigidbody.AffectedByGravity = false;
    JRigidbody newValue = jrigidbody;
    JVector zero = JVector.Zero;
    entity.AddRigidbody(newValue, zero);
    return jrigidbody;
  }

  private static JRigidbody CreateCapsule(
    JVector position,
    float height,
    float radius,
    string name)
  {
    GameEntity entity = Contexts.sharedInstance.game.CreateEntity();
    JRigidbody jrigidbody = new JRigidbody((Shape) new CapsuleShape(height, radius));
    jrigidbody.name = name;
    jrigidbody.Position = position;
    jrigidbody.AffectedByGravity = false;
    JRigidbody newValue = jrigidbody;
    JVector zero = JVector.Zero;
    entity.AddRigidbody(newValue, zero);
    return jrigidbody;
  }

  private World CreateWorld(bool createBruteForceSystem = false)
  {
    this.collisionSystem = createBruteForceSystem ? (CollisionSystem) new CollisionSystemBrute() : (CollisionSystem) new CollisionSystemSAP();
    World world = new World(this.collisionSystem);
    ContactSettings contactSettings = world.ContactSettings;
    contactSettings.BiasFactor = 1.5f;
    contactSettings.MaximumBias = 30f;
    contactSettings.MinimumVelocity = 1f / 1000f;
    contactSettings.AllowedPenetration = 0.0001f;
    contactSettings.BreakThreshold = 0.01f;
    return world;
  }

  private void Update()
  {
    this.timeStep = 1f / this.herz;
    if (this.ballPos != this.ball.Position)
      this.ball.Position = this.ballPos;
    this.UpdateVelocity();
    if (this.tick != this.currentTick)
    {
      if (this.tick < 0)
        this.tick = 0;
      if (this.tick < this.tickInfos.Count)
      {
        this.currentTick = this.tick;
        this.SetTick(this.currentTick);
      }
      else
      {
        int tick = this.tick;
        this.currentTick = this.tickInfos.Count - 1;
        this.SetTick(this.currentTick);
        while (this.currentTick < tick)
          this.Tick();
      }
    }
    if (this.step || this.play)
    {
      if (this.step)
        this.step = false;
      this.Tick();
    }
    this.debugDrawSystem.Execute();
  }

  private void SetTick(int tick)
  {
    TickInfo tickInfo = this.tickInfos[tick];
    this.ball.Position = tickInfo.ballPos;
    this.ballPos = tickInfo.ballPos;
    this.currentDirection = tickInfo.direction;
    this.speed = tickInfo.speed;
    this.velocity = this.currentDirection * this.speed;
  }

  private void Tick()
  {
    this.UpdateSphereCast();
    this.ball.Position = this.checkResult.projectedPosition;
    this.ballPos = this.ball.Position;
    this.currentDirection = this.checkResult.resultDirection;
    this.physicsSystem.Execute();
    this.tick = ++this.currentTick;
    if (this.tickInfos.Count > this.currentTick)
      this.tickInfos[this.currentTick] = new TickInfo()
      {
        ballPos = this.ball.Position,
        direction = this.currentDirection,
        speed = this.speed
      };
    else
      this.tickInfos.Add(new TickInfo()
      {
        ballPos = this.ball.Position,
        direction = this.currentDirection,
        speed = this.speed
      });
  }

  private void UpdateSphereCast()
  {
    this.checkResult.collided = false;
    this.checkResult.sphereCastResults.Clear();
  }

  private void OnDrawGizmos()
  {
    if (this.ball == null)
      return;
    Color color = new Color(0.4f, 0.4f, 0.4f, 0.5f);
    Color yellow = Color.yellow;
    this.UpdateSphereCast();
    if (this.checkResult.collided)
    {
      int count = this.checkResult.sphereCastResults.Count;
      for (int index = 0; index < count; ++index)
      {
        SphereCastData sphereCastResult = this.checkResult.sphereCastResults[index];
        Vector3 vector3_1 = sphereCastResult.contactPosition.ToVector3();
        Vector3 end = index != count - 1 ? this.checkResult.sphereCastResults[index + 1].contactPosition.ToVector3() : sphereCastResult.ProjectedPosition.ToVector3();
        Gizmos.color = color;
        Gizmos.DrawWireSphere(vector3_1, this.ballRadius);
        Debug.DrawLine(sphereCastResult.deOrigin.ToVector3(), vector3_1, Color.white);
        Debug.DrawLine(vector3_1, vector3_1 + sphereCastResult.deCastDir.ToVector3() * sphereCastResult.deCheckDistance, Color.red);
        Debug.DrawLine(vector3_1, end, Color.cyan);
        Vector3 vector3_2 = sphereCastResult.contactPoint.ToVector3();
        if (!sphereCastResult.deNormal.IsNearlyZero())
          Debug.DrawLine(vector3_2, vector3_2 + sphereCastResult.deNormal.ToVector3(), yellow);
        Gizmos.color = Color.red;
        Gizmos.DrawSphere(vector3_1, this.contactPSize);
        Gizmos.color = yellow;
        Gizmos.DrawSphere(vector3_2, this.contactPSize);
      }
    }
    else
    {
      Vector3 vector3 = (this.ball.Position + this.currentDirection * this.speed * this.timeStep).ToVector3();
      Debug.DrawLine(this.ball.Position.ToVector3(), vector3);
      Gizmos.color = color;
      Gizmos.DrawWireSphere(vector3, this.ballRadius);
    }
    Gizmos.color = color;
    Gizmos.DrawWireSphere(this.checkResult.projectedPosition.ToVector3(), this.ballRadius);
  }
}
