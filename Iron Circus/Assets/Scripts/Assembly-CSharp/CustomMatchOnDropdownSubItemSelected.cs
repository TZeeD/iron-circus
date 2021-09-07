using UnityEngine;
using UnityEngine.UI;

public class CustomMatchOnDropdownSubItemSelected : MonoBehaviour
{
	[SerializeField]
	private Text dropdownTxt;
	[SerializeField]
	private Image dropdownCheckmarkImg;
	public ScrollRect parentScrollRect;
	public RectTransform contentPanel;
}
