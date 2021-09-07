using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
	public class PickupView : FloorSpawnableObject
	{
		[SerializeField]
		private Animation pickupBaseAnimation;
		[SerializeField]
		private Animator pickupAnimator;
		[SerializeField]
		private GameObject pickupHologramSpehere;
		[SerializeField]
		private GameObject pickupHologramIcon;
		[SerializeField]
		private Color lensOffColor;
		[SerializeField]
		private Color lensOnColor;
		[SerializeField]
		private Renderer lensRenderer;
		[SerializeField]
		private Color lensProjectionColor;
		[SerializeField]
		private Renderer lensProjection;
	}
}
