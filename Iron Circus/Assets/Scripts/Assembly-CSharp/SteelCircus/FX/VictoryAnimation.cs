using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.FX
{
	public class VictoryAnimation : MonoBehaviour
	{
		[SerializeField]
		private Color victoryGlowColor;
		[SerializeField]
		private Color defeatGlowColor;
		[SerializeField]
		private Color overtimeGlowColor;
		[SerializeField]
		private Color victoryParticlesColor;
		[SerializeField]
		private Color defeatParticlesColor;
		[SerializeField]
		private Color overtimeParticlesColor;
		[SerializeField]
		private Texture2D victoryGradient;
		[SerializeField]
		private Texture2D defeatGradient;
		[SerializeField]
		private Texture2D overtimrGradient;
		[SerializeField]
		private Image glow;
		[SerializeField]
		private ParticleSystem particles;
		[SerializeField]
		private Image background;
	}
}
