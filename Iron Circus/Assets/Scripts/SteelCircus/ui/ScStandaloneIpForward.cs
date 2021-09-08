// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ScStandaloneIpForward
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.Core.Services;
using SteelCircus.Networking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ScStandaloneIpForward : MonoBehaviour
  {
    [SerializeField]
    private InputField ipField;

    private void Awake()
    {
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen += new LoadingScreenService.OnShowLoadingScreenEventHandler(this.DisableSelf);
      this.gameObject.SetActive(false);
    }

    private void DisableSelf(LoadingScreenService.LoadingScreenIntent intent) => this.gameObject.SetActive(false);

    private void OnDisable() => ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen -= new LoadingScreenService.OnShowLoadingScreenEventHandler(this.DisableSelf);

    public void ForwardIp()
    {
      IPAddress address;
      if (IPAddress.TryParse(this.ipField.text, out address))
      {
        ImiServices.Instance.MatchmakingService.SetStandaloneIp(address);
        this.gameObject.SetActive(false);
      }
      else
        Log.Error("Could not parse IP");
    }

    public void AutoConnectToIp()
    {
      this.ForwardIp();
      ImiServices.Instance.MatchmakingService.StartMatchmaking(1, ImiServices.Instance.LoginService.GetPlayerId(), "", AwsPinger.RegionLatencies);
    }

    private IPAddress GetLocalIP() => ((IEnumerable<IPAddress>) Dns.GetHostEntry(Dns.GetHostName()).AddressList).FirstOrDefault<IPAddress>((Func<IPAddress, bool>) (ip => ip.AddressFamily == AddressFamily.InterNetwork));
  }
}
