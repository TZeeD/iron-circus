using System;
using UnityEngine;
using UnityEngine.Audio;

namespace ClockStone
{
	[Serializable]
	public class AudioCategory
	{
		public AudioCategory(AudioController audioController)
		{
		}

		public string Name;
		[SerializeField]
		private string _parentCategoryName;
		public GameObject AudioObjectPrefab;
		public AudioItem[] AudioItems;
		[SerializeField]
		private float _volume;
		public AudioMixerGroup audioMixerGroup;
	}
}
