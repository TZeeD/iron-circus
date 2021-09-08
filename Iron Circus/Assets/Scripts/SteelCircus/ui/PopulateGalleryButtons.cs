// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.PopulateGalleryButtons
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Steamworks;
using SteelCircus.Core.Services;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class PopulateGalleryButtons : MonoBehaviour
  {
    [SerializeField]
    private GameObject loadingIcon;
    [SerializeField]
    private GameObject buttonContainer;
    [SerializeField]
    private GameObject championButtonPrefab;
    [SerializeField]
    private ChampionDescriptions championPageDescription;
    [SerializeField]
    private Transform row1Parent;
    private List<GameObject> row1;
    [SerializeField]
    private Transform row2Parent;
    private List<GameObject> row2;
    [SerializeField]
    private Transform row3Parent;
    private List<GameObject> row3;
    [SerializeField]
    private RectTransform background;
    [SerializeField]
    private ChampionConfigProvider configProvider;
    private Dictionary<ChampionConfig, GameObject> AllChampionButtons;
    [Header("Backgroundscaling")]
    public int buttonWidth;
    public int addidionalWidth;

    public int ButtonWidth
    {
      get => this.buttonWidth;
      set => this.buttonWidth = value;
    }

    private void Start()
    {
      this.configProvider = SingletonScriptableObject<ChampionConfigProvider>.Instance;
      MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.OnChampionGalleryEnter));
      ImiServices.Instance.progressManager.OnChampionUnlockInfoUpdated += new ProgressManager.OnChampionUnlockInfoUpdatedHandler(this.UpdateChampionPage);
      this.AllChampionButtons = new Dictionary<ChampionConfig, GameObject>();
      this.row1 = new List<GameObject>();
      this.row2 = new List<GameObject>();
      this.row3 = new List<GameObject>();
    }

    private void OnDestroy()
    {
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnChampionGalleryEnter));
      ImiServices.Instance.progressManager.OnChampionUnlockInfoUpdated -= new ProgressManager.OnChampionUnlockInfoUpdatedHandler(this.UpdateChampionPage);
    }

    private void ClearChampionButtons()
    {
      if (this.AllChampionButtons != null)
      {
        foreach (KeyValuePair<ChampionConfig, GameObject> allChampionButton in this.AllChampionButtons)
          UnityEngine.Object.Destroy((UnityEngine.Object) allChampionButton.Value);
      }
      this.AllChampionButtons = new Dictionary<ChampionConfig, GameObject>();
      this.row1 = new List<GameObject>();
      this.row2 = new List<GameObject>();
      this.row3 = new List<GameObject>();
    }

    public void UpdateChampionPage()
    {
      if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) MenuController.Instance.championGallery))
        return;
      this.loadingIcon.SetActive(false);
      this.buttonContainer.SetActive(true);
      MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
      if (singleEntity.hasMetaChampionsUnlocked)
        this.CreateChampionButtonsMeta(singleEntity);
      else
        this.CreateChampionButtons();
      this.ScaleBackgroundElement();
      MenuController.Instance.buttonFocusManager.FocusOnButton(this.GetActiveChampionButton());
    }

    private void CreateChampionButtons()
    {
      this.ClearChampionButtons();
      for (int index = 0; index < this.configProvider.championConfigs.Count; ++index)
      {
        if (this.configProvider.championConfigs[index].IsActive && this.configProvider.championConfigs[index].UiPosition != ChampionConfigProvider.ChampionButtonUiPosition.dontRender)
        {
          Log.Debug(this.configProvider.championConfigs[index].ChampionConfig.displayName);
          GameObject championButton = this.CreateChampionButton(this.configProvider.championConfigs[index].ChampionConfig);
          if (this.configProvider.championConfigs[index].UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.firstRow)
          {
            championButton.transform.SetParent(this.row1Parent, false);
            this.row1.Add(championButton);
          }
          else if (this.configProvider.championConfigs[index].UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.secondRow)
          {
            championButton.transform.SetParent(this.row2Parent, false);
            this.row2.Add(championButton);
          }
          else if (this.configProvider.championConfigs[index].UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.thirdRow)
          {
            championButton.transform.SetParent(this.row3Parent, false);
            this.row3.Add(championButton);
          }
          this.AllChampionButtons.Add(this.configProvider.championConfigs[index].ChampionConfig, championButton);
          championButton.GetComponent<FillGalleryChampButtonInfo>().StyleLocked(false, false);
        }
      }
    }

    private void CreateChampionButtonsMeta(MetaEntity metaPlayer)
    {
      this.ClearChampionButtons();
      Dictionary<ChampionType, bool> championLockStateDict = metaPlayer.metaChampionsUnlocked.championLockStateDict;
      Dictionary<ChampionType, bool> rotationStateDict = metaPlayer.metaChampionsUnlocked.championRotationStateDict;
      foreach (KeyValuePair<ChampionType, bool> keyValuePair in championLockStateDict)
      {
        ChampionConfigProvider.ChampionConfigUiInfo championConfigUiInfoFor = this.configProvider.GetChampionConfigUiInfoFor(keyValuePair.Key);
        GameObject championButton = this.CreateChampionButton(championConfigUiInfoFor.ChampionConfig);
        switch (championConfigUiInfoFor.UiPosition)
        {
          case ChampionConfigProvider.ChampionButtonUiPosition.firstRow:
            championButton.transform.SetParent(this.row1Parent, false);
            this.row1.Add(championButton);
            break;
          case ChampionConfigProvider.ChampionButtonUiPosition.secondRow:
            championButton.transform.SetParent(this.row2Parent, false);
            this.row2.Add(championButton);
            break;
          case ChampionConfigProvider.ChampionButtonUiPosition.thirdRow:
            championButton.transform.SetParent(this.row3Parent, false);
            this.row3.Add(championButton);
            break;
        }
        bool inRotation = false;
        if (rotationStateDict != null && rotationStateDict.ContainsKey(keyValuePair.Key))
          inRotation = rotationStateDict[keyValuePair.Key];
        championButton.GetComponent<FillGalleryChampButtonInfo>().StyleLocked(!keyValuePair.Value, inRotation);
        this.AllChampionButtons.Add(championConfigUiInfoFor.ChampionConfig, championButton);
      }
    }

    private void ScaleBackgroundElement(int nChampionColumns = 0)
    {
      if (nChampionColumns == 0)
      {
        nChampionColumns = Math.Max(this.row1.Count, this.row2.Count);
        nChampionColumns = Math.Max(nChampionColumns, this.row3.Count);
      }
      this.background.sizeDelta = new Vector2((float) (this.addidionalWidth + nChampionColumns * this.buttonWidth), this.background.sizeDelta.y);
    }

    private GameObject CreateChampionButton(ChampionConfig championConfig)
    {
      GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.championButtonPrefab);
      gameObject.name = championConfig.name + "-SelectBtn";
      OnChampionSelectedInGallery componentInChildren = gameObject.GetComponentInChildren<OnChampionSelectedInGallery>(true);
      componentInChildren.championConfig = championConfig;
      componentInChildren.turntableUi = MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>();
      componentInChildren.championDescription = this.championPageDescription;
      componentInChildren.championGalleryMenu = this.GetComponent<MenuObject>();
      componentInChildren.championPageMenu = this.championPageDescription.gameObject.GetComponent<MenuObject>();
      gameObject.GetComponent<FillGalleryChampButtonInfo>().SetImage(championConfig.icon);
      gameObject.GetComponent<FillGalleryChampButtonInfo>().SetText(championConfig.displayName);
      return gameObject;
    }

    public void OnChampionGalleryEnter()
    {
      if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.gameObject.GetComponent<MenuObject>()))
        return;
      this.loadingIcon.SetActive(true);
      this.buttonContainer.SetActive(false);
      ImiServices.Instance.progressManager.FetchChampionUnlockInfo();
      ImiServices.Instance.progressManager.FetchAllItems();
      this.ScaleBackgroundElement(3);
      if (!SteamManager.Initialized || ProgressManager.dlcInstalledAtStartup || !SteamApps.BIsDlcInstalled(new AppId_t(1101500U)))
        return;
      ProgressManager.dlcInstalledAtStartup = true;
    }

    public Selectable GetActiveChampionButton() => (UnityEngine.Object) MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion == (UnityEngine.Object) null ? this.AllChampionButtons[SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(ChampionType.Hildegard)].GetComponent<Selectable>() : this.AllChampionButtons[MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion].GetComponent<Selectable>();
  }
}
