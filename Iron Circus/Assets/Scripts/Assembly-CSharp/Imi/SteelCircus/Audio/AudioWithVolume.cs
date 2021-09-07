using System;
using UnityEngine;

namespace Imi.SteelCircus.Audio
{
	[Serializable]
	public class AudioWithVolume
	{
		public AudioClip clip;
		public bool is2d;
		public float volume;
	}
}
