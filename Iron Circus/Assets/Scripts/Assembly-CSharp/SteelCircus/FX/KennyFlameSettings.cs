using UnityEngine;
using System;

namespace SteelCircus.FX
{
	public class KennyFlameSettings : ScriptableObject
	{
		[Serializable]
		public class FlameDescription
		{
			public string parentBoneName;
			public KennyFlameAnimationCurve animationCurve;
			public Vector3 localPos;
			public Vector3 localEuler;
			public Vector3 localScale;
		}

		public FlameDescription[] flames;
	}
}
