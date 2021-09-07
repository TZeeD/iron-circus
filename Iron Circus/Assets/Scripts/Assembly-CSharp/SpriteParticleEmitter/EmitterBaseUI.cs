using UnityEngine;
using UnityEngine.UI;

namespace SpriteParticleEmitter
{
	public class EmitterBaseUI : MonoBehaviour
	{
		public Image imageRenderer;
		public ParticleSystem particlesSystem;
		public bool UseEmissionFromColor;
		public Color EmitFromColor;
		public float RedTolerance;
		public float GreenTolerance;
		public float BlueTolerance;
		public bool UsePixelSourceColor;
	}
}
