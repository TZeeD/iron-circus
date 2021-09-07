using Imi.SteelCircus.Utils;
using UnityEngine.UI;
using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;

namespace Imi.SteelCircus.UI
{
	public class ConnectedPlayersUI : MonoBehaviourWithSetup
	{
		public GridLayoutGroup team1Grid;
		public GridLayoutGroup team2Grid;
		public GridLayoutGroup teamNoneGrid;
		public Text team1Header;
		public Text team2Header;
		public TeamMemberUI teamMemberPrefab;
		public ChampionConfig[] configList;
		public ColorsConfig colors;
		public Button readyButton;
	}
}
