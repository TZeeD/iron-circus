// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.CameraSystem.InGameCameraSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
  [CreateAssetMenu(fileName = "CameraSettings", menuName = "SteelCircus/Configs/CameraSettings")]
  public class InGameCameraSettings : GameConfigEntry
  {
    [Header("Basics")]
    public Vector3 eulerAngles = new Vector3(-43f, -90f, 0.0f);
    public float fov = 20f;
    [Header("Playing field edges / limits (relative to floor edges)")]
    public bool limitToBounds = true;
    public float minViewX = -25f;
    public float maxViewX = 21f;
    public float minViewZ = -43f;
    public float maxViewZ = 43f;
    [Header("Maximum offset that the player can have on screen (0 = remains in center, 1 = max offset is screen edge)")]
    public float maxPlayerScreenOffsetX = 0.66f;
    public float maxPlayerScreenOffsetY = 0.66f;
    [Header("Transition between ball possession / non-possession state")]
    public float transitionToBallPossessionDuration = 0.3f;
    public float transitionToBallNonPossessionDuration = 0.5f;
    [Header("Settings when NOT in ball possession")]
    public float playerToBallMinOffset = 0.25f;
    public float playerToBallMinOffsetAtDistance = 0.25f;
    public float playerToBallMaxOffset = 20f;
    public float playerToBallMaxOffsetAtDistance = 5f;
    public AnimationCurve playerToBallOffsetCurve;
    public float cameraZoomBallNonPossession = 58f;
    [Header("Player moving & changing direction activates different finalOffsetSmoothing:")]
    public float transitionToMovingPlayerDuration = 1f;
    public AnimationCurve transitionToMovingPlayerCurve = AnimationCurve.EaseInOut(0.0f, 0.0f, 1f, 1f);
    [Header("Settings when in possession of ball")]
    public float cameraZoomBallPossession = 70f;
    public float ballPossessionOffsetToGoal = 3f;
    [Header("Camera offset when approaching enemy goal")]
    public float maxOffsetTowardsEnemyGoal = 10f;
    public float offsetTowardsEnemyGoalStartDistance = 30f;
    public float offsetTowardsEnemyGoalFullDistance = 20f;
    public AnimationCurve offsetTowardsEnemyGoalCurve;
    [Header("Effects of being first or last player on field")]
    public float firstPlayerZoom = 50f;
    public float lastPlayerZoom = 50f;
    public float firstPlayerOffset = 10f;
    public float lastPlayerOffset = 10f;
    [Header("How long it takes for being furthest player on field (first or last) to take effect")]
    public float furthestPlayerTransitionDuration = 1f;
    public float furthestPlayerMinDistanceToOthers = 5f;
    public AnimationCurve furthestPlayerEffectTransitionCurve = AnimationCurve.EaseInOut(0.0f, 0.0f, 1f, 1f);
    [Header("Effects of being in a crowd (removes zooms and some offsets)")]
    public int minCrowdSize = 4;
    public float maxCrowdRadius = 6f;
    public float crowdFXTransitionDuration = 2f;
    public AnimationCurve crowdFXTransitionCurve = AnimationCurve.EaseInOut(0.0f, 0.0f, 1f, 1f);
    [Header("Settings for skills")]
    public float sprintSkillZoomOffset = 5f;
    public float sprintSkillZoomSpeed = 20f;
    [Header("Adjustments for team mates and ball below edge of screen")]
    public float verticalAdjustmentAttenuationDistance = 10f;
    public AnimationCurve verticalAdjustmentAttenuationCurve = AnimationCurve.Linear(0.0f, 1f, 1f, 0.0f);
    public float verticalAdjustmentPadding = 0.75f;
    [Header("Final smoothing of resulting zoom and offset (Higher = faster rate of change)")]
    public float finalZoomSmoothing = 0.01f;
    public float finalOffsetSmoothing = 0.01f;
    public float finalOffsetSmoothingWhileMovingAndChangingDirection = 3f;
    public float targetPositionSmoothing = 10f;
  }
}
