// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Floor.FloorCenterDisplay
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SteelCircus.Utils;
using Imi.SteelCircus.Utils.Extensions;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.UI.Floor
{
  public class FloorCenterDisplay : MonoBehaviour
  {
    [Header("Time Displays")]
    public GameObject timeDisplayPrefab;
    public GameObject getReadyDisplayPrefab;
    public Transform timeDisplayParent;
    public float timeDisplayRotationSpeed = 30f;
    public int numTimeDisplays = 5;
    public Transform timeDisplayBG;
    public AnimationCurve timeDisplayBGAnimation;
    private List<Transform> timeDisplays = new List<Transform>();
    private List<Text> timeDisplayTexts = new List<Text>();
    private GameObject getReadyDisplay;
    [Header("Simple Time Display")]
    public bool useSimpleTimeDisplay;
    public Text simpleTime;
    [Header("Score Display")]
    public Text teamAlphaScore;
    public Text teamBetaScore;
    [Header("Countdown")]
    public Text countdownText;
    private int prevAlphaScore = -1;
    private int prevBetaScore = -1;
    private float prevRemainingSeconds = -1f;

    private void Awake()
    {
      if (!this.useSimpleTimeDisplay)
        this.simpleTime.gameObject.SetActive(false);
      for (int index = 0; index < this.numTimeDisplays; ++index)
      {
        Transform transform = UnityEngine.Object.Instantiate<GameObject>(this.timeDisplayPrefab).transform;
        transform.parent = this.timeDisplayParent;
        transform.SetToIdentity();
        transform.localEulerAngles = new Vector3(0.0f, 0.0f, (float) index * 360f / (float) this.numTimeDisplays);
        this.timeDisplays.Add(transform);
        this.timeDisplayTexts.Add(transform.GetComponentInChildren<Text>());
      }
      this.getReadyDisplay = UnityEngine.Object.Instantiate<GameObject>(this.getReadyDisplayPrefab);
      Transform transform1 = this.getReadyDisplay.transform;
      transform1.SetParent(this.transform, true);
      transform1.SetToIdentity();
    }

    private void Update()
    {
      this.UpdateTimeDisplay();
      this.UpdateScore();
    }

    public void StartCountdown()
    {
      this.getReadyDisplay.SetActive(false);
      this.GetComponent<Animator>().Play("floor_center_display_anim_countdown");
    }

    private void SwitchCountdownText(string newText)
    {
      this.countdownText.text = newText;
      this.PlayMatchStartCountdownAudio(newText);
    }

    private void PlayMatchStartCountdownAudio(string text)
    {
      if (!text.Equals("GO!") && MatchUtils.GetScore(Team.Alpha) == 0 && MatchUtils.GetScore(Team.Beta) == 0)
        AudioController.Play("AnnouncerNumber" + text);
      if (text.Equals("3"))
      {
        if (MatchUtils.GetScore(Team.Alpha) == 0 && MatchUtils.GetScore(Team.Beta) == 0)
        {
          AudioController.Play("MatchStartCountdown");
          if (AudioController.GetPlayingAudioObjects("AmbienceCrowdBaseLoop").Count != 0)
            return;
          AudioController.Play("AmbienceCrowdBaseLoop");
        }
        else
          AudioController.Play("MatchInGameCountdown");
      }
      else
      {
        if (!text.Equals("GO!"))
          return;
        if (MatchUtils.GetScore(Team.Alpha) == 0 && MatchUtils.GetScore(Team.Beta) == 0)
        {
          AudioController.Play("KickoffCrowd");
          AudioController.Play("AnnouncerGo");
        }
        else
        {
          AudioController.Play("KickoffCrowdIngame");
          if (!AudioController.IsMusicPaused())
            return;
          AudioController.UnpauseMusic();
        }
      }
    }

    private void UpdateScore()
    {
      int score1 = MatchUtils.GetScore(Team.Alpha);
      int score2 = MatchUtils.GetScore(Team.Beta);
      if (score1 == this.prevAlphaScore && score2 == this.prevBetaScore)
        return;
      this.teamAlphaScore.text = string.Format("{0}", (object) score1);
      this.teamBetaScore.text = string.Format("{0}", (object) score2);
      this.prevAlphaScore = score1;
      this.prevBetaScore = score2;
    }

    private void UpdateTimeDisplay()
    {
      float remainingTime = MatchUtils.GetRemainingTime();
      float num = Mathf.Round(remainingTime);
      if ((double) num != (double) this.prevRemainingSeconds)
      {
        this.prevRemainingSeconds = num;
        TimeSpan timeSpan = TimeSpan.FromSeconds((double) remainingTime);
        string str = string.Format("{0:D2}:{1:D2}", (object) timeSpan.Minutes, (object) timeSpan.Seconds);
        foreach (Text timeDisplayText in this.timeDisplayTexts)
          timeDisplayText.text = str;
        if (this.useSimpleTimeDisplay)
          this.simpleTime.text = str;
      }
      this.timeDisplayParent.Rotate(Vector3.forward, this.timeDisplayRotationSpeed * Time.deltaTime);
      if (this.useSimpleTimeDisplay)
        return;
      this.timeDisplayBG.localScale = Vector3.one * this.timeDisplayBGAnimation.Evaluate((float) (1.0 - (double) remainingTime % 1.0));
    }
  }
}
