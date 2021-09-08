// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.SteamLoginService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.UI.Network;
using Steamworks;
using System;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class SteamLoginService : ILoginService
  {
    private readonly Action<ulong> onLoginSuccessful;
    private readonly Action<string> onLoginError;
    private readonly Action<string> onClientVersionMismatch;
    private string username;
    private ulong playerId;
    private SteamAuthHelper steamAuthHelper;
    private MonoBehaviour coroutineRunner;
    private bool loginOk;

    public bool IsLoginOk() => this.loginOk;

    public void SetLoginFailed() => this.loginOk = false;

    public void Connect()
    {
      if (SteamManager.Initialized)
      {
        this.username = SteamFriends.GetPersonaName();
        Log.Debug("Got Steam Name: " + this.username);
        if (SteamUser.BLoggedOn())
        {
          this.steamAuthHelper = new SteamAuthHelper();
          this.steamAuthHelper.RequestAuthSessionTicket(true, new Action<string, HAuthTicket>(this.OnSteamAuthSessionTicket));
        }
        else
        {
          Action<string> onLoginError = this.onLoginError;
          if (onLoginError == null)
            return;
          onLoginError("Cannot connect to Steam servers. Please restart your steam client and try again.");
        }
      }
      else
      {
        this.loginOk = false;
        ImiServices.Instance.Analytics.OnLoginFailed("SteamNotInitialized");
        Action<string> onLoginError = this.onLoginError;
        if (onLoginError == null)
          return;
        onLoginError("Steam is not initialized");
      }
    }

    public ulong GetPlayerId()
    {
      if (this.loginOk)
        return this.playerId;
      throw new ImiException("Can't fetch player id - not logged in.");
    }

    public string GetUsername()
    {
      if (this.loginOk)
        return this.username;
      throw new ImiException("Can't fetch username - not logged in.");
    }

    public SteamLoginService(
      MonoBehaviour coroutineRunner,
      Action<ulong> onLoginSuccessful,
      Action<string> onLoginError,
      Action<string> onClientVersionMismatch)
    {
      this.onLoginSuccessful = onLoginSuccessful;
      this.onLoginError = onLoginError;
      this.onClientVersionMismatch = onClientVersionMismatch;
      this.coroutineRunner = coroutineRunner;
    }

    private void OnSteamAuthSessionTicket(string authSessionTicketHexString, HAuthTicket authTicket) => this.coroutineRunner.StartCoroutine(MetaServiceHelpers.LoginToUserService(this.username, authSessionTicketHexString, authTicket, (Action<ulong>) (playerId =>
    {
      Log.Debug("Received PlayerId from Login Service: " + (object) playerId);
      this.loginOk = true;
      this.playerId = playerId;
      Action<ulong> onLoginSuccessful = this.onLoginSuccessful;
      if (onLoginSuccessful == null)
        return;
      onLoginSuccessful(playerId);
    }), this.onLoginError, this.onClientVersionMismatch));
  }
}
