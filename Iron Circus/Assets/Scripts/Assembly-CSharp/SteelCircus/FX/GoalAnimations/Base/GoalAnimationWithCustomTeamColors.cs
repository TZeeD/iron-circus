using System;
using UnityEngine;

namespace SteelCircus.FX.GoalAnimations.Base
{
	public class GoalAnimationWithCustomTeamColors : GoalAnimationBase
	{
		[Serializable]
		public class CustomTeamColor
		{
			public Renderer[] teamColorRenderers;
			public Color teamAlphaColor;
			public Color teamBetaColor;
			public GoalAnimationWithCustomTeamColors.Attributes attributes;
		}

		public enum Attributes
		{
			MainColor = 1,
			TextColor = 2,
			OutlineColor = 4,
			GlowColor = 4,
		}

		[SerializeField]
		public CustomTeamColor[] colors;
	}
}
