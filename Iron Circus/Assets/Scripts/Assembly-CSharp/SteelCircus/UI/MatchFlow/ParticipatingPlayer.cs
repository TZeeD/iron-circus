using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.MatchFlow
{
	public class ParticipatingPlayer : MonoBehaviour
	{
		[SerializeField]
		private GameObject skillIconsPrefabTeamAlpha;
		[SerializeField]
		private GameObject skillIconsPrefabTeamBeta;
		[SerializeField]
		private Sprite playerIconBackGroundAlpha;
		[SerializeField]
		private Sprite playerIconBackGroundBeta;
		[SerializeField]
		private Image playerIcon;
		[SerializeField]
		private Material grayscaleMat;
		[SerializeField]
		private SimpleCountDownTextMesh countDown;
	}
}
