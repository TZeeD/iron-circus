using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class CurrencyContainer : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI currencyAmountText;
	[SerializeField]
	private TextMeshProUGUI currencyPriceText;
	[SerializeField]
	private TextMeshProUGUI bonusCurrencyText;
	[SerializeField]
	private GameObject bonusCurrencyGameObject;
	[SerializeField]
	private Image containerImage;
	public int id;
	public int totalCreds;
}
