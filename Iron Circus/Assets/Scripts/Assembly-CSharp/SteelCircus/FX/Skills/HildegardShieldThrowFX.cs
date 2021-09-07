using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class HildegardShieldThrowFX : MonoBehaviour
	{
		[SerializeField]
		private Transform shieldModel;
		[SerializeField]
		private Transform trailParent;
		[SerializeField]
		private Renderer trailModel;
		[SerializeField]
		private Renderer floorCircle;
		[SerializeField]
		private Transform trailModelFloor;
		[SerializeField]
		private Transform glowModel;
		[SerializeField]
		private Vector3 rotationAxis;
		[SerializeField]
		private float trailExpandDuration;
	}
}
