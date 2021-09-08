// Decompiled with JetBrains decompiler
// Type: GroupMemberTeamAssignButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using SteelCircus.UI.Menu;
using System;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class GroupMemberTeamAssignButton : 
  MonoBehaviour,
  ISelectHandler,
  IEventSystemHandler,
  IDeselectHandler,
  IPointerEnterHandler,
  IPointerExitHandler
{
  [Header("Buttons")]
  [SerializeField]
  private Button joinRightBtn;
  [SerializeField]
  private Button joinLeftBtn;
  [SerializeField]
  private Button extendUiBtn;
  [SerializeField]
  private Button mutePlayerButton;
  [SerializeField]
  private Button kickBtn;
  [SerializeField]
  private Button makeGroupLeaderButton;
  [Header("UI Elements")]
  [SerializeField]
  private GameObject buttonParentLayoutObject;
  [SerializeField]
  private GameObject extendedUi;
  [SerializeField]
  private GameObject groupLeaderIcon;
  [SerializeField]
  private GameObject isReadyIcon;
  [SerializeField]
  private TextMeshProUGUI usernameTxt;
  [SerializeField]
  private TextMeshProUGUI levelTxt;
  [SerializeField]
  private Image selectedBG;
  [SerializeField]
  private Image leftArrowsImage;
  [SerializeField]
  private Image rightArrowsImage;
  [SerializeField]
  private Image rightTriggerImage;
  [SerializeField]
  private Image leftTriggerImage;
  [SerializeField]
  private Image foloutImage;
  [SerializeField]
  private Image foloutShortcutImage;
  [SerializeField]
  private GameObject borderObject;
  [Space(10f)]
  [SerializeField]
  private APartyService.GroupMember groupMember;
  [SerializeField]
  private SwitchAvatarIcon avatar;
  private Transform noneGroupMemberListParent;
  private Transform alphaGroupMemberListParent;
  private Transform betaGroupMemberListParent;
  private Action<ulong> updateLobbyDelegate;
  public bool isExpanded;

  private void Start()
  {
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatEntered += new VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler(this.UpdateMuteButtonVisibility);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatLeft += new VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler(this.UpdateMuteButtonVisibility);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatLeft += new VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler(this.UpdateMuteButtonVisibility);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatEntered += new VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler(this.UpdateMuteButtonVisibility);
    this.kickBtn.onClick.AddListener((UnityAction) (() =>
    {
      if (!ImiServices.Instance.PartyService.IsGroupOwner())
        return;
      Log.Debug("Kicking Player: " + (object) this.groupMember.playerId);
      ImiServices.Instance.PartyService.NotifyGroupKickPlayer(this.groupMember.playerId);
    }));
    this.makeGroupLeaderButton.onClick.AddListener((UnityAction) (() =>
    {
      if (!ImiServices.Instance.PartyService.IsGroupOwner())
        return;
      ImiServices.Instance.PartyService.SetLobbyOwner(this.groupMember.steamId);
      this.ExpandUi(false);
      Log.Debug("Making Player GroupLeader: " + (object) this.groupMember.playerId);
    }));
    this.extendUiBtn.onClick.AddListener((UnityAction) (() =>
    {
      if (!ImiServices.Instance.PartyService.IsGroupOwner())
        return;
      this.ExpandUi();
    }));
    ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.ControllerChangedDelegate);
    this.ControllerChangedDelegate(ImiServices.Instance.InputService.GetLastInputSource());
    this.UpdateMuteButtonVisibility();
    this.SetUiDeselected();
    if (!(this.groupMember.level == "?") || (long) this.groupMember.playerId != (long) ImiServices.Instance.LoginService.GetPlayerId())
      return;
    this.levelTxt.text = string.Format("lvl {0}", (object) ImiServices.Instance.progressManager.GetPlayerLevel());
  }

  public void SetGroupMember(APartyService.GroupMember member)
  {
    this.groupMember = member;
    this.avatar.SetPlayerID(this.groupMember.playerId);
    this.avatar.CheckForAvatarIcon();
  }

  public APartyService.GroupMember GetGroupMember() => this.groupMember;

  private void OnDestroy() => ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.ControllerChangedDelegate);

  private void UpdateMuteButtonVisibility(ulong playerID)
  {
    if ((long) playerID != (long) this.groupMember.playerId)
      return;
    this.UpdateMuteButtonVisibility();
  }

  private void UpdateMuteButtonVisibility(string lobbyName) => this.UpdateMuteButtonVisibility();

  private void UpdateMuteButtonVisibility()
  {
    if ((UnityEngine.Object) this.mutePlayerButton == (UnityEngine.Object) null || (UnityEngine.Object) this.mutePlayerButton.gameObject == (UnityEngine.Object) null)
      return;
    if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel() && ImiServices.Instance.VoiceChatService.GetParticipant(this.groupMember.playerId) != null && ((UnityEngine.Object) EventSystem.current.currentSelectedGameObject == (UnityEngine.Object) this.gameObject || this.selectedBG.enabled))
      this.mutePlayerButton.gameObject.SetActive(true);
    else
      this.mutePlayerButton.gameObject.SetActive(false);
  }

  public void SetVoiceChatMuteButtonPlayerId(ulong playerId) => this.mutePlayerButton.GetComponent<VoiceChatMuteButton>().SetPlayerID(playerId);

  private void ScaleToContent()
  {
    if (this.isExpanded)
      this.GetComponent<RectTransform>().sizeDelta = new Vector2(this.GetComponent<RectTransform>().sizeDelta.x, 126f);
    else
      this.GetComponent<RectTransform>().sizeDelta = new Vector2(this.GetComponent<RectTransform>().sizeDelta.x, 65f);
  }

  public void SetPlayerMuted() => ImiServices.Instance.VoiceChatService.ToggleUserMute(this.groupMember.playerId.ToString());

  private void ControllerChangedDelegate(InputSource inputSource)
  {
    if (inputSource != InputSource.Keyboard)
    {
      if (inputSource == InputSource.Mouse)
      {
        this.leftTriggerImage.gameObject.SetActive(false);
        this.rightTriggerImage.gameObject.SetActive(false);
        this.foloutShortcutImage.gameObject.SetActive(false);
        this.foloutImage.gameObject.SetActive(true);
      }
      else
      {
        if (this.isExpanded && ImiServices.Instance.InputService.GetLastInputSource() != InputSource.Mouse)
        {
          EventSystem.current.currentSelectedGameObject.GetComponent<Selectable>().OnDeselect((BaseEventData) null);
          this.makeGroupLeaderButton.Select();
          this.makeGroupLeaderButton.OnSelect((BaseEventData) null);
        }
        this.leftTriggerImage.gameObject.SetActive(true);
        this.rightTriggerImage.gameObject.SetActive(true);
        this.foloutShortcutImage.gameObject.SetActive(true);
        this.foloutImage.gameObject.SetActive(false);
      }
    }
    else
    {
      this.leftTriggerImage.gameObject.SetActive(false);
      this.rightTriggerImage.gameObject.SetActive(false);
      this.foloutShortcutImage.gameObject.SetActive(false);
      this.foloutImage.gameObject.SetActive(true);
    }
  }

  public void ExpandUi() => this.ExpandUi(!this.extendedUi.activeInHierarchy);

  public void ExpandUi(bool expand)
  {
    if (expand && (long) ImiServices.Instance.PartyService.GetGroupOwner() == (long) this.groupMember.playerId)
      return;
    this.isExpanded = expand;
    Log.Debug("Toggle ExtendeUi: " + (object) this.groupMember.playerId + " " + this.isExpanded.ToString());
    this.extendedUi.SetActive(this.isExpanded);
    this.ScaleToContent();
    if (this.isExpanded)
    {
      this.borderObject.SetActive(true);
      if (ImiServices.Instance.InputService.GetLastInputSource() != InputSource.Mouse)
      {
        if ((UnityEngine.Object) EventSystem.current.currentSelectedGameObject != (UnityEngine.Object) null)
          EventSystem.current.currentSelectedGameObject.GetComponent<Selectable>().OnDeselect((BaseEventData) null);
        this.makeGroupLeaderButton.Select();
        this.makeGroupLeaderButton.OnSelect((BaseEventData) null);
      }
    }
    else if (ImiServices.Instance.InputService.GetLastInputSource() != InputSource.Mouse)
    {
      if ((UnityEngine.Object) EventSystem.current.currentSelectedGameObject != (UnityEngine.Object) null)
        EventSystem.current.currentSelectedGameObject.GetComponent<Selectable>().OnDeselect((BaseEventData) null);
      this.GetComponent<Selectable>().Select();
      this.GetComponent<Selectable>().OnSelect((BaseEventData) null);
    }
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.noneGroupMemberListParent.GetComponent<RectTransform>());
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.alphaGroupMemberListParent.GetComponent<RectTransform>());
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.betaGroupMemberListParent.GetComponent<RectTransform>());
  }

  public void SetupListeners(
    Action<ulong> updateLobbyDelegate,
    Transform alphaParent,
    Transform betaParent,
    Transform noneParent)
  {
    this.alphaGroupMemberListParent = alphaParent;
    this.betaGroupMemberListParent = betaParent;
    this.noneGroupMemberListParent = noneParent;
    this.updateLobbyDelegate = updateLobbyDelegate;
    this.joinRightBtn.onClick.AddListener((UnityAction) (() => this.SetTeamForGroupMember(true)));
    this.joinLeftBtn.onClick.AddListener((UnityAction) (() => this.SetTeamForGroupMember(false)));
  }

  public void SetTeamForGroupMember(bool isRightJoinButton)
  {
    Team teamShift = this.GetTeamShift(isRightJoinButton);
    if (!ImiServices.Instance.PartyService.IsGroupOwner())
      return;
    this.SetJoinTeamButtonStyle(teamShift);
    Log.Debug("Assigning Team: " + (object) teamShift);
    this.groupMember.team = teamShift;
    Action<ulong> updateLobbyDelegate = this.updateLobbyDelegate;
    if (updateLobbyDelegate == null)
      return;
    updateLobbyDelegate(this.groupMember.playerId);
  }

  private void SetJoinTeamButtonStyle(Team team)
  {
    switch (team)
    {
      case Team.None:
        this.transform.SetParent(this.noneGroupMemberListParent);
        this.rightArrowsImage.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(Team.Beta);
        this.leftArrowsImage.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(Team.Alpha);
        break;
      case Team.Alpha:
        this.transform.SetParent(this.alphaGroupMemberListParent);
        this.rightArrowsImage.color = Color.white;
        this.leftArrowsImage.color = Color.gray;
        break;
      case Team.Beta:
        this.transform.SetParent(this.betaGroupMemberListParent);
        this.rightArrowsImage.color = Color.gray;
        this.leftArrowsImage.color = Color.white;
        break;
    }
  }

  public void SetButtons()
  {
    this.joinRightBtn.gameObject.SetActive(this.groupMember.team != Team.Alpha);
    this.joinLeftBtn.gameObject.SetActive(this.groupMember.team != Team.Beta);
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.buttonParentLayoutObject.GetComponent<RectTransform>());
  }

  public void SetupUiInteractabilityAndStyle()
  {
    bool flag = ImiServices.Instance.PartyService.IsGroupOwner();
    Log.Debug(string.Format("SetupUiInteractabilityAndStyle: {0} - {1} leader = {2}", (object) this.groupMember.playerId, (object) this.groupMember.team, (object) flag));
    this.usernameTxt.text = this.groupMember.username ?? "";
    this.levelTxt.text = "lvl " + this.groupMember.level;
    this.SetCustomLobbyReady(this.groupMember.isCustomLobbyReady);
    if ((long) this.groupMember.playerId == (long) ImiServices.Instance.PartyService.GetGroupOwner())
    {
      this.groupLeaderIcon.SetActive(true);
      this.usernameTxt.color = Color.yellow;
    }
    else
    {
      this.groupLeaderIcon.SetActive(false);
      if (this.groupMember.isCustomLobbyReady)
        this.usernameTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
      else
        this.usernameTxt.color = Color.white;
    }
    if (flag)
      this.extendUiBtn.gameObject.SetActive(false);
    this.kickBtn.gameObject.SetActive(flag);
    this.makeGroupLeaderButton.gameObject.SetActive(flag);
    this.SetJoinTeamButtonStyle(this.groupMember.team);
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.noneGroupMemberListParent.GetComponent<RectTransform>());
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.buttonParentLayoutObject.GetComponent<RectTransform>());
  }

  public void SetCustomLobbyReady(bool isReady)
  {
    Log.Debug(string.Format("Player {0} is Custom Lobby ready: {1}", (object) this.groupMember.playerId, (object) isReady));
    if ((long) ImiServices.Instance.PartyService.GetGroupOwner() == (long) this.groupMember.playerId)
    {
      this.isReadyIcon.SetActive(false);
    }
    else
    {
      if (isReady)
        this.usernameTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
      else
        this.usernameTxt.color = Color.white;
      this.isReadyIcon.SetActive(isReady);
    }
  }

  private Team GetTeamShift(bool isRightJoinButton) => this.groupMember.team == Team.None ? (!isRightJoinButton ? Team.Alpha : Team.Beta) : (this.groupMember.team == Team.Alpha ? (!isRightJoinButton ? Team.Alpha : Team.None) : (this.groupMember.team == Team.Beta && isRightJoinButton ? Team.Beta : Team.None));

  public void OnSelect(BaseEventData eventData) => this.SetUiSelected();

  private void SetUiSelected()
  {
    this.selectedBG.enabled = true;
    this.borderObject.SetActive(true);
    this.UpdateMuteButtonVisibility();
    if (ImiServices.Instance.PartyService.IsGroupOwner())
    {
      if ((long) this.groupMember.playerId != (long) ImiServices.Instance.LoginService.GetPlayerId())
        this.extendUiBtn.gameObject.SetActive(true);
      this.joinRightBtn.gameObject.SetActive(true);
      this.joinLeftBtn.gameObject.SetActive(true);
    }
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.buttonParentLayoutObject.GetComponent<RectTransform>());
  }

  public void OnDeselect(BaseEventData eventData) => this.SetUiDeselected();

  private void SetUiDeselected()
  {
    if (!this.isExpanded)
      this.borderObject.SetActive(false);
    this.selectedBG.enabled = false;
    this.extendUiBtn.gameObject.SetActive(false);
    this.joinRightBtn.gameObject.SetActive(false);
    this.joinLeftBtn.gameObject.SetActive(false);
    this.mutePlayerButton.gameObject.SetActive(false);
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.buttonParentLayoutObject.GetComponent<RectTransform>());
  }

  public void OnPointerEnter(PointerEventData eventData) => this.SetUiSelected();

  public void OnPointerExit(PointerEventData eventData) => this.SetUiDeselected();
}
