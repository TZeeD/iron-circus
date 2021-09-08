// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Audio.ServitorAudioHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;

namespace Imi.SteelCircus.Audio
{
  public class ServitorAudioHelper : MonoBehaviour
  {
    [SerializeField]
    private AudioSource source;
    [SerializeField]
    private float audioLoopVolume;

    public void OnEnable() => this.source.volume = 0.0f;

    public void StartAudio()
    {
    }

    public void StopAudio()
    {
    }

    private IEnumerator FadeOutLoop(AudioSource audioSource, float fadeTime)
    {
      while ((double) audioSource.volume > 0.0)
      {
        audioSource.volume -= this.audioLoopVolume * Time.deltaTime / fadeTime;
        yield return (object) null;
      }
      audioSource.volume = 0.0f;
    }

    private IEnumerator FadeInLoop(AudioSource audioSource, float fadeTime)
    {
      while ((double) audioSource.volume < (double) this.audioLoopVolume)
      {
        audioSource.volume += this.audioLoopVolume * Time.deltaTime / fadeTime;
        yield return (object) null;
      }
      audioSource.volume = this.audioLoopVolume;
    }
  }
}
