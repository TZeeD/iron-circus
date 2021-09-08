// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.DebugServerList
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SharedWithServer.Game;
using SteelCircus.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
  public class DebugServerList : MonoBehaviour
  {
    [SerializeField]
    private GameObject buttonPrefab;
    [SerializeField]
    private Image serverList;
    [SerializeField]
    private InputField ipField;
    private string selectedServerAddress;
    private int selectedServerPort;

    private void Start()
    {
      if (ImiServices.Instance.LoginService.IsLoginOk())
        this.RefreshServerList();
      this.selectedServerAddress = this.GetLocalIP().ToString();
      this.selectedServerPort = 7033;
      this.ipField.text = this.selectedServerAddress;
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen += new LoadingScreenService.OnShowLoadingScreenEventHandler(this.DestroySelf);
    }

    private IPAddress GetLocalIP() => ((IEnumerable<IPAddress>) Dns.GetHostEntry(Dns.GetHostName()).AddressList).FirstOrDefault<IPAddress>((Func<IPAddress, bool>) (ip => ip.AddressFamily == AddressFamily.InterNetwork));

    private void DestroySelf(LoadingScreenService.LoadingScreenIntent intent) => UnityEngine.Object.Destroy((UnityEngine.Object) this.gameObject);

    private void OnDestroy() => ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen -= new LoadingScreenService.OnShowLoadingScreenEventHandler(this.DestroySelf);

    private void OnServerSelected(string serverName, string ip, string port, string sessionId)
    {
      Log.Debug("Selected server: " + serverName);
      Log.Debug("Game Session Id: " + sessionId);
      this.selectedServerAddress = ip;
      this.selectedServerPort = int.Parse(port);
      this.ConnectClicked();
    }

    public void ConnectClicked()
    {
      Log.Debug("Connecting from DebugServerList with PlayerId: " + (object) ImiServices.Instance.LoginService.GetPlayerId());
      ImiServices.Instance.ConnectToServerManagerServer(this.CreateConnectInfo());
      this.gameObject.GetComponent<Canvas>().enabled = false;
      this.DeactivateButtonsAndSelf();
    }

    private ConnectionInfo CreateConnectInfo(string playerSessionId = null)
    {
      ConnectionInfo connectionInfo = new ConnectionInfo()
      {
        ip = IPAddress.Parse(this.selectedServerAddress),
        port = this.selectedServerPort,
        username = ImiServices.Instance.LoginService.GetUsername(),
        playerId = ImiServices.Instance.LoginService.GetPlayerId(),
        gameLiftPlayerSessionId = playerSessionId
      };
      if (string.IsNullOrEmpty(connectionInfo.username))
        connectionInfo.username = Environment.MachineName;
      if (connectionInfo.playerId == 0UL)
        connectionInfo.playerId = ImiServices.GeneratePlayerIdAsInt(connectionInfo.username);
      return connectionInfo;
    }

    private void DeactivateButtonsAndSelf() => this.gameObject.SetActive(false);

    public void SetIpFromInputField()
    {
      IPAddress address;
      if (IPAddress.TryParse(this.ipField.text, out address))
      {
        this.selectedServerAddress = address.ToString();
        this.selectedServerPort = 7033;
      }
      else
        Log.Error("Could not parse IP");
    }

    private void AddServerListEntry(
      string serverName,
      string status,
      string ip,
      string port,
      string sessionId)
    {
      GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.buttonPrefab);
      gameObject.transform.SetParent(this.serverList.transform, false);
      gameObject.name = serverName;
      gameObject.GetComponentInChildren<Text>().text = serverName + " [" + status + "]";
      gameObject.GetComponent<Button>().onClick.AddListener((UnityAction) (() => this.OnServerSelected(serverName, ip, port, sessionId)));
    }

    private void DisplayNoServersFound()
    {
      GameObject gameObject = new GameObject("No Servers Text");
      Text text = gameObject.AddComponent<Text>();
      text.text = "No Servers found.\n Refresh";
      text.fontSize = 28;
      text.font = this.buttonPrefab.GetComponentInChildren<Text>().font;
      text.verticalOverflow = VerticalWrapMode.Overflow;
      text.horizontalOverflow = HorizontalWrapMode.Overflow;
      text.alignment = TextAnchor.UpperCenter;
      gameObject.transform.SetParent(this.serverList.transform);
    }

    public void RefreshServerList() => this.StartCoroutine(MetaServiceHelpers.HttpGetJson(MetaServiceConfig.ServerManager + "/list", new JObject(), (Action<string>) (error => Log.Debug("Could not talk to server manager: " + error)), new Action<JObject>(this.OnServerListLoaded)));

    private void OnServerListLoaded(JObject resultJson)
    {
      Log.Debug("Got server data from service");
      this.ClearServerList();
      if (resultJson["runningServers"] != null && resultJson["runningServers"].ToArray<JToken>().Length != 0)
      {
        foreach (JToken jtoken in (IEnumerable<JToken>) resultJson["runningServers"])
        {
          string serverName = jtoken[(object) "name"].ToString();
          int num = (bool) jtoken[(object) "isGameLift"] ? 1 : 0;
          string status = num != 0 ? "Remote" : "Local";
          string sessionId = num != 0 ? jtoken[(object) "gameSessionId"].ToString() : (string) null;
          string ip = jtoken[(object) "ip"].ToString();
          string port = jtoken[(object) "port"].ToString();
          this.AddServerListEntry(serverName, status, ip, port, sessionId);
        }
      }
      else
      {
        if (resultJson["runningServers"] == null)
          Log.Error("Could not fetch server list...");
        this.DisplayNoServersFound();
      }
    }

    public void ClearServerList()
    {
      for (int index = 0; index < this.serverList.transform.childCount; ++index)
        UnityEngine.Object.Destroy((UnityEngine.Object) this.serverList.transform.GetChild(index).gameObject);
    }
  }
}
