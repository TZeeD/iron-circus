using UnityEngine;

namespace Imi.SteelCircus.UI.Floor.Player
{
	public class PlayerFloorHealthDisplay : MonoBehaviour
	{
		[SerializeField]
		private GameObject healthPointPrefab;
		public float healthPointAngleSpread;
		public Color healthPointActiveFill;
		public Color healthPointActiveOutline;
		public Color healthPointLowBlinkOn;
		public Color healthPointLowBlinkOff;
		public float healthPointLowBlinkFrequency;
		public Color healthPointInactiveFill;
		public Color healthPointInactiveOutline;
	}
}
