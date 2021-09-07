using UnityEngine;
using System.Collections.Generic;
using UnityEngine.UI;
using TMPro;

namespace Imi.SteelCircus.UI
{
	public class LoadingScreenManager : MonoBehaviour
	{
		[SerializeField]
		private List<string> loadingTips;
		[SerializeField]
		private float timeToNextTip;
		[SerializeField]
		private GameObject loadingPanel;
		[SerializeField]
		private Text infoText;
		[SerializeField]
		private TextMeshProUGUI loadingTipTxt;
		[SerializeField]
		private TextMeshProUGUI skipTipTxt;
		[SerializeField]
		private TextMeshProUGUI playersDoneLoadingTxt;
		[SerializeField]
		private Image progressBar;
		[SerializeField]
		private Image buttonIcon;
		[SerializeField]
		private Image loadingScreenBackground;
		[SerializeField]
		private TextMeshProUGUI loadingScreenFactionNameText;
		[SerializeField]
		private GameObject controllerGo;
		[SerializeField]
		private GameObject keyboardGo;
		[SerializeField]
		private RawImage leftPanel;
		[SerializeField]
		private RawImage rightPanel;
		[SerializeField]
		private LoadingScreenConfig[] loadingScreenConfigs;
	}
}
