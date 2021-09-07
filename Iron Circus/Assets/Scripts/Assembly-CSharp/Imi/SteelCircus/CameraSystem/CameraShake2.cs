using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
	public class CameraShake2 : MonoBehaviour
	{
		[SerializeField]
		private float duration;
		[SerializeField]
		private float perlinFactor;
		[SerializeField]
		private float translationFactor;
		[SerializeField]
		private float rotationFactor;
		[SerializeField]
		private AnimationCurve dampeningCurve;
		[SerializeField]
		private float dampingPercent;
		[SerializeField]
		private bool allowTranslation;
		[SerializeField]
		private bool allowRotation;
		[SerializeField]
		private float translationPercent;
		[SerializeField]
		private float rotationPercent;
	}
}
