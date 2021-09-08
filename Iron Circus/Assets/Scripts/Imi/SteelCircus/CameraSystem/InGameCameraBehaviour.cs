// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.CameraSystem.InGameCameraBehaviour
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.Utils;
using Imi.Utils;
using SharedWithServer.ScEvents;
using SteelCircus;
using SteelCircus.Core;
using SteelCircus.Utils.Smoothing;
using System;
using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
  public class InGameCameraBehaviour : MonoBehaviour
  {
    [SerializeField]
    private InGameCameraSettings settings;
    [SerializeField]
    private Transform rotationTransform;
    [SerializeField]
    private Transform zoomTransform;
    [SerializeField]
    private SCCamera camera;
    private Vector3 targetPosition;
    private bool overrideInProgress;
    private GameContext gameContext;
    private Transform[] goals;
    private Team playersTeam;
    private ulong playerId;
    private IGroup<GameEntity> players;
    private const int historySize = 100;
    private CircularQueue<Vector3> playerVelocityHistory = new CircularQueue<Vector3>(100);
    private CircularQueue<Vector3> playerPositionHistory = new CircularQueue<Vector3>(100);
    private bool playerMovingAndChangingDirection = true;
    private float playerMovingAndChangingDirectionCounter;
    private float playerMovingAndChangingDirectionAcceleration = 5f;
    private float playerMovingAndChangingDirectionSpeed;
    private float playerMovingAndChangingDirectionFXIntensity;
    private float firstPlayerCounter;
    private float lastPlayerCounter;
    private float firstPlayerFXIntensity;
    private float lastPlayerFXIntensity;
    private float ballPossessionCounter;
    private float inCrowdCounter;
    private float inCrowdFXIntensity;
    private HarmonicMotionVector3 smoothedTargetPosition = new HarmonicMotionVector3();
    private float snapToTargetPositionDuration = 1f;
    private float snapToTargetPositionCounter;
    private HarmonicMotionVector3 smoothedOffset = new HarmonicMotionVector3();
    private HarmonicMotionFloat smoothedZoom = new HarmonicMotionFloat();
    private HarmonicMotionFloat smoothedZoomToKeepBallOnScreen = new HarmonicMotionFloat();
    private Vector2[] frustumEdges = new Vector2[4];
    private float sprintSkillZoom;
    private Vector2[] KeepPlayerOnScreen_segments = new Vector2[5];

    public SCCamera Camera => this.camera;

    public void Setup()
    {
      this.gameContext = Contexts.sharedInstance.game;
      GameEntity firstLocalEntity = this.gameContext.GetFirstLocalEntity();
      this.playerId = firstLocalEntity.playerId.value;
      this.playersTeam = firstLocalEntity.playerTeam.value;
      this.goals = Array.ConvertAll<Goal, Transform>(UnityEngine.Object.FindObjectsOfType<Goal>(), (Converter<Goal, Transform>) (g => g.transform));
      if (this.goals.Length == 0)
        Debug.LogWarning((object) "No goals found.");
      this.players = this.gameContext.GetGroup(GameMatcher.Player);
      this.Reset();
    }

    private void Awake() => Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnMatchStateChanged);

    private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnMatchStateChanged);

    private void OnMatchStateChanged(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      if (matchState != Imi.SharedWithServer.Game.MatchState.Intro)
        return;
      this.Setup();
    }

    private void LateUpdate()
    {
      if (!this.camera.gameObject.activeSelf)
        return;
      this.targetPosition = this.gameContext.cameraTarget.position.ToVector3();
      this.targetPosition.y = 0.0f;
      this.smoothedTargetPosition.targetValue = this.targetPosition;
      this.snapToTargetPositionCounter += Time.deltaTime;
      if ((double) this.snapToTargetPositionCounter > (double) this.snapToTargetPositionDuration)
      {
        this.targetPosition = this.smoothedTargetPosition.Step();
      }
      else
      {
        this.smoothedTargetPosition.currentValue = this.targetPosition;
        this.smoothedTargetPosition.velocity = Vector3.zero;
      }
      this.overrideInProgress = this.gameContext.cameraTarget.overrideInProgress;
      this.UpdateBehaviour();
    }

    private void FixedUpdate() => this.AnalyzePlayerMovement();

    public void Reset()
    {
      Log.Debug("In Game Camera is resetting.");
      this.ballPossessionCounter = 0.0f;
      this.lastPlayerCounter = this.firstPlayerCounter = 0.0f;
      this.playerMovingAndChangingDirectionSpeed = 0.0f;
      this.playerMovingAndChangingDirectionCounter = 0.0f;
      this.inCrowdCounter = 0.0f;
      this.smoothedOffset.velocity = Vector3.zero;
      this.smoothedOffset.targetValue = this.smoothedOffset.currentValue = Vector3.zero;
      this.smoothedOffset.AngularFrequency = 3f;
      this.smoothedOffset.recalcCoefficientsEveryStep = true;
      this.smoothedZoom.velocity = 0.0f;
      this.smoothedZoom.targetValue = this.smoothedZoom.currentValue = this.settings.cameraZoomBallNonPossession;
      this.smoothedZoom.AngularFrequency = 3f;
      this.smoothedZoom.recalcCoefficientsEveryStep = true;
      this.smoothedZoomToKeepBallOnScreen.velocity = 0.0f;
      this.smoothedZoomToKeepBallOnScreen.targetValue = this.smoothedZoomToKeepBallOnScreen.currentValue = 1f;
      this.smoothedZoomToKeepBallOnScreen.AngularFrequency = 3f;
      this.smoothedZoomToKeepBallOnScreen.recalcCoefficientsEveryStep = true;
      this.smoothedTargetPosition.velocity = Vector3.zero;
      this.smoothedTargetPosition.targetValue = this.smoothedTargetPosition.currentValue = this.gameContext.cameraTarget.position.ToVector3();
      this.smoothedTargetPosition.AngularFrequency = this.settings.targetPositionSmoothing;
      this.smoothedTargetPosition.recalcCoefficientsEveryStep = true;
      this.snapToTargetPositionCounter = 0.0f;
    }

    private void UpdateBehaviour()
    {
      this.rotationTransform.localEulerAngles = this.settings.eulerAngles;
      this.camera.fov = this.settings.fov;
      Vector3 zero = Vector3.zero;
      this.transform.position = this.targetPosition;
      this.UpdateInCrowdStatus();
      this.UpdateFurthestPlayerStatus();
      this.UpdateInfluenceForMovingAndChangingDirection();
      float num1 = 1f - Mathf.Max(this.firstPlayerFXIntensity, this.lastPlayerFXIntensity);
      float t = 1f - this.inCrowdFXIntensity;
      this.ballPossessionCounter = !this.DoesPlayerOwnBall() ? Mathf.Clamp01(this.ballPossessionCounter - Time.deltaTime / this.settings.transitionToBallNonPossessionDuration) : Mathf.Clamp01(this.ballPossessionCounter + Time.deltaTime / this.settings.transitionToBallPossessionDuration);
      Vector3 resultOffset1;
      float resultZoom1;
      this.HandlePlayerOwnsBall(out resultOffset1, out resultZoom1);
      Vector3 resultOffset2;
      float resultZoom2;
      this.HandlePlayerDoesntOwnBall(out resultOffset2, out resultZoom2);
      Vector3 vector3_1 = zero + Vector3.Lerp(resultOffset2, resultOffset1, this.ballPossessionCounter) * t;
      float num2 = Mathf.Lerp(resultZoom2, resultZoom1, this.ballPossessionCounter);
      Vector3 vector3_2 = vector3_1 + this.GetOffsetTowardsEnemyGoal() * num1 * t;
      Vector3 furthestPlayerOffset;
      float furthestPlayerZoom;
      this.UpdateFurthestPlayerFX(num2, out furthestPlayerOffset, out furthestPlayerZoom);
      Vector3 currentOffset = vector3_2 + furthestPlayerOffset * t;
      float num3 = Mathf.Lerp(num2, Mathf.Max(num2, furthestPlayerZoom), t);
      Vector3 keepOthersOnScreen = this.VerticalOffsetToKeepOthersOnScreen();
      Vector3 vector3_3 = currentOffset + this.KeepPlayerOnScreen(currentOffset) + keepOthersOnScreen;
      if (this.overrideInProgress)
      {
        num3 = 45f;
        vector3_3 = Vector3.zero;
        this.smoothedZoom.currentValue = num3;
        this.smoothedOffset.currentValue = vector3_3;
      }
      this.smoothedOffset.AngularFrequency = Mathf.Lerp(this.settings.finalOffsetSmoothing, this.settings.finalOffsetSmoothingWhileMovingAndChangingDirection, this.playerMovingAndChangingDirectionFXIntensity);
      this.smoothedZoom.AngularFrequency = this.settings.finalZoomSmoothing;
      this.smoothedZoom.targetValue = num3;
      float num4 = this.smoothedZoom.Step();
      this.smoothedOffset.targetValue = vector3_3;
      this.transform.position += this.smoothedOffset.Step();
      this.zoomTransform.localPosition = Vector3.up * num4;
      if (this.settings.limitToBounds)
        this.KeepCameraInsideBounds();
      this.ZoomToKeepBallOnScreenIfFurthestPlayer();
      if (this.settings.limitToBounds)
        this.KeepCameraInsideBounds();
      Vector3 offset;
      float zoomOffset;
      this.GetSkillOffsetAndZoom(out offset, out zoomOffset);
      this.transform.position += offset;
      this.zoomTransform.localPosition += Vector3.up * zoomOffset;
    }

    private void ZoomToKeepBallOnScreenIfFurthestPlayer()
    {
      float b = 1f;
      InGameCameraBehaviour.Frustum floorIntersections = this.GetFrustumFloorIntersections(this.camera);
      Vector3 position1 = this.transform.position;
      Vector3 position2 = this.gameContext.ballEntity.unityView.gameObject.transform.position;
      Vector2 vector2_1 = new Vector2(position2.x, position2.z);
      Vector2 segment2A = new Vector2(position1.x, position1.z);
      Vector2 vector2_2 = segment2A + (vector2_1 - segment2A) * 1.3f;
      Vector2 segment2B = vector2_2 + (vector2_2 - segment2A).normalized * 1.5f;
      Vector2 vector2_3 = new Vector2(floorIntersections.bl.x, floorIntersections.bl.z);
      Vector2 vector2_4 = new Vector2(floorIntersections.br.x, floorIntersections.br.z);
      Vector2 vector2_5 = new Vector2(floorIntersections.tl.x, floorIntersections.tl.z);
      Vector2 vector2_6 = new Vector2(floorIntersections.tr.x, floorIntersections.tr.z);
      this.frustumEdges[0] = vector2_3;
      this.frustumEdges[1] = vector2_5;
      this.frustumEdges[2] = vector2_6;
      this.frustumEdges[3] = vector2_4;
      for (int index = 0; index < 4; ++index)
      {
        Vector2 result;
        if (MathUtils.IntersectSegmentSegment(this.frustumEdges[index], this.frustumEdges[(index + 1) % 4], segment2A, segment2B, out result))
        {
          Vector3 center = MatchObjectsParent.Floor.Center;
          Vector3 size = MatchObjectsParent.Floor.Size;
          float num1 = center.z + size.y / 2f + this.settings.maxViewZ;
          float num2 = (float) (-(double) center.z - (double) size.y / 2.0) + this.settings.minViewZ;
          Vector2 vector2_7 = vector2_4 - segment2A;
          Vector2 vector2_8 = vector2_3 - segment2A;
          double num3 = ((double) num1 - (double) segment2A.y) / (double) vector2_7.y;
          float f = (num2 - segment2A.y) / vector2_8.y;
          float num4 = Mathf.Min(Mathf.Abs((float) num3), Mathf.Abs(f));
          float magnitude = (result - segment2A).magnitude;
          b = (segment2B - segment2A).magnitude / magnitude;
          if ((double) b > (double) num4)
          {
            b = num4 + (float) (((double) b - (double) num4) * 0.5);
            break;
          }
          break;
        }
      }
      float num = Mathf.Lerp(1f, b, Mathf.Max(this.firstPlayerFXIntensity, this.lastPlayerFXIntensity));
      this.smoothedZoomToKeepBallOnScreen.AngularFrequency = 4f;
      this.smoothedZoomToKeepBallOnScreen.targetValue = num;
      this.zoomTransform.localPosition *= this.smoothedZoomToKeepBallOnScreen.Step();
    }

    private void GetSkillOffsetAndZoom(out Vector3 offset, out float zoomOffset)
    {
      offset = Vector3.zero;
      zoomOffset = 0.0f;
      GameEntity firstLocalEntity = this.gameContext.GetFirstLocalEntity();
      bool flag = false;
      if (firstLocalEntity.skillUi.HasStateData(Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint))
        flag = firstLocalEntity.skillUi.GetStateData(Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint).active;
      this.sprintSkillZoom = !flag ? Mathf.Max(this.sprintSkillZoom - Time.deltaTime * this.settings.sprintSkillZoomSpeed, 0.0f) : Mathf.Min(this.sprintSkillZoom + Time.deltaTime * this.settings.sprintSkillZoomSpeed, this.settings.sprintSkillZoomOffset);
      zoomOffset += this.sprintSkillZoom;
    }

    private Vector3 VerticalOffsetToKeepOthersOnScreen()
    {
      InGameCameraBehaviour.Frustum floorIntersections = this.GetFrustumFloorIntersections(this.camera);
      float a = 0.0f;
      foreach (GameEntity player in this.players)
      {
        if (player.playerTeam.value == this.playersTeam)
        {
          float verticalOffsetForEntity = this.GetVerticalOffsetForEntity(player, floorIntersections);
          a = Mathf.Max(a, verticalOffsetForEntity);
        }
      }
      float verticalOffsetForEntity1 = this.GetVerticalOffsetForEntity(this.gameContext.ballEntity, floorIntersections);
      return new Vector3(Mathf.Max(a, verticalOffsetForEntity1), 0.0f, 0.0f);
    }

    private float GetVerticalOffsetForEntity(
      GameEntity entity,
      InGameCameraBehaviour.Frustum frustum)
    {
      float num1 = (float) (((double) frustum.bl.x + (double) frustum.br.x) * 0.5);
      Vector3 position = this.GetPosition(entity);
      position.x += this.settings.verticalAdjustmentPadding;
      float num2 = position.x - num1;
      if ((double) num2 <= 0.0)
        return 0.0f;
      if ((double) position.z >= (double) frustum.bl.z && (double) position.z <= (double) frustum.br.z)
        return num2;
      float num3 = this.settings.verticalAdjustmentAttenuationCurve.Evaluate(Mathf.Clamp01(((double) position.z >= (double) frustum.bl.z ? position.z - frustum.br.z : frustum.bl.z - position.z) / this.settings.verticalAdjustmentAttenuationDistance));
      return num2 * num3;
    }

    private void UpdateInCrowdStatus()
    {
      float num1 = Mathf.Pow(this.settings.maxCrowdRadius, 2f);
      Vector3 playerPosition = this.GetPlayerPosition();
      int num2 = 1;
      foreach (GameEntity player in this.players)
      {
        if (!player.isLocalEntity)
        {
          Vector3 position = player.unityView.gameObject.transform.position;
          position.y = 0.0f;
          if ((double) (position - playerPosition).sqrMagnitude <= (double) num1)
            ++num2;
        }
      }
      if (num2 >= this.settings.minCrowdSize)
        this.inCrowdCounter += Time.deltaTime / this.settings.crowdFXTransitionDuration;
      else
        this.inCrowdCounter -= Time.deltaTime / this.settings.crowdFXTransitionDuration;
      this.inCrowdCounter = Mathf.Clamp01(this.inCrowdCounter);
      this.inCrowdFXIntensity = this.settings.crowdFXTransitionCurve.Evaluate(this.inCrowdCounter);
    }

    private void UpdateFurthestPlayerFX(
      float currentZoom,
      out Vector3 furthestPlayerOffset,
      out float furthestPlayerZoom)
    {
      furthestPlayerZoom = 0.0f;
      furthestPlayerOffset = Vector3.zero;
      float a = Mathf.Lerp(currentZoom, this.settings.firstPlayerZoom, this.firstPlayerFXIntensity);
      float b = Mathf.Lerp(currentZoom, this.settings.lastPlayerZoom, this.lastPlayerFXIntensity);
      furthestPlayerZoom = Mathf.Max(a, b);
      float num1 = this.firstPlayerFXIntensity * Mathf.Abs(this.settings.firstPlayerOffset) * (float) -this.GetDirectionSignToEnemyGoal();
      float num2 = this.lastPlayerFXIntensity * Mathf.Abs(this.settings.lastPlayerOffset) * (float) this.GetDirectionSignToEnemyGoal();
      furthestPlayerOffset = new Vector3(0.0f, 0.0f, num1 + num2);
    }

    private void UpdateInfluenceForMovingAndChangingDirection()
    {
      if (this.playerMovingAndChangingDirection)
      {
        this.playerMovingAndChangingDirectionSpeed += this.playerMovingAndChangingDirectionAcceleration * Time.deltaTime;
        this.playerMovingAndChangingDirectionSpeed = Mathf.Clamp(this.playerMovingAndChangingDirectionSpeed, -1f, 1f);
        this.playerMovingAndChangingDirectionCounter += this.playerMovingAndChangingDirectionSpeed * Time.deltaTime / this.settings.transitionToMovingPlayerDuration;
      }
      else
      {
        this.playerMovingAndChangingDirectionSpeed -= this.playerMovingAndChangingDirectionAcceleration * Time.deltaTime;
        this.playerMovingAndChangingDirectionSpeed = Mathf.Clamp(this.playerMovingAndChangingDirectionSpeed, -1f, 1f);
        this.playerMovingAndChangingDirectionCounter += this.playerMovingAndChangingDirectionSpeed * Time.deltaTime / this.settings.transitionToMovingPlayerDuration;
      }
      this.playerMovingAndChangingDirectionCounter = Mathf.Clamp01(this.playerMovingAndChangingDirectionCounter);
      if ((double) this.playerMovingAndChangingDirectionCounter == 0.0 || (double) this.playerMovingAndChangingDirectionCounter == 1.0)
        this.playerMovingAndChangingDirectionSpeed = 0.0f;
      this.playerMovingAndChangingDirectionFXIntensity = this.settings.transitionToMovingPlayerCurve.Evaluate(this.playerMovingAndChangingDirectionCounter);
    }

    private void UpdateFurthestPlayerStatus()
    {
      float horizontalDistance = this.GetClosestHorizontalDistance();
      bool flag1 = this.IsFirstPlayer() && (double) horizontalDistance >= (double) this.settings.furthestPlayerMinDistanceToOthers && !this.DoesPlayerOwnBall();
      bool flag2 = this.IsLastPlayer() && (double) horizontalDistance >= (double) this.settings.furthestPlayerMinDistanceToOthers;
      this.firstPlayerCounter = Mathf.Clamp01(this.firstPlayerCounter + (float) ((double) Time.deltaTime / (double) this.settings.furthestPlayerTransitionDuration * (flag1 ? 1.0 : -1.0)));
      this.lastPlayerCounter = Mathf.Clamp01(this.lastPlayerCounter + (float) ((double) Time.deltaTime / (double) this.settings.furthestPlayerTransitionDuration * (flag2 ? 1.0 : -1.0)));
      this.firstPlayerFXIntensity = this.settings.furthestPlayerEffectTransitionCurve.Evaluate(this.firstPlayerCounter);
      this.lastPlayerFXIntensity = this.settings.furthestPlayerEffectTransitionCurve.Evaluate(this.lastPlayerCounter);
    }

    private void HandlePlayerDoesntOwnBall(out Vector3 resultOffset, out float resultZoom)
    {
      resultZoom = this.settings.cameraZoomBallNonPossession;
      GameEntity ballEntity = this.gameContext.ballEntity;
      Vector3 position = ballEntity.unityView.gameObject.transform.position;
      if (ballEntity.hasBallOwner)
        position = this.gameContext.GetFirstEntityWithPlayerId(ballEntity.ballOwner.playerId).unityView.gameObject.transform.position;
      position.y = 0.0f;
      position.x = this.targetPosition.x;
      Vector3 vector3 = position - this.targetPosition;
      float magnitude = vector3.magnitude;
      float a = Mathf.Lerp(this.settings.playerToBallMaxOffset, this.settings.playerToBallMinOffset, this.settings.playerToBallOffsetCurve.Evaluate(Mathf.Clamp01((float) (((double) magnitude - (double) this.settings.playerToBallMaxOffsetAtDistance) / ((double) this.settings.playerToBallMinOffsetAtDistance - (double) this.settings.playerToBallMaxOffsetAtDistance)))));
      if ((double) magnitude > 9.99999974737875E-05)
        resultOffset = Mathf.Min(a, magnitude) * vector3.normalized;
      else
        resultOffset = Vector3.zero;
    }

    private void HandlePlayerOwnsBall(out Vector3 resultOffset, out float resultZoom)
    {
      resultZoom = this.settings.cameraZoomBallPossession;
      int directionSignToEnemyGoal = this.GetDirectionSignToEnemyGoal();
      resultOffset = new Vector3(0.0f, 0.0f, this.settings.ballPossessionOffsetToGoal * (float) directionSignToEnemyGoal);
    }

    private Vector3 KeepPlayerOnScreen(Vector3 currentOffset)
    {
      float playerScreenOffsetX = this.settings.maxPlayerScreenOffsetX;
      float playerScreenOffsetY = this.settings.maxPlayerScreenOffsetY;
      InGameCameraBehaviour.Frustum floorIntersections = this.GetFrustumFloorIntersections(this.camera);
      Vector3 v = this.transform.position + currentOffset;
      floorIntersections.tl -= v;
      floorIntersections.tr -= v;
      floorIntersections.bl -= v;
      floorIntersections.br -= v;
      floorIntersections.tl.z *= playerScreenOffsetX;
      floorIntersections.tr.z *= playerScreenOffsetX;
      floorIntersections.bl.z *= playerScreenOffsetX;
      floorIntersections.br.z *= playerScreenOffsetX;
      floorIntersections.tl.x *= playerScreenOffsetY;
      floorIntersections.tr.x *= playerScreenOffsetY;
      floorIntersections.bl.x *= playerScreenOffsetY;
      floorIntersections.br.x *= playerScreenOffsetY;
      floorIntersections.tl += v;
      floorIntersections.tr += v;
      floorIntersections.bl += v;
      floorIntersections.br += v;
      Vector2 segment1B = MathUtils.FlattenY(this.targetPosition);
      Vector2 segment1A = MathUtils.FlattenY(v);
      Vector2 vector2_1 = MathUtils.FlattenY(floorIntersections.tl);
      Vector2 vector2_2 = MathUtils.FlattenY(floorIntersections.tr);
      Vector2 vector2_3 = MathUtils.FlattenY(floorIntersections.bl);
      Vector2 vector2_4 = MathUtils.FlattenY(floorIntersections.br);
      this.KeepPlayerOnScreen_segments[0] = vector2_1;
      this.KeepPlayerOnScreen_segments[1] = vector2_2;
      this.KeepPlayerOnScreen_segments[2] = vector2_4;
      this.KeepPlayerOnScreen_segments[3] = vector2_3;
      this.KeepPlayerOnScreen_segments[4] = vector2_1;
      Vector3 zero = Vector3.zero;
      for (int index = 0; index < this.KeepPlayerOnScreen_segments.Length - 1; ++index)
      {
        Vector2 playerOnScreenSegment1 = this.KeepPlayerOnScreen_segments[index];
        Vector2 playerOnScreenSegment2 = this.KeepPlayerOnScreen_segments[index + 1];
        Vector2 result;
        if (MathUtils.IntersectSegmentSegment(segment1A, segment1B, playerOnScreenSegment1, playerOnScreenSegment2, out result))
        {
          Vector2 vector2_5 = segment1B - result;
          Vector3 vector3 = new Vector3(vector2_5.x, 0.0f, vector2_5.y);
          zero += vector3;
          break;
        }
      }
      return zero;
    }

    private Vector3 GetOffsetTowardsEnemyGoal()
    {
      Transform transform = (Transform) null;
      foreach (Transform goal in this.goals)
      {
        if (goal.GetComponent<Goal>().team == this.playersTeam)
        {
          transform = goal;
          break;
        }
      }
      if ((UnityEngine.Object) transform == (UnityEngine.Object) null)
        return Vector3.zero;
      double z = (double) transform.position.z;
      float num = Mathf.Lerp(0.0f, this.settings.maxOffsetTowardsEnemyGoal, this.settings.offsetTowardsEnemyGoalCurve.Evaluate(Mathf.Clamp01((float) (((double) Mathf.Abs((float) z - this.targetPosition.z) - (double) this.settings.offsetTowardsEnemyGoalStartDistance) / ((double) this.settings.offsetTowardsEnemyGoalFullDistance - (double) this.settings.offsetTowardsEnemyGoalStartDistance)))));
      return new Vector3(0.0f, 0.0f, Mathf.Sign((float) z) * num);
    }

    private void KeepCameraInsideBounds()
    {
      Vector3 position = this.transform.position;
      InGameCameraBehaviour.Frustum floorIntersections = this.GetFrustumFloorIntersections(this.camera);
      Vector3 center = MatchObjectsParent.Floor.Center;
      Vector3 size = MatchObjectsParent.Floor.Size;
      float x1 = floorIntersections.br.x;
      float num1 = center.x + size.x / 2f + this.settings.maxViewX;
      float num2 = (float) (-(double) center.x - (double) size.x / 2.0) + this.settings.minViewX;
      float num3 = center.z + size.y / 2f + this.settings.maxViewZ;
      float num4 = (float) (-(double) center.z - (double) size.y / 2.0) + this.settings.minViewZ;
      float x2 = floorIntersections.tr.x;
      float num5 = 0.0f;
      if ((double) x1 > (double) num1)
        num5 = x1 - num1;
      if ((double) x2 < (double) num2)
        num5 = Mathf.Max(x1 - num1, x2 - num2);
      position.x -= num5;
      float z1 = floorIntersections.br.z;
      if ((double) z1 > (double) num3)
        position.z -= z1 - num3;
      float z2 = floorIntersections.bl.z;
      if ((double) z2 < (double) num4)
        position.z += num4 - z2;
      this.transform.position = position;
    }

    private void AnalyzePlayerMovement()
    {
      Vector3 playerVelocity = this.GetPlayerVelocity();
      Vector3 playerPosition = this.GetPlayerPosition();
      this.playerVelocityHistory.Add(playerVelocity);
      this.playerPositionHistory.Add(playerPosition);
      float num1 = 9f;
      float num2 = 1f;
      if ((double) playerVelocity.sqrMagnitude < (double) num1)
      {
        this.playerMovingAndChangingDirection = false;
      }
      else
      {
        for (int numTicksInThePast = 1; numTicksInThePast < this.playerVelocityHistory.Size; ++numTicksInThePast)
        {
          if ((double) this.playerVelocityHistory.Get(numTicksInThePast).sqrMagnitude < (double) num1)
          {
            this.playerMovingAndChangingDirection = true;
            return;
          }
        }
        Vector3 lineStart = this.playerPositionHistory.Get(this.playerPositionHistory.Size - 1);
        Vector3 normalized = (playerPosition - lineStart).normalized;
        for (int numTicksInThePast = 1; numTicksInThePast < this.playerPositionHistory.Size - 1; ++numTicksInThePast)
        {
          if ((double) MathUtils.SqrDistancePointNormalizedLine(this.playerPositionHistory.Get(numTicksInThePast), lineStart, normalized) > (double) num2)
          {
            this.playerMovingAndChangingDirection = true;
            return;
          }
        }
        this.playerMovingAndChangingDirection = false;
      }
    }

    private int GetDirectionSignToEnemyGoal() => this.playersTeam == Team.Beta ? -1 : 1;

    private bool DoesPlayerOwnBall()
    {
      if (this.gameContext == null)
        return false;
      GameEntity ballEntity = this.gameContext.ballEntity;
      return ballEntity != null && ballEntity.hasBallOwner && (long) ballEntity.ballOwner.playerId == (long) this.playerId;
    }

    private Vector3 GetPosition(GameEntity entityWithView) => entityWithView.unityView.gameObject.transform.position;

    private float GetClosestHorizontalDistance()
    {
      Vector3 targetPosition = this.targetPosition;
      float a = float.MaxValue;
      foreach (GameEntity player in this.players)
      {
        if (!player.IsDead() && !player.isLocalEntity)
        {
          float b = Mathf.Abs(this.GetPosition(player).z - targetPosition.z);
          a = Mathf.Min(a, b);
        }
      }
      return a;
    }

    private bool IsFurthestPlayer(int directionSign)
    {
      Vector3 targetPosition = this.targetPosition;
      foreach (GameEntity player in this.players)
      {
        if (!player.IsDead() && !player.isLocalEntity)
        {
          Vector3 position = this.GetPosition(player);
          if (((double) targetPosition.z - (double) position.z) * (double) directionSign <= 0.0)
            return false;
        }
      }
      return true;
    }

    private bool IsFirstPlayer() => this.IsFurthestPlayer(this.GetDirectionSignToEnemyGoal());

    private bool IsLastPlayer() => this.IsFurthestPlayer(-this.GetDirectionSignToEnemyGoal());

    private Vector3 GetPlayerVelocity() => this.gameContext.GetFirstLocalEntity().rigidbody.value.LinearVelocity.ToVector3();

    private Vector3 GetPlayerPosition() => this.gameContext.GetFirstLocalEntity().transform.position.ToVector3();

    private InGameCameraBehaviour.Frustum GetFrustumFloorIntersections(
      SCCamera cam)
    {
      UnityEngine.Camera main = cam.GetMain();
      float num1 = Mathf.Tan((float) ((double) main.fieldOfView * 0.5 * (Math.PI / 180.0)));
      float num2 = num1 * main.aspect;
      Vector3 forward = main.transform.forward;
      Vector3 right = main.transform.right;
      Vector3 up = main.transform.up;
      Vector3 dir1 = forward - right * num2 + up * num1;
      Vector3 dir2 = forward + right * num2 + up * num1;
      Vector3 dir3 = forward - right * num2 - up * num1;
      Vector3 dir4 = forward + right * num2 - up * num1;
      Vector3 position = main.transform.position;
      return new InGameCameraBehaviour.Frustum(this.IntersectFloor(position, dir1), this.IntersectFloor(position, dir2), this.IntersectFloor(position, dir4), this.IntersectFloor(position, dir3));
    }

    private Vector3 IntersectFloor(Vector3 origin, Vector3 dir) => origin - origin.y / dir.y * dir;

    private struct Frustum
    {
      public Vector3 tl;
      public Vector3 tr;
      public Vector3 bl;
      public Vector3 br;

      public Frustum(Vector3 tl, Vector3 tr, Vector3 br, Vector3 bl)
      {
        this.tl = tl;
        this.tr = tr;
        this.bl = bl;
        this.br = br;
      }
    }
  }
}
