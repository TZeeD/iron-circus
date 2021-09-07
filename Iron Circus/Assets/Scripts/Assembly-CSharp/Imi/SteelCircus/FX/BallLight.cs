using UnityEngine;

namespace Imi.SteelCircus.FX
{
	public class BallLight : MonoBehaviour
	{
		[SerializeField]
		private Rigidbody ball;
		[SerializeField]
		private Light ballLight;
		public float rangeAtHit;
		public float intensityAtHit;
		public float rangeNormal;
		public float intensityNormal;
		public float hitDuration;
		public float threshold;
	}
}
