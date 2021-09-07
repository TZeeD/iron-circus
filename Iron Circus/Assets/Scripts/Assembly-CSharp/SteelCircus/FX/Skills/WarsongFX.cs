using UnityEngine;
using Imi.SharedWithServer.Config;

namespace SteelCircus.FX.Skills
{
	public class WarsongFX : MonoBehaviour
	{
		[SerializeField]
		private ParticleSystem particles;
		[SerializeField]
		private MeshRenderer[] waves;
		public float frequency;
		public AnimationCurve scaleCurve;
		public AnimationCurve fadeCurve;
		public float rotationSpeed;
		public float alphaScale;
		[SerializeField]
		private Color color;
		[SerializeField]
		private AreaOfEffect aoe;
	}
}
