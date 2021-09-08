// Decompiled with JetBrains decompiler
// Type: CustomLobbyUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game.AI;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using JetBrains.Annotations;
using Newtonsoft.Json.Linq;
using Steamworks;
using SteelCircus.Core.Services;
using SteelCircus.Networking;
using SteelCircus.UI;
using SteelCircus.UI.Menu;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class CustomLobbyUi : MonoBehaviour
{
  [Header("UI Elements")]
  [SerializeField]
  private Dropdown arenaDropdown;
  [SerializeField]
  private Dropdown matchmakingDropDown;
  [SerializeField]
  private Dropdown botDifficultyDropdown;
  [SerializeField]
  private TextMeshProUGUI startMatchErrorTxt;
  [SerializeField]
  private Button invitePlayersBtn;
  [SerializeField]
  private GameObject startingGameInfo;
  [Header("Play Button UI Elements")]
  [SerializeField]
  private Button startMatchBtn;
  [SerializeField]
  private Sprite startMatchBtn_notReady;
  [SerializeField]
  private Sprite startMatchBtn_notReadyHighlighted;
  [SerializeField]
  private Sprite startMatchBtn_ready;
  [SerializeField]
  private Sprite startMatchBtn_readyHighlighted;
  [Header("Ready UI Elemets")]
  [SerializeField]
  private Button isReadyBtn;
  [SerializeField]
  private Sprite isReadySprite;
  [SerializeField]
  private Sprite isReadyHighlightedSprite;
  [SerializeField]
  private Sprite isNotReadySprite;
  [SerializeField]
  private Sprite isNotReadHighlightedSprite;
  [SerializeField]
  private GameObject groupMemberPrefab;
  [SerializeField]
  private Transform groupMemberListParent;
  [SerializeField]
  private Transform alphaGroupMemberListParent;
  [SerializeField]
  private Transform betaGroupMemberListParent;
  [SerializeField]
  private Image arenaMinimapIcon;
  [SerializeField]
  private Image arenaMinimapIconRightCorner;
  [SerializeField]
  private TextMeshProUGUI arenaTxt;
  [SerializeField]
  private TextMeshProUGUI regionTxt;
  [Header("BOt UI Elements")]
  [SerializeField]
  public GameObject botTeamMemberButtonPrefab;
  [SerializeField]
  private Button addBotAlphaButton;
  [SerializeField]
  private Button addBotBetaButton;
  private List<CustomLobbyBotTeamAssignButton> team1BotButtons;
  private List<CustomLobbyBotTeamAssignButton> team2BotButtons;
  public static bool isInitialized;
  public static bool isAborted;
  private readonly List<string> allowedArenas = new List<string>()
  {
    "Arena_Shenzhen_01_VariationA",
    "Arena_Shenzhen_01_VariationB",
    "Arena_Shenzhen_01_VariationC",
    "Arena_Mars_01_VariationA",
    "Arena_Mars_01_VariationB",
    "Arena_Mars_01_VariationC"
  };
  private List<string> localizedArenaList;
  private List<string> matchmakingRegions;
  private List<string> localizedMatchmakingRegions;
  private List<string> botDifficulties;
  private List<string> localizedBotDifficulties;
  private Dictionary<ulong, GroupMemberTeamAssignButton> groupMembersUi = new Dictionary<ulong, GroupMemberTeamAssignButton>();
  private InputService input;
  private readonly string botCountAlphaPlayerPref = "CustomMatchBotCountAlpha";
  private readonly string botCountBetaPlayerPref = "CustomMatchBotCountBeta";
  private readonly string botDifficultyPlayerPref = "CustomMatchBotDifficulty";

  public event CustomLobbyUi.OnLocalPlayerJoinedCustomLobbyEventHandler onLocalPlayerJoinedCustomLobby;

  private void Start()
  {
    this.team1BotButtons = new List<CustomLobbyBotTeamAssignButton>();
    this.team2BotButtons = new List<CustomLobbyBotTeamAssignButton>();
    Log.Debug("CustomLobby Start: " + CustomLobbyUi.isInitialized.ToString());
    ImiServices.Instance.PartyService.OnGroupCustomMatchLobbyUpdate += new APartyService.GroupCustomMatchLobbyUpdateEventHandler(this.OnGroupCustomMatchLobbyUpdate);
    ImiServices.Instance.PartyService.OnGroupCustomMatchLobbyIsReady += new APartyService.GroupCustomMatchLobbyIsReadyEventHandler(this.OnGroupCustomMatchLobbyUpdateIsReady);
    this.SetArenaDropdown();
    this.SetMatchmakingRegionDropdown();
    this.SetBotDifficultyDropdown();
    this.input = ImiServices.Instance.InputService;
    foreach (APartyService.GroupMember groupMember in ImiServices.Instance.PartyService.GetCurrentGroup())
      groupMember.isCustomLobbyReady = false;
    if (!CustomLobbyUi.isInitialized)
      return;
    Log.Debug("CustomLobby Start After Match " + CustomLobbyUi.isInitialized.ToString());
    this.StartCoroutine(this.DelayedShowMenu());
    this.Initialize();
    this.SendUpdateCustomLobbyUiMessage(0UL);
  }

  private IEnumerator DelayedShowMenu()
  {
    // ISSUE: reference to a compiler-generated field
    int num = this.\u003C\u003E1__state;
    CustomLobbyUi customLobbyUi = this;
    if (num != 0)
    {
      if (num != 1)
        return false;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      customLobbyUi.GetComponent<MenuObject>().ActualShowMenu(MenuObject.animationType.changeInstantly);
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.leaveSteamGroup);
      customLobbyUi.ShowTeamMembersAndTeams();
      return false;
    }
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E1__state = -1;
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E2__current = (object) null;
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E1__state = 1;
    return true;
  }

  private void OnDestroy()
  {
    if (CustomLobbyUi.isAborted)
    {
      this.Uninitialize();
      CustomLobbyUi.isAborted = false;
    }
    else if (CustomLobbyUi.isInitialized)
      this.RemoveListeners();
    ImiServices.Instance.PartyService.OnGroupCustomMatchLobbyUpdate -= new APartyService.GroupCustomMatchLobbyUpdateEventHandler(this.OnGroupCustomMatchLobbyUpdate);
    ImiServices.Instance.PartyService.OnGroupCustomMatchLobbyIsReady -= new APartyService.GroupCustomMatchLobbyIsReadyEventHandler(this.OnGroupCustomMatchLobbyUpdateIsReady);
    this.arenaDropdown.onValueChanged.RemoveListener(this.OnArenaDropdownChanged());
    this.matchmakingDropDown.onValueChanged.RemoveListener(this.OnRegionDropdownChanged());
    this.botDifficultyDropdown.onValueChanged.RemoveListener(this.OnBotDifficultyChanged());
    this.groupMembersUi.Clear();
    this.ClearGroupList();
  }

  public void AddAIBotToTeam(int team)
  {
    Team team1;
    switch (team)
    {
      case 1:
        team1 = Team.Alpha;
        break;
      case 2:
        team1 = Team.Beta;
        break;
      default:
        return;
    }
    GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.botTeamMemberButtonPrefab);
    CustomLobbyBotTeamAssignButton component = gameObject.GetComponent<CustomLobbyBotTeamAssignButton>();
    component.Team = team1;
    component.customLobbyManager = this;
    if (team1 == Team.Alpha)
    {
      gameObject.transform.SetParent(this.alphaGroupMemberListParent, false);
      gameObject.transform.localPosition = Vector3.zero;
      this.team1BotButtons.Add(component);
    }
    if (team1 == Team.Beta)
    {
      gameObject.transform.SetParent(this.betaGroupMemberListParent, false);
      gameObject.transform.localPosition = Vector3.zero;
      this.team2BotButtons.Add(component);
    }
    if (ImiServices.Instance.PartyService.IsInGroup() && ImiServices.Instance.PartyService.IsGroupOwner())
      this.SendUpdateCustomLobbyUiMessage(0UL);
    this.ShowTeamMembersAndTeams();
  }

  private void UpdateTeamBotCounts(int team1BotCount, int team2BotCount)
  {
    Log.Debug(string.Format("Updating Team bot counts:\nAlpha: {0} (was{1})\nBeta: {2} (was {3})", (object) team1BotCount, (object) this.team1BotButtons.Count, (object) team2BotCount, (object) this.team2BotButtons.Count));
    int count1 = this.team1BotButtons.Count;
    int count2 = this.team2BotButtons.Count;
    if (count1 < team1BotCount)
    {
      for (int index = 0; index < team1BotCount - count1; ++index)
        this.AddAIBotToTeam(1);
    }
    if (count1 > team1BotCount)
    {
      for (int index = 0; index < count1 - team1BotCount; ++index)
        this.RemoveBot(this.team1BotButtons[count1 - 1 - index]);
    }
    if (count2 < team2BotCount)
    {
      for (int index = 0; index < team2BotCount - count2; ++index)
        this.AddAIBotToTeam(2);
    }
    if (count2 <= team2BotCount)
      return;
    for (int index = 0; index < count2 - team2BotCount; ++index)
      this.RemoveBot(this.team2BotButtons[count2 - 1 - index]);
  }

  public void RemoveBot(CustomLobbyBotTeamAssignButton bot)
  {
    if (bot.Team == Team.Alpha && this.team1BotButtons.Contains(bot))
      this.team1BotButtons.Remove(bot);
    if (bot.Team == Team.Beta && this.team2BotButtons.Contains(bot))
      this.team2BotButtons.Remove(bot);
    bot.gameObject.transform.SetParent((Transform) null, false);
    this.ForceRebuildLayouts();
    if ((UnityEngine.Object) bot.gameObject != (UnityEngine.Object) null)
      UnityEngine.Object.Destroy((UnityEngine.Object) bot.gameObject);
    if (!ImiServices.Instance.PartyService.IsInGroup() || !ImiServices.Instance.PartyService.IsGroupOwner())
      return;
    this.SendUpdateCustomLobbyUiMessage(0UL);
  }

  private void ResetBotLists()
  {
    this.team1BotButtons = new List<CustomLobbyBotTeamAssignButton>();
    this.team2BotButtons = new List<CustomLobbyBotTeamAssignButton>();
  }

  private void SetArenaDropdown()
  {
    this.arenaDropdown.ClearOptions();
    this.localizedArenaList = this.allowedArenas.Select<string, string>((Func<string, string>) (option => ImiServices.Instance.LocaService.GetLocalizedValue("@" + option))).ToList<string>();
    this.arenaDropdown.AddOptions(this.localizedArenaList);
    Sprite sprite = UnityEngine.Resources.Load<Sprite>("UI/Lobby_ArenaIcons/" + this.allowedArenas[this.arenaDropdown.value]);
    this.arenaMinimapIcon.sprite = sprite;
    this.arenaMinimapIconRightCorner.sprite = sprite;
    this.arenaTxt.text = this.arenaDropdown.options[this.arenaDropdown.value].text;
    this.arenaDropdown.onValueChanged.AddListener(this.OnArenaDropdownChanged());
  }

  private UnityAction<int> OnArenaDropdownChanged() => (UnityAction<int>) (_param1 =>
  {
    Sprite sprite = UnityEngine.Resources.Load<Sprite>("UI/Lobby_ArenaIcons/" + this.allowedArenas[this.arenaDropdown.value]);
    this.arenaMinimapIcon.sprite = sprite;
    this.arenaMinimapIconRightCorner.sprite = sprite;
    this.arenaTxt.text = this.arenaDropdown.options[this.arenaDropdown.value].text;
    this.SendUpdateCustomLobbyUiMessage(0UL);
  });

  private void SetMatchmakingRegionDropdown()
  {
    this.matchmakingRegions = ImiServices.Instance.MatchmakingService.GetRegions();
    this.matchmakingDropDown.ClearOptions();
    this.localizedMatchmakingRegions = this.matchmakingRegions.Select<string, string>((Func<string, string>) (option => ImiServices.Instance.LocaService.GetLocalizedValue("@MatchmakingRegion_" + option))).ToList<string>();
    this.matchmakingDropDown.AddOptions(this.localizedMatchmakingRegions);
    string str;
    if (PlayerPrefs.HasKey("CustomMatchMatchmakingRegion"))
    {
      str = PlayerPrefs.GetString("CustomMatchMatchmakingRegion");
    }
    else
    {
      str = "eu-west-1";
      PlayerPrefs.SetString("CustomMatchMatchmakingRegion", "eu-west-1");
    }
    this.matchmakingDropDown.value = this.matchmakingRegions.IndexOf(str);
    this.regionTxt.text = this.matchmakingDropDown.options[this.matchmakingDropDown.value].text;
    this.matchmakingDropDown.onValueChanged.AddListener(this.OnRegionDropdownChanged());
  }

  private UnityAction<int> OnRegionDropdownChanged() => (UnityAction<int>) (_param1 =>
  {
    this.regionTxt.text = this.matchmakingDropDown.options[this.matchmakingDropDown.value].text;
    PlayerPrefs.SetString("CustomMatchMatchmakingRegion", this.matchmakingRegions[this.matchmakingDropDown.value]);
    this.SendUpdateCustomLobbyUiMessage(0UL);
  });

  private void SetBotDifficultyDropdown()
  {
    this.botDifficulties = ((IEnumerable<string>) Enum.GetNames(typeof (AIDifficulty))).ToList<string>();
    this.botDifficulties.Remove("BasicTrainingTeamMate");
    this.botDifficulties.Remove("BasicTrainingOpponent");
    this.botDifficulties.Remove("Tutorial");
    this.botDifficultyDropdown.ClearOptions();
    this.localizedBotDifficulties = this.botDifficulties.Select<string, string>((Func<string, string>) (option => ImiServices.Instance.LocaService.GetLocalizedValue("@BotDifficulty_" + option))).ToList<string>();
    this.botDifficultyDropdown.AddOptions(this.localizedBotDifficulties);
    string str = "Intermediate";
    if (PlayerPrefs.HasKey(this.botDifficultyPlayerPref))
      str = PlayerPrefs.GetString(this.botDifficultyPlayerPref);
    this.botDifficultyDropdown.value = this.botDifficulties.IndexOf(str);
    this.botDifficultyDropdown.onValueChanged.AddListener(this.OnBotDifficultyChanged());
  }

  private UnityAction<int> OnBotDifficultyChanged() => (UnityAction<int>) (_param1 =>
  {
    PlayerPrefs.SetString(this.botDifficultyPlayerPref, this.botDifficulties[this.botDifficultyDropdown.value]);
    this.SendUpdateCustomLobbyUiMessage(0UL);
  });

  private void Initialize()
  {
    Log.Debug("Initialize CustomLobby!");
    this.ClearGroupList();
    CustomLobbyUi.isInitialized = true;
    this.AddListeners();
    if (ImiServices.Instance.PartyService.IsGroupOwner())
      this.AddBotsFromPreviousMatch();
    this.StoreBotCountPlayerPrefs(0, 0);
    MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.leaveSteamGroup);
    MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().leaveSteamGroupEvent = new Action(this.LeaveCustomLobby);
  }

  private void SetBotButtonsActive(bool active)
  {
    this.addBotBetaButton.gameObject.SetActive(active);
    this.addBotAlphaButton.gameObject.SetActive(active);
  }

  private void StoreBotCountPlayerPrefs(int nBotsAlpha, int nBotsBeta)
  {
    PlayerPrefs.SetInt(this.botCountAlphaPlayerPref, nBotsAlpha);
    PlayerPrefs.SetInt(this.botCountBetaPlayerPref, nBotsBeta);
  }

  private void AddBotsFromPreviousMatch()
  {
    if (PlayerPrefs.HasKey(this.botCountAlphaPlayerPref))
    {
      for (int index = 0; index < PlayerPrefs.GetInt(this.botCountAlphaPlayerPref); ++index)
        this.AddAIBotToTeam(1);
    }
    if (!PlayerPrefs.HasKey(this.botCountBetaPlayerPref))
      return;
    for (int index = 0; index < PlayerPrefs.GetInt(this.botCountBetaPlayerPref); ++index)
      this.AddAIBotToTeam(2);
  }

  private void AddListeners()
  {
    Log.Debug("Add Custom Lobby Listeners");
    ImiServices.Instance.PartyService.RaiseOnCustomLobbyEntered();
    ImiServices.Instance.PartyService.OnGroupEntered += new APartyService.OnGroupEnteredEventHandler(this.OnGroupEntered);
    ImiServices.Instance.PartyService.OnGroupMemberJoined += new APartyService.OnGroupMemberJoinedEventHandler(this.OnGroupMemberJoined);
    ImiServices.Instance.PartyService.OnGroupMemberLeft += new APartyService.OnGroupMemberLeftEventHandler(this.OnGroupMemberLeft);
    ImiServices.Instance.PartyService.OnPlayerKick += new APartyService.OnPlayerKickEventHandler(this.OnKickPlayer);
    ImiServices.Instance.PartyService.OnGroupLobbyOwnerChanged += new APartyService.OnGroupLobbyOwnerChangedEventHandler(this.OnGroupLobbyOwnerChanged);
  }

  private void Uninitialize()
  {
    Log.Debug("Uninitialize CustomLobby!");
    CustomLobbyUi.isInitialized = false;
    ImiServices.Instance.PartyService.LeaveGroup();
    if ((UnityEngine.Object) MenuController.Instance != (UnityEngine.Object) null && (UnityEngine.Object) MenuController.Instance.gameObject != (UnityEngine.Object) null && MenuController.Instance.gameObject.activeInHierarchy)
      MenuController.Instance.GoToPreviousMenu();
    ImiServices.Instance.PartyService.RaiseOnCustomLobbyLeft();
    this.RemoveListeners();
    this.ClearGroupList();
    this.ResetBotLists();
    this.groupMembersUi.Clear();
  }

  private void RemoveListeners()
  {
    Log.Debug("Remove Custom Lobby Listeners");
    ImiServices.Instance.PartyService.OnGroupEntered -= new APartyService.OnGroupEnteredEventHandler(this.OnGroupEntered);
    ImiServices.Instance.PartyService.OnGroupMemberJoined -= new APartyService.OnGroupMemberJoinedEventHandler(this.OnGroupMemberJoined);
    ImiServices.Instance.PartyService.OnGroupMemberLeft -= new APartyService.OnGroupMemberLeftEventHandler(this.OnGroupMemberLeft);
    ImiServices.Instance.PartyService.OnPlayerKick -= new APartyService.OnPlayerKickEventHandler(this.OnKickPlayer);
    ImiServices.Instance.PartyService.OnGroupLobbyOwnerChanged -= new APartyService.OnGroupLobbyOwnerChangedEventHandler(this.OnGroupLobbyOwnerChanged);
  }

  private void OnGroupLobbyOwnerChanged(ulong playerId)
  {
    this.ShowTeamMembersAndTeams();
    this.CollapseAllButtons();
  }

  private void OnKickPlayer(ulong playerId)
  {
    if ((long) playerId == (long) ImiServices.Instance.LoginService.GetPlayerId())
      this.Uninitialize();
    else
      this.RemoveGroupMemberUi(playerId);
  }

  private void LateUpdate()
  {
    if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.GetComponent<MenuObject>()))
      return;
    this.ForceRebuildLayouts();
  }

  private void Update()
  {
    List<APartyService.GroupMember> currentGroup = ImiServices.Instance.PartyService.GetCurrentGroup();
    List<ulong> ulongList1 = new List<ulong>();
    List<ulong> ulongList2 = new List<ulong>();
    foreach (APartyService.GroupMember groupMember in currentGroup)
    {
      if (groupMember.team == Team.Alpha)
        ulongList1.Add(groupMember.playerId);
      else if (groupMember.team == Team.Beta)
        ulongList2.Add(groupMember.playerId);
    }
    int num1 = ulongList1.Count + this.team1BotButtons.Count;
    int num2 = ulongList2.Count + this.team2BotButtons.Count;
    if (num1 >= 3)
    {
      this.addBotAlphaButton.interactable = false;
      if (num1 > 3 && this.team1BotButtons.Count > 0)
        this.RemoveBot(this.team1BotButtons[this.team1BotButtons.Count - 1]);
    }
    else
      this.addBotAlphaButton.interactable = true;
    if (num2 >= 3)
    {
      this.addBotBetaButton.interactable = false;
      if (num2 > 3 && this.team2BotButtons.Count > 0)
        this.RemoveBot(this.team2BotButtons[this.team2BotButtons.Count - 1]);
    }
    else
      this.addBotBetaButton.interactable = true;
    if (this.input.GetButtonDown(DigitalInput.UILeftTrigger))
    {
      GameObject selectedGameObject = EventSystem.current.currentSelectedGameObject;
      if (!((UnityEngine.Object) selectedGameObject != (UnityEngine.Object) null))
        return;
      GroupMemberTeamAssignButton componentInChildren = selectedGameObject.GetComponentInChildren<GroupMemberTeamAssignButton>();
      if (!((UnityEngine.Object) componentInChildren != (UnityEngine.Object) null))
        return;
      componentInChildren.SetTeamForGroupMember(false);
    }
    else if (this.input.GetButtonDown(DigitalInput.UIRightTrigger))
    {
      GameObject selectedGameObject = EventSystem.current.currentSelectedGameObject;
      if (!((UnityEngine.Object) selectedGameObject != (UnityEngine.Object) null))
        return;
      GroupMemberTeamAssignButton componentInChildren = selectedGameObject.GetComponentInChildren<GroupMemberTeamAssignButton>();
      if (!((UnityEngine.Object) componentInChildren != (UnityEngine.Object) null))
        return;
      componentInChildren.SetTeamForGroupMember(true);
    }
    else if (this.input.GetButtonDown(DigitalInput.UISubmit))
    {
      if (!ImiServices.Instance.PartyService.IsGroupOwner())
        return;
      GameObject selectedGameObject = EventSystem.current.currentSelectedGameObject;
      if (!((UnityEngine.Object) selectedGameObject != (UnityEngine.Object) null))
        return;
      GroupMemberTeamAssignButton componentInChildren = selectedGameObject.GetComponentInChildren<GroupMemberTeamAssignButton>();
      if (!((UnityEngine.Object) componentInChildren != (UnityEngine.Object) null))
        return;
      this.CollapseAllButtons();
      if (componentInChildren.isExpanded || !ImiServices.Instance.PartyService.IsGroupOwner())
        return;
      componentInChildren.ExpandUi(true);
    }
    else
    {
      if (!this.input.GetButtonUp(DigitalInput.UIShortcut))
        return;
      GameObject selectedGameObject = EventSystem.current.currentSelectedGameObject;
      if (!((UnityEngine.Object) selectedGameObject != (UnityEngine.Object) null))
        return;
      GroupMemberTeamAssignButton componentInChildren = selectedGameObject.GetComponentInChildren<GroupMemberTeamAssignButton>();
      if (!((UnityEngine.Object) componentInChildren != (UnityEngine.Object) null))
        return;
      componentInChildren.SetPlayerMuted();
    }
  }

  private void CollapseAllButtons()
  {
    foreach (KeyValuePair<ulong, GroupMemberTeamAssignButton> keyValuePair in this.groupMembersUi)
      keyValuePair.Value.ExpandUi(false);
  }

  private void OnGroupEntered()
  {
    Log.Debug("CustomMatch OnGroupEntered");
    CustomLobbyUi.OnLocalPlayerJoinedCustomLobbyEventHandler joinedCustomLobby = this.onLocalPlayerJoinedCustomLobby;
    if (joinedCustomLobby != null)
      joinedCustomLobby(ImiServices.Instance.PartyService.GetLobbyId());
    this.ShowTeamMembersAndTeams();
  }

  private void OnGroupMemberJoined(APartyService.GroupMember groupmember)
  {
    Log.Debug("CustomMatch OnGroupMemberJoined");
    this.ShowTeamMembersAndTeams();
    if (!ImiServices.Instance.PartyService.IsGroupOwner())
      return;
    this.SendUpdateCustomLobbyUiMessage(groupmember.playerId);
  }

  private void OnGroupMemberLeft(APartyService.GroupMember groupmember)
  {
    Log.Debug("CustomMatch OnGroupMemberLeft");
    this.RemoveGroupMemberUi(groupmember.playerId);
    this.ShowTeamMembersAndTeams();
    if (!ImiServices.Instance.PartyService.IsGroupOwner())
      return;
    this.SendUpdateCustomLobbyUiMessage(groupmember.playerId);
  }

  public void SendUpdateCustomLobbyUiMessage(ulong playerId)
  {
    JObject jobject1 = new JObject();
    jobject1["arena"] = (JToken) this.arenaDropdown.value;
    jobject1["region"] = (JToken) this.matchmakingDropDown.value;
    jobject1["aiDifficulty"] = (JToken) this.botDifficultyDropdown.value;
    JArray jarray = new JArray();
    foreach (APartyService.GroupMember groupMember in ImiServices.Instance.PartyService.GetCurrentGroup())
    {
      JObject jobject2 = new JObject();
      jobject2[nameof (playerId)] = (JToken) groupMember.playerId;
      jobject2["team"] = (JToken) (int) groupMember.team;
      jobject2["isBot"] = (JToken) false;
      if ((long) playerId == (long) groupMember.playerId)
      {
        jobject2["isReadyChanged"] = (JToken) true;
        groupMember.isCustomLobbyReady = false;
      }
      else
        jobject2["isReadyChanged"] = (JToken) false;
      jarray.Add((JToken) jobject2);
    }
    for (int index = 0; index < this.team1BotButtons.Count; ++index)
      jarray.Add((JToken) this.GetBotJson(1));
    for (int index = 0; index < this.team2BotButtons.Count; ++index)
      jarray.Add((JToken) this.GetBotJson(2));
    jobject1["players"] = (JToken) jarray;
    if (ImiServices.Instance.PartyService.IsInGroup() && ImiServices.Instance.PartyService.IsGroupOwner())
    {
      ImiServices.Instance.PartyService.NotifyGroupCustomGameLobbyUpdated(jobject1.ToString());
      this.SendIsReadyMessage();
    }
    this.ShowTeamMembersAndTeams();
  }

  private JObject GetBotJson(int team) => new JObject()
  {
    ["playerId"] = (JToken) 0,
    [nameof (team)] = (JToken) team,
    ["isBot"] = (JToken) true,
    ["isReadyChanged"] = (JToken) false
  };

  public void SendIsReadyMessage()
  {
    if (!ImiServices.Instance.PartyService.IsInGroup())
      return;
    APartyService.GroupMember groupMember = ImiServices.Instance.PartyService.GetGroupMember(ImiServices.Instance.LoginService.GetPlayerId());
    ImiServices.Instance.PartyService.NotifyGroupCustomGameLobbyIsReady(new JObject()
    {
      ["isReady"] = (groupMember.team != Team.None ? (!ImiServices.Instance.PartyService.IsGroupOwner() ? (JToken) !groupMember.isCustomLobbyReady : (JToken) true) : (JToken) false)
    }.ToString());
  }

  private void BroadcastReadyState(APartyService.GroupMember member)
  {
    if (!ImiServices.Instance.PartyService.IsInGroup())
      return;
    APartyService.GroupMember groupMember = ImiServices.Instance.PartyService.GetGroupMember(ImiServices.Instance.LoginService.GetPlayerId());
    if ((long) groupMember.playerId != (long) member.playerId)
      return;
    ImiServices.Instance.PartyService.NotifyGroupCustomGameLobbyIsReady(new JObject()
    {
      ["isReady"] = (groupMember.team != Team.None ? (!ImiServices.Instance.PartyService.IsGroupOwner() ? (JToken) groupMember.isCustomLobbyReady : (JToken) true) : (JToken) false)
    }.ToString());
  }

  private void OnGroupCustomMatchLobbyUpdateIsReady(ulong steamId, JObject readyData)
  {
    ImiServices.Instance.PartyService.GetGroupMemberViaSteamId(steamId).isCustomLobbyReady = (bool) readyData["isReady"];
    this.ShowTeamMembersAndTeams();
  }

  private void OnGroupCustomMatchLobbyUpdate([NotNull] JObject lobbyData)
  {
    if (lobbyData == null)
      throw new ArgumentNullException(nameof (lobbyData));
    Log.Debug("Received a CustomLobby Update: " + lobbyData.ToString());
    if (ImiServices.Instance.PartyService.IsGroupOwner())
      return;
    if (CustomLobbyUi.isInitialized)
    {
      int num1 = (int) lobbyData["arena"];
      int num2 = (int) lobbyData["region"];
      int num3 = (int) lobbyData["aiDifficulty"];
      this.arenaDropdown.value = num1;
      this.matchmakingDropDown.value = num2;
      this.botDifficultyDropdown.value = num3;
      this.regionTxt.text = this.matchmakingDropDown.options[this.matchmakingDropDown.value].text;
      Sprite sprite = UnityEngine.Resources.Load<Sprite>("UI/Lobby_ArenaIcons/" + this.allowedArenas[this.arenaDropdown.value]);
      this.arenaMinimapIcon.sprite = sprite;
      this.arenaMinimapIconRightCorner.sprite = sprite;
      this.arenaTxt.text = this.arenaDropdown.options[this.arenaDropdown.value].text;
      int team1BotCount = 0;
      int team2BotCount = 0;
      foreach (JToken jtoken in (IEnumerable<JToken>) lobbyData["players"])
      {
        Log.Debug(string.Format("Parsing GroupMember {0} Team = {1}", (object) jtoken[(object) "playerId"], (object) (Team) (int) jtoken[(object) "team"]));
        if (!(bool) jtoken[(object) "isBot"])
        {
          APartyService.GroupMember groupMember = ImiServices.Instance.PartyService.GetGroupMember((ulong) jtoken[(object) "playerId"]);
          groupMember.team = (Team) (int) jtoken[(object) "team"];
          if ((bool) jtoken[(object) "isReadyChanged"])
            groupMember.isCustomLobbyReady = false;
        }
        else
        {
          if ((int) jtoken[(object) "team"] == 1)
            ++team1BotCount;
          if ((int) jtoken[(object) "team"] == 2)
            ++team2BotCount;
        }
      }
      this.UpdateTeamBotCounts(team1BotCount, team2BotCount);
      this.ShowTeamMembersAndTeams();
    }
    else
    {
      this.GetComponent<MenuObject>().ShowMenu(0);
      this.Initialize();
      this.OnGroupCustomMatchLobbyUpdate(lobbyData);
    }
  }

  public void StartCustomMatch()
  {
    if (this.startMatchErrorTxt.text != "")
      this.startMatchErrorTxt.color = Color.red.WithAlpha(1f);
    if (ImiServices.Instance.MatchmakingService.IsMatchmaking() || !ImiServices.Instance.PartyService.IsInGroup() || !ImiServices.Instance.PartyService.IsGroupOwner())
    {
      Log.Warning("You Cannot start a custom Match!");
    }
    else
    {
      List<APartyService.GroupMember> currentGroup = ImiServices.Instance.PartyService.GetCurrentGroup();
      if (currentGroup.Count < 1 || (this.team1BotButtons.Count + this.team2BotButtons.Count + currentGroup.Count) % 2 != 0)
      {
        Log.Warning("You Cannot start a custom Match!");
      }
      else
      {
        List<ulong> alphaPlayerIds = new List<ulong>();
        List<ulong> betaPlayerIds = new List<ulong>();
        bool flag = false;
        foreach (APartyService.GroupMember groupMember in currentGroup)
        {
          if (!groupMember.isCustomLobbyReady)
            flag = true;
          if (groupMember.team == Team.Alpha)
            alphaPlayerIds.Add(groupMember.playerId);
          else if (groupMember.team == Team.Beta)
          {
            betaPlayerIds.Add(groupMember.playerId);
          }
          else
          {
            Log.Warning(string.Format("Player {0} was in Team NONE!", (object) groupMember.playerId));
            return;
          }
        }
        if (alphaPlayerIds.Count + this.team1BotButtons.Count != betaPlayerIds.Count + this.team2BotButtons.Count)
          Log.Warning("Teams are not balanced!");
        else if (flag)
        {
          Log.Warning("A Player was not ready!");
        }
        else
        {
          AIDifficulty result = AIDifficulty.Intermediate;
          if (PlayerPrefs.HasKey(this.botDifficultyPlayerPref))
            Enum.TryParse<AIDifficulty>(PlayerPrefs.GetString(this.botDifficultyPlayerPref), out result);
          this.StoreBotCountPlayerPrefs(this.team1BotButtons.Count, this.team2BotButtons.Count);
          this.startMatchBtn.gameObject.SetActive(false);
          this.startingGameInfo.SetActive(true);
          this.startMatchBtn.interactable = false;
          ImiServices.Instance.MatchmakingService.StartCustomMatch(ImiServices.Instance.LoginService.GetPlayerId(), alphaPlayerIds, betaPlayerIds, this.team1BotButtons.Count, this.team2BotButtons.Count, result, this.allowedArenas[this.arenaDropdown.value], MatchmakingServiceUi.GetCustomMatchMatchmakingRegionFromPlayerPrefs(), AwsPinger.RegionLatencies, (Action<bool>) (error =>
          {
            this.startMatchBtn.gameObject.SetActive(error);
            this.startMatchBtn.interactable = error;
          }));
        }
      }
    }
  }

  [EditorButton]
  private void StartCustomMatchEditor()
  {
    if (ImiServices.Instance.MatchmakingService.IsMatchmaking() || !ImiServices.Instance.PartyService.IsInGroup() || !ImiServices.Instance.PartyService.IsGroupOwner())
      Log.Warning("You Cannot start a custom Match!");
    List<APartyService.GroupMember> currentGroup = ImiServices.Instance.PartyService.GetCurrentGroup();
    List<ulong> alphaPlayerIds = new List<ulong>();
    List<ulong> betaPlayerIds = new List<ulong>();
    bool flag = false;
    foreach (APartyService.GroupMember groupMember in currentGroup)
    {
      if (!groupMember.isCustomLobbyReady)
        flag = true;
      if (groupMember.team == Team.Alpha)
        alphaPlayerIds.Add(groupMember.playerId);
      else if (groupMember.team == Team.Beta)
      {
        betaPlayerIds.Add(groupMember.playerId);
      }
      else
      {
        Log.Warning(string.Format("Player {0} was in Team NONE!", (object) groupMember.playerId));
        return;
      }
    }
    if (alphaPlayerIds.Count != betaPlayerIds.Count)
      Log.Warning("Teams are not balanced!");
    else if (flag)
    {
      Log.Warning("A Player was not ready!");
    }
    else
    {
      this.startMatchBtn.gameObject.SetActive(false);
      this.startingGameInfo.SetActive(false);
      this.startMatchBtn.interactable = false;
      ImiServices.Instance.MatchmakingService.StartCustomMatch(ImiServices.Instance.LoginService.GetPlayerId(), alphaPlayerIds, betaPlayerIds, this.team1BotButtons.Count, this.team2BotButtons.Count, AIDifficulty.Intermediate, this.allowedArenas[this.arenaDropdown.value], MatchmakingServiceUi.GetCustomMatchMatchmakingRegionFromPlayerPrefs(), AwsPinger.RegionLatencies, (Action<bool>) (error =>
      {
        this.startMatchBtn.gameObject.SetActive(error);
        this.startMatchBtn.interactable = error;
      }));
    }
  }

  public void CreateCustomLobbySteamGroup()
  {
    if (!ImiServices.Instance.MatchmakingService.IsMatchmaking())
      this.StartCoroutine(this.CreateCustomLobby());
    else
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@CannotStartCustomMatchDescription", "@confirm", title: "@CannotStartCustomMatchTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
  }

  public void LeaveCustomLobby()
  {
    bool flag1 = false;
    foreach (KeyValuePair<ulong, GroupMemberTeamAssignButton> keyValuePair in this.groupMembersUi)
    {
      if (keyValuePair.Value.isExpanded)
        flag1 = true;
    }
    bool flag2 = false;
    if ((UnityEngine.Object) this.matchmakingDropDown.gameObject.GetComponentInChildren<ScrollRect>() != (UnityEngine.Object) null)
      flag2 = true;
    if ((UnityEngine.Object) this.arenaDropdown.gameObject.GetComponentInChildren<ScrollRect>() != (UnityEngine.Object) null)
      flag2 = true;
    if ((UnityEngine.Object) this.botDifficultyDropdown.gameObject.GetComponentInChildren<ScrollRect>() != (UnityEngine.Object) null)
      flag2 = true;
    if (ImiServices.Instance.PartyService.IsGroupOwner() & flag1)
    {
      this.CollapseAllButtons();
    }
    else
    {
      if (flag2)
        return;
      PopupManager.Instance.ShowPopup(PopupManager.Popup.TwoButtons, (IPopupSettings) new Popup("@LeaveCustomMatchMenuDescription", "@Yes", "@No", title: "@LeaveCustomMatchMenuTitle"), (Action) (() =>
      {
        this.Uninitialize();
        PopupManager.Instance.HidePopup();
      }), (Action) null, (Action) null, (Action) null, (Selectable) null);
    }
  }

  public void ShowInviteDialog()
  {
    if (!ImiServices.Instance.PartyService.IsInGroup())
      return;
    ImiServices.Instance.PartyService.ShowInviteUi();
  }

  private IEnumerator CreateCustomLobby()
  {
    CustomLobbyUi customLobbyUi = this;
    if (!ImiServices.Instance.PartyService.IsInGroup())
    {
      Debug.Log((object) "New Custom Match group was created.");
      ImiServices.Instance.PartyService.CreateGroup(6, ELobbyType.k_ELobbyTypeFriendsOnly);
      customLobbyUi.Initialize();
      yield return (object) new WaitForSecondsRealtime(0.0f);
      customLobbyUi.GetComponent<MenuObject>().ShowMenu(0);
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.leaveSteamGroup);
      customLobbyUi.ShowTeamMembersAndTeams();
    }
    else
    {
      // ISSUE: reference to a compiler-generated method
      PopupManager.Instance.ShowPopup(PopupManager.Popup.TwoButtons, (IPopupSettings) new Popup("@JoinCustomMatchMenuDescription", "@Yes", "@No", title: "@JoinCustomMatchMenuTitle"), new Action(customLobbyUi.\u003CCreateCustomLobby\u003Eb__85_0), (Action) null, (Action) null, (Action) null, (Selectable) null);
      yield return (object) new WaitForSecondsRealtime(0.0f);
    }
  }

  private void ShowTeamMembersAndTeams()
  {
    if (ImiServices.Instance.PartyService.IsGroupOwner())
      this.SetBotButtonsActive(true);
    else
      this.SetBotButtonsActive(false);
    List<APartyService.GroupMember> currentGroup = ImiServices.Instance.PartyService.GetCurrentGroup();
    bool isInteractable = true;
    foreach (APartyService.GroupMember member in currentGroup)
    {
      if (!this.groupMembersUi.ContainsKey(member.playerId))
      {
        Log.Debug("Adding GroupMember To Custom Match:" + (object) member.playerId);
        this.groupMembersUi[member.playerId] = this.CreateGroupMemberUi(member);
      }
      else
        this.UpdateGroupMemberUi(member);
      if (!member.isCustomLobbyReady)
        isInteractable = false;
    }
    this.ChangeStartButton(isInteractable);
    this.ChangeReadyButton();
    this.SetupUiInteractability();
    this.ForceRebuildLayouts();
  }

  private void ForceRebuildLayouts()
  {
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.groupMemberListParent.GetComponent<RectTransform>());
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.alphaGroupMemberListParent.GetComponent<RectTransform>());
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.betaGroupMemberListParent.GetComponent<RectTransform>());
  }

  private void SetupUiInteractability()
  {
    if (ImiServices.Instance.PartyService.IsInGroup() && !ImiServices.Instance.PartyService.IsGroupOwner())
    {
      this.matchmakingDropDown.interactable = false;
      this.arenaDropdown.interactable = false;
      this.botDifficultyDropdown.interactable = false;
    }
    else
    {
      this.matchmakingDropDown.interactable = true;
      this.arenaDropdown.interactable = true;
      this.botDifficultyDropdown.interactable = true;
    }
    foreach (KeyValuePair<ulong, GroupMemberTeamAssignButton> keyValuePair in this.groupMembersUi)
      keyValuePair.Value.SetupUiInteractabilityAndStyle();
  }

  private void ChangeStartButton(bool isInteractable)
  {
    TextMeshProUGUI componentInChildren = this.startMatchBtn.GetComponentInChildren<TextMeshProUGUI>();
    this.startMatchErrorTxt.text = "";
    this.startMatchErrorTxt.color = Color.white.WithAlpha(1f);
    this.startingGameInfo.SetActive(false);
    if (ImiServices.Instance.PartyService.IsGroupOwner())
    {
      this.startMatchBtn.gameObject.SetActive(true);
      if (isInteractable)
      {
        this.startMatchErrorTxt.text = "";
        this.startMatchBtn.interactable = true;
        SpriteState spriteState = this.startMatchBtn.spriteState;
        spriteState.highlightedSprite = this.startMatchBtn_readyHighlighted;
        this.startMatchBtn.image.sprite = this.startMatchBtn_ready;
        this.startMatchBtn.spriteState = spriteState;
        componentInChildren.color = Color.black;
      }
      else
      {
        TextMeshProUGUI startMatchErrorTxt = this.startMatchErrorTxt;
        startMatchErrorTxt.text = startMatchErrorTxt.text + ImiServices.Instance.LocaService.GetLocalizedValue("@InvalidNotReady") + "\n";
        componentInChildren.color = Color.black;
        SpriteState spriteState = this.startMatchBtn.spriteState;
        spriteState.highlightedSprite = this.startMatchBtn_notReadyHighlighted;
        this.startMatchBtn.image.sprite = this.startMatchBtn_notReady;
        this.startMatchBtn.spriteState = spriteState;
      }
      List<APartyService.GroupMember> currentGroup = ImiServices.Instance.PartyService.GetCurrentGroup();
      if (currentGroup.Count < 1 || currentGroup.Count > 6 || currentGroup.Count % 2 != 0)
        componentInChildren.color = Color.black;
      List<ulong> ulongList1 = new List<ulong>();
      List<ulong> ulongList2 = new List<ulong>();
      bool flag = false;
      foreach (APartyService.GroupMember groupMember in currentGroup)
      {
        if (groupMember.team == Team.Alpha)
          ulongList1.Add(groupMember.playerId);
        else if (groupMember.team == Team.Beta)
        {
          ulongList2.Add(groupMember.playerId);
        }
        else
        {
          flag = true;
          componentInChildren.color = Color.black;
        }
      }
      if (flag)
      {
        TextMeshProUGUI startMatchErrorTxt = this.startMatchErrorTxt;
        startMatchErrorTxt.text = startMatchErrorTxt.text + ImiServices.Instance.LocaService.GetLocalizedValue("@InvalidNoTeam") + "\n";
      }
      if (ulongList1.Count + this.team1BotButtons.Count == ulongList2.Count + this.team2BotButtons.Count)
        return;
      TextMeshProUGUI startMatchErrorTxt1 = this.startMatchErrorTxt;
      startMatchErrorTxt1.text = startMatchErrorTxt1.text + ImiServices.Instance.LocaService.GetLocalizedValue("@InvalidUnevenTeams") + "\n";
      componentInChildren.color = Color.black;
    }
    else
    {
      this.startMatchErrorTxt.text = "";
      this.startMatchBtn.gameObject.SetActive(false);
    }
  }

  private void ChangeReadyButton()
  {
    if (!ImiServices.Instance.PartyService.IsInGroup())
      return;
    if (ImiServices.Instance.PartyService.IsGroupOwner())
      this.isReadyBtn.gameObject.SetActive(false);
    else
      this.SetReadyButtonStyle();
  }

  private void SetReadyButtonStyle()
  {
    APartyService.GroupMember groupMember = ImiServices.Instance.PartyService.GetGroupMember(ImiServices.Instance.LoginService.GetPlayerId());
    TextMeshProUGUI componentInChildren = this.isReadyBtn.GetComponentInChildren<TextMeshProUGUI>();
    if (groupMember.isCustomLobbyReady)
    {
      this.isReadyBtn.gameObject.SetActive(true);
      componentInChildren.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
      componentInChildren.text = ImiServices.Instance.LocaService.GetLocalizedValue("@YouAreReady");
      SpriteState spriteState = this.isReadyBtn.spriteState;
      spriteState.highlightedSprite = this.isReadyHighlightedSprite;
      this.isReadyBtn.image.sprite = this.isReadySprite;
      this.isReadyBtn.spriteState = spriteState;
    }
    else
    {
      componentInChildren.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
      componentInChildren.text = ImiServices.Instance.LocaService.GetLocalizedValue("@NotReady");
      SpriteState spriteState = this.isReadyBtn.spriteState;
      spriteState.highlightedSprite = this.isNotReadHighlightedSprite;
      this.isReadyBtn.image.sprite = this.isNotReadySprite;
      this.isReadyBtn.spriteState = spriteState;
      if (groupMember.team != Team.None)
      {
        this.isReadyBtn.gameObject.SetActive(true);
        this.isReadyBtn.interactable = true;
        componentInChildren.color = Color.black;
      }
      else
      {
        this.isReadyBtn.gameObject.SetActive(true);
        this.isReadyBtn.interactable = false;
        componentInChildren.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor.WithAlpha(0.3f);
      }
    }
  }

  private GroupMemberTeamAssignButton CreateGroupMemberUi(
    APartyService.GroupMember member)
  {
    GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.groupMemberPrefab);
    gameObject.name = member.username;
    GroupMemberTeamAssignButton component = gameObject.GetComponent<GroupMemberTeamAssignButton>();
    APartyService.GroupMember groupMember = ImiServices.Instance.PartyService.GetGroupMember(member.playerId);
    component.SetGroupMember(groupMember);
    component.SetVoiceChatMuteButtonPlayerId(member.playerId);
    if (groupMember.team == Team.Alpha)
      gameObject.transform.SetParent(this.alphaGroupMemberListParent.transform, false);
    else if (groupMember.team == Team.Beta)
      gameObject.transform.SetParent(this.betaGroupMemberListParent.transform, false);
    else
      gameObject.transform.SetParent(this.groupMemberListParent.transform, false);
    component.SetupListeners(new Action<ulong>(this.SendUpdateCustomLobbyUiMessage), this.alphaGroupMemberListParent, this.betaGroupMemberListParent, this.groupMemberListParent);
    component.SetButtons();
    component.SetCustomLobbyReady(member.isCustomLobbyReady);
    return component;
  }

  private void UpdateGroupMemberUi(APartyService.GroupMember member)
  {
    GroupMemberTeamAssignButton teamAssignButton = (GroupMemberTeamAssignButton) null;
    if (!this.groupMembersUi.TryGetValue(member.playerId, out teamAssignButton))
      return;
    if (teamAssignButton.GetGroupMember().team == Team.Alpha)
      teamAssignButton.gameObject.transform.SetParent(this.alphaGroupMemberListParent.transform, false);
    else if (teamAssignButton.GetGroupMember().team == Team.Beta)
      teamAssignButton.gameObject.transform.SetParent(this.betaGroupMemberListParent.transform, false);
    else
      teamAssignButton.gameObject.transform.SetParent(this.groupMemberListParent.transform, false);
    teamAssignButton.SetCustomLobbyReady(member.isCustomLobbyReady);
  }

  private void RemoveGroupMemberUi(ulong playerId)
  {
    GroupMemberTeamAssignButton teamAssignButton = (GroupMemberTeamAssignButton) null;
    if (!this.groupMembersUi.TryGetValue(playerId, out teamAssignButton))
      return;
    this.groupMembersUi.Remove(playerId);
    UnityEngine.Object.Destroy((UnityEngine.Object) teamAssignButton.gameObject);
  }

  public void ClearGroupList()
  {
    Log.Debug("Clearing Custom Lobby Lists");
    for (int index = 0; index < this.groupMemberListParent.transform.childCount; ++index)
      UnityEngine.Object.Destroy((UnityEngine.Object) this.groupMemberListParent.transform.GetChild(index).gameObject);
    for (int index = 0; index < this.alphaGroupMemberListParent.transform.childCount; ++index)
      UnityEngine.Object.Destroy((UnityEngine.Object) this.alphaGroupMemberListParent.transform.GetChild(index).gameObject);
    for (int index = 0; index < this.betaGroupMemberListParent.transform.childCount; ++index)
      UnityEngine.Object.Destroy((UnityEngine.Object) this.betaGroupMemberListParent.transform.GetChild(index).gameObject);
  }

  public delegate void OnLocalPlayerJoinedCustomLobbyEventHandler(CSteamID partyID);
}
