using UnityEngine;

namespace SteelCircus.FX
{
	public class KennyFlameController : MonoBehaviour
	{
		[SerializeField]
		private GameObject flamePrefab;
		[SerializeField]
		private string rootBoneName;
		[SerializeField]
		private KennyFlameSettings flameSettings;
		[SerializeField]
		private Animator animator;
	}
}
