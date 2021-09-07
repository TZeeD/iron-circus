using UnityEngine;
using UnityEngine.UI;

public class PickupSpawnFloorUi : MonoBehaviour
{
	[SerializeField]
	private SimplePickupCountDown countDown;
	[SerializeField]
	private Text text;
	[SerializeField]
	private SpriteRenderer icon;
	[SerializeField]
	private float scaleUpDuration;
	[SerializeField]
	private Sprite rechargeIcon;
	[SerializeField]
	private Sprite healthIcon;
	[SerializeField]
	private Sprite sprintIcon;
}
