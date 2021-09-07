namespace Imi.SteelCircus.ScriptableObjects
{
	public class LocalPlayerVisualSmoothingConfig : GameConfigEntry
	{
		public float snapThreshold;
		public float minSmoothDuration;
		public float maxSmoothDuration;
		public float positionDeltaMinSmooth;
		public float positionDeltaMaxSmooth;
		public float rotationDeltaMinSmooth;
		public float rotationDeltaMaxSmooth;
		public float startSmoothingThreshold;
		public float skipSmoothingThreshold;
		public float topSpeed;
		public float secondsToTopSpeed;
	}
}
