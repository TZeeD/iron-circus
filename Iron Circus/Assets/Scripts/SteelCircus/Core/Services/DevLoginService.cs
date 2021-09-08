// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.DevLoginService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Utils;
using Imi.SteelCircus.UI.Network;
using System;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class DevLoginService : ILoginService
  {
    private readonly Action<ulong> onLoginSuccessful;
    private readonly Action<string> onLoginError;
    private readonly Action<string> onClientVersionMismatch;
    private string username;
    private ulong playerId;
    private MonoBehaviour coroutineRunner;
    private bool isLoginOk;

    public ulong GetPlayerId()
    {
      if (this.isLoginOk)
        return this.playerId;
      throw new ImiException("Can't fetch player id - not logged in.");
    }

    public string GetUsername()
    {
      if (this.isLoginOk)
        return this.username;
      throw new ImiException("Can't fetch username - not logged in.");
    }

    public bool IsLoginOk() => this.isLoginOk;

    public void SetLoginFailed() => this.isLoginOk = false;

    public void Connect() => this.FakeLogin();

    public DevLoginService(
      MonoBehaviour coroutineRunner,
      string username,
      Action<ulong> onLoginSuccessful,
      Action<string> onLoginError,
      Action<string> onClientVersionMismatch)
    {
      this.username = username;
      this.coroutineRunner = coroutineRunner;
      this.onLoginSuccessful = onLoginSuccessful;
      this.onLoginError = onLoginError;
      this.onClientVersionMismatch = onClientVersionMismatch;
    }

    private void FakeLogin()
    {
      ulong sHashed;
      SimpleHash.FromString(this.username, out sHashed);
      this.coroutineRunner.StartCoroutine(MetaServiceHelpers.LoginToFakeUserService(this.username, sHashed.ToString(), (Action<ulong>) (playerId =>
      {
        Log.Debug("Received PlayerId from DevLogin Service: " + (object) playerId);
        this.isLoginOk = true;
        this.playerId = playerId;
        Action<ulong> onLoginSuccessful = this.onLoginSuccessful;
        if (onLoginSuccessful == null)
          return;
        onLoginSuccessful(playerId);
      }), this.onLoginError, this.onClientVersionMismatch));
    }
  }
}
