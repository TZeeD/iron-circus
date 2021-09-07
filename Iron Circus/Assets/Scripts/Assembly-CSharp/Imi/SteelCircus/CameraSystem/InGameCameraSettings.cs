using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
	public class InGameCameraSettings : GameConfigEntry
	{
		public Vector3 eulerAngles;
		public float fov;
		public bool limitToBounds;
		public float minViewX;
		public float maxViewX;
		public float minViewZ;
		public float maxViewZ;
		public float maxPlayerScreenOffsetX;
		public float maxPlayerScreenOffsetY;
		public float transitionToBallPossessionDuration;
		public float transitionToBallNonPossessionDuration;
		public float playerToBallMinOffset;
		public float playerToBallMinOffsetAtDistance;
		public float playerToBallMaxOffset;
		public float playerToBallMaxOffsetAtDistance;
		public AnimationCurve playerToBallOffsetCurve;
		public float cameraZoomBallNonPossession;
		public float transitionToMovingPlayerDuration;
		public AnimationCurve transitionToMovingPlayerCurve;
		public float cameraZoomBallPossession;
		public float ballPossessionOffsetToGoal;
		public float maxOffsetTowardsEnemyGoal;
		public float offsetTowardsEnemyGoalStartDistance;
		public float offsetTowardsEnemyGoalFullDistance;
		public AnimationCurve offsetTowardsEnemyGoalCurve;
		public float firstPlayerZoom;
		public float lastPlayerZoom;
		public float firstPlayerOffset;
		public float lastPlayerOffset;
		public float furthestPlayerTransitionDuration;
		public float furthestPlayerMinDistanceToOthers;
		public AnimationCurve furthestPlayerEffectTransitionCurve;
		public int minCrowdSize;
		public float maxCrowdRadius;
		public float crowdFXTransitionDuration;
		public AnimationCurve crowdFXTransitionCurve;
		public float sprintSkillZoomOffset;
		public float sprintSkillZoomSpeed;
		public float verticalAdjustmentAttenuationDistance;
		public AnimationCurve verticalAdjustmentAttenuationCurve;
		public float verticalAdjustmentPadding;
		public float finalZoomSmoothing;
		public float finalOffsetSmoothing;
		public float finalOffsetSmoothingWhileMovingAndChangingDirection;
		public float targetPositionSmoothing;
	}
}
