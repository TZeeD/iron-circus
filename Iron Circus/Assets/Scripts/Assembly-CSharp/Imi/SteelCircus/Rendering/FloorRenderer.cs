using UnityEngine;

namespace Imi.SteelCircus.Rendering
{
	public class FloorRenderer : MonoBehaviour
	{
		public enum FloorLayer
		{
			Emissive = 0,
			Normals = 1,
		}

		[SerializeField]
		private Camera cameraEmissive;
		[SerializeField]
		private Camera cameraNormals;
		[SerializeField]
		private Transform parentEmissive;
		[SerializeField]
		private Transform parentNormals;
		[SerializeField]
		private Canvas floorCanvas;
	}
}
