// Decompiled with JetBrains decompiler
// Type: LobbyChampionPickingController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.Utils.Extensions;
using Imi.SteelCircus.Core;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using SteelCircus.UI.Lobby;
using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class LobbyChampionPickingController : MonoBehaviour
{
  public GUIStyle guiStyle;
  [SerializeField]
  private GameObject progressBarPrefab;
  [SerializeField]
  private Transform pickingBarParent;
  [SerializeField]
  private bool isDev;
  [SerializeField]
  private TextMeshProUGUI YourTurnTxt;
  [SerializeField]
  private TextMeshProUGUI countDownTxt;
  [SerializeField]
  private TextMeshProUGUI waitingForAdditionalPlayersTxt;
  [SerializeField]
  private Text YouPickTxt;
  [SerializeField]
  private MatchmakingConnectedPlayersUi matchmakingConnectedPlayersUi;
  [SerializeField]
  private PopulateStageLobbyChampionButtons defaultButtonScript;
  [SerializeField]
  private Text arenaText;
  [SerializeField]
  private Image arenaMinimapIcon;
  [SerializeField]
  private GameObject[] alphaPedestals;
  [SerializeField]
  private GameObject[] betaPedestals;
  private UniqueId[] alphaPickOrder;
  private UniqueId[] betaPickOrder;
  private int[,] alphaPlayerPickTimes;
  private int[,] betaPlayerPickTimes;
  private GameEntity localEntity;
  private GameEntity globalTimeEntity;
  private float pickOrderReceived;
  private float pickTimesReceived;
  private float previousTimeLeft;
  private bool isPickingState;
  private Dictionary<UniqueId, LobbyProgressBar> playerProgressBarDict = new Dictionary<UniqueId, LobbyProgressBar>();

  private void Awake()
  {
    Events.Global.OnEventLobbyPickOrder += new Events.EventLobbyPickOrder(this.OnLobbyPickOrder);
    Events.Global.OnEventLobbyPickTimes += new Events.EventLobbyPickTimes(this.OnLobbyPickTimes);
    Events.Global.OnEventMetaStateChanged += new Events.EventMetaStateChanged(this.OnMetaStateChanged);
    Events.Global.OnEventDisconnect += new Events.EventDisconnect(this.OnDisconnect);
    this.matchmakingConnectedPlayersUi.SetPedestals(this.alphaPedestals, this.betaPedestals);
    this.matchmakingConnectedPlayersUi.SetLobbyChampionPickingController(this);
    this.matchmakingConnectedPlayersUi.SetPopulateLobbyChampionButtons(this.defaultButtonScript);
  }

  private void OnDisconnect(ulong id, byte index) => this.matchmakingConnectedPlayersUi.gameObject.SetActive(true);

  private void OnDestroy()
  {
    Events.Global.OnEventLobbyPickOrder -= new Events.EventLobbyPickOrder(this.OnLobbyPickOrder);
    Events.Global.OnEventLobbyPickTimes -= new Events.EventLobbyPickTimes(this.OnLobbyPickTimes);
    Events.Global.OnEventMetaStateChanged -= new Events.EventMetaStateChanged(this.OnMetaStateChanged);
    Events.Global.OnEventDisconnect -= new Events.EventDisconnect(this.OnDisconnect);
  }

  private void Start()
  {
    this.matchmakingConnectedPlayersUi.SelectButton = this.defaultButtonScript.GetFreeChampionButton();
    this.YouPickTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@PlayersConnecting");
    this.waitingForAdditionalPlayersTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@WaitingForAdditionalPlayers");
  }

  private void OnMetaStateChanged(in MetaState metaState)
  {
    if (metaState == MetaState.Waiting && this.isPickingState)
    {
      this.isPickingState = false;
      this.alphaPlayerPickTimes = (int[,]) null;
      this.betaPlayerPickTimes = (int[,]) null;
      this.alphaPickOrder = (UniqueId[]) null;
      this.betaPickOrder = (UniqueId[]) null;
      this.matchmakingConnectedPlayersUi.SetIsChampPickState(false);
      this.matchmakingConnectedPlayersUi.Reset();
      this.gameObject.GetComponent<Animation>().Play("lobby_champion_selection_to_waiting");
      this.waitingForAdditionalPlayersTxt.gameObject.SetActive(true);
    }
    if (metaState != MetaState.Game)
      return;
    this.matchmakingConnectedPlayersUi.gameObject.SetActive(false);
  }

  public void EnterConnectionScreen()
  {
    this.matchmakingConnectedPlayersUi.gameObject.SetActive(true);
    this.arenaText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + ImiServices.Instance.isInMatchService.CurrentArena);
    this.arenaMinimapIcon.sprite = UnityEngine.Resources.Load<Sprite>("UI/Lobby_ArenaIcons/" + ImiServices.Instance.isInMatchService.CurrentArena);
  }

  private void OnLobbyPickTimes(
    ref int[,] newAlphaPlayerPickTimes,
    ref int[,] newBetaPlayerPickTimes)
  {
    this.pickTimesReceived = this.globalTimeEntity.globalTime.timeSinceMatchStart;
    this.alphaPlayerPickTimes = newAlphaPlayerPickTimes;
    this.betaPlayerPickTimes = newBetaPlayerPickTimes;
    if (this.localEntity.playerChampionData.value.team == Team.Alpha)
    {
      for (int index = 0; index < this.alphaPlayerPickTimes.GetLength(0); ++index)
        this.playerProgressBarDict[this.alphaPickOrder[index]].SetStartAndEndTick(this.alphaPlayerPickTimes[index, 0], this.alphaPlayerPickTimes[index, 1]);
    }
    else
    {
      for (int index = 0; index < this.betaPlayerPickTimes.GetLength(0); ++index)
        this.playerProgressBarDict[this.betaPickOrder[index]].SetStartAndEndTick(this.betaPlayerPickTimes[index, 0], this.betaPlayerPickTimes[index, 1]);
    }
  }

  private void OnLobbyPickOrder(UniqueId[] newAlphaPickOrder, UniqueId[] newBetaPickOrder)
  {
    Log.Debug(string.Format("Got PickOrder: Players: {0}", (object) (newAlphaPickOrder.Length + newBetaPickOrder.Length)));
    this.localEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
    this.matchmakingConnectedPlayersUi.SetPickOrder(newAlphaPickOrder, newBetaPickOrder);
    this.matchmakingConnectedPlayersUi.SetIsChampPickState(true);
    this.globalTimeEntity = Contexts.sharedInstance.game.globalTimeEntity;
    this.pickOrderReceived = this.globalTimeEntity.globalTime.timeSinceMatchStart;
    this.alphaPickOrder = newAlphaPickOrder;
    this.betaPickOrder = newBetaPickOrder;
    UniqueId[] uniqueIdArray = this.localEntity.playerChampionData.value.team == Team.Alpha ? this.alphaPickOrder : this.betaPickOrder;
    foreach (UniqueId key in this.playerProgressBarDict.Keys)
      UnityEngine.Object.Destroy((UnityEngine.Object) this.playerProgressBarDict[key].gameObject);
    this.playerProgressBarDict.Clear();
    for (int order = 0; order < uniqueIdArray.Length; ++order)
    {
      if (!this.playerProgressBarDict.ContainsKey(uniqueIdArray[order]))
        this.playerProgressBarDict.Add(uniqueIdArray[order], this.CreatePlayerProgressBar(uniqueIdArray[order], (float) uniqueIdArray.Length, order));
    }
    for (int order = 0; order < uniqueIdArray.Length; ++order)
    {
      if (uniqueIdArray[order].Equals(this.localEntity.uniqueId.id))
      {
        this.defaultButtonScript.SetLocalPickOrderForAllButtons(order);
        this.defaultButtonScript.localPickOrder = order;
      }
    }
  }

  private void Update()
  {
    MetaContext meta = Contexts.sharedInstance.meta;
    if (!meta.hasMetaState)
      return;
    if (meta.metaState.value == MetaState.Game)
    {
      this.gameObject.SetActive(false);
    }
    else
    {
      if (meta.metaState.value != MetaState.Lobby || this.isPickingState || this.alphaPickOrder == null || this.betaPickOrder == null || this.alphaPlayerPickTimes == null || this.betaPlayerPickTimes == null)
        return;
      this.isPickingState = true;
      this.waitingForAdditionalPlayersTxt.gameObject.SetActive(false);
      this.gameObject.GetComponent<Animation>().Play("lobby_champion_selection_in");
    }
  }

  private IEnumerator TransitionToChampSelectAnim()
  {
    // ISSUE: reference to a compiler-generated field
    int num = this.\u003C\u003E1__state;
    LobbyChampionPickingController pickingController = this;
    if (num != 0)
    {
      if (num != 1)
        return false;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      pickingController.gameObject.GetComponent<Animation>().Play("lobby_champion_selection_in");
      return false;
    }
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E1__state = -1;
    pickingController.waitingForAdditionalPlayersTxt.gameObject.SetActive(false);
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E2__current = (object) new WaitForSeconds((float) StartupSetup.configProvider.matchConfig.WaitingForPlayersDuration);
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E1__state = 1;
    return true;
  }

  private void EnableSpeechBubble() => this.playerProgressBarDict[this.localEntity.uniqueId.id].EnableLocalPlayerTag();

  private void DisableSpeechBubble() => this.playerProgressBarDict[this.localEntity.uniqueId.id].DisableLocalPlayerTag();

  private void SetYourPickText() => this.YouPickTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@GetReady");

  private void SetCountDownText(string text) => this.countDownTxt.text = string.IsNullOrEmpty(text) ? "" : text;

  private void SetCountdown(int timeLeft)
  {
    AudioController.Play("LobbyPickChampCountdown");
    this.countDownTxt.text = Mathf.CeilToInt((float) timeLeft).ToString();
  }

  private void FinishTransitionToChampSelectState()
  {
    this.matchmakingConnectedPlayersUi.SelectButton = this.defaultButtonScript.GetSelectedOrFreeChampionButton();
    EventSystem.current.SetSelectedGameObject((GameObject) null);
  }

  private void SelectButton()
  {
    EventSystem.current.SetSelectedGameObject(this.matchmakingConnectedPlayersUi.SelectButton.gameObject);
    this.matchmakingConnectedPlayersUi.SelectButton.OnSelect((BaseEventData) null);
  }

  public int GetCurrentPickingIndex()
  {
    for (int index = this.alphaPlayerPickTimes.GetLength(0) - 1; index > -1; --index)
    {
      Log.Debug(string.Format("Is {0} < {1} = {2}", (object) this.globalTimeEntity.globalTime.currentTick, (object) this.alphaPlayerPickTimes[index, 1], (object) (this.globalTimeEntity.globalTime.currentTick < this.alphaPlayerPickTimes[index, 1])));
      int currentTick = this.globalTimeEntity.globalTime.currentTick;
      int alphaPlayerPickTime = this.alphaPlayerPickTimes[index, 1];
    }
    return -1;
  }

  public bool DidPickingStartForPickIndex(int i, Team team) => team == Team.Alpha ? this.globalTimeEntity.globalTime.currentTick > this.alphaPlayerPickTimes[i, 0] : this.globalTimeEntity.globalTime.currentTick > this.betaPlayerPickTimes[i, 0];

  public bool DidPickingEndForPickIndex(int i, Team team)
  {
    if (team == Team.None || this.alphaPlayerPickTimes == null || this.betaPlayerPickTimes == null)
      return false;
    i = i.Clamp<int>(0, this.alphaPlayerPickTimes.Length);
    return team == Team.Alpha ? this.globalTimeEntity.globalTime.currentTick > this.alphaPlayerPickTimes[i, 1] : this.globalTimeEntity.globalTime.currentTick > this.betaPlayerPickTimes[i, 1];
  }

  public int GetPickIndexForPlayer(UniqueId id, Team team)
  {
    if (id != UniqueId.Zero && id != UniqueId.Invalid)
    {
      switch (team)
      {
        case Team.None:
          break;
        case Team.Alpha:
          if (this.alphaPickOrder != null)
            return Array.IndexOf<UniqueId>(this.alphaPickOrder, id);
          break;
        default:
          if (this.betaPickOrder != null)
            return Array.IndexOf<UniqueId>(this.betaPickOrder, id);
          break;
      }
    }
    return -1;
  }

  public PlayerPickingState GetPickStateForPlayerIndex(int i, Team team)
  {
    if (team == Team.Alpha)
    {
      if (this.globalTimeEntity.globalTime.currentTick < this.alphaPlayerPickTimes[i, 0])
        return PlayerPickingState.PrePick;
      return this.globalTimeEntity.globalTime.currentTick >= this.alphaPlayerPickTimes[i, 0] && this.globalTimeEntity.globalTime.currentTick <= this.alphaPlayerPickTimes[i, 1] ? PlayerPickingState.Picking : PlayerPickingState.PostPick;
    }
    if (this.globalTimeEntity.globalTime.currentTick < this.betaPlayerPickTimes[i, 0])
      return PlayerPickingState.PrePick;
    return this.globalTimeEntity.globalTime.currentTick >= this.betaPlayerPickTimes[i, 0] && this.globalTimeEntity.globalTime.currentTick <= this.betaPlayerPickTimes[i, 1] ? PlayerPickingState.Picking : PlayerPickingState.PostPick;
  }

  private LobbyProgressBar CreatePlayerProgressBar(
    UniqueId player,
    float teamPlayerCount,
    int order)
  {
    GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.progressBarPrefab, this.pickingBarParent, true);
    LobbyProgressBar component1 = gameObject.GetComponent<LobbyProgressBar>();
    component1.SetupProgressBar(player, order);
    RectTransform component2 = gameObject.GetComponent<RectTransform>();
    Vector3 position = component2.position;
    component2.localPosition = new Vector3(position.x, position.y, 0.0f);
    component2.sizeDelta = new Vector2((float) (Screen.width - 250) / teamPlayerCount, component2.sizeDelta.y);
    component2.localScale = new Vector3(1f, 1f, 1f);
    component1.OnPickingDone = new Action<UniqueId>(this.OnPickingDoneForPlayer);
    component1.OnPickingStarted = new Action<UniqueId, int>(this.OnPickingStartedForPlayer);
    component1.OnPickingDoneDelayed = new Action<ChampionType, int>(this.OnPickingDoneDelayed);
    return component1;
  }

  private void OnPickingStartedForPlayer(UniqueId obj, int order)
  {
    if (this.isDev)
      return;
    Button freeChampionButton = this.defaultButtonScript.GetSelectedOrFreeChampionButton();
    this.matchmakingConnectedPlayersUi.SelectButton = freeChampionButton;
    Log.Debug("Picking started for: " + (object) obj);
    if (Contexts.sharedInstance.game.GetFirstEntityWithUniqueId(obj).playerChampionData.value.team == Team.Alpha)
      this.alphaPedestals[order].GetComponent<Renderer>().material.EnableKeyword("_EMISSION");
    else
      this.betaPedestals[order].GetComponent<Renderer>().material.EnableKeyword("_EMISSION");
    if (this.localEntity.uniqueId.id.Equals(obj))
    {
      this.YourTurnTxt.gameObject.SetActive(true);
      Log.Debug("Selecting Buttin " + freeChampionButton.name);
      freeChampionButton.Select();
      freeChampionButton.OnSelect((BaseEventData) null);
    }
    this.YouPickTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Player" + (object) (order + 1) + "IsPicking");
  }

  private void OnPickingDoneForPlayer(UniqueId obj)
  {
    if (this.isDev)
      return;
    Log.Debug("Picking is done for: " + (object) obj);
    if (!this.localEntity.uniqueId.id.Equals(obj))
      return;
    this.matchmakingConnectedPlayersUi.SetPickingDone();
    this.YourTurnTxt.gameObject.SetActive(false);
  }

  private void OnPickingDoneDelayed(ChampionType type, int order)
  {
    Log.Debug("PickingDelayed is done for: " + (object) type);
    int num = this.isDev ? 1 : 0;
  }
}
