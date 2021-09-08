// Decompiled with JetBrains decompiler
// Type: ClockStone.AudioCategory
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

namespace ClockStone
{
  [Serializable]
  public class AudioCategory
  {
    public string Name;
    private AudioCategory _parentCategory;
    private AudioFader _audioFader;
    [SerializeField]
    private string _parentCategoryName;
    public GameObject AudioObjectPrefab;
    public AudioItem[] AudioItems;
    [SerializeField]
    private float _volume = 1f;
    public AudioMixerGroup audioMixerGroup;

    public float Volume
    {
      get => this._volume;
      set
      {
        this._volume = value;
        this._ApplyVolumeChange();
      }
    }

    public float VolumeTotal
    {
      get
      {
        this._UpdateFadeTime();
        float num = this.audioFader.Get();
        return this.parentCategory != null ? this.parentCategory.VolumeTotal * this._volume * num : this._volume * num;
      }
    }

    public AudioCategory parentCategory
    {
      set
      {
        this._parentCategory = value;
        if (value != null)
          this._parentCategoryName = this._parentCategory.Name;
        else
          this._parentCategoryName = (string) null;
      }
      get
      {
        if (string.IsNullOrEmpty(this._parentCategoryName))
          return (AudioCategory) null;
        if (this._parentCategory == null)
        {
          if ((UnityEngine.Object) this.audioController != (UnityEngine.Object) null)
            this._parentCategory = this.audioController._GetCategory(this._parentCategoryName);
          else
            Debug.LogWarning((object) "_audioController == null");
        }
        return this._parentCategory;
      }
    }

    private AudioFader audioFader
    {
      get
      {
        if (this._audioFader == null)
          this._audioFader = new AudioFader();
        return this._audioFader;
      }
    }

    public AudioController audioController { get; set; }

    public AudioCategory(AudioController audioController) => this.audioController = audioController;

    public GameObject GetAudioObjectPrefab()
    {
      if ((UnityEngine.Object) this.AudioObjectPrefab != (UnityEngine.Object) null)
        return this.AudioObjectPrefab;
      return this.parentCategory != null ? this.parentCategory.GetAudioObjectPrefab() : this.audioController.AudioObjectPrefab;
    }

    public AudioMixerGroup GetAudioMixerGroup()
    {
      if ((UnityEngine.Object) this.audioMixerGroup != (UnityEngine.Object) null)
        return this.audioMixerGroup;
      return this.parentCategory != null ? this.parentCategory.GetAudioMixerGroup() : (AudioMixerGroup) null;
    }

    internal void _AnalyseAudioItems(Dictionary<string, AudioItem> audioItemsDict)
    {
      if (this.AudioItems == null)
        return;
      foreach (AudioItem audioItem in this.AudioItems)
      {
        if (audioItem != null)
        {
          audioItem._Initialize(this);
          if (audioItemsDict != null)
          {
            try
            {
              audioItemsDict.Add(audioItem.Name, audioItem);
            }
            catch (ArgumentException ex)
            {
              Debug.LogWarning((object) ("Multiple audio items with name '" + audioItem.Name + "'"), (UnityEngine.Object) this.audioController);
            }
          }
        }
      }
    }

    internal int _GetIndexOf(AudioItem audioItem)
    {
      if (this.AudioItems == null)
        return -1;
      for (int index = 0; index < this.AudioItems.Length; ++index)
      {
        if (audioItem == this.AudioItems[index])
          return index;
      }
      return -1;
    }

    private void _ApplyVolumeChange()
    {
      List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects();
      for (int index = 0; index < playingAudioObjects.Count; ++index)
      {
        AudioObject audioObject = playingAudioObjects[index];
        if (this._IsCategoryParentOf(audioObject.category, this))
          audioObject._ApplyVolumeBoth();
      }
    }

    private bool _IsCategoryParentOf(AudioCategory toTest, AudioCategory parent)
    {
      for (AudioCategory audioCategory = toTest; audioCategory != null; audioCategory = audioCategory.parentCategory)
      {
        if (audioCategory == parent)
          return true;
      }
      return false;
    }

    public void UnloadAllAudioClips()
    {
      for (int index = 0; index < this.AudioItems.Length; ++index)
        this.AudioItems[index].UnloadAudioClip();
    }

    public void FadeIn(float fadeInTime, bool stopCurrentFadeOut = true)
    {
      this._UpdateFadeTime();
      this.audioFader.FadeIn(fadeInTime, stopCurrentFadeOut);
    }

    public void FadeOut(float fadeOutLength, float startToFadeTime = 0.0f)
    {
      this._UpdateFadeTime();
      this.audioFader.FadeOut(fadeOutLength, startToFadeTime);
    }

    private void _UpdateFadeTime() => this.audioFader.time = AudioController.systemTime;

    public bool isFadingIn => this.audioFader.isFadingIn;

    public bool isFadingOut => this.audioFader.isFadingOut;

    public bool isFadeOutComplete => this.audioFader.isFadingOutComplete;
  }
}
