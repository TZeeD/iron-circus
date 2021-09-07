using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.ui
{
	public class InputModulePatcher : MonoBehaviour
	{
		[SerializeField]
		private StandaloneInputModule inputModule;
		[SerializeField]
		private string horizontalOSX;
		[SerializeField]
		private string verticalOSX;
		[SerializeField]
		private string selectOSX;
		[SerializeField]
		private string cancelOSX;
		[SerializeField]
		private string horizontalWindows;
		[SerializeField]
		private string verticalWindows;
		[SerializeField]
		private string selectWindows;
		[SerializeField]
		private string cancelWindows;
	}
}
