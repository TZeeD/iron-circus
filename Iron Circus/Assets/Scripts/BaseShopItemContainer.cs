// Decompiled with JetBrains decompiler
// Type: BaseShopItemContainer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using System;
using System.Diagnostics;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class BaseShopItemContainer : 
  MonoBehaviour,
  ISelectHandler,
  IEventSystemHandler,
  IPointerEnterHandler
{
  public int containerID;
  public Vector2Int gridDimensions;
  [SerializeField]
  protected ShopManager.ShopItemType itemType;
  public ShopPage shopPage;
  public ShopManager manager;
  public ShopItemButtonGroup buttonGroup;
  public ShopManager.CurrencyType currenyType;
  public bool hasCountdown;
  protected Stopwatch countdownTimer;
  protected long countdownDurationInMS;
  [Header("GameObjects")]
  [SerializeField]
  protected GameObject buttonParent;
  [SerializeField]
  protected Image backgroundSprite;
  [SerializeField]
  protected Image borderImage;
  [SerializeField]
  protected Image panelSeperator;
  [SerializeField]
  protected Image imageObject;
  [SerializeField]
  protected Button buttonObject;
  [SerializeField]
  protected GameObject discountBackground;
  [SerializeField]
  protected GameObject oldPriceStrikethrough;
  [SerializeField]
  protected GameObject countDownPanel;
  [SerializeField]
  protected Image currencySymbol;
  [Header("TextFields")]
  [SerializeField]
  public bool showPriceText;
  [SerializeField]
  protected TextMeshProUGUI nameText;
  [SerializeField]
  protected TextMeshProUGUI SecondaryText;
  [SerializeField]
  protected TextMeshProUGUI priceText;
  [SerializeField]
  protected TextMeshProUGUI priceTextNoDiscount;
  [SerializeField]
  protected TextMeshProUGUI priceBeforeDiscountText;
  [SerializeField]
  protected TextMeshProUGUI countdownText;
  [SerializeField]
  protected TextMeshProUGUI discountText;
  [Header("AlreadyOwnedGroup")]
  [SerializeField]
  protected GameObject alreadyOwnedGrp;

  private void Start()
  {
  }

  private void Update()
  {
    if (this.countdownTimer != null && this.countdownTimer.IsRunning && this.countdownTimer.ElapsedMilliseconds <= this.countdownDurationInMS)
    {
      TimeSpan timeSpan = TimeSpan.FromMilliseconds((double) (this.countdownDurationInMS - this.countdownTimer.ElapsedMilliseconds));
      this.countdownText.text = string.Format("{0:D}:{1:D2}:{2:D2}:{3:D2}", (object) timeSpan.Days, (object) timeSpan.Hours, (object) timeSpan.Minutes, (object) timeSpan.Seconds);
    }
    else
      this.countdownText.text = "00:00:00";
  }

  public void SetDimensions(int xSize, int ySize)
  {
    this.gridDimensions.x = xSize;
    this.gridDimensions.y = ySize;
    this.ScaleContainer();
  }

  public void SetDimensions(Vector2Int size)
  {
    this.gridDimensions = size;
    this.ScaleContainer();
  }

  private void ScaleContainer() => this.GetComponent<RectTransform>().sizeDelta = new Vector2((float) ((double) ShopManager.columnWidth * (double) this.gridDimensions.x + (double) ShopManager.gutterSize * (double) (this.gridDimensions.x - 1)), (float) ((double) ShopManager.lineHeight * (double) this.gridDimensions.y + (double) ShopManager.gutterSize * (double) (this.gridDimensions.y - 1)));

  public void SetContainerVisibility(bool hasDiscount, bool alreadyOwned = false)
  {
    this.alreadyOwnedGrp.SetActive(alreadyOwned);
    this.countdownText.gameObject.SetActive(this.hasCountdown);
    this.countDownPanel.gameObject.SetActive(this.hasCountdown);
    if (!this.showPriceText)
    {
      this.priceTextNoDiscount.gameObject.SetActive(false);
      this.discountText.gameObject.SetActive(false);
      this.discountBackground.SetActive(false);
      this.oldPriceStrikethrough.SetActive(false);
      this.priceBeforeDiscountText.gameObject.SetActive(false);
    }
    else if (hasDiscount)
    {
      this.priceTextNoDiscount.gameObject.SetActive(false);
      this.discountText.gameObject.SetActive(true);
      this.discountBackground.SetActive(true);
      this.oldPriceStrikethrough.SetActive(true);
      this.priceBeforeDiscountText.gameObject.SetActive(true);
    }
    else
    {
      this.priceText.gameObject.SetActive(false);
      this.priceTextNoDiscount.gameObject.SetActive(true);
      this.discountText.gameObject.SetActive(false);
      this.discountBackground.SetActive(false);
      this.oldPriceStrikethrough.SetActive(false);
      this.priceBeforeDiscountText.gameObject.SetActive(false);
    }
  }

  public void SetContainerPriceText(
    int price,
    ShopManager.CurrencyType currencyType,
    string isoCurrency = "EUR",
    int priceBeforeDiscount = 0)
  {
    string str1 = "";
    string str2 = "";
    switch (currencyType)
    {
      case ShopManager.CurrencyType.steel:
        str1 = price.ToString();
        str2 = priceBeforeDiscount.ToString();
        this.priceTextNoDiscount.color = SingletonScriptableObject<ColorsConfig>.Instance.steelColor;
        this.currencySymbol.sprite = this.manager.steelSprite;
        break;
      case ShopManager.CurrencyType.credits:
        str1 = price.ToString();
        str2 = priceBeforeDiscount.ToString();
        this.priceTextNoDiscount.color = SingletonScriptableObject<ColorsConfig>.Instance.credsColor;
        this.currencySymbol.sprite = this.manager.creditsSprite;
        break;
      case ShopManager.CurrencyType.realMoney:
        str1 = CurrencyContainer.GetFormattedPrice(price, isoCurrency);
        str2 = CurrencyContainer.GetFormattedPrice(priceBeforeDiscount, isoCurrency);
        this.currencySymbol.gameObject.SetActive(false);
        break;
    }
    this.currencySymbol.preserveAspect = true;
    this.priceTextNoDiscount.text = str1;
    this.priceText.text = str1;
    this.priceBeforeDiscountText.text = str2;
  }

  public void ShopItemClickAction()
  {
  }

  public void OnSelect(BaseEventData eventData)
  {
  }

  public void OnPointerEnter(PointerEventData eventData)
  {
  }

  public Button GetButton() => this.buttonObject;

  private void UpdateTimeLimit()
  {
  }

  public int GetHeightInSections() => this.gridDimensions.y;

  public int GetWidthInSections() => this.gridDimensions.x;
}
