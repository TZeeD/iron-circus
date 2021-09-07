using SteelCircus.FX;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class LightningTrailParticleFX : FollowTransform
	{
		[SerializeField]
		private string parentBoneName;
		[SerializeField]
		private Transform particleParent;
	}
}
