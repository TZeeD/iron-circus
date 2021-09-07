using Imi.SharedWithServer.Config;
using Imi.Game;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
	public class DefaultAoePreview : FloorEffectBase
	{
		public AreaOfEffect aoe;
		public Team team;
		public int arcResolution;
		public Material previewMatTeam1;
		public Material previewMatTeam2;
		public GameObject circlePreviewPrefabTeam1;
		public GameObject rectPreviewPrefabTeam1;
		public GameObject circlePreviewPrefabTeam2;
		public GameObject rectPreviewPrefabTeam2;
	}
}
