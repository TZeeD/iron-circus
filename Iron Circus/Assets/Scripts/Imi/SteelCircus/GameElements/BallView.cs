// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.BallView
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ClockStone;
using Entitas.Unity;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.Rendering;
using Jitter.LinearMath;
using SharedWithServer.Game;
using SharedWithServer.ScEntitas.Systems.Gameplay;
using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.Debugging.Proxies;
using SteelCircus.Utils.Smoothing;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
  public class BallView : FloorSpawnableObject
  {
    [SerializeField]
    private Transform model;
    [SerializeField]
    private GameObject glowingOutline;
    [SerializeField]
    private ParticleSystem glowingOutlineParticles;
    [SerializeField]
    private MeshRenderer ballModelMeshRenderer;
    [Header("Hover / y motion")]
    [Tooltip("How 'springy' is the ball height. value less than 1 is more springy. 1 == no springiness")]
    public float viewHeightDamping = 0.23f;
    [Tooltip("How fast does the ball height change")]
    public float viewHeightAngularFrequency = 4f;
    [Tooltip("How fast does the ball height change initially, when throwing the ball. A positive value makes the ball initially move upwards.")]
    public float viewHeightStartVelocity = 5.5f;
    public float hoverHeight = 0.3f;
    public float hoverAmplitude = 0.05f;
    public float hoverFrequency = 0.4f;
    public ParticleSystem chargeParticles;
    [Header("Floor UI")]
    [SerializeField]
    private Transform uiParent;
    [SerializeField]
    private Transform uiIndicator;
    [SerializeField]
    private ParticleSystem uiParticles;
    [SerializeField]
    private TrailRenderer uiTrail;
    [Header("TrailRenderer of the BallModel")]
    [SerializeField]
    private TrailRenderer modelTrail;
    public float ballSpeedToTrailAnimationSpeed = 1f;
    public AnimationCurve ballSpeedToTrailBrightness = AnimationCurve.Constant(0.0f, 0.0f, 3f);
    public float brightnessAdjustmentDampen = 0.5f;
    private Material trailMaterial;
    private static int _Tint = Shader.PropertyToID(nameof (_Tint));
    private static int _AnimationOffset = Shader.PropertyToID(nameof (_AnimationOffset));
    private static int _BrightnessScale = Shader.PropertyToID(nameof (_BrightnessScale));
    private EntityLink entityLink;
    private GameEntity ballEntity;
    private GameEntity ownerEntity;
    private Player ballOwnerView;
    private bool resetQueuedForNextUpdate;
    private float throwTimeCounter;
    public float throwTintDuration = 0.2f;
    [ColorUsage(true, true)]
    public Color throwTint = Color.white;
    [Header("Sparky particles")]
    public ParticleSystem sparkParticles;
    private Vector3 prevModelPosition;
    public AnimationCurve ballSpeedToEmissionRate = AnimationCurve.Constant(0.0f, 20f, 30f);
    public int collisionSparkCount = 30;
    public float collisionSparkSpread = 0.5f;
    public float collisionSparkMinSpeed = 13f;
    public float collisionSparkMaxSpeed = 18f;
    public float wallCollisionBallSpeedThreshold = 5f;
    public Color32 wallCollisionColor = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);
    [Header("Throwing")]
    public float throwParticleSpread = 0.3f;
    public float throwParticleMinSpeed = 20f;
    public float throwParticleMaxSpeed = 30f;
    public int throwParticleCount = 40;
    public Color32 throwParticleColor = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);
    [Header("Rotation")]
    public AnimationCurve ballSpeedToRotationSpeed = AnimationCurve.Constant(0.0f, 20f, 6f);
    public Vector3 ballRotationEulerPerSecond = new Vector3(180f, -73f, 262f);
    public float ballRotationYOscillationSpeed = 6f;
    public AnimationCurve ballSpeedToForwardAxis = AnimationCurve.Linear(10f, 0.0f, 15f, 1f);
    [Header("Glowing outline")]
    public float glowParticleSizeDefault = 0.65f;
    public float glowParticleSizeHolding = 0.75f;
    public float glowParticleSizeCharging = 1.3f;
    private BallConfig ballConfig;
    private AudioObject currentPlayingBallFlightAudio;
    private AudioObject currentPlayingBallFlameAudio;
    private AudioObject currentPlayingChargeShotAudio;
    private float initialBallFlightPitch;
    private float initialBallFlightVolume;
    private float initialBallFlamePitch;
    private float initialBallFlameVolume;
    private float initialBallSpeed;
    private float chargeProgress;
    private float ballSpeedBeforePickup;
    private ObstacleCheckResult checkResult;
    private BallStateMachine stateMachine;
    private float lastCollisionTime;
    private HarmonicMotionFloat harmonicBallY = new HarmonicMotionFloat();
    private float hoverTimeSeconds;
    private bool abortPickup;
    private bool vfxResetting;
    private float ballSpeedFactor = 4.5f;

    public Vector3 Position => new Vector3(this.transform.position.x, this.model.position.y, this.transform.position.z);

    public Transform UiIndicator => this.uiIndicator;

    public ParticleSystem UiParticles => this.uiParticles;

    public TrailRenderer UiTrail => this.uiTrail;

    public TrailRenderer ModelTrail => this.modelTrail;

    public void SetBallConfig(BallConfig ballConfig) => this.ballConfig = ballConfig;

    private void Start()
    {
      this.trailMaterial = this.modelTrail.material;
      this.entityLink = this.GetComponent<EntityLink>();
      this.ballEntity = (GameEntity) this.entityLink.entity;
      this.ballModelMeshRenderer.material = new Material(this.ballModelMeshRenderer.material);
      Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChanged);
      Events.Global.OnEventBumperBallCollision += new Events.EventBumperBallCollision(this.OnBumperCollision);
      Events.Global.OnEventBallTerrainCollision += new Events.EventBallTerrainCollision(this.OnTerrainCollision);
      MatchObjectsParent.FloorRenderer.AddToLayer(this.uiParent, FloorRenderer.FloorLayer.Emissive);
      this.stateMachine = new BallStateMachine();
      this.stateMachine.AddState(BallViewState.InFlight, new BallViewStateConfig()
      {
        onEnter = new Action(this.EnterFlight)
      });
      this.stateMachine.AddState(BallViewState.BeingPickedUp, new BallViewStateConfig()
      {
        onEnter = new Action(this.EnterPickupBall)
      });
      this.stateMachine.AddState(BallViewState.IsHeld, new BallViewStateConfig());
      this.stateMachine.AddState(BallViewState.OwnerChargingThrow, new BallViewStateConfig()
      {
        onEnter = new Action(this.EnterOwnerChargingThrow)
      });
      this.stateMachine.AddState(BallViewState.OwnerThrowing, new BallViewStateConfig()
      {
        onEnter = new Action(this.EnterOwnerThrowing)
      });
      this.stateMachine.EnterState(BallViewState.InFlight);
      if (AudioController.GetAudioItem("BallFlightLoop") != null)
      {
        this.initialBallFlightPitch = AudioController.GetAudioItem("BallFlightLoop").PitchShift;
        this.initialBallFlightVolume = AudioController.GetAudioItem("BallFlightLoop").Volume;
        this.initialBallFlamePitch = AudioController.GetAudioItem("BallFlameLoop").PitchShift;
        this.initialBallFlameVolume = AudioController.GetAudioItem("BallFlameLoop").Volume;
      }
      this.checkResult.sphereCastResults = new List<SphereCastData>();
      MatchObjectsParent.Add(UnityEngine.Object.Instantiate<GameObject>(Resources.Load<GameObject>("Prefabs/Testing/debug_proxy_player"))).GetComponent<DebugProxyPlayer>().id = this.ballEntity.uniqueId.id;
      this.harmonicBallY.currentValue = this.hoverHeight;
      this.harmonicBallY.targetValue = this.hoverHeight;
      this.prevModelPosition = this.model.position;
    }

    private void OnBumperCollision(UniqueId id, JVector position, JVector normal)
    {
      this.harmonicBallY.velocity = this.viewHeightStartVelocity;
      float realtimeSinceStartup = Time.realtimeSinceStartup;
      if ((double) realtimeSinceStartup < (double) this.lastCollisionTime + 0.0500000007450581)
        return;
      this.lastCollisionTime = realtimeSinceStartup;
      this.SpawnSparkParticles(this.model.position, Quaternion.LookRotation(normal.ToVector3()), this.collisionSparkSpread, this.collisionSparkMinSpeed, this.collisionSparkMaxSpeed, this.collisionSparkCount);
    }

    private void OnTerrainCollision(UniqueId id, JVector position, JVector normal)
    {
      float realtimeSinceStartup = Time.realtimeSinceStartup;
      if ((double) realtimeSinceStartup < (double) this.lastCollisionTime + 0.0500000007450581)
        return;
      this.lastCollisionTime = realtimeSinceStartup;
      if ((double) this.ballEntity.velocityOverride.value.Length() < (double) this.wallCollisionBallSpeedThreshold)
        return;
      this.SpawnSparkParticles(this.model.position, Quaternion.LookRotation(normal.ToVector3()), this.collisionSparkSpread, this.collisionSparkMinSpeed, this.collisionSparkMaxSpeed, this.collisionSparkCount, new Color32?(this.wallCollisionColor));
    }

    private void SpawnSparkParticles(
      Vector3 center,
      Quaternion rotation,
      float spread,
      float minSpeed,
      float maxSpeed,
      int count,
      Color32? color = null)
    {
      ParticleSystem.EmitParams emitParams = new ParticleSystem.EmitParams();
      emitParams.position = center;
      if (color.HasValue)
        emitParams.startColor = color.Value;
      for (int index = 0; index < count; ++index)
      {
        float num = UnityEngine.Random.Range(Mathf.Cos(spread * 3.141593f), 1f);
        float f = UnityEngine.Random.Range(0.0f, 6.283185f);
        Vector3 vector3_1 = new Vector3(Mathf.Sqrt(1f - Mathf.Pow(num, 2f)) * Mathf.Cos(f), Mathf.Sqrt(1f - Mathf.Pow(num, 2f)) * Mathf.Sin(f), num);
        Vector3 vector3_2 = vector3_1 * UnityEngine.Random.Range(minSpeed, maxSpeed);
        vector3_1 = rotation * vector3_2;
        emitParams.velocity = vector3_1;
        this.sparkParticles.Emit(emitParams, 1);
      }
    }

    private void LateUpdate()
    {
      if (this.ballEntity == null)
        return;
      if ((double) this.throwTimeCounter > 0.0)
      {
        this.throwTimeCounter -= Time.deltaTime;
        this.trailMaterial.SetColor(BallView._Tint, this.throwTint);
      }
      else
        this.trailMaterial.SetColor(BallView._Tint, Color.white);
      ParticleSystem.EmissionModule emission1 = this.sparkParticles.emission;
      Vector3 vector3_1 = this.ballEntity.velocityOverride.value.ToVector3();
      float magnitude1 = vector3_1.magnitude;
      Vector3 vector3_2 = this.prevModelPosition - this.model.position;
      ParticleSystem.MainModule main = this.glowingOutlineParticles.main;
      main.startSize = (ParticleSystem.MinMaxCurve) this.glowParticleSizeDefault;
      this.prevModelPosition = this.model.position;
      float num1 = this.ballSpeedToTrailAnimationSpeed * magnitude1 * Time.deltaTime;
      float num2 = this.trailMaterial.GetFloat(BallView._AnimationOffset);
      this.trailMaterial.SetFloat(BallView._AnimationOffset, num2 + num1);
      float a1 = this.trailMaterial.GetFloat(BallView._BrightnessScale);
      float b = this.ballSpeedToTrailBrightness.Evaluate(magnitude1);
      if ((double) b < (double) a1)
        b = Mathf.Lerp(a1, b, 1f - Mathf.Exp(-this.brightnessAdjustmentDampen * Time.deltaTime));
      this.trailMaterial.SetFloat(BallView._BrightnessScale, b);
      ParticleSystem.EmissionModule emission2 = this.chargeParticles.emission;
      emission2.enabled = false;
      this.UpdateCurrentState();
      switch (this.stateMachine.state)
      {
        case BallViewState.InFlight:
          this.harmonicBallY.DampingRatio = this.viewHeightDamping;
          this.harmonicBallY.AngularFrequency = this.viewHeightAngularFrequency;
          if (this.ballEntity.velocityOverride.value.IsNearlyZero())
          {
            this.hoverTimeSeconds += Time.deltaTime;
            this.harmonicBallY.targetValue = this.GetBallHover(this.hoverTimeSeconds);
          }
          double num3 = (double) this.harmonicBallY.Step(Time.deltaTime);
          if ((double) this.harmonicBallY.currentValue < (double) this.ballConfig.ballColliderRadius)
          {
            this.harmonicBallY.currentValue = this.ballConfig.ballColliderRadius;
            this.harmonicBallY.velocity *= -1f;
          }
          float y = this.harmonicBallY.currentValue;
          float num4 = 0.75f;
          float num5 = 0.33f;
          if ((double) y < (double) num4)
            y = Mathf.Pow(Mathf.Clamp01((float) (((double) y - (double) num4) / ((double) num5 - (double) num4))), 0.5f) * (num5 - num4) + num4;
          this.model.localPosition = new Vector3(0.0f, y, 0.0f);
          if ((double) vector3_2.x != 0.0 || (double) vector3_2.z != 0.0)
            this.sparkParticles.transform.rotation = Quaternion.LookRotation(vector3_2.normalized, Vector3.up);
          float num6 = this.ballSpeedToEmissionRate.Evaluate(magnitude1);
          emission1.rateOverTime = (ParticleSystem.MinMaxCurve) num6;
          float num7 = this.ballSpeedToRotationSpeed.Evaluate(magnitude1);
          Vector3 rotationEulerPerSecond = this.ballRotationEulerPerSecond;
          float magnitude2 = rotationEulerPerSecond.magnitude;
          rotationEulerPerSecond.y *= Mathf.Sin(this.ballRotationYOscillationSpeed * Time.time);
          Quaternion a2 = Quaternion.Euler(rotationEulerPerSecond * Time.deltaTime * num7);
          float t = this.ballSpeedToForwardAxis.Evaluate(magnitude1);
          this.ballModelMeshRenderer.transform.rotation = Quaternion.Slerp(a2, Quaternion.AngleAxis(Time.deltaTime * num7 * magnitude2, vector3_1.normalized), t) * this.ballModelMeshRenderer.transform.rotation;
          if (this.ballEntity.velocityOverride.value.ToVector3() != Vector3.zero)
          {
            this.ballSpeedBeforePickup = magnitude1;
            this.UpdateBallFlightAudio(this.ballSpeedBeforePickup);
            break;
          }
          this.StopBallFlightAudio();
          break;
        case BallViewState.BeingPickedUp:
          emission1.rateOverTime = (ParticleSystem.MinMaxCurve) 0.0f;
          main.startSize = (ParticleSystem.MinMaxCurve) this.glowParticleSizeHolding;
          this.StopBallFlightAudio();
          break;
        case BallViewState.IsHeld:
          if (this.ballEntity.hasBallOwner && ((UnityEngine.Object) this.ballOwnerView == (UnityEngine.Object) null || (long) this.ballEntity.ballOwner.playerId != (long) this.ballOwnerView.PlayerId))
          {
            this.ownerEntity = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.ballEntity.ballOwner.playerId);
            this.ballOwnerView = this.ownerEntity.unityView.gameObject.GetComponent<Player>();
          }
          this.OverrideBallViewPosition(this.ballOwnerView.BallHoldTransform.position);
          emission1.rateOverTime = (ParticleSystem.MinMaxCurve) 0.0f;
          main.startSize = (ParticleSystem.MinMaxCurve) this.glowParticleSizeHolding;
          break;
        case BallViewState.OwnerChargingThrow:
          if (this.ballEntity.hasBallOwner && (long) this.ballEntity.ballOwner.playerId != (long) this.ballOwnerView.PlayerId)
          {
            this.ResetOwnerAndGoToIsHeld();
            break;
          }
          this.OverrideBallViewPosition(this.ballOwnerView.BallHoldTransform.position);
          this.chargeProgress = this.ownerEntity.animationState.GetState(AnimationStateType.ChargeThrowBall).normalizedProgress;
          main.startSize = (ParticleSystem.MinMaxCurve) Mathf.Lerp(this.glowParticleSizeHolding, this.glowParticleSizeCharging, this.chargeProgress);
          emission1.rateOverTime = (ParticleSystem.MinMaxCurve) 0.0f;
          emission2.enabled = (double) this.chargeProgress > 0.5;
          break;
        case BallViewState.OwnerThrowing:
          this.StopBallFlightAudio();
          if (this.ballEntity.hasBallOwner && (long) this.ballEntity.ballOwner.playerId != (long) this.ballOwnerView.PlayerId)
          {
            this.ResetOwnerAndGoToIsHeld();
            break;
          }
          this.OverrideBallViewPosition(this.ballOwnerView.BallHoldTransform.position);
          emission1.rateOverTime = (ParticleSystem.MinMaxCurve) 0.0f;
          break;
      }
      if ((UnityEngine.Object) this.model != (UnityEngine.Object) null)
      {
        if (this.stateMachine.state == BallViewState.InFlight && (double) vector3_1.magnitude < 10.0 && Contexts.sharedInstance.game.matchStateEntity.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress)
          this.ballModelMeshRenderer.material.EnableKeyword("DRAW_BEHIND");
        else
          this.ballModelMeshRenderer.material.DisableKeyword("DRAW_BEHIND");
        this.UpdateBallModelTrail(this.ballEntity, magnitude1);
      }
      this.uiParent.localPosition = this.transform.localPosition;
      this.uiParent.localScale = this.transform.localScale;
      this.uiParent.localRotation = this.transform.localRotation;
      this.uiIndicator.gameObject.SetActive(!this.ballEntity.hasBallOwner);
      if (!this.resetQueuedForNextUpdate)
        return;
      this.StartCoroutine(this.ResetVfx(1f));
      this.resetQueuedForNextUpdate = false;
    }

    private void ResetOwnerAndGoToIsHeld()
    {
      this.ownerEntity = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.ballEntity.ballOwner.playerId);
      this.ballOwnerView = this.ownerEntity.unityView.gameObject.GetComponent<Player>();
      this.OverrideBallViewPosition(this.ballOwnerView.BallHoldTransform.position);
      this.stateMachine.EnterState(BallViewState.IsHeld);
    }

    protected override void VirtualOnDestroy()
    {
      base.VirtualOnDestroy();
      Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChanged);
      Events.Global.OnEventBumperBallCollision -= new Events.EventBumperBallCollision(this.OnBumperCollision);
      Events.Global.OnEventBallTerrainCollision -= new Events.EventBallTerrainCollision(this.OnTerrainCollision);
    }

    private void OnGameStateChanged(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      switch (matchState)
      {
        case Imi.SharedWithServer.Game.MatchState.Intro:
          this.gameObject.SetActive(false);
          break;
        case Imi.SharedWithServer.Game.MatchState.GetReady:
          this.gameObject.SetActive(true);
          this.resetQueuedForNextUpdate = true;
          break;
        case Imi.SharedWithServer.Game.MatchState.StartPoint:
          this.gameObject.SetActive(true);
          this.resetQueuedForNextUpdate = true;
          break;
        case Imi.SharedWithServer.Game.MatchState.VictoryPose:
          this.gameObject.SetActive(false);
          this.uiParent.gameObject.SetActive(false);
          break;
      }
    }

    private void UpdateCurrentState()
    {
      switch (this.stateMachine.state)
      {
        case BallViewState.InFlight:
          if (!this.ballEntity.hasBallOwner || this.ownerEntity != null)
            break;
          this.stateMachine.EnterState(BallViewState.BeingPickedUp);
          break;
        case BallViewState.BeingPickedUp:
          if (this.ballEntity.hasBallOwner)
            break;
          this.abortPickup = true;
          if (this.IsChargingThrow())
          {
            this.stateMachine.EnterState(BallViewState.OwnerChargingThrow);
            break;
          }
          if (this.stateMachine.state == BallViewState.InFlight)
            break;
          this.stateMachine.EnterState(BallViewState.InFlight);
          break;
        case BallViewState.IsHeld:
          if (this.IsChargingThrow())
          {
            this.stateMachine.EnterState(BallViewState.OwnerChargingThrow);
            break;
          }
          if (this.ballEntity.hasBallOwner)
            break;
          this.stateMachine.EnterState(BallViewState.InFlight);
          break;
        case BallViewState.OwnerChargingThrow:
          if (this.ballEntity.hasBallOwner && (long) this.ballEntity.ballOwner.playerId != (long) this.ballOwnerView.PlayerId)
          {
            this.ownerEntity = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.ballEntity.ballOwner.playerId);
            this.ballOwnerView = this.ownerEntity.unityView.gameObject.GetComponent<Player>();
            this.stateMachine.EnterState(BallViewState.InFlight);
            break;
          }
          if (!this.IsChargingThrow())
          {
            this.stateMachine.EnterState(BallViewState.OwnerThrowing);
            break;
          }
          if (this.ballEntity.hasBallOwner)
            break;
          this.stateMachine.EnterState(BallViewState.InFlight);
          break;
        case BallViewState.OwnerThrowing:
          if (this.ballEntity.hasBallOwner)
            break;
          this.stateMachine.EnterState(BallViewState.InFlight);
          break;
      }
    }

    private void EnterFlight()
    {
      this.ownerEntity = (GameEntity) null;
      if ((UnityEngine.Object) this.ballOwnerView != (UnityEngine.Object) null)
      {
        this.harmonicBallY.currentValue = this.ballOwnerView.BallHoldTransform.position.y;
        GameEntity gameEntity = this.ballOwnerView.GameEntity;
        if (gameEntity != null)
          Quaternion.LookRotation(gameEntity.skillUi.GetStateData(Imi.SharedWithServer.ScEntitas.Components.ButtonType.ThrowBall).aimDirection.ToVector3().normalized);
      }
      this.throwTimeCounter = this.throwTintDuration;
      this.harmonicBallY.velocity = this.viewHeightStartVelocity;
      this.hoverTimeSeconds = 0.0f;
      this.ballOwnerView = (Player) null;
      this.uiParticles.Play(false);
      this.initialBallSpeed = this.ballEntity.velocityOverride.value.ToVector3().magnitude;
      this.currentPlayingBallFlightAudio = AudioController.Play("BallFlightLoop", this.transform);
      this.currentPlayingBallFlameAudio = AudioController.Play("BallFlameLoop", this.transform);
      this.StopChargingThrowAudio();
    }

    private float GetBallHover(float hoverTimeSeconds) => this.hoverAmplitude * (float) Math.Sin((double) hoverTimeSeconds * Math.PI * 2.0 * (double) this.hoverFrequency) + this.hoverHeight + this.ballConfig.ballColliderRadius;

    private void EnterPickupBall()
    {
      this.ownerEntity = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.ballEntity.ballOwner.playerId);
      this.ballOwnerView = this.ownerEntity.unityView.gameObject.GetComponent<Player>();
      this.uiParticles.Stop(false, ParticleSystemStopBehavior.StopEmittingAndClear);
      this.uiTrail.Clear();
      this.StopBallFlightAudio();
      float volumeIfLocal = Mathf.Min((float) (0.699999988079071 + (double) this.ballSpeedBeforePickup / 50.0), 1f);
      AudioTriggerManager.PlayAudioUnwatched2DIfLocal("PickupBallBase", this.ownerEntity, volumeIfLocal, volumeIfLocal * 0.75f);
      AudioTriggerManager.PlayAudioUnwatched2DIfLocal("PickupBallLayer", this.ownerEntity, volumeIfRemote: 0.75f);
      AudioTriggerManager.PlayAudioUnwatched2DIfLocal("PickupBallLayerLocal", this.ownerEntity, volumeIfRemote: 0.0f);
      if (this.ownerEntity.playerTeam.value != Contexts.sharedInstance.game.GetFirstLocalEntity().playerTeam.value)
        AudioController.Play("PickupBallEnemy", this.ownerEntity.unityView.gameObject.transform);
      else
        AudioTriggerManager.PlayAudioUnwatched2DIfLocal("PickupBallAlly", this.ownerEntity, volumeIfRemote: 0.8f);
      string audioId = "";
      ChampionType championType = this.ownerEntity.championConfig.value.championType;
      switch (championType)
      {
        case ChampionType.Servitor:
          audioId = "Capx02VoiceCatchBall";
          break;
        case ChampionType.Bagpipes:
          audioId = "LochlanVoiceCatchBall";
          break;
        case ChampionType.Li:
          audioId = "SchroederVoiceCatchBall";
          break;
        case ChampionType.Mali:
          audioId = "ShaniVoiceCatchBall";
          break;
        case ChampionType.Hildegard:
          audioId = "EllikaVoiceCatchBall";
          break;
        case ChampionType.Acrid:
          audioId = "AcridVoiceCatchBall";
          break;
        case ChampionType.Galena:
          audioId = "GalenaVoiceCatchBall";
          break;
        case ChampionType.Kenny:
          audioId = "KennyVoiceCatchBall";
          break;
        case ChampionType.Robot:
          audioId = "Capx02VoiceCatchBall";
          break;
        default:
          Log.Error(string.Format("CatchBall voice not found for {0}! Using cap", (object) championType));
          break;
      }
      AudioTriggerManager.PlayAudioUnwatched2DIfLocal(audioId, this.ownerEntity);
      this.StartCoroutine(this.UpdateBallPickupAnim());
    }

    private void EnterOwnerChargingThrow()
    {
      if (!this.ownerEntity.isLocalEntity)
        return;
      this.currentPlayingChargeShotAudio = this.PlayChargingThrowAudio();
    }

    private void EnterOwnerThrowing()
    {
      this.PlayBallThrowAudio();
      this.StopChargingThrowAudio();
    }

    private IEnumerator UpdateBallPickupAnim()
    {
      this.abortPickup = false;
      float t = 0.0f;
      float duration = this.ballConfig.takeBallInterpolationDuration;
      Vector3 ballPickupStartV = this.ballEntity.velocityOverride.value.ToVector3();
      Vector3 ballPickupStartPos = this.ballEntity.transform.position.ToVector3();
      while ((double) t < (double) duration)
      {
        if (this.abortPickup)
        {
          yield break;
        }
        else
        {
          t += Time.deltaTime;
          float t1 = (double) duration > 1.40129846432482E-45 ? Mathf.Clamp01(t / duration) : 0.0f;
          this.OverrideBallViewPosition(Vector3.Lerp(ballPickupStartPos + ballPickupStartV * Mathf.Clamp(t, 0.0f, duration), this.ballOwnerView.BallHoldTransform.position, t1));
          yield return (object) null;
        }
      }
      this.stateMachine.EnterState(BallViewState.IsHeld);
    }

    private bool IsChargingThrow() => this.ownerEntity != null && this.ownerEntity.animationState.HasType(AnimationStateType.ChargeThrowBall);

    private IEnumerator ResetVfx(float disabledDuration)
    {
      BallView ballView = this;
      ballView.vfxResetting = true;
      ballView.ballModelMeshRenderer.enabled = false;
      ballView.glowingOutline.SetActive(false);
      ballView.uiTrail.Clear();
      ballView.modelTrail.Clear();
      ballView.uiTrail.enabled = false;
      ballView.modelTrail.enabled = false;
      if (ballView.uiParticles.isEmitting)
        ballView.uiParticles.Stop(false, ParticleSystemStopBehavior.StopEmittingAndClear);
      float t = 0.0f;
      while ((double) t < (double) disabledDuration)
      {
        t += Time.deltaTime;
        yield return (object) null;
      }
      ballView.Spawn();
      AudioController.Play("BallSpawn", ballView.transform);
      ballView.glowingOutline.SetActive(true);
      ballView.ballModelMeshRenderer.enabled = true;
      ballView.uiTrail.enabled = true;
      ballView.modelTrail.enabled = true;
      ballView.vfxResetting = false;
    }

    private IEnumerator ResetTrailWorkaround()
    {
      this.uiTrail.enabled = false;
      this.modelTrail.enabled = false;
      yield return (object) null;
      this.uiTrail.enabled = true;
      this.modelTrail.enabled = true;
    }

    private void UpdateBallModelTrail(GameEntity ballEntity, float magnitude)
    {
      if (this.vfxResetting)
        return;
      if (!ballEntity.hasBallOwner && (double) magnitude < 0.00999999977648258)
        this.modelTrail.enabled = false;
      else
        this.modelTrail.enabled = true;
    }

    private void OverrideBallViewPosition(Vector3 pos)
    {
      Vector3 vector3 = new Vector3(0.0f, pos.y, 0.0f);
      pos.y = 0.0f;
      this.transform.position = pos;
      this.model.localPosition = vector3;
    }

    private void PlayBallThrowAudio()
    {
      AudioController.Play("BallThrowLayer", this.transform, Mathf.Clamp(0.3f + this.chargeProgress, 0.0f, 1f));
      AudioController.Play("BallThrowBaseLight", this.transform, Mathf.Clamp(1f - this.chargeProgress, 0.0f, 1f));
      AudioController.Play("BallThrowBaseHard", this.transform, this.chargeProgress);
      if ((double) this.chargeProgress > 0.899999976158142)
        AudioController.Play("BallThrowBaseFullCharged", this.transform);
      string audioId = "";
      ChampionType championType = this.ownerEntity.championConfig.value.championType;
      switch (championType)
      {
        case ChampionType.Servitor:
          audioId = "Capx02VoiceThrowBall";
          break;
        case ChampionType.Bagpipes:
          audioId = "LochlanVoiceThrowBall";
          break;
        case ChampionType.Li:
          audioId = "SchroederVoiceThrowBall";
          break;
        case ChampionType.Mali:
          audioId = "ShaniVoiceThrowBall";
          break;
        case ChampionType.Hildegard:
          audioId = "EllikaVoiceThrowBall";
          break;
        case ChampionType.Acrid:
          audioId = "AcridVoiceThrowBall";
          break;
        case ChampionType.Galena:
          audioId = "GalenaVoiceThrowBall";
          break;
        case ChampionType.Kenny:
          audioId = "KennyVoiceThrowBall";
          break;
        case ChampionType.Robot:
          audioId = "Capx02VoiceThrowBall";
          break;
        default:
          Log.Error(string.Format("No throw ball sound for {0}", (object) championType));
          break;
      }
      if ((double) this.chargeProgress <= 0.300000011920929 && (double) UnityEngine.Random.Range(0.0f, 1f) <= 0.300000011920929)
        return;
      float num = Mathf.Min(0.7f + this.chargeProgress, 1f);
      AudioTriggerManager.PlayAudioUnwatched2DIfLocal(audioId, this.ownerEntity, num, num);
    }

    private void UpdateBallFlightAudio(float ballSpeed)
    {
      this.ApplyPitchAndVolumeAutomation(this.currentPlayingBallFlightAudio, ballSpeed, this.initialBallFlightVolume, this.initialBallFlightPitch);
      this.ApplyPitchAndVolumeAutomation(this.currentPlayingBallFlameAudio, ballSpeed, this.initialBallFlameVolume, this.initialBallFlamePitch);
    }

    private void ApplyPitchAndVolumeAutomation(
      AudioObject sound,
      float speed,
      float initialVolume,
      float initialPitch)
    {
      if ((UnityEngine.Object) sound == (UnityEngine.Object) null)
        return;
      float num = (float) ((double) this.initialBallSpeed / (double) this.ballSpeedFactor - ((double) this.initialBallSpeed - (double) speed) / (double) this.ballSpeedFactor);
      sound.volume = initialVolume * speed / this.initialBallSpeed;
      sound.pitch = AudioObject.TransformPitch(initialPitch + num);
    }

    private void StopBallFlightAudio(float fadeout = 0.5f)
    {
      AudioController.Stop("BallFlightLoop", fadeout);
      AudioController.Stop("BallFlameLoop", fadeout);
      this.currentPlayingBallFlightAudio = (AudioObject) null;
      this.currentPlayingBallFlameAudio = (AudioObject) null;
    }

    private AudioObject PlayChargingThrowAudio() => AudioController.Play("ChargeShot");

    private void StopChargingThrowAudio(float fadeout = 0.15f)
    {
      if (!(bool) (UnityEngine.Object) this.currentPlayingChargeShotAudio)
        return;
      this.currentPlayingChargeShotAudio.Stop(fadeout);
      this.currentPlayingChargeShotAudio = (AudioObject) null;
    }
  }
}
