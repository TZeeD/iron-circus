using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.Debugging
{
	public class DebugNetworkUi : MonoBehaviour
	{
		[SerializeField]
		private uint updateRateInHertz;
		[SerializeField]
		private bool updateEveryFrame;
		[SerializeField]
		private GameObject uiRoot;
		[SerializeField]
		private GameObject simpleUiRoot;
		[SerializeField]
		private GameObject graphUiRoot;
		[SerializeField]
		private Text rttField;
		[SerializeField]
		private Text rtttField;
		[SerializeField]
		private Text lossField;
		[SerializeField]
		private Text receivedField;
		[SerializeField]
		private Text sendField;
		[SerializeField]
		private Text ackField;
		[SerializeField]
		private Text serverTickField;
		[SerializeField]
		private Text clientTickField;
		[SerializeField]
		private Text tickDField;
		[SerializeField]
		private Text tickRateField;
		[SerializeField]
		private Text fpsField;
		[SerializeField]
		private Text memoryField;
		[SerializeField]
		private Text gcField;
		[SerializeField]
		private NetworkQuantityGraph rttGraph;
		[SerializeField]
		private Text rtttFieldGraph;
		[SerializeField]
		private NetworkQuantityGraph lossGraph;
		[SerializeField]
		private NetworkQuantityGraph receivedGraph;
		[SerializeField]
		private NetworkQuantityGraph sendGraph;
		[SerializeField]
		private NetworkQuantityGraph ackGraph;
		[SerializeField]
		private NetworkQuantityGraph fpsGraph;
		[SerializeField]
		private Text serverTickFieldGraph;
		[SerializeField]
		private Text clientTickFieldGraph;
		[SerializeField]
		private Text tickDFieldGraph;
		[SerializeField]
		private Text tickRateFieldGraph;
		[SerializeField]
		private Text fpsFieldGraph;
	}
}
