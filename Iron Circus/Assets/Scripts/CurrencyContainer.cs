// Decompiled with JetBrains decompiler
// Type: CurrencyContainer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SharedWithServer.Utils.Extensions;
using Steamworks;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class CurrencyContainer : 
  MonoBehaviour,
  IPointerExitHandler,
  IEventSystemHandler,
  ISubmitHandler,
  IPointerClickHandler
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
  protected Callback<MicroTxnAuthorizationResponse_t> m_MicroTxnAuthorizationResponse;
  public int id;
  public int totalCreds;

  public void SetCurrencyValues(
    int id,
    string currencyAmount,
    string currencyPrice,
    string currencyBonusAmount,
    string ISOCurrency)
  {
    this.m_MicroTxnAuthorizationResponse = Callback<MicroTxnAuthorizationResponse_t>.Create(new Callback<MicroTxnAuthorizationResponse_t>.DispatchDelegate(this.OnBuyCurrencySuccess));
    this.id = id;
    int num1 = int.Parse(currencyAmount);
    int num2 = int.Parse(currencyBonusAmount);
    this.currencyAmountText.text = (num1 + num2).ToString();
    this.totalCreds = num1 + num2;
    this.currencyPriceText.text = CurrencyContainer.GetFormattedPrice(int.Parse(currencyPrice), ISOCurrency);
    if (num2 > 0)
      this.bonusCurrencyGameObject.SetActive(true);
    else
      this.bonusCurrencyGameObject.SetActive(false);
    this.bonusCurrencyText.text = "(" + (object) num1 + " <color=#56FFB6>+ " + (object) num2 + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@ShopBonusCredits") + "</color>)";
  }

  private void OnDestroy() => this.m_MicroTxnAuthorizationResponse.Dispose();

  public static string GetFormattedPrice(int currencyPrice, string ISOCurrency)
  {
    float num = (float) currencyPrice / 100f;
    return StringExtensions.GetCurrencySymbol(ISOCurrency) + string.Format("{0:0.##}", (object) num);
  }

  public void OnPointerExit(PointerEventData eventData) => this.GetComponent<Selectable>().OnDeselect((BaseEventData) null);

  public void OnSubmit(BaseEventData eventData) => this.PurchaseCurrencyAction();

  public void OnPointerClick(PointerEventData eventData) => this.PurchaseCurrencyAction();

  private void PurchaseCurrencyAction() => this.InitiateBuyCurrency(this.id);

  public void InitiateBuyCurrency(int itemId)
  {
    this.StartCoroutine(MetaServiceHelpers.InitiateShopTransaction(ImiServices.Instance.LoginService.GetPlayerId(), itemId, new Action<JObject>(this.OnBuyCurrencySuccess)));
    MenuController.Instance.shopMenu.GetComponent<ShopManager>().currencyPage.DisableShopPacks();
  }

  public void OnBuyCurrencySuccess(MicroTxnAuthorizationResponse_t response)
  {
    if (response.m_bAuthorized == (byte) 1)
    {
      Debug.Log((object) ("Successfully bought currency. OrderID: " + response.m_ulOrderID.ToString() + "\n AppID: " + (object) response.m_unAppID + "\n Authorized:  " + (object) response.m_bAuthorized));
      this.FinalizeBuyCurrency(response.m_ulOrderID);
    }
    else
      Debug.Log((object) "Cancelled currency purchase.");
  }

  public void OnBuyCurrencySuccess(JObject obj)
  {
    Debug.Log((object) ("OnBuyCurrencySuccess: " + obj.ToString()));
    MenuController.Instance.shopMenu.GetComponent<ShopManager>().currencyPage.EnableShopPacks();
  }

  public void FinalizeBuyCurrency(ulong orderId) => this.StartCoroutine(MetaServiceHelpers.FinalizeShopTransaction(ImiServices.Instance.LoginService.GetPlayerId(), orderId, new Action<JObject>(this.OnFinalizeBuyCurrencySuccess)));

  public void OnFinalizeBuyCurrencySuccess(JObject obj)
  {
    Debug.Log((object) obj);
    ImiServices.Instance.Analytics.FinalizeMicroTransactionGameAnalyticsEvent(obj);
    ImiServices.Instance.progressManager.UpdatePlayerCreds((int) obj["freeCredits"] + (int) obj["paidCredits"]);
    MenuController.Instance.shopMenu.GetComponent<ShopManager>().OpenCurrencyBuyWindow(this.totalCreds);
  }
}
