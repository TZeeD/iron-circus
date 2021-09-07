using UnityEngine;
using TMPro;
using UnityEngine.UI;

namespace SteelCircus.UI.MatchFlow
{
	public class MatchOutcomeScreen : MonoBehaviour
	{
		[SerializeField]
		private TextMeshProUGUI outcomeText;
		[SerializeField]
		private TextMeshProUGUI scoreText;
		[SerializeField]
		private Image background;
		[SerializeField]
		private Transform animationParent;
		[SerializeField]
		private GameObject animationPrefab;
	}
}
