using UnityEngine;

namespace Imi.SteelCircus.ScriptableObjects
{
	public class FloorLitMaterialConfig : ScriptableObject
	{
		public Texture2D _FloorLightNoise;
		public Vector4 _FloorLightNoiseParams;
		public float _FloorLightEmissionScale;
		public float _FloorLightEmissionRange;
		public float _FloorLightDarkensRegularLight;
		public float _FloorLightRaymarchSamples;
		public float _FloorLightScatterAngle;
	}
}
