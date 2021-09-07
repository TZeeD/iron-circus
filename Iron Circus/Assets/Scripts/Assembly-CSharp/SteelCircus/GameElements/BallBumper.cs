using UnityEngine;
using Imi.SharedWithServer.Game;
using Rewired.ComponentControls.Effects;

namespace SteelCircus.GameElements
{
	public class BallBumper : MonoBehaviour
	{
		[SerializeField]
		private BumperType type;
		[SerializeField]
		private Transform model;
		[SerializeField]
		private bool useLight;
		[SerializeField]
		private Light bumpLight;
		[SerializeField]
		private Animator animator;
		[SerializeField]
		private float bumpLightDuration;
		[SerializeField]
		private AnimationCurve bumpScaleCurve;
		[SerializeField]
		private float bumpScaleDuration;
		[SerializeField]
		private RotateAroundAxis rotateWingsScript;
		[SerializeField]
		private float rotationAccelerationDuration;
		[SerializeField]
		private float rotationDecelerationDuration;
		[SerializeField]
		private float bumpRotationTopSpeed;
		[SerializeField]
		private BumperFloorUI floorUI;
	}
}
