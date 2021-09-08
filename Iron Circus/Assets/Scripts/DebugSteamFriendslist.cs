// Decompiled with JetBrains decompiler
// Type: DebugSteamFriendslist
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Steamworks;
using SteelCircus.Core.Services;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class DebugSteamFriendslist : MonoBehaviour
{
  [SerializeField]
  private GUIStyle skinGuiStyle;
  [SerializeField]
  private GameObject buttonPrefab;
  [SerializeField]
  private Transform friendListParent;
  private List<CSteamID> friendsList = new List<CSteamID>();

  private void Start()
  {
  }

  private void ShowFriendsList()
  {
    if (!ImiServices.Instance.PartyService.IsInGroup())
      return;
    int friendCount = SteamFriends.GetFriendCount(EFriendFlags.k_EFriendFlagAll);
    int num = 0;
    for (int iFriend = 0; iFriend < friendCount; ++iFriend)
    {
      CSteamID friendByIndex = SteamFriends.GetFriendByIndex(iFriend, EFriendFlags.k_EFriendFlagAll);
      if (SteamFriends.GetFriendGamePlayed(friendByIndex, out FriendGameInfo_t _))
      {
        Rect position = new Rect((float) (Screen.width - 150), (float) (num * 35), 150f, 30f);
        this.skinGuiStyle = new GUIStyle(GUI.skin.button);
        string text = friendByIndex.m_SteamID.ToString();
        if (GUI.Button(position, text))
        {
          Log.Debug(friendByIndex.m_SteamID.ToString());
          SteamMatchmaking.InviteUserToLobby(ImiServices.Instance.PartyService.GetLobbyId(), (CSteamID) friendByIndex.m_SteamID);
        }
        ++num;
      }
    }
  }

  public void CreateFriendList()
  {
    Log.Debug("Creating Friends List");
    this.LoadFriendList();
    this.ClearFriendsList();
    foreach (CSteamID friends in this.friendsList)
      this.AddFriendListEntry(friends, SteamFriends.GetFriendPersonaName(friends));
  }

  [EditorButton]
  public void InvitePex() => this.InviteFriendToLobby(new CSteamID(76561198123682634UL), "Pex");

  [EditorButton]
  public void InviteMo() => this.InviteFriendToLobby(new CSteamID(76561198915916980UL), "Mo");

  [EditorButton]
  public void InviteNiki() => this.InviteFriendToLobby(new CSteamID(76561198058450071UL), "Mo");

  [EditorButton]
  public void InviteWiktor() => this.InviteFriendToLobby(new CSteamID(76561198033201703UL), "Wiktor");

  [EditorButton]
  public void LoadFriendList()
  {
    this.friendsList = new List<CSteamID>();
    int friendCount = SteamFriends.GetFriendCount(EFriendFlags.k_EFriendFlagAll);
    for (int iFriend = 0; iFriend < friendCount; ++iFriend)
    {
      CSteamID friendByIndex = SteamFriends.GetFriendByIndex(iFriend, EFriendFlags.k_EFriendFlagAll);
      if (SteamFriends.GetFriendGamePlayed(friendByIndex, out FriendGameInfo_t _))
      {
        Log.Debug(friendByIndex.m_SteamID.ToString());
        this.friendsList.Add(friendByIndex);
      }
    }
  }

  private void AddFriendListEntry(CSteamID steamId, string friendName)
  {
    GameObject gameObject = Object.Instantiate<GameObject>(this.buttonPrefab);
    gameObject.transform.SetParent(this.friendListParent.transform, false);
    gameObject.name = friendName;
    gameObject.GetComponentInChildren<Text>().text = friendName ?? "";
    gameObject.GetComponent<Button>().onClick.AddListener((UnityAction) (() => this.InviteFriendToLobby(steamId, friendName)));
  }

  public void ClearFriendsList()
  {
    for (int index = 0; index < this.friendListParent.transform.childCount; ++index)
      Object.Destroy((Object) this.friendListParent.transform.GetChild(index).gameObject);
  }

  private void InviteFriendToLobby(CSteamID steamId, string friendName)
  {
    if (!SteamMatchmaking.InviteUserToLobby(ImiServices.Instance.PartyService.GetLobbyId(), steamId))
      return;
    Log.Debug("Invite was send to: " + friendName);
  }
}
