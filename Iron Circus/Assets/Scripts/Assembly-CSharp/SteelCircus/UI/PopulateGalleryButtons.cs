using UnityEngine;

namespace SteelCircus.UI
{
	public class PopulateGalleryButtons : MonoBehaviour
	{
		[SerializeField]
		private GameObject loadingIcon;
		[SerializeField]
		private GameObject buttonContainer;
		[SerializeField]
		private GameObject championButtonPrefab;
		[SerializeField]
		private ChampionDescriptions championPageDescription;
		[SerializeField]
		private Transform row1Parent;
		[SerializeField]
		private Transform row2Parent;
		[SerializeField]
		private Transform row3Parent;
		[SerializeField]
		private RectTransform background;
		[SerializeField]
		private ChampionConfigProvider configProvider;
		public int buttonWidth;
		public int addidionalWidth;
	}
}
