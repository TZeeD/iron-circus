using UnityEngine;

namespace SteelCircus.UI
{
	public class MVPScreen : MonoBehaviour
	{
		[SerializeField]
		private GameObject MvpPanel;
		[SerializeField]
		private GameObject cardPrefab;
		[SerializeField]
		private Transform cardContainerTransform;
		[SerializeField]
		private MatchEndScreen endScreenManager;
		public bool animFinished;
		[SerializeField]
		private MVPPlayerAvatar[] mvpAvatars;
		public ulong mvpID;
		public bool allowVoteUpdates;
	}
}
