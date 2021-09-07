using UnityEngine;
using Imi.Game;

namespace SteelCircus.FX.Skills
{
	public class VirtualSwapFloorExitFX : MonoBehaviour
	{
		[SerializeField]
		private ParticleSystem particles;
		public Team ownerTeam;
		public bool success;
	}
}
