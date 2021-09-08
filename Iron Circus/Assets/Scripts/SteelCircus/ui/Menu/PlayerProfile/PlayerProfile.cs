// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.PlayerProfile.PlayerProfile
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu.PlayerProfile
{
  public class PlayerProfile : MonoBehaviour
  {
    [Header("Avatar Selection Screen")]
    public Image avatarPreview;
    public TextMeshProUGUI avatarNameTextLeft;
    public Button avatarBuyButton;
    public GameObject avatarBuyButtonPrompt;
    public Button avatarEquipButton;
    public GameObject avatarEquipButtonPrompt;
    public ShopItem activeAvatarIcon;
    [SerializeField]
    private TextMeshProUGUI avatarNameText;
    private ShopItem currentlySelectedAvatar;

    private void Start()
    {
      this.avatarBuyButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue("@ViewItemInShop");
      this.avatarEquipButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue("@EquipItem");
      ImiServices.Instance.progressManager.onPlayerAvatarEquipped += new ProgressManager.OnPlayerAvatarChangedEventHandler(this.OnEquippedAvatar);
      MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.OnEnteredMenu));
    }

    private void OnDestroy()
    {
      ImiServices.Instance.progressManager.onPlayerAvatarEquipped -= new ProgressManager.OnPlayerAvatarChangedEventHandler(this.OnEquippedAvatar);
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnEnteredMenu));
    }

    private void Update()
    {
      if (this.activeAvatarIcon == null)
      {
        this.avatarBuyButton.GetComponent<Button>().interactable = false;
        this.avatarBuyButtonPrompt.SetActive(false);
        this.avatarEquipButton.GetComponent<Button>().interactable = false;
        this.avatarEquipButtonPrompt.SetActive(false);
      }
      else if (!this.activeAvatarIcon.ownedByPlayer)
      {
        this.avatarBuyButton.GetComponent<Button>().interactable = true;
        this.avatarBuyButtonPrompt.SetActive(true);
        this.avatarEquipButton.GetComponent<Button>().interactable = false;
        this.avatarEquipButtonPrompt.SetActive(false);
      }
      else
      {
        this.avatarBuyButton.GetComponent<Button>().interactable = false;
        this.avatarBuyButtonPrompt.SetActive(false);
        this.avatarEquipButton.GetComponent<Button>().interactable = true;
        this.avatarEquipButtonPrompt.SetActive(true);
      }
    }

    private void OnEnteredMenu()
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playerProfile))
        return;
      MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
      this.OnEquippedAvatar(ImiServices.Instance.LoginService.GetPlayerId(), singleEntity.metaLoadout.avatarIconId);
      ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(singleEntity.metaLoadout.avatarIconId);
      this.avatarPreview.sprite = UnityEngine.Resources.Load<Sprite>(ItemsConfig.avatarHighResIconPath + itemById.fileName);
      this.avatarNameTextLeft.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + itemById.fileName).ToUpper();
    }

    private void OnEquippedAvatar(ulong playerid, int avataritemid)
    {
      if ((long) playerid != (long) ImiServices.Instance.LoginService.GetPlayerId())
        return;
      Log.Debug("Set equipped avatar text for player " + (object) playerid + " and Avatar " + SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(avataritemid).fileName);
      this.avatarNameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(avataritemid).fileName);
    }

    public void UpdateAvatarPreview(ShopItem item)
    {
      this.currentlySelectedAvatar = item;
      this.activeAvatarIcon = item;
      this.avatarPreview.sprite = UnityEngine.Resources.Load<Sprite>(ItemsConfig.avatarHighResIconPath + item.itemDefinition.fileName);
      this.avatarPreview.preserveAspect = true;
      this.avatarNameTextLeft.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + item.itemDefinition.fileName).ToUpper();
    }

    public void EquipAvatar() => ImiServices.Instance.progressManager.EquipAvatar(ImiServices.Instance.LoginService.GetPlayerId(), this.currentlySelectedAvatar.itemDefinition.definitionId);

    public void BuyAvatar()
    {
      MenuController.Instance.shopBuyPanel.ActualShowMenu(MenuObject.animationType.changeInstantly, showOnTopOfOldMenu: true);
      if (this.currentlySelectedAvatar.buyable)
        MenuController.Instance.shopBuyPanel.gameObject.GetComponent<ShopPanel>().FillShopPanel(this.currentlySelectedAvatar, ImiServices.Instance.progressManager.GetPlayerCreds() >= this.currentlySelectedAvatar.itemDefinition.priceCreds, ShopManager.CurrencyType.credits);
      else
        MenuController.Instance.shopBuyPanel.gameObject.GetComponent<ShopPanel>().FillShopPanelPreview(this.currentlySelectedAvatar.itemDefinition, ImiServices.Instance.LocaService.GetLocalizedValue("@CantPurchaseLong"));
    }
  }
}
