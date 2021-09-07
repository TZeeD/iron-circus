using System;
using UnityEngine;
using System.Collections.Generic;

namespace ClockStone
{
	[Serializable]
	public class AudioSubItem
	{
		public AudioSubItemType SubItemType;
		public float Probability;
		public bool DisableOtherSubitems;
		public string ItemModeAudioID;
		public AudioClip Clip;
		public float Volume;
		public float PitchShift;
		public float Pan2D;
		public float Delay;
		public float RandomPitch;
		public float RandomVolume;
		public float RandomDelay;
		public float ClipStopTime;
		public float ClipStartTime;
		public float FadeIn;
		public float FadeOut;
		public bool RandomStartPosition;
		public List<string> individualSettings;
	}
}
