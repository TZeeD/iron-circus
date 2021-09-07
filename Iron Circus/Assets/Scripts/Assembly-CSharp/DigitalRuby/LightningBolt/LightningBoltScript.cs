using UnityEngine;

namespace DigitalRuby.LightningBolt
{
	public class LightningBoltScript : MonoBehaviour
	{
		public GameObject StartObject;
		public Vector3 StartPosition;
		public GameObject EndObject;
		public Vector3 EndPosition;
		public int Generations;
		public float Duration;
		public float ChaosFactor;
		public bool ManualMode;
		public int Rows;
		public int Columns;
		public LightningBoltAnimationMode AnimationMode;
	}
}
