// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.TwitchService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Networking.Messages;
using Imi.SharedWithServer.ScEntitas.EventSystem;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SharedWithServer.ScEvents;
using SteelCircus.UI.OptionsUI;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class TwitchService
  {
    private ImiServicesHelper imiHelper;
    private Dictionary<ulong, TwitchAccountInfo> twitchViewerDict;
    private Dictionary<string, ulong> twitchNamePlayerIdDict;

    public event TwitchService.OnTwitchViewerCountUpdateEventHandler OnTwitchViewerCountUpdateEvent;

    public event TwitchService.OnTwitchUserInfoUpdateEventHandler OnTwitchUserInfoUpdate;

    public TwitchService(ImiServicesHelper helper)
    {
      Events.Global.OnNetEventUsernameMessage += new Events.EventNetworkEvent<UsernameMessage>(this.OnGetPlayerUsernameMessage);
      helper.ApplicationQuitEvent += new Action(this.RemoveListeners);
      this.twitchViewerDict = new Dictionary<ulong, TwitchAccountInfo>();
      this.twitchNamePlayerIdDict = new Dictionary<string, ulong>();
      this.imiHelper = helper;
      List<string> stringList = new List<string>()
      {
        "Valkia",
        "BurkeBlack"
      };
    }

    public string GetTwitchUserName() => this.twitchViewerDict.ContainsKey(ImiServices.Instance.LoginService.GetPlayerId()) ? this.twitchViewerDict[ImiServices.Instance.LoginService.GetPlayerId()].twitchDisplayName : "";

    public void ResetViewerDict() => this.twitchViewerDict = new Dictionary<ulong, TwitchAccountInfo>();

    public void AddTwitchUser(ulong playerid, TwitchAccountInfo accountInfo)
    {
      if (this.twitchViewerDict.ContainsKey(playerid))
        this.twitchViewerDict[playerid] = accountInfo;
      else
        this.twitchViewerDict.Add(playerid, accountInfo);
      if (this.twitchNamePlayerIdDict.ContainsKey(accountInfo.twitchDisplayName))
        return;
      Log.Error("Adding new Twitch User: " + accountInfo.twitchDisplayName);
      this.twitchNamePlayerIdDict.Add(accountInfo.twitchDisplayName, playerid);
    }

    public int GetStoredTwitchViewerCount(ulong playerId) => this.twitchViewerDict.ContainsKey(playerId) ? this.twitchViewerDict[playerId].viewerCount : 0;

    public bool IsPlayerTwitchUser(ulong playerId) => this.twitchViewerDict.ContainsKey(playerId);

    private void OnGetPlayerUsernameMessage(NetworkEvent<UsernameMessage> e)
    {
      if (e.msg.isTwitchUser)
      {
        TwitchAccountInfo twitchAccountInfo = new TwitchAccountInfo(e.msg.playerId, e.msg.username, e.msg.twitchUsername, e.msg.twitchViewerCount > 0, e.msg.twitchViewerCount);
        this.AddTwitchUser(e.msg.playerId, twitchAccountInfo);
        TwitchService.OnTwitchViewerCountUpdateEventHandler countUpdateEvent = this.OnTwitchViewerCountUpdateEvent;
        if (countUpdateEvent != null)
          countUpdateEvent(e.msg.playerId, e.msg.twitchViewerCount);
        TwitchService.OnTwitchUserInfoUpdateEventHandler twitchUserInfoUpdate = this.OnTwitchUserInfoUpdate;
        if (twitchUserInfoUpdate == null)
          return;
        twitchUserInfoUpdate(twitchAccountInfo);
      }
      else
        Log.Debug("User " + e.msg.username + " is not a twitch user");
    }

    private void RemoveListeners()
    {
      this.imiHelper.ApplicationQuitEvent -= new Action(this.RemoveListeners);
      Events.Global.OnNetEventUsernameMessage += new Events.EventNetworkEvent<UsernameMessage>(this.OnGetPlayerUsernameMessage);
    }

    public void SetUserNotConnected()
    {
      Log.Debug("User not connected to Twitch Account");
      PlayerPrefs.SetInt(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref, 0);
      PlayerPrefs.SetInt(TwitchAccountSettings.TwitchNameTogglePlayerPref, 0);
      PlayerPrefs.SetInt(TwitchAccountSettings.TwitchViewerCountTogglePlayerPref, 0);
    }

    public IEnumerator LoadTwitchInfo()
    {
      TwitchService twitchService = this;
      yield return (object) twitchService.imiHelper.StartCoroutine(MetaServiceHelpers.GetTwitchUISettings(ImiServices.Instance.LoginService.GetPlayerId(), new Action<JObject>(twitchService.OnGetTwitchUISettings)));
      if (PlayerPrefs.HasKey(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref) && PlayerPrefs.GetInt(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref) == 1)
      {
        Log.Debug("User connected To Twitch. Getting user info.");
        yield return (object) twitchService.imiHelper.StartCoroutine(MetaServiceHelpers.GetTwitchUserInfo(ImiServices.Instance.LoginService.GetPlayerId(), new Action<ulong, JObject>(twitchService.OnGetTwitchUserInfo)));
      }
    }

    public IEnumerator GetTwitchViewerCount(List<string> twitchUserNames)
    {
      string str = string.Join("&", (IEnumerable<string>) twitchUserNames.Select<string, string>((Func<string, string>) (username => "user_login=" + username)).ToList<string>());
      Dictionary<string, string> headers = new Dictionary<string, string>();
      headers.Add("Client-ID", "akm9y7ekefj4mxx3833wwudelr2z43");
      Log.Debug("Twitch viewer count request: https://api.twitch.tv/helix/streams?" + str);
      WWW www = new WWW("https://api.twitch.tv/helix/streams?" + str, (byte[]) null, headers);
      yield return (object) www;
      this.ParseTwitchViewers(JObject.Parse(www.text));
    }

    public Dictionary<string, int> ParseTwitchViewers(JObject obj)
    {
      Log.Error(obj.ToString());
      if (obj["error"] != null || obj["data"] == null)
      {
        Log.Error("Error parsing twitch viewer count " + (object) obj);
        return (Dictionary<string, int>) null;
      }
      Dictionary<string, int> dictionary = new Dictionary<string, int>();
      foreach (JToken jtoken in (IEnumerable<JToken>) obj["data"])
      {
        dictionary.Add(jtoken[(object) "user_name"].ToString(), (int) jtoken[(object) "viewer_count"]);
        Log.Error(string.Format("User: {0} = {1}", (object) jtoken[(object) "user_name"], (object) jtoken[(object) "viewer_count"]));
        TwitchService.OnTwitchViewerCountUpdateEventHandler countUpdateEvent = this.OnTwitchViewerCountUpdateEvent;
        if (countUpdateEvent != null)
          countUpdateEvent(this.twitchNamePlayerIdDict[jtoken[(object) "user_name"].ToString()], (int) jtoken[(object) "viewer_count"]);
      }
      return dictionary;
    }

    public void OnGetTwitchUserInfo(ulong playerId, JObject obj)
    {
      Log.Debug("Get Twitch User info: " + (object) obj);
      if (obj["error"] != null || obj["msg"] != null)
        this.SetUserNotConnected();
      else if (obj["twitchConnection"] != null && (bool) obj["twitchConnection"] && obj["twitchDisplayName"] != null)
      {
        int viewerCount = obj["twitchViewerCount"] != null ? (int) obj["twitchViewerCount"] : 0;
        this.AddTwitchUser(playerId, new TwitchAccountInfo(playerId, (string) obj["twitchUserName"], (string) obj["twitchDisplayName"], viewerCount > 0, viewerCount));
        PlayerPrefs.SetString(TwitchAccountSettings.TwitchAccountNamePlayerPref, (string) obj["twitchDisplayName"]);
      }
      else
        this.SetUserNotConnected();
    }

    public void OnGetTwitchUISettings(JObject obj)
    {
      if (obj["error"] != null || obj["msg"] != null || obj["twitchShowUsername"] == null || obj["twitchShowViewerCount"] == null)
      {
        Log.Error("OnGetTwitchUISettings returned error: " + (object) obj);
        this.SetUserNotConnected();
      }
      else
      {
        JToken jtoken1 = obj["twitchShowUsername"];
        JToken jtoken2 = obj["twitchShowViewerCount"];
        if (jtoken1.Type == JTokenType.Null || jtoken1.Type == JTokenType.Null)
        {
          this.SetUserNotConnected();
        }
        else
        {
          PlayerPrefs.SetInt(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref, 1);
          Log.Debug("User connected to Twitch Account! Getting info");
          int num1 = (bool) obj["twitchShowUsername"] ? 1 : 0;
          PlayerPrefs.SetInt(TwitchAccountSettings.TwitchNameTogglePlayerPref, num1);
          int num2 = (bool) obj["twitchShowViewerCount"] ? 1 : 0;
          PlayerPrefs.SetInt(TwitchAccountSettings.TwitchViewerCountTogglePlayerPref, num2);
        }
      }
    }

    public delegate void OnTwitchViewerCountUpdateEventHandler(ulong playerId, int viewerCount);

    public delegate void OnTwitchUserInfoUpdateEventHandler(TwitchAccountInfo userInfo);
  }
}
