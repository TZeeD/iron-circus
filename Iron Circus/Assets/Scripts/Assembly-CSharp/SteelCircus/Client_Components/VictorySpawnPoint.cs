using UnityEngine;
using Imi.Game;
using SharedWithServer.Game;

namespace SteelCircus.Client_Components
{
	public class VictorySpawnPoint : MonoBehaviour
	{
		public Team team;
		public SpawnPositionType spawnPosition;
		[SerializeField]
		private bool drawGizmo;
		[SerializeField]
		private Color gizmoColor;
		[SerializeField]
		private Mesh mesh;
	}
}
