// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.GroupUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using Steamworks;
using SteelCircus.Core.Services;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
  public class GroupUi : MonoBehaviour
  {
    public GameObject buttonPromptObject;
    [Header("Own Player")]
    [SerializeField]
    public Text ownPlayerName;
    [SerializeField]
    private TextMeshProUGUI ownPlayerLevel;
    [SerializeField]
    public GameObject ownContainer;
    [SerializeField]
    public GameObject ownGroupLeaderIcon;
    [SerializeField]
    private GameObject container;
    [SerializeField]
    private GameObject leaveBtn;
    [SerializeField]
    private GameObject inviteBtn;
    [SerializeField]
    public GroupUi.GroupUiObject[] groupContainers;
    private IEnumerator notifyCoRoutine;

    private void OnEnable()
    {
      ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);
      ImiServices.Instance.PartyService.OnGroupEntered += new APartyService.OnGroupEnteredEventHandler(this.OnGroupEntered);
      ImiServices.Instance.PartyService.OnGroupMemberJoined += new APartyService.OnGroupMemberJoinedEventHandler(this.OnGroupMemberJoined);
      ImiServices.Instance.PartyService.OnGroupMemberLeft += new APartyService.OnGroupMemberLeftEventHandler(this.OnGroupMemberLeft);
      ImiServices.Instance.PartyService.OnGroupLeft += new APartyService.OnGroupLeftEventHandler(this.OnGroupLeft);
      ImiServices.Instance.PartyService.OnGroupMatchmakingStarted += new APartyService.OnGroupMatchmakingStartedEventHandler(this.OnGroupMatchmakingStarted);
      ImiServices.Instance.PartyService.OnGroupMatchmakingCanceled += new APartyService.OnGroupMatchmakingCanceledEventHandler(this.OnGroupMatchmakingCanceled);
      ImiServices.Instance.PartyService.OnCustomLobbyEntered += new APartyService.OnCustomLobbyEnteredEventHandler(this.OnCustomLobbyEntered);
      ImiServices.Instance.PartyService.OnCustomLobbyLeft += new APartyService.OnCustomLobbyLeftEventHandler(this.OnCustomLobbyLeft);
      ImiServices.Instance.MatchmakingService.OnMatchmakingStarted += new AMatchmakingService.OnMatchmakingStartedEventHandler(this.OnMatchmakingStartet);
      ImiServices.Instance.MatchmakingService.OnMatchmakingCancelled += new AMatchmakingService.OnMatchmakingCanceledEventHandler(this.OnMatchMakingCancelled);
      ImiServices.Instance.MatchmakingService.OnMatchmakingSuccessful += new AMatchmakingService.OnMatchmakingSuccessfulEventHandler(this.OnMatchmakingSuccessful);
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen += new LoadingScreenService.OnShowLoadingScreenEventHandler(this.OnShowLoadingScreen);
      ImiServices.Instance.progressManager.OnPlayerLevelUpdated += new ProgressManager.OnPlayerLevelUpdatedHandler(this.OnPlayerLevelUpdated);
      if (!ImiServices.Instance.LoginService.IsLoginOk())
        return;
      this.ownPlayerName.text = ImiServices.Instance.LoginService.GetUsername();
      this.ownContainer.SetActive(true);
      this.OnPlayerLevelUpdated(ImiServices.Instance.LoginService.GetPlayerId(), ImiServices.Instance.progressManager.GetPlayerLevel());
    }

    private void OnCustomLobbyEntered()
    {
      Log.Debug("Enter Custom Lobby");
      this.SetLobbyUi();
    }

    private void OnCustomLobbyLeft()
    {
      Log.Debug("Left Custom Lobby");
      this.SetLobbyUi();
    }

    private void OnPlayerLevelUpdated(ulong playerId, int level)
    {
      if ((long) playerId == (long) ImiServices.Instance.LoginService.GetPlayerId())
      {
        this.ownPlayerLevel.text = level.ToString();
      }
      else
      {
        foreach (GroupUi.GroupUiObject groupContainer in this.groupContainers)
        {
          if ((long) groupContainer.userId == (long) playerId)
            groupContainer.userlevel.text = level.ToString();
        }
      }
      if ((long) ImiServices.Instance.LoginService.GetPlayerId() == (long) playerId)
        return;
      ImiServices.Instance.PartyService.GetGroupMember(playerId).level = level.ToString();
    }

    private void OnMatchmakingSuccessful(ConnectionInfo connectioninfo)
    {
      if (this.notifyCoRoutine == null)
        return;
      this.StopCoroutine(this.notifyCoRoutine);
      this.notifyCoRoutine = (IEnumerator) null;
    }

    private void Start()
    {
      Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
      if (!ImiServices.Instance.PartyService.IsInGroup())
        return;
      this.SetLobbyUi();
    }

    private void Update()
    {
      if (this.ShouldShowInviteButton())
        this.inviteBtn.SetActive(true);
      else
        this.inviteBtn.SetActive(false);
      if (!this.inviteBtn.activeInHierarchy || !ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UIPrevious))
        return;
      this.OnButtonShowInviteDialog();
    }

    private void OnDisable()
    {
      ImiServices.Instance.OnMetaLoginSuccessful -= new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);
      ImiServices.Instance.PartyService.OnGroupEntered -= new APartyService.OnGroupEnteredEventHandler(this.OnGroupEntered);
      ImiServices.Instance.PartyService.OnGroupMemberJoined -= new APartyService.OnGroupMemberJoinedEventHandler(this.OnGroupMemberJoined);
      ImiServices.Instance.PartyService.OnGroupMemberLeft -= new APartyService.OnGroupMemberLeftEventHandler(this.OnGroupMemberLeft);
      ImiServices.Instance.PartyService.OnGroupLeft -= new APartyService.OnGroupLeftEventHandler(this.OnGroupLeft);
      ImiServices.Instance.PartyService.OnGroupMatchmakingStarted -= new APartyService.OnGroupMatchmakingStartedEventHandler(this.OnGroupMatchmakingStarted);
      ImiServices.Instance.PartyService.OnGroupMatchmakingCanceled -= new APartyService.OnGroupMatchmakingCanceledEventHandler(this.OnGroupMatchmakingCanceled);
      ImiServices.Instance.PartyService.OnCustomLobbyEntered -= new APartyService.OnCustomLobbyEnteredEventHandler(this.OnCustomLobbyEntered);
      ImiServices.Instance.PartyService.OnCustomLobbyLeft -= new APartyService.OnCustomLobbyLeftEventHandler(this.OnCustomLobbyLeft);
      ImiServices.Instance.MatchmakingService.OnMatchmakingStarted -= new AMatchmakingService.OnMatchmakingStartedEventHandler(this.OnMatchmakingStartet);
      ImiServices.Instance.MatchmakingService.OnMatchmakingCancelled -= new AMatchmakingService.OnMatchmakingCanceledEventHandler(this.OnMatchMakingCancelled);
      ImiServices.Instance.MatchmakingService.OnMatchmakingSuccessful -= new AMatchmakingService.OnMatchmakingSuccessfulEventHandler(this.OnMatchmakingSuccessful);
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen -= new LoadingScreenService.OnShowLoadingScreenEventHandler(this.OnShowLoadingScreen);
      ImiServices.Instance.progressManager.OnPlayerLevelUpdated -= new ProgressManager.OnPlayerLevelUpdatedHandler(this.OnPlayerLevelUpdated);
    }

    private void OnShowLoadingScreen(LoadingScreenService.LoadingScreenIntent intent)
    {
      this.container.SetActive(false);
      this.ownContainer.SetActive(false);
      foreach (GroupUi.GroupUiObject groupContainer in this.groupContainers)
        groupContainer.groupContainer.SetActive(false);
    }

    private void OnMatchMakingCancelled()
    {
      if (this.notifyCoRoutine == null)
        return;
      this.StopCoroutine(this.notifyCoRoutine);
      this.notifyCoRoutine = (IEnumerator) null;
    }

    private void OnGroupMatchmakingStarted(string gameliftkey, string matchmakerRegion) => Log.Debug("Group matchmaking has started. we should already poll..");

    private void OnGroupMatchmakingCanceled(string gameliftkey, string matchmakerRegion)
    {
      Log.Debug("Group matchmaking was canceled");
      if (!ImiServices.Instance.PartyService.IsInGroup())
        return;
      ImiServices.Instance.MatchmakingService.OnGroupMatchmakingCancelReceived();
    }

    private void OnMatchmakingStartet(string gameliftkey, string matchmakerRegion)
    {
      Log.Api("Matchmaking started.");
      if (this.notifyCoRoutine != null)
      {
        this.StopCoroutine(this.notifyCoRoutine);
        this.notifyCoRoutine = (IEnumerator) null;
      }
      this.notifyCoRoutine = this.NotifyOverTime(gameliftkey, matchmakerRegion);
      this.StartCoroutine(this.notifyCoRoutine);
    }

    private IEnumerator NotifyOverTime(string gameliftkey, string matchmakerRegion)
    {
      for (int i = 0; i < 3 && ImiServices.Instance.MatchmakingService.IsMatchmaking(); ++i)
      {
        ImiServices.Instance.PartyService.NotifyGroupMatchmaking(gameliftkey, matchmakerRegion);
        yield return (object) new WaitForSecondsRealtime(3f);
      }
      this.notifyCoRoutine = (IEnumerator) null;
      yield return (object) null;
    }

    private void OnGroupMemberLeft(APartyService.GroupMember groupMember)
    {
      this.CancelMatchmakingIfActive();
      Log.Api(string.Format("UI - A group member left {0} {1}.", (object) groupMember.username, (object) groupMember.playerId));
      this.SetLobbyUi();
    }

    private void OnGroupLeft()
    {
      this.CancelMatchmakingIfActive();
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@YouLeftTheGroupPopupDescription", "OK", title: "@YouLeftTheGroupPopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
      this.SetLobbyUi();
    }

    private void OnMetaLoginSuccessful(ulong playerid)
    {
      this.ownPlayerName.text = ImiServices.Instance.LoginService.GetUsername();
      this.ownContainer.SetActive(true);
      ImiServices.Instance.progressManager.FetchPlayerProgress();
    }

    private void OnGroupMemberJoined(APartyService.GroupMember groupMember)
    {
      this.CancelMatchmakingIfActive();
      this.StartCoroutine(MetaServiceHelpers.GetPlayerLoadouts(new ulong[1]
      {
        groupMember.playerId
      }, new Action<JObject>(this.ParseGroupMemberUserAvatar)));
      Log.Api(string.Format("UI - A group member joined {0} {1}.", (object) groupMember.username, (object) groupMember.playerId));
      this.SetLobbyUi();
    }

    private void ParseGroupMemberUserAvatar(JObject obj)
    {
      if (obj["error"] == null && obj["msg"] == null && obj["results"] != null)
      {
        using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>) obj["results"]).GetEnumerator())
        {
          if (!enumerator.MoveNext())
            return;
          JToken current = enumerator.Current;
          ulong num = ulong.Parse(current.ToObject<JProperty>().Name);
          ItemDefinition itemDefinition = (ItemDefinition) null;
          foreach (JToken jtoken in (IEnumerable<JToken>) current.First)
          {
            if ((int) jtoken[(object) "champion"] == -1)
              itemDefinition = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID((int) jtoken[(object) "avatarIcon"]);
          }
          if (itemDefinition == null)
          {
            Log.Error("No Avatar found for player " + (object) num);
            this.SetDefaultAvatarForPlayer(num);
          }
          else
          {
            ImiServices.Instance.progressManager.OnEquipPlayerAvatar(num, itemDefinition.definitionId);
            ImiServices.Instance.PartyService.SetAvatarItemId(num, itemDefinition.definitionId);
          }
        }
      }
      else
        Log.Error("Error parsing player Loadout " + (object) obj);
    }

    private void SetDefaultAvatarForPlayer(ulong playerId) => ImiServices.Instance.progressManager.OnEquipPlayerAvatar(playerId, SingletonScriptableObject<ItemsConfig>.Instance.GetItemsByType(ShopManager.ShopItemType.avatarIcon)[0].definitionId);

    private void SetLobbyUi()
    {
      List<APartyService.GroupMember> groupMembers = ImiServices.Instance.PartyService.GetCurrentGroup();
      Log.Api(string.Format("Set Lobby is called for {0} players.", (object) groupMembers.Count));
      foreach (GroupUi.GroupUiObject groupContainer in this.groupContainers)
        groupContainer.groupContainer.SetActive(false);
      ulong groupOwner = ImiServices.Instance.PartyService.GetGroupOwner();
      int index = 0;
      foreach (APartyService.GroupMember groupMember in groupMembers)
      {
        Log.Api(string.Format("Groupmember {0} {1}", (object) groupMember.playerId, (object) groupMember.username));
        if (index < this.groupContainers.Length)
        {
          if ((long) groupMember.playerId == (long) ImiServices.Instance.LoginService.GetPlayerId())
          {
            ImiServices.Instance.progressManager.FetchPlayerProgress();
            this.ownPlayerName.text = ImiServices.Instance.LoginService.GetUsername();
            this.ownContainer.SetActive(true);
            if (ImiServices.Instance.PartyService.IsInGroup() && ImiServices.Instance.PartyService.IsGroupOwner())
              this.ownGroupLeaderIcon.SetActive(true);
            else
              this.ownGroupLeaderIcon.SetActive(false);
          }
          else
          {
            this.groupContainers[index].username.text = groupMember.username;
            this.groupContainers[index].userId = groupMember.playerId;
            this.groupContainers[index].groupContainer.SetActive(true);
            if ((UnityEngine.Object) this.groupContainers[index].avatarObject != (UnityEngine.Object) null)
              this.groupContainers[index].avatarObject.SetPlayerID(groupMember.playerId);
            if (ImiServices.Instance.PartyService.IsInGroup() && (long) this.groupContainers[index].userId == (long) groupOwner)
              this.groupContainers[index].groupLeaderIcon.SetActive(true);
            else
              this.groupContainers[index].groupLeaderIcon.SetActive(false);
            ++index;
          }
        }
        else
          break;
      }
      SingletonManager<MetaServiceHelpers>.Instance.GetPlayerLevelsCoroutine(groupMembers.Select<APartyService.GroupMember, ulong>((Func<APartyService.GroupMember, ulong>) (x => x.playerId)).ToArray<ulong>(), (Action<JObject>) (jObj =>
      {
        if (jObj == null)
          Log.Error("Could not fetch Steam GroupMember's Levels.");
        else if (jObj["error"] != null)
        {
          Log.Error("Could not fetch Steam GroupMember's Levels. Error: " + jObj["error"].ToString());
        }
        else
        {
          foreach (APartyService.GroupMember groupMember in groupMembers)
          {
            if (jObj[groupMember.playerId.ToString()] != null)
            {
              int level = int.Parse(jObj[groupMember.playerId.ToString()].ToString());
              groupMember.level = level.ToString();
              this.OnPlayerLevelUpdated(groupMember.playerId, level);
            }
          }
        }
      }));
      if (ImiServices.Instance.PartyService.IsInGroup())
      {
        this.leaveBtn.SetActive(true);
      }
      else
      {
        this.leaveBtn.SetActive(false);
        this.ownGroupLeaderIcon.SetActive(false);
      }
      if (CustomLobbyUi.isInitialized)
        this.container.SetActive(false);
      else
        this.container.SetActive(true);
      Log.Api("SetLobbyUi finished.");
    }

    private bool ShouldShowInviteButton()
    {
      bool flag1 = (UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) MenuController.Instance.mainMenuPanel || (UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) MenuController.Instance.playMenu;
      List<APartyService.GroupMember> currentGroup = ImiServices.Instance.PartyService.GetCurrentGroup();
      int num = !ImiServices.Instance.PartyService.IsInGroup() ? 0 : (currentGroup.Count >= 3 ? 1 : 0);
      bool flag2 = ImiServices.Instance.isInMatchService.IsPlayerInMatch || ImiServices.Instance.MatchmakingService.IsMatchmaking();
      return ((num != 0 ? 1 : (!flag1 ? 1 : 0)) | (flag2 ? 1 : 0)) == 0;
    }

    private void CancelMatchmakingIfActive()
    {
      if (!ImiServices.Instance.MatchmakingService.IsMatchmaking())
        return;
      ImiServices.Instance.MatchmakingService.CancelMatchmaking();
    }

    private void OnGroupEntered()
    {
      this.CancelMatchmakingIfActive();
      this.SetLobbyUi();
      this.ownPlayerName.text = ImiServices.Instance.LoginService.GetUsername();
      this.leaveBtn.SetActive(true);
    }

    public void OnButtonShowInviteDialog()
    {
      Debug.Log((object) "Pressing Button Invite to group.");
      this.StartCoroutine(this.ShowInviteUi());
    }

    public void OnButtonLeaveGroup()
    {
      Debug.Log((object) "Pressing Button leave group.");
      if (!ImiServices.Instance.PartyService.IsInGroup())
        return;
      Debug.Log((object) "Leaving Group.");
      ImiServices.Instance.PartyService.LeaveGroup();
    }

    private IEnumerator ShowInviteUi()
    {
      if (!ImiServices.Instance.PartyService.IsInGroup())
      {
        Debug.Log((object) "Button leads to group creation.");
        ImiServices.Instance.PartyService.CreateGroup(3, ELobbyType.k_ELobbyTypePrivate);
        yield return (object) new WaitForSecondsRealtime(0.25f);
      }
      else
        ImiServices.Instance.PartyService.ShowInviteUi();
    }

    [Serializable]
    public struct GroupUiObject
    {
      public Text username;
      public ulong userId;
      public TextMeshProUGUI userlevel;
      public GameObject groupContainer;
      public GameObject groupLeaderIcon;
      public SwitchAvatarIcon avatarObject;
    }
  }
}
