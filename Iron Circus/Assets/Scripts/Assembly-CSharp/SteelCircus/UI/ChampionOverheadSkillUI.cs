using UnityEngine;
using System.Collections.Generic;
using UnityEngine.UI;

namespace SteelCircus.UI
{
	public class ChampionOverheadSkillUI : MonoBehaviour
	{
		[SerializeField]
		private RectTransform staminaBarParent;
		[SerializeField]
		private float tacklePartPadding;
		[SerializeField]
		private RectTransform tackleParentFill;
		[SerializeField]
		private RectTransform tackleParentDiff;
		[SerializeField]
		private RectTransform tackleParentBG;
		[SerializeField]
		private RectTransform sprintParentFill;
		[SerializeField]
		private RectTransform sprintParentDiff;
		[SerializeField]
		private RectTransform sprintParentBG;
		[SerializeField]
		private List<Image> staminaSlicesBG;
		[SerializeField]
		private List<Image> staminaSlicesFill;
		[SerializeField]
		private List<Image> staminaSlicesDiff;
		[SerializeField]
		private Color staminaBGColor;
		[SerializeField]
		private Color staminaDiffColor;
		[SerializeField]
		private float staminaDepletedBlinkDuration;
		[SerializeField]
		private float staminaDepletedBlinkFrequency;
		[SerializeField]
		private Image staminaReplenishedGlow;
		[SerializeField]
		private float staminaReplenishedGlowDuration;
		[SerializeField]
		private float diffDelayAfterTackle;
		[SerializeField]
		private float diffSmoothing;
	}
}
