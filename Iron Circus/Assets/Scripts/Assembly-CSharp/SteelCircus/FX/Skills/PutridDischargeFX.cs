using UnityEngine;
using Imi.SharedWithServer.Config;

namespace SteelCircus.FX.Skills
{
	public class PutridDischargeFX : MonoBehaviour
	{
		[SerializeField]
		private float buildUpDuration;
		[SerializeField]
		private float buildUpDelay;
		[SerializeField]
		private float breakDownDuration;
		[SerializeField]
		private MeshRenderer puddleRenderer;
		[SerializeField]
		private ParticleSystem particles;
		[SerializeField]
		private AreaOfEffect aoe;
		[SerializeField]
		private float fringeSize;
	}
}
