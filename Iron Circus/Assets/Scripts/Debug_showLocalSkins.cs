// Decompiled with JetBrains decompiler
// Type: Debug_showLocalSkins
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using SteelCircus.Utils;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class Debug_showLocalSkins : MonoBehaviour
{
  public List<ShopItem> localSkins;
  public ChampionPageButtonGenerator buttonGenerator;
  public GameObject debugEmoteButtonContainer;
  public GameObject debugChampionEmoteButtonPrefab;

  private void Awake() => Object.Destroy((Object) this.gameObject);

  public void ShowLocalSkins()
  {
    ChampionConfig activeChampion = MenuController.Instance.championPage.gameObject.GetComponent<ChampionDescriptions>().activeChampion;
    this.localSkins = LocalItemsFetcher.GetDebugShopItemList(activeChampion, ShopManager.ShopItemType.skin);
    this.buttonGenerator.SetAllPageItems(this.localSkins);
    this.buttonGenerator.FillPageButtons(getItems: false);
    this.SetupDebugEmoteButtons(activeChampion);
  }

  private void SetupDebugEmoteButtons(ChampionConfig championConfig)
  {
    this.debugEmoteButtonContainer.SetActive(true);
    foreach (ShopItem shopItem in ImiServices.Instance.progressManager.GetItemsByTypeAndChampion(ShopManager.ShopItemType.emote, championConfig))
    {
      GameObject gameObject = Object.Instantiate<GameObject>(this.debugChampionEmoteButtonPrefab);
      ChampionPageButton component = gameObject.GetComponent<ChampionPageButton>();
      gameObject.GetComponent<RectTransform>().parent = this.debugEmoteButtonContainer.transform;
      component.item = shopItem;
      gameObject.GetComponentInChildren<TextMeshProUGUI>().text = shopItem.itemDefinition.name;
    }
    foreach (ShopItem shopItem in ImiServices.Instance.progressManager.GetItemsByTypeAndChampion(ShopManager.ShopItemType.victoryPose, championConfig))
    {
      GameObject gameObject = Object.Instantiate<GameObject>(this.debugChampionEmoteButtonPrefab);
      ChampionPageButton component = gameObject.GetComponent<ChampionPageButton>();
      gameObject.GetComponent<RectTransform>().parent = this.debugEmoteButtonContainer.transform;
      component.item = shopItem;
      gameObject.GetComponentInChildren<TextMeshProUGUI>().text = shopItem.itemDefinition.name;
    }
  }
}
