// Decompiled with JetBrains decompiler
// Type: DebugLobbyCountdown
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using SharedWithServer.ScEvents;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

public class DebugLobbyCountdown : MonoBehaviour
{
  [FormerlySerializedAs("preText")]
  public string PreText = "";
  [FormerlySerializedAs("postText")]
  public string PostText = "";
  private float timeLeft = -1f;
  private LobbyState lobbyState;
  private bool hasStarted;
  private Animation anim;
  private Text timeLeftTxt;
  [SerializeField]
  private Text lobbyTxt;
  [SerializeField]
  private Text lobbyInfoTxt;
  [SerializeField]
  private GameObject upperPanelLogoContainer;
  private bool countDownStarted;
  private bool animationHasPlayed;
  private bool hasPlayed3S;
  private bool hasPlayed2S;
  private bool hasPlayed1S;
  private bool hasPlayed0S;

  private void Start()
  {
    Events.Global.OnEventMatchStartCountdown += new Events.EventMatchStartCountdown(this.OnMatchStartCountdownEvent);
    if ((Object) this.timeLeftTxt == (Object) null)
      this.timeLeftTxt = this.GetComponent<Text>();
    this.anim = this.GetComponent<Animation>();
    this.timeLeftTxt.text = "";
    this.lobbyTxt.text = "Waiting for other Players.";
    if (!((Object) this.lobbyInfoTxt != (Object) null))
      return;
    this.lobbyInfoTxt.text = "Players connecting to game!";
  }

  private void OnMatchStartCountdownEvent(float countdown, LobbyState lobbystate)
  {
    this.countDownStarted = true;
    this.lobbyTxt.text = "Match starts in: ";
    this.timeLeft = countdown;
    this.lobbyState = lobbystate;
    if (this.lobbyState == LobbyState.GracePeriod && !this.animationHasPlayed)
    {
      this.anim.Play();
      this.animationHasPlayed = true;
    }
    if (this.lobbyState != LobbyState.Selection)
      return;
    if ((Object) this.lobbyInfoTxt != (Object) null)
      this.lobbyInfoTxt.text = "Pick your Champion!";
    if (!((Object) this.upperPanelLogoContainer != (Object) null))
      return;
    this.upperPanelLogoContainer.SetActive(false);
  }

  private void Update()
  {
    if (!this.countDownStarted)
      return;
    if ((double) this.timeLeft > 0.0)
    {
      this.timeLeft -= Time.deltaTime;
      this.timeLeftTxt.text = this.PreText + (object) Mathf.Round(this.timeLeft) + this.PostText;
      this.PlayCountdownAudio();
      if ((double) this.timeLeft >= 0.0)
        return;
      this.timeLeft = -1f;
    }
    else
      this.timeLeftTxt.text = "";
  }

  private void PlayCountdownAudio()
  {
    if (this.timeLeftTxt.text.Equals("3s") && !this.hasPlayed3S)
    {
      AudioController.Play("LobbyMatchCountdown");
      this.hasPlayed3S = true;
    }
    else if (this.timeLeftTxt.text.Equals("2s") && !this.hasPlayed2S)
    {
      AudioController.Play("LobbyMatchCountdown");
      this.hasPlayed2S = true;
    }
    else if (this.timeLeftTxt.text.Equals("1s") && !this.hasPlayed1S)
    {
      AudioController.Play("LobbyMatchCountdown");
      this.hasPlayed1S = true;
    }
    else
    {
      if (!this.timeLeftTxt.text.Equals("0s") || this.hasPlayed0S)
        return;
      AudioController.Play("LobbyMatchCountdownFinal");
      this.hasPlayed0S = true;
    }
  }

  private void OnDestroy() => Events.Global.OnEventMatchStartCountdown -= new Events.EventMatchStartCountdown(this.OnMatchStartCountdownEvent);
}
