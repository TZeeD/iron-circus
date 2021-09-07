using UnityEngine;
using UnityEngine.UI;

public class OffscreenObjectIndicator : MonoBehaviour
{
	public GameObject objectToIndicate;
	public Camera cameraToUse;
	public float pixelsFromScreenBorder;
	public GameObject graphic;
	[SerializeField]
	private Image arrowImg;
	[SerializeField]
	private Image circleImg;
}
