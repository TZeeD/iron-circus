using UnityEngine;
using Imi.SteelCircus.ScriptableObjects;

namespace Imi.SteelCircus.Rendering
{
	public class Floor : MonoBehaviour
	{
		[SerializeField]
		private FloorLitMaterialConfig floorLitMaterialConfig;
		public GameObject floorContentsPrefab;
	}
}
