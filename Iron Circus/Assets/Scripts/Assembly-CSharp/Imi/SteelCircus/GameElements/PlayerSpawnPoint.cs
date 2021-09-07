using UnityEngine;
using Imi.SharedWithServer.Game;
using Imi.Game;

namespace Imi.SteelCircus.GameElements
{
	public class PlayerSpawnPoint : MonoBehaviour
	{
		[SerializeField]
		private Color gizmoColor;
		[SerializeField]
		private MatchType matchType;
		[SerializeField]
		private Team team;
	}
}
