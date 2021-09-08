// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Lobby.PopulateStageLobbyChampionButtons
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.GameElements;
using SharedWithServer.ScEvents;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Lobby
{
  public class PopulateStageLobbyChampionButtons : MonoBehaviour
  {
    [SerializeField]
    protected ConfigProvider configProvider;
    [SerializeField]
    protected ChampionTurntableUI turntableUi;
    [SerializeField]
    protected MatchmakingConnectedPlayersUi matchmakingUi;
    [SerializeField]
    protected GameObject championButtonPrefab;
    public int localPickOrder;
    [SerializeField]
    private RectTransform background;
    [SerializeField]
    private float buttonWidth = 135f;
    [SerializeField]
    private float additionalWidth = 135f;
    public bool UseDevSkip = true;
    [SerializeField]
    private Transform championButtonFirstRow;
    [SerializeField]
    private Transform championButtonSecondRow;
    [SerializeField]
    private Transform championButtonThirdRow;
    private RectTransform backGround;
    protected Dictionary<ChampionType, GameObject> buttonsForChampionType = new Dictionary<ChampionType, GameObject>();

    private void Awake()
    {
      Events.Global.OnEventMatchInfo += new Events.EventMatchInfo(this.OnMatchInfo);
      this.backGround = this.GetComponent<RectTransform>();
      this.backGround.sizeDelta = new Vector2((float) (140.0 * (double) this.configProvider.ChampionConfigProvider.highestColumnCount + 20.0), this.backGround.sizeDelta.y);
      this.CreateChampionButtonsMeta(Contexts.sharedInstance.meta.GetEntityWithMetaPlayerId(Contexts.sharedInstance.game.GetFirstLocalEntity().playerId.value));
      this.ScaleBackgroundElement();
      this.gameObject.SetActive(false);
    }

    private void OnDestroy() => Events.Global.OnEventMatchInfo -= new Events.EventMatchInfo(this.OnMatchInfo);

    private void Start()
    {
      if (!Contexts.sharedInstance.meta.hasMetaMatch || !Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground())
        return;
      this.ActivateAllChampionButtons();
    }

    public void Reset()
    {
      Dictionary<ChampionType, bool> championLockStateDict = Contexts.sharedInstance.meta.GetEntityWithMetaPlayerId(Contexts.sharedInstance.game.GetFirstLocalEntity().playerId.value).metaChampionsUnlocked.championLockStateDict;
      foreach (ChampionType key in this.buttonsForChampionType.Keys)
      {
        OnSelectedChampionAvatarUi component = this.buttonsForChampionType[key].GetComponent<OnSelectedChampionAvatarUi>();
        if (championLockStateDict.ContainsKey(key) && championLockStateDict[key])
          component.SetButtonActive();
        else
          component.SetButtonInactive();
        component.DisableAllSelectedChampionIcons();
      }
    }

    private void OnMatchInfo(string arena, string matchId, GameType gameType)
    {
      if (!gameType.IsPlayground())
        return;
      Log.Debug("ChampionButtons are all Enabled because of Playground.");
      this.ActivateAllChampionButtons();
    }

    public void SetLocalPickOrderForAllButtons(int order)
    {
      foreach (KeyValuePair<ChampionType, GameObject> keyValuePair in this.buttonsForChampionType)
        keyValuePair.Value.GetComponent<OnChampionSelected>().pickOrder = order;
    }

    private void CreateChampionButtons()
    {
      for (int index = 0; index < this.configProvider.ChampionConfigProvider.championConfigs.Count; ++index)
      {
        List<ChampionConfigProvider.ChampionConfigUiInfo> championConfigs = this.configProvider.ChampionConfigProvider.championConfigs;
        if (championConfigs[index].IsActive && championConfigs[index].UiPosition != ChampionConfigProvider.ChampionButtonUiPosition.dontRender)
        {
          GameObject championButton = this.CreateChampionButton(championConfigs[index].ChampionConfig);
          if (championConfigs[index].UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.firstRow)
            championButton.transform.SetParent(this.championButtonFirstRow, false);
          else if (championConfigs[index].UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.secondRow)
            championButton.transform.SetParent(this.championButtonSecondRow, false);
          else if (championConfigs[index].UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.thirdRow)
            championButton.transform.SetParent(this.championButtonThirdRow, false);
          this.buttonsForChampionType.Add(championConfigs[index].ChampionConfig.championType, championButton);
          if (index == 0)
            this.matchmakingUi.SelectButton = championButton.GetComponent<Button>();
        }
      }
    }

    private void CreateChampionButtonsMeta(MetaEntity metaLocalEntity)
    {
      int num = 0;
      Dictionary<ChampionType, bool> rotationStateDict = metaLocalEntity.metaChampionsUnlocked.championRotationStateDict;
      foreach (KeyValuePair<ChampionType, bool> keyValuePair in metaLocalEntity.metaChampionsUnlocked.championLockStateDict)
      {
        ChampionType key = keyValuePair.Key;
        ChampionConfigProvider.ChampionConfigUiInfo championConfigUiInfoFor = this.configProvider.ChampionConfigProvider.GetChampionConfigUiInfoFor(key);
        GameObject championButton = this.CreateChampionButton(championConfigUiInfoFor.ChampionConfig);
        if (championConfigUiInfoFor.UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.firstRow)
          championButton.transform.SetParent(this.championButtonFirstRow, false);
        else if (championConfigUiInfoFor.UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.secondRow)
          championButton.transform.SetParent(this.championButtonSecondRow, false);
        else if (championConfigUiInfoFor.UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.thirdRow)
          championButton.transform.SetParent(this.championButtonThirdRow, false);
        if (!keyValuePair.Value)
          championButton.GetComponent<OnSelectedChampionAvatarUi>().SetButtonInactive();
        if (rotationStateDict != null && rotationStateDict.ContainsKey(key))
          championButton.GetComponent<OnSelectedChampionAvatarUi>().SetWeeklyRotationIcon(rotationStateDict[key]);
        else
          championButton.GetComponent<OnSelectedChampionAvatarUi>().SetWeeklyRotationIcon(false);
        this.buttonsForChampionType.Add(championConfigUiInfoFor.ChampionConfig.championType, championButton);
        if (num == 0)
          this.matchmakingUi.SelectButton = championButton.GetComponent<Button>();
      }
    }

    private void ScaleBackgroundElement() => this.background.sizeDelta = new Vector2(this.additionalWidth + (float) Math.Max(Math.Max(this.championButtonFirstRow.childCount, this.championButtonSecondRow.childCount), this.championButtonThirdRow.childCount) * this.buttonWidth, this.background.sizeDelta.y);

    private GameObject CreateChampionButton(ChampionConfig championConfig)
    {
      GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.championButtonPrefab);
      gameObject.name = championConfig.displayName + "_ChampionBtn";
      gameObject.GetComponentInChildren<OnSelectedChampionAvatarUi>(true).SetChampionButtonData(championConfig.displayName, championConfig.icon);
      OnChampionSelected componentInChildren = gameObject.GetComponentInChildren<OnChampionSelected>(true);
      componentInChildren.championConfig = championConfig;
      componentInChildren.turntableUi = this.turntableUi;
      componentInChildren.pickOrder = this.localPickOrder;
      componentInChildren.SetPlayerReadyOnServer = false;
      return gameObject;
    }

    public Button GetFreeChampionButton()
    {
      foreach (KeyValuePair<ChampionType, GameObject> keyValuePair in this.buttonsForChampionType)
      {
        Button component = keyValuePair.Value.GetComponent<Button>();
        if (component.interactable)
          return component;
      }
      return (Button) null;
    }

    public Button GetSelectedOrFreeChampionButton()
    {
      foreach (KeyValuePair<ChampionType, GameObject> keyValuePair in this.buttonsForChampionType)
      {
        Button component = keyValuePair.Value.GetComponent<Button>();
        if (component.interactable && (UnityEngine.Object) EventSystem.current.currentSelectedGameObject == (UnityEngine.Object) component.gameObject)
          return component;
      }
      return this.GetFreeChampionButton();
    }

    public void ActivateAllChampionButtons()
    {
      foreach (KeyValuePair<ChampionType, GameObject> keyValuePair in this.buttonsForChampionType)
        keyValuePair.Value.GetComponent<OnSelectedChampionAvatarUi>().SetButtonActive();
    }

    public void SetSelectedChampionIcon(GameEntity player, int order, PlayerPickingState pickState)
    {
      if (!this.buttonsForChampionType.ContainsKey(player.playerChampionData.value.type))
        return;
      this.buttonsForChampionType[player.playerChampionData.value.type].GetComponent<OnSelectedChampionAvatarUi>().EnableIconForPlayer(player, order, pickState);
    }

    public void DeactivateAllChampionIcons()
    {
      foreach (KeyValuePair<ChampionType, GameObject> keyValuePair in this.buttonsForChampionType)
        keyValuePair.Value.GetComponent<OnSelectedChampionAvatarUi>().DisableAllSelectedChampionIcons();
    }
  }
}
