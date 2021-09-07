using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class ServitorBarrierRotationControls : MonoBehaviour
	{
		[SerializeField]
		private string rootName;
		[SerializeField]
		private string spineStartBoneName;
		[SerializeField]
		private string leftThighBoneName;
		[SerializeField]
		private string rightThighBoneName;
		[SerializeField]
		private string armBoneName;
		[SerializeField]
		private string neckParentBoneName;
		public float smoothing;
		[SerializeField]
		private float minAngle;
		[SerializeField]
		private float spineTargetRotationLimit;
		[SerializeField]
		private float spineRotationLimit;
		[SerializeField]
		private float spineRotationLimitSoftness;
	}
}
