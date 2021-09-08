// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Audio.AudioManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Audio
{
  public class AudioManager : MonoBehaviour
  {
    private AudioSource sfxAudio2D;
    private AudioSource backgroundAudio2D;
    private Dictionary<string, AudioClip> audioClipsMap = new Dictionary<string, AudioClip>();
    [Header("Temporary Location for Pickup Audio. Will be somewhere else.")]
    [SerializeField]
    private AudioClip pickupClip;
    private static AudioManager instance;
    private static object lockObj = new object();

    public static AudioManager Instance
    {
      get
      {
        if ((Object) AudioManager.instance == (Object) null)
          AudioManager.CreateInstance();
        return AudioManager.instance;
      }
    }

    private static void CreateInstance()
    {
      lock (AudioManager.lockObj)
      {
        if (!((Object) AudioManager.instance == (Object) null))
          return;
        AudioManager.instance = (AudioManager) Object.FindObjectOfType(typeof (AudioManager));
        if (!((Object) AudioManager.instance == (Object) null))
          return;
        GameObject gameObject = new GameObject();
        AudioManager.instance = gameObject.AddComponent<AudioManager>();
        gameObject.name = "(singleton) " + (object) typeof (AudioManager);
        Object.DontDestroyOnLoad((Object) gameObject);
      }
    }

    private void Awake()
    {
      if ((Object) AudioManager.instance != (Object) null)
      {
        Object.DestroyImmediate((Object) this);
      }
      else
      {
        AudioManager.CreateInstance();
        this.Initialize();
      }
    }

    private void Start()
    {
    }

    private void Initialize()
    {
    }

    private static AudioSource Create2DAudioSource(GameObject sfxObj)
    {
      AudioSource audioSource = sfxObj.AddComponent<AudioSource>();
      audioSource.rolloffMode = AudioRolloffMode.Linear;
      audioSource.spatialBlend = 0.0f;
      audioSource.dopplerLevel = 0.0f;
      audioSource.loop = false;
      audioSource.playOnAwake = false;
      return audioSource;
    }

    public AudioClip GetClip(string stressLoop) => this.audioClipsMap[stressLoop];

    public void ResetBackground2D()
    {
    }

    public void PlayBackground2D(string backgroundName, float volume, float pitch)
    {
    }

    public void PlaySfx2D(string sfxName)
    {
    }

    public void PlaySfx2DRandomized(string sfxName, float volume)
    {
    }

    public void PlaySfx2D(AudioClip clip, float volume)
    {
    }

    public void PlaySfx2D(string sfxName, float volume, float pitch)
    {
    }

    public void PlayClipAtPoint3D(
      AudioClip clip,
      Vector3 position,
      float volume,
      float pitch,
      float minDistance = 1f,
      float maxDistance = 500f)
    {
    }

    public static IEnumerator FadeOut(AudioSource audioSource, float FadeTime)
    {
      float startVolume = audioSource.volume;
      while ((double) audioSource.volume > 0.0)
      {
        audioSource.volume -= startVolume * Time.deltaTime / FadeTime;
        if (Mathf.Approximately(0.0f, audioSource.volume))
          audioSource.volume = 0.0f;
        yield return (object) null;
      }
      audioSource.Stop();
      audioSource.volume = startVolume;
    }

    public static IEnumerator FadeIn(AudioSource audioSource, float FadeTime)
    {
      float startVolume = 0.2f;
      audioSource.volume = 0.0f;
      audioSource.Play();
      while ((double) audioSource.volume < 1.0)
      {
        audioSource.volume += startVolume * Time.deltaTime / FadeTime;
        if (Mathf.Approximately(1f, audioSource.volume))
          audioSource.volume = 1f;
        yield return (object) null;
      }
      audioSource.volume = 1f;
    }
  }
}
