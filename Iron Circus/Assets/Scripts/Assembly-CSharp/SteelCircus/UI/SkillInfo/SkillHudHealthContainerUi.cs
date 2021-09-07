using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.SkillInfo
{
	public class SkillHudHealthContainerUi : MonoBehaviour
	{
		[SerializeField]
		private GameObject healthPointPrefab;
		[SerializeField]
		private GridLayoutGroup healthGridLayout;
		public HealthPoint[] HealthPoints;
	}
}
