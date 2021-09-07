using UnityEngine;

namespace SpriteParticleEmitter
{
	public class EmitterBase : MonoBehaviour
	{
		public SpriteRenderer spriteRenderer;
		public ParticleSystem particlesSystem;
		public bool UseEmissionFromColor;
		public Color EmitFromColor;
		public float RedTolerance;
		public float GreenTolerance;
		public float BlueTolerance;
		public bool UsePixelSourceColor;
	}
}
