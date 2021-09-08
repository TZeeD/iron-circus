// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.StandaloneLoginService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace SteelCircus.Core.Services
{
  public class StandaloneLoginService : ILoginService
  {
    private readonly Action<ulong> onLoginSuccessful;
    private readonly Action<string> onLoginError;
    private string username;
    private readonly Action<ulong> _onLoginSuccessful;
    private ulong playerId;
    private bool isLoginOk;

    public ulong GetPlayerId() => this.playerId;

    public string GetUsername() => this.username;

    public bool IsLoginOk() => this.isLoginOk;

    public void SetLoginFailed() => this.isLoginOk = false;

    public void Connect()
    {
      this.isLoginOk = true;
      Action<ulong> onLoginSuccessful = this.onLoginSuccessful;
      if (onLoginSuccessful == null)
        return;
      onLoginSuccessful(this.playerId);
    }

    public StandaloneLoginService(
      ulong playerId,
      string username,
      Action<ulong> onLoginSuccessful,
      Action<string> onLoginError)
    {
      this.onLoginSuccessful = onLoginSuccessful;
      this.onLoginError = onLoginError;
      this.username = username;
      this._onLoginSuccessful = onLoginSuccessful;
      this.playerId = playerId;
    }
  }
}
