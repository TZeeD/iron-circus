using UnityEngine;
using UnityEngine.UI;
using SteelCircus.UI;
using SteelCircus.UI.Misc;

namespace SteelCircus.UI.Menu
{
	public class MenuProgressionUI : MonoBehaviour
	{
		[SerializeField]
		private Button playButton;
		[SerializeField]
		private Button quickMatchButton;
		[SerializeField]
		private Button playGroundButton;
		[SerializeField]
		private Button botMatchButton;
		[SerializeField]
		private Button customGameButton;
		[SerializeField]
		private Button rankedGameButton;
		[SerializeField]
		private Button freeTrainingButton;
		[SerializeField]
		private ShowChallengeRewards rewardPanel;
		[SerializeField]
		private GameObject GroupInviteButton;
		[SerializeField]
		private CoroutineRunner playMenuCoroutineRunner;
		[SerializeField]
		private GameObject buttonUnlockGlowAnimPrefab;
	}
}
