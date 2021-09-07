namespace ClockStone
{
	public class PlayAudio : AudioTriggerBase
	{
		public enum SoundType
		{
			SFX = 0,
			Music = 1,
			AmbienceSound = 2,
		}

		public enum PlayPosition
		{
			Global = 0,
			ChildObject = 1,
			ObjectPosition = 2,
		}

		public string audioID;
		public SoundType soundType;
		public PlayPosition position;
		public float volume;
		public float delay;
		public float startTime;
	}
}
