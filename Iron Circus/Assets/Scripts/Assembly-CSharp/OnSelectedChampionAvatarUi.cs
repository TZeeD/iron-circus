using UnityEngine;
using UnityEngine.UI;

public class OnSelectedChampionAvatarUi : MonoBehaviour
{
	[SerializeField]
	private GameObject background;
	[SerializeField]
	private GameObject championPickedByPlayerUi;
	[SerializeField]
	private GameObject[] selectedChampionIcons;
	[SerializeField]
	private Image championIcon;
	[SerializeField]
	private Text champNameTxt;
	[SerializeField]
	private Material grayscaleMat;
	[SerializeField]
	private GameObject weeklyRotationIcon;
	[SerializeField]
	private Sprite solidIcon;
	[SerializeField]
	private Sprite transparentIcon;
}
