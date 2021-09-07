using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class LatencyIndicator : MonoBehaviour
{
	[SerializeField]
	private Image packetLossImage;
	[SerializeField]
	private Image latencyImage;
	[SerializeField]
	private TextMeshProUGUI latencyTxt;
	[SerializeField]
	private float latencyMin;
	[SerializeField]
	private float latencyMax;
	[SerializeField]
	private float packetLossMin;
	[SerializeField]
	private float packetLossMax;
	[SerializeField]
	private float updateInterval;
	[SerializeField]
	private float minimumDuration;
	public float Loss;
	public float Latency;
}
