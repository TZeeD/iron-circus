using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
	public class CameraShake : MonoBehaviour
	{
		public float angle;
		public float strength;
		public float duration;
		public float maxSpeed;
		public float minSpeed;
		public float noisePercent;
		public float dampingPercent;
		public float rotationPercent;
	}
}
