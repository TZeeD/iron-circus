using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class LightningStrikeConnectionFX : MonoBehaviour
	{
		public float brightness;
		public float initialBrightness;
		public float brightnessFadeDuration;
		public Vector3 startOffset;
		public Vector3 endOffset;
		[SerializeField]
		private LineRenderer lineRenderer;
		[SerializeField]
		private int numVertsPerUnit;
		[SerializeField]
		private int minNumVerts;
		[SerializeField]
		private float curveHeight;
		[SerializeField]
		private float maxDistortionXZ;
		[SerializeField]
		private float maxDistortionY;
		[SerializeField]
		private float distortionPow;
		public float freq1;
		public float phase1;
		public float amp1;
		public float ampModFreq1;
		public float ampModAmp1;
		public float freq2;
		public float phase2;
		public float amp2;
		public float ampModFreq2;
		public float ampModAmp2;
		public float freq3;
		public float phase3;
		public float amp3;
		public float speedScale;
		public float ampScale;
	}
}
