// Decompiled with JetBrains decompiler
// Type: ShowPlayerCurrencies
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using System;
using System.Collections;
using TMPro;
using UnityEngine;

public class ShowPlayerCurrencies : MonoBehaviour
{
  public TextMeshProUGUI playerCredsText;
  public TextMeshProUGUI playerSteelText;

  private void Awake()
  {
    ImiServices.Instance.progressManager.OnPlayerSteelUpdated += new ProgressManager.OnPlayerSteelUpdatedHandler(this.OnUpdatePlayerSteel);
    ImiServices.Instance.progressManager.OnPlayerCredsUpdated += new ProgressManager.OnPlayerCredsUpdatedHandler(this.OnUpdatePlayerCreds);
    this.StartCoroutine(this.WaitUntilLogin());
  }

  private void OnDestroy()
  {
    ImiServices.Instance.progressManager.OnPlayerSteelUpdated -= new ProgressManager.OnPlayerSteelUpdatedHandler(this.OnUpdatePlayerSteel);
    ImiServices.Instance.progressManager.OnPlayerCredsUpdated -= new ProgressManager.OnPlayerCredsUpdatedHandler(this.OnUpdatePlayerCreds);
  }

  private void OnUpdatePlayerCreds(ulong playerId, int creds)
  {
    if (!((UnityEngine.Object) this.playerCredsText != (UnityEngine.Object) null))
      return;
    this.playerCredsText.text = creds.ToString();
  }

  private void OnUpdatePlayerSteel(ulong playerId, int steel)
  {
    if (!((UnityEngine.Object) this.playerSteelText != (UnityEngine.Object) null))
      return;
    this.playerSteelText.text = steel.ToString();
  }

  public IEnumerator WaitUntilLogin()
  {
    yield return (object) new WaitUntil((Func<bool>) (() => ImiServices.Instance.LoginService.IsLoginOk()));
    this.OnUpdatePlayerCreds(ImiServices.Instance.LoginService.GetPlayerId(), ImiServices.Instance.progressManager.GetPlayerCreds());
    this.OnUpdatePlayerSteel(ImiServices.Instance.LoginService.GetPlayerId(), ImiServices.Instance.progressManager.GetPlayerSteel());
  }
}
