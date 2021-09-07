using UnityEngine;
using Imi.SharedWithServer.Config;

namespace SteelCircus.FX.Skills
{
	public class VirtualMotionStrikeFX : MonoBehaviour
	{
		[SerializeField]
		private ParticleSystem particles;
		[SerializeField]
		private AreaOfEffect aoe;
	}
}
