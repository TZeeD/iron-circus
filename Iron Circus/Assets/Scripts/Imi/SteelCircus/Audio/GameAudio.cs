// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Audio.GameAudio
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;

namespace Imi.SteelCircus.Audio
{
  [RequireComponent(typeof (AudioSource))]
  public class GameAudio : MonoBehaviour
  {
    [Header("Intro-Audio")]
    [SerializeField]
    private AudioWithVolume[] introAudios;
    [Space]
    [Header("Goal-Audio")]
    [SerializeField]
    private AudioWithVolume[] cheeringVariants;
    [SerializeField]
    private AudioWithVolume goalModerator;
    [SerializeField]
    private AudioWithVolume goalSiren;
    [Space]
    [Header("Point-Start-Audio")]
    [SerializeField]
    private AudioWithVolume onThree;
    [SerializeField]
    private AudioWithVolume onTwo;
    [SerializeField]
    private AudioWithVolume onOne;
    [SerializeField]
    private AudioWithVolume onGo;
    [SerializeField]
    private float transitionThreeToTwo = 1f;
    [SerializeField]
    private float transitionTwoToOne = 1f;
    [SerializeField]
    private float transitionOneToGo = 0.8f;
    [SerializeField]
    private AudioWithVolume[] gameOverAudios;
    [SerializeField]
    private AudioWithVolume backgroundNoise;
    [SerializeField]
    private AudioSource backgroundNoiseSource;
    private float timeBetweenGoals = 2f;
    private float timeStamp;

    private void Awake()
    {
      if (!((Object) this.backgroundNoiseSource == (Object) null))
        return;
      this.backgroundNoiseSource = this.GetComponent<AudioSource>();
    }

    public void PlayGameEndedSound()
    {
      for (int index = 0; index < this.gameOverAudios.Length; ++index)
        AudioWithVolume.PlayAudioClipWithVolume(this.gameOverAudios[index]);
    }

    public void PlayIntroAudio()
    {
      this.StartCoroutine(this.IntroAudioCr());
      AudioManager.Instance.ResetBackground2D();
      this.backgroundNoiseSource.loop = true;
      this.backgroundNoiseSource.clip = this.backgroundNoise.clip;
      this.backgroundNoiseSource.volume = this.backgroundNoise.volume;
      this.backgroundNoiseSource.Play();
    }

    private IEnumerator IntroAudioCr()
    {
      for (int index = 0; index < this.introAudios.Length; ++index)
        AudioWithVolume.PlayAudioClipWithVolume(this.introAudios[index]);
      yield return (object) null;
    }

    public void PlayPointAudio() => this.StartCoroutine(this.PointAudioCr());

    private IEnumerator PointAudioCr()
    {
      yield return (object) new WaitForSeconds(this.transitionThreeToTwo);
      yield return (object) new WaitForSeconds(this.transitionTwoToOne);
      yield return (object) new WaitForSeconds(this.transitionOneToGo);
      AudioWithVolume.PlayAudioClipWithVolume(this.onGo);
    }

    public void PlayGoalSound()
    {
      if ((double) this.timeStamp > (double) Time.time)
        return;
      this.timeStamp = Time.time + this.timeBetweenGoals;
      AudioWithVolume.PlayAudioClipWithVolume(this.goalModerator);
      AudioWithVolume.PlayAudioClipWithVolume(this.goalSiren);
    }

    private IEnumerator PlayGoalMumbleCr()
    {
      yield return (object) new WaitForSeconds(Random.Range(0.8f, 2f));
    }
  }
}
