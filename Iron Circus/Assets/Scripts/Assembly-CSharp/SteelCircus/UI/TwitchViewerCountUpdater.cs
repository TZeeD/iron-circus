using UnityEngine;
using TMPro;

namespace SteelCircus.UI
{
	public class TwitchViewerCountUpdater : MonoBehaviour
	{
		[SerializeField]
		private GameObject viewerCountParentObject;
		[SerializeField]
		private TextMeshProUGUI viewerCountText;
		public ulong playerId;
		[SerializeField]
		private GameObject layoutElement;
	}
}
