using UnityEngine;

namespace Coffee.UIExtensions
{
	public class UIEffectBase : BaseMeshEffect
	{
		[SerializeField]
		private int m_Version;
		[SerializeField]
		protected Material m_EffectMaterial;
	}
}
