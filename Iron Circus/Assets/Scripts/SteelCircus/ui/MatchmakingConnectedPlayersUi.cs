// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MatchmakingConnectedPlayersUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.Utils;
using SharedWithServer.ScEvents;
using SteelCircus.UI.Lobby;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class MatchmakingConnectedPlayersUi : MonoBehaviourWithSetup
  {
    [SerializeField]
    private ChampionTurntableUI turntableUi;
    [SerializeField]
    private Transform playerAvatarsParent;
    [SerializeField]
    private GameObject playerAvatarPrefab;
    [SerializeField]
    private GameObject waitingForPlayersTxt;
    [SerializeField]
    private ArenaLoadingFinishedUi arenaLoadingFinishedUi;
    private LobbyChampionPickingController lobbyChampionPickingController;
    private PopulateStageLobbyChampionButtons defaultButtonScript;
    public ChampionConfig[] configList;
    public Button SelectButton;
    [SerializeField]
    private Text[] teamMemberChampionUsernames;
    [SerializeField]
    private Text teamTxt;
    private GameObject[] alphaPedestals;
    private GameObject[] betaPedestals;
    private GameEntity localEntity;
    private Team localTeam;
    private bool localPickingDone;
    private bool isChampPickingState;
    private UniqueId[] alphaPickOrder;
    private UniqueId[] betaPickOrder;
    private GameEntity[] matchDataEntities;
    private Dictionary<Team, Dictionary<ulong, Text>> teams = new Dictionary<Team, Dictionary<ulong, Text>>();
    private Dictionary<ulong, Text> playerAvatarDict = new Dictionary<ulong, Text>();
    private float timeStamp;
    private bool pickOrderReceivedErrorLog;

    private void Start()
    {
      foreach (GameObject alphaPedestal in this.alphaPedestals)
        alphaPedestal.GetComponent<Renderer>().material.DisableKeyword("_EMISSION");
      foreach (GameObject betaPedestal in this.betaPedestals)
        betaPedestal.GetComponent<Renderer>().material.DisableKeyword("_EMISSION");
      this.teams.Add(Team.Alpha, new Dictionary<ulong, Text>());
      this.teams.Add(Team.Beta, new Dictionary<ulong, Text>());
      this.localEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
      this.ClearPlayerAvatarParent();
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.disabled);
    }

    public void SetPedestals(GameObject[] alphaPedestals, GameObject[] betaPedestals)
    {
      this.alphaPedestals = alphaPedestals;
      this.betaPedestals = betaPedestals;
    }

    public void SetIsChampPickState(bool isChampPickingState) => this.isChampPickingState = isChampPickingState;

    public void SetPickOrder(UniqueId[] alphaPickOrder, UniqueId[] betaPickOrder)
    {
      this.alphaPickOrder = alphaPickOrder;
      this.betaPickOrder = betaPickOrder;
    }

    public void SetLobbyChampionPickingController(LobbyChampionPickingController controller) => this.lobbyChampionPickingController = controller;

    public void SetPopulateLobbyChampionButtons(PopulateStageLobbyChampionButtons script) => this.defaultButtonScript = script;

    public void SetPickingDone() => this.localPickingDone = true;

    public bool GetPickingDone() => this.localPickingDone;

    private Text CreatePlayerAvatar(GameEntity entity)
    {
      if (string.IsNullOrEmpty(entity.playerUsername.username))
        return (Text) null;
      GameObject gameObject = Object.Instantiate<GameObject>(this.playerAvatarPrefab);
      gameObject.transform.SetParent(this.playerAvatarsParent);
      Text componentInChildren = gameObject.GetComponentInChildren<Text>(true);
      componentInChildren.text = entity.playerUsername.username;
      RectTransform component = gameObject.GetComponent<RectTransform>();
      component.localPosition = new Vector3(component.position.x, component.position.y, 0.0f);
      component.localScale = new Vector3(1f, 1f, 1f);
      return componentInChildren;
    }

    public void Update()
    {
      if ((double) this.timeStamp + 0.5 >= (double) Time.realtimeSinceStartup)
        return;
      this.SetButtonsIfNotSelected();
      this.localEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
      if (this.localEntity != null)
      {
        if (this.localEntity.hasPlayerChampionData)
          this.localTeam = this.localEntity.playerChampionData.value.team;
        this.arenaLoadingFinishedUi.UpdateArenaLoadedInfoBig();
        if (this.isChampPickingState)
        {
          this.RenderChampionsOrdered();
          this.SetTeamPedestals(this.localTeam);
        }
        else if (!this.pickOrderReceivedErrorLog)
        {
          Log.Debug("Did not receive Pick order yet and Lobby is active!");
          this.pickOrderReceivedErrorLog = true;
        }
      }
      this.timeStamp = Time.realtimeSinceStartup;
    }

    private void RenderChampionsOrdered()
    {
      this.defaultButtonScript.DeactivateAllChampionIcons();
      if (this.localTeam != Team.None)
      {
        GameContext game = Contexts.sharedInstance.game;
        UniqueId[] uniqueIdArray = this.localTeam == Team.Alpha ? this.alphaPickOrder : this.betaPickOrder;
        for (int index = 0; index < uniqueIdArray.Length; ++index)
        {
          GameEntity entityWithUniqueId = game.GetFirstEntityWithUniqueId(uniqueIdArray[index]);
          PlayerPickingState stateForPlayerIndex = this.lobbyChampionPickingController.GetPickStateForPlayerIndex(index, this.localTeam);
          ChampionType type = entityWithUniqueId.playerChampionData.value.type;
          ChampionConfig championConfigFor = SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(type);
          if (this.lobbyChampionPickingController.DidPickingStartForPickIndex(index, this.localTeam) && type != ChampionType.Invalid)
          {
            this.defaultButtonScript.SetSelectedChampionIcon(entityWithUniqueId, index, stateForPlayerIndex);
            this.turntableUi.SetTeamMemberChampionActive(entityWithUniqueId, entityWithUniqueId.playerId.value, championConfigFor, index, true);
          }
          else
          {
            this.defaultButtonScript.SetSelectedChampionIcon(entityWithUniqueId, index, stateForPlayerIndex);
            this.turntableUi.SetTeamMemberChampionIconActive(entityWithUniqueId.playerId.value, championConfigFor, index);
          }
        }
      }
      else
        this.turntableUi.Clear();
    }

    public void Reset()
    {
      this.ClearPlayerAvatarParent();
      this.defaultButtonScript.Reset();
    }

    private void SetButtonsIfNotSelected()
    {
      int num = 0;
      if (this.localEntity.hasUniqueId)
        num = this.lobbyChampionPickingController.GetPickIndexForPlayer(this.localEntity.uniqueId.id, this.localTeam);
      if (num < 0 || this.localTeam == Team.None || !(!this.localPickingDone & ((Object) EventSystem.current.currentSelectedGameObject == (Object) null || !EventSystem.current.currentSelectedGameObject.GetComponent<Selectable>().interactable || !EventSystem.current.currentSelectedGameObject.activeInHierarchy)))
        return;
      if ((Object) this.SelectButton == (Object) null)
        this.SelectButton = this.defaultButtonScript.GetSelectedOrFreeChampionButton();
      if (!((Object) this.SelectButton != (Object) null))
        return;
      this.SelectButton.Select();
      this.SelectButton.OnSelect((BaseEventData) null);
      if (!((Object) this.SelectButton.GetComponent<OnChampionSelected>() != (Object) null))
        return;
      this.SelectButton.GetComponent<OnChampionSelected>().OnSelect((BaseEventData) null);
    }

    public void ChangeEntry(GameEntity entity)
    {
      ulong playerId = entity.playerId.value;
      if (!entity.isLocalEntity && this.IsPlayerInLocalPlayersTeam(entity))
      {
        if (this.playerAvatarDict.ContainsKey(entity.playerId.value))
          return;
        this.playerAvatarDict[entity.playerId.value] = this.CreatePlayerAvatar(entity);
      }
      else
      {
        if (!this.playerAvatarDict.ContainsKey(entity.playerId.value))
          return;
        this.RemoveEntry(playerId);
      }
    }

    private bool IsPlayerInLocalPlayersTeam(GameEntity player) => player.playerChampionData.value.team == this.localEntity.playerChampionData.value.team;

    public void RemoveEntry(ulong playerId)
    {
      Object.Destroy((Object) this.playerAvatarDict[playerId].gameObject);
      this.playerAvatarDict.Remove(playerId);
    }

    public void IsReadyClicked() => Events.Global.FireEventChampionSelectionReady();

    private void OnDestroy() => this.ClearPlayerAvatarParent();

    private void ClearPlayerAvatarParent()
    {
      foreach (KeyValuePair<ulong, Text> keyValuePair in this.playerAvatarDict)
        Object.Destroy((Object) keyValuePair.Value.transform.parent.parent.gameObject);
      for (int index = 1; index < this.playerAvatarsParent.transform.childCount; ++index)
        Object.Destroy((Object) this.playerAvatarsParent.transform.GetChild(index).gameObject);
      this.playerAvatarDict.Clear();
    }

    private void SetTeamPedestals(Team team)
    {
      switch (team)
      {
        case Team.Alpha:
          foreach (GameObject alphaPedestal in this.alphaPedestals)
            alphaPedestal.SetActive(true);
          foreach (GameObject betaPedestal in this.betaPedestals)
            betaPedestal.SetActive(false);
          break;
        case Team.Beta:
          foreach (GameObject betaPedestal in this.betaPedestals)
            betaPedestal.SetActive(true);
          foreach (GameObject alphaPedestal in this.alphaPedestals)
            alphaPedestal.SetActive(false);
          break;
        default:
          Log.Error("A player was in Team None while the Lobby was active.");
          break;
      }
    }

    private void OnEnable() => AudioController.PlayMusic("MusicLobby");
  }
}
