// Decompiled with JetBrains decompiler
// Type: ClockStone.AudioObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Audio;

namespace ClockStone
{
  [RequireComponent(typeof (AudioSource))]
  [AddComponentMenu("ClockStone/Audio/AudioObject")]
  public class AudioObject : RegisteredComponent
  {
    [NonSerialized]
    private AudioCategory _category;
    private AudioSubItem _subItemPrimary;
    private AudioSubItem _subItemSecondary;
    private AudioObject.AudioEventDelegate _completelyPlayedDelegate;
    private int _pauseCoroutineCounter;
    private bool areSources1and2Swapped;
    internal float _volumeExcludingCategory = 1f;
    private float _volumeFromPrimaryFade = 1f;
    private float _volumeFromSecondaryFade = 1f;
    internal float _volumeFromScriptCall = 1f;
    private bool _paused;
    private bool _applicationPaused;
    private AudioFader _primaryFader;
    private AudioFader _secondaryFader;
    private double _playTime = -1.0;
    private double _playStartTimeLocal = -1.0;
    private double _playStartTimeSystem = -1.0;
    private double _playScheduledTimeDsp = -1.0;
    private double _audioObjectTime;
    private bool _IsInactive = true;
    private bool _stopRequested;
    private bool _finishSequence;
    private int _loopSequenceCount;
    private bool _stopAfterFadeoutUserSetting;
    private bool _pauseWithFadeOutRequested;
    private double _dspTimeRemainingAtPause;
    private AudioController _audioController;
    internal bool _isCurrentPlaylistTrack;
    internal float _audioSource_MinDistance_Saved = 1f;
    internal float _audioSource_MaxDistance_Saved = 500f;
    internal float _audioSource_SpatialBlend_Saved;
    private AudioMixerGroup _audioMixerGroup;
    internal int _lastChosenSubItemIndex = -1;
    private AudioSource _audioSource1;
    private AudioSource _audioSource2;
    private bool _primaryAudioSourcePaused;
    private bool _secondaryAudioSourcePaused;
    private bool _primarySourceWasPlayingWhenDisabled;
    private bool _primarySourceWasPlayingLastUpdate;
    private bool _secondarySourceWasPlayingWhenDisabled;
    private bool _secondarySourceWasPlayingLastUpdate;
    private const float VOLUME_TRANSFORM_POWER = 1.6f;

    public string audioID { get; internal set; }

    public AudioCategory category
    {
      get => this._category;
      internal set => this._category = value;
    }

    public AudioSubItem subItem
    {
      get => this._subItemPrimary;
      internal set => this._subItemPrimary = value;
    }

    public AudioChannelType channel { get; internal set; }

    public AudioItem audioItem => this.subItem != null ? this.subItem.item : (AudioItem) null;

    public AudioObject.AudioEventDelegate completelyPlayedDelegate
    {
      set => this._completelyPlayedDelegate = value;
      get => this._completelyPlayedDelegate;
    }

    public float volume
    {
      get => this._volumeWithCategory;
      set
      {
        float volumeFromCategory = this._volumeFromCategory;
        this._volumeExcludingCategory = (double) volumeFromCategory <= 0.0 ? value : value / volumeFromCategory;
        this._ApplyVolumeBoth();
      }
    }

    public float volumeItem
    {
      get => (double) this._volumeFromScriptCall > 0.0 ? this._volumeExcludingCategory / this._volumeFromScriptCall : this._volumeExcludingCategory;
      set
      {
        this._volumeExcludingCategory = value * this._volumeFromScriptCall;
        this._ApplyVolumeBoth();
      }
    }

    public float volumeTotal => this.volumeTotalWithoutFade * this._volumeFromPrimaryFade;

    public float volumeTotalWithoutFade
    {
      get
      {
        float num = this._volumeWithCategory;
        AudioController audioController = this.category == null ? this._audioController : this.category.audioController;
        if ((UnityEngine.Object) audioController != (UnityEngine.Object) null)
        {
          num *= audioController.Volume;
          if (audioController.soundMuted && this.channel == AudioChannelType.Default)
            num = 0.0f;
        }
        return num;
      }
    }

    public double playCalledAtTime => this._playTime;

    public double startedPlayingAtTime => this._playStartTimeSystem;

    public float timeUntilEnd => this.clipLength - this.audioTime;

    public double scheduledPlayingAtDspTime
    {
      get => this._playScheduledTimeDsp;
      set
      {
        this._playScheduledTimeDsp = value;
        this.primaryAudioSource.SetScheduledStartTime(this._playScheduledTimeDsp);
      }
    }

    public float clipLength
    {
      get
      {
        if ((double) this._stopClipAtTime > 0.0)
          return this._stopClipAtTime - this._startClipAtTime;
        return (UnityEngine.Object) this.primaryAudioSource.clip != (UnityEngine.Object) null ? this.primaryAudioSource.clip.length - this._startClipAtTime : 0.0f;
      }
    }

    public float audioTime
    {
      get => this.primaryAudioSource.time - this._startClipAtTime;
      set => this.primaryAudioSource.time = value + this._startClipAtTime;
    }

    public bool isFadingOut => this._primaryFader.isFadingOut;

    public bool isFadeOutComplete => this._primaryFader.isFadingOutComplete;

    public bool isFadingOutOrScheduled => this._primaryFader.isFadingOutOrScheduled;

    public bool isFadingIn => this._primaryFader.isFadingIn;

    public float pitch
    {
      get => this.primaryAudioSource.pitch;
      set => this.primaryAudioSource.pitch = value;
    }

    public float pan
    {
      get => this.primaryAudioSource.panStereo;
      set => this.primaryAudioSource.panStereo = value;
    }

    public double audioObjectTime => this._audioObjectTime;

    public bool stopAfterFadeOut
    {
      get => this._stopAfterFadeoutUserSetting;
      set => this._stopAfterFadeoutUserSetting = value;
    }

    public void FadeIn(float fadeInTime)
    {
      if (this._playStartTimeLocal > 0.0 && this._playStartTimeLocal - this.audioObjectTime > 0.0)
      {
        this._primaryFader.FadeIn(fadeInTime, this._playStartTimeLocal);
        this._UpdateFadeVolume();
      }
      else
      {
        this._primaryFader.FadeIn(fadeInTime, this.audioObjectTime, !this._shouldStopIfPrimaryFadedOut);
        this._UpdateFadeVolume();
      }
    }

    public void PlayScheduled(double dspTime) => this._PlayScheduled(dspTime);

    public void PlayAfter(string audioID, double deltaDspTime = 0.0, float volume = 1f, float startTime = 0.0f) => AudioController.PlayAfter(audioID, this, deltaDspTime, volume, startTime);

    public void PlayNow(string audioID, float delay = 0.0f, float volume = 1f, float startTime = 0.0f)
    {
      AudioItem audioItem = AudioController.GetAudioItem(audioID);
      if (audioItem == null)
        Debug.LogWarning((object) ("Audio item with name '" + audioID + "' does not exist"));
      else
        this._audioController.PlayAudioItem(audioItem, volume, this.transform.position, this.transform.parent, delay, startTime, useExistingAudioObj: this);
    }

    public void Play(float delay = 0.0f) => this._PlayDelayed(delay);

    public void Stop() => this.Stop(-1f);

    public void Stop(float fadeOutLength) => this.Stop(fadeOutLength, 0.0f);

    public void Stop(float fadeOutLength, float startToFadeTime)
    {
      if (this.IsPaused(false))
      {
        fadeOutLength = 0.0f;
        startToFadeTime = 0.0f;
      }
      if ((double) startToFadeTime > 0.0)
      {
        this.StartCoroutine(this._WaitForSecondsThenStop(startToFadeTime, fadeOutLength));
      }
      else
      {
        this._stopRequested = true;
        if ((double) fadeOutLength < 0.0)
          fadeOutLength = this.subItem == null ? 0.0f : this.subItem.FadeOut;
        if ((double) fadeOutLength == 0.0 && (double) startToFadeTime == 0.0)
        {
          this._Stop();
        }
        else
        {
          this.FadeOut(fadeOutLength, startToFadeTime);
          if (!this.IsSecondaryPlaying())
            return;
          this.SwitchAudioSources();
          this.FadeOut(fadeOutLength, startToFadeTime);
          this.SwitchAudioSources();
        }
      }
    }

    public void FinishSequence()
    {
      if (this._finishSequence)
        return;
      AudioItem audioItem = this.audioItem;
      if (audioItem == null)
        return;
      switch (audioItem.Loop)
      {
        case AudioItem.LoopMode.LoopSequence:
        case AudioItem.LoopMode.LoopSubitem | AudioItem.LoopMode.LoopSequence:
          this._finishSequence = true;
          break;
        case AudioItem.LoopMode.PlaySequenceAndLoopLast:
        case AudioItem.LoopMode.IntroLoopOutroSequence:
          this.primaryAudioSource.loop = false;
          this._finishSequence = true;
          break;
      }
    }

    private IEnumerator _WaitForSecondsThenStop(
      float startToFadeTime,
      float fadeOutLength)
    {
      yield return (object) new WaitForSeconds(startToFadeTime);
      if (!this._IsInactive)
        this.Stop(fadeOutLength);
    }

    public void FadeOut(float fadeOutLength) => this.FadeOut(fadeOutLength, 0.0f);

    public void FadeOut(float fadeOutLength, float startToFadeTime)
    {
      if ((double) fadeOutLength < 0.0)
        fadeOutLength = this.subItem == null ? 0.0f : this.subItem.FadeOut;
      if ((double) fadeOutLength > 0.0 || (double) startToFadeTime > 0.0)
      {
        this._primaryFader.FadeOut(fadeOutLength, startToFadeTime);
      }
      else
      {
        if ((double) fadeOutLength != 0.0)
          return;
        if (this._shouldStopIfPrimaryFadedOut)
          this._Stop();
        else
          this._primaryFader.FadeOut(0.0f, startToFadeTime);
      }
    }

    public void Pause() => this.Pause(0.0f);

    public void Pause(float fadeOutTime)
    {
      if (this._paused)
        return;
      this._paused = true;
      if ((double) fadeOutTime > 0.0)
      {
        this._pauseWithFadeOutRequested = true;
        this.FadeOut(fadeOutTime);
        this.StartCoroutine(this._WaitThenPause(fadeOutTime, ++this._pauseCoroutineCounter));
      }
      else
        this._PauseNow();
    }

    private void _PauseNow()
    {
      if (this._playScheduledTimeDsp > 0.0)
      {
        this._dspTimeRemainingAtPause = this._playScheduledTimeDsp - AudioSettings.dspTime;
        this.scheduledPlayingAtDspTime = 9000000000.0;
      }
      this._PauseAudioSources();
      if (!this._pauseWithFadeOutRequested)
        return;
      this._pauseWithFadeOutRequested = false;
      this._primaryFader.Set0();
    }

    public void Unpause() => this.Unpause(0.0f);

    public void Unpause(float fadeInTime)
    {
      if (!this._paused)
        return;
      this._UnpauseNow();
      if ((double) fadeInTime > 0.0)
        this.FadeIn(fadeInTime);
      this._pauseWithFadeOutRequested = false;
    }

    private void _UnpauseNow()
    {
      this._paused = false;
      if ((bool) (UnityEngine.Object) this.secondaryAudioSource && this._secondaryAudioSourcePaused)
        this.secondaryAudioSource.Play();
      if (this._dspTimeRemainingAtPause > 0.0 && this._primaryAudioSourcePaused)
      {
        double time = AudioSettings.dspTime + this._dspTimeRemainingAtPause;
        this._playStartTimeSystem = AudioController.systemTime + this._dspTimeRemainingAtPause;
        this.primaryAudioSource.PlayScheduled(time);
        this.scheduledPlayingAtDspTime = time;
        this._dspTimeRemainingAtPause = -1.0;
      }
      else
      {
        if (!this._primaryAudioSourcePaused)
          return;
        this.primaryAudioSource.Play();
      }
    }

    private IEnumerator _WaitThenPause(float waitTime, int counter)
    {
      yield return (object) new WaitForSeconds(waitTime);
      if (this._pauseWithFadeOutRequested && counter == this._pauseCoroutineCounter)
        this._PauseNow();
    }

    private void _PauseAudioSources()
    {
      if (this.primaryAudioSource.isPlaying)
      {
        this._primaryAudioSourcePaused = true;
        this.primaryAudioSource.Pause();
      }
      else
        this._primaryAudioSourcePaused = false;
      if ((bool) (UnityEngine.Object) this.secondaryAudioSource && this.secondaryAudioSource.isPlaying)
      {
        this._secondaryAudioSourcePaused = true;
        this.secondaryAudioSource.Pause();
      }
      else
        this._secondaryAudioSourcePaused = false;
    }

    public bool IsPaused(bool returnTrueIfStillFadingOut = true) => (returnTrueIfStillFadingOut || !this._pauseWithFadeOutRequested) && this._paused;

    public bool IsPlaying() => this.IsPrimaryPlaying() || this.IsSecondaryPlaying();

    public bool IsPrimaryPlaying() => this.primaryAudioSource.isPlaying;

    public bool IsSecondaryPlaying() => (UnityEngine.Object) this.secondaryAudioSource != (UnityEngine.Object) null && this.secondaryAudioSource.isPlaying;

    public AudioSource primaryAudioSource => this._audioSource1;

    public AudioSource secondaryAudioSource => this._audioSource2;

    public void SwitchAudioSources()
    {
      if ((UnityEngine.Object) this._audioSource2 == (UnityEngine.Object) null)
        this._CreateSecondAudioSource();
      this._SwitchValues<AudioSource>(ref this._audioSource1, ref this._audioSource2);
      this._SwitchValues<AudioFader>(ref this._primaryFader, ref this._secondaryFader);
      this._SwitchValues<AudioSubItem>(ref this._subItemPrimary, ref this._subItemSecondary);
      this._SwitchValues<float>(ref this._volumeFromPrimaryFade, ref this._volumeFromSecondaryFade);
      this.areSources1and2Swapped = !this.areSources1and2Swapped;
    }

    private void _SwitchValues<T>(ref T v1, ref T v2)
    {
      T obj = v1;
      v1 = v2;
      v2 = obj;
    }

    internal float _volumeFromCategory => this.category != null ? this.category.VolumeTotal : 1f;

    internal float _volumeWithCategory => this._volumeFromCategory * this._volumeExcludingCategory;

    private float _stopClipAtTime => this.subItem == null ? 0.0f : this.subItem.ClipStopTime;

    private float _startClipAtTime => this.subItem == null ? 0.0f : this.subItem.ClipStartTime;

    protected override void Awake()
    {
      base.Awake();
      if (this._primaryFader == null)
        this._primaryFader = new AudioFader();
      else
        this._primaryFader.Set0();
      if (this._secondaryFader == null)
        this._secondaryFader = new AudioFader();
      else
        this._secondaryFader.Set0();
      if ((UnityEngine.Object) this._audioSource1 == (UnityEngine.Object) null)
      {
        AudioSource[] components = this.GetComponents<AudioSource>();
        if (components.Length == 0)
        {
          Debug.LogError((object) "AudioObject does not have an AudioSource component!");
        }
        else
        {
          this._audioSource1 = components[0];
          if (components.Length >= 2)
            this._audioSource2 = components[1];
        }
      }
      else if ((bool) (UnityEngine.Object) this._audioSource2 && this.areSources1and2Swapped)
        this.SwitchAudioSources();
      this._audioMixerGroup = this.primaryAudioSource.outputAudioMixerGroup;
      this._Set0();
      this._audioController = SingletonMonoBehaviour<AudioController>.Instance;
    }

    private void OnEnable()
    {
      if (this._primarySourceWasPlayingWhenDisabled)
      {
        this._primarySourceWasPlayingWhenDisabled = false;
        this.primaryAudioSource.Play();
      }
      if (!this._secondarySourceWasPlayingWhenDisabled)
        return;
      this._secondarySourceWasPlayingWhenDisabled = false;
      this.secondaryAudioSource.Play();
    }

    private void OnDisable()
    {
      if (this._IsInactive || this.IsPaused(false))
        return;
      this._primarySourceWasPlayingWhenDisabled = (UnityEngine.Object) this.primaryAudioSource != (UnityEngine.Object) null && this._primarySourceWasPlayingLastUpdate;
      this._secondarySourceWasPlayingWhenDisabled = (UnityEngine.Object) this.secondaryAudioSource != (UnityEngine.Object) null && this._secondarySourceWasPlayingLastUpdate;
    }

    private void _CreateSecondAudioSource()
    {
      this._audioSource2 = this.gameObject.AddComponent<AudioSource>();
      this._audioSource2.rolloffMode = this._audioSource1.rolloffMode;
      this._audioSource2.minDistance = this._audioSource1.minDistance;
      this._audioSource2.maxDistance = this._audioSource1.maxDistance;
      this._audioSource2.dopplerLevel = this._audioSource1.dopplerLevel;
      this._audioSource2.spread = this._audioSource1.spread;
      this._audioSource2.spatialBlend = this._audioSource1.spatialBlend;
      this._audioSource2.outputAudioMixerGroup = this._audioSource1.outputAudioMixerGroup;
      this._audioSource2.velocityUpdateMode = this._audioSource1.velocityUpdateMode;
      this._audioSource2.ignoreListenerVolume = this._audioSource1.ignoreListenerVolume;
      this._audioSource2.playOnAwake = false;
      this._audioSource2.priority = this._audioSource1.priority;
      this._audioSource2.bypassEffects = this._audioSource1.bypassEffects;
      this._audioSource2.ignoreListenerPause = this._audioSource1.ignoreListenerPause;
      this._audioSource2.bypassListenerEffects = this._audioSource1.bypassListenerEffects;
      this._audioSource2.bypassReverbZones = this._audioSource1.bypassReverbZones;
      this._audioSource2.reverbZoneMix = this._audioSource1.reverbZoneMix;
    }

    private void _Set0()
    {
      this._SetReferences0();
      this._audioObjectTime = 0.0;
      this.primaryAudioSource.playOnAwake = false;
      if ((bool) (UnityEngine.Object) this.secondaryAudioSource)
        this.secondaryAudioSource.playOnAwake = false;
      this._lastChosenSubItemIndex = -1;
      this._primaryFader.Set0();
      this._secondaryFader.Set0();
      this._playTime = -1.0;
      this._playStartTimeLocal = -1.0;
      this._playStartTimeSystem = -1.0;
      this._playScheduledTimeDsp = -1.0;
      this._volumeFromPrimaryFade = 1f;
      this._volumeFromSecondaryFade = 1f;
      this._volumeFromScriptCall = 1f;
      this._IsInactive = true;
      this._stopRequested = false;
      this._finishSequence = false;
      this._volumeExcludingCategory = 1f;
      this._paused = false;
      this._applicationPaused = false;
      this._isCurrentPlaylistTrack = false;
      this._loopSequenceCount = 0;
      this._stopAfterFadeoutUserSetting = true;
      this._pauseWithFadeOutRequested = false;
      this._dspTimeRemainingAtPause = -1.0;
      this._primaryAudioSourcePaused = false;
      this._secondaryAudioSourcePaused = false;
      this._primarySourceWasPlayingWhenDisabled = false;
      this._secondarySourceWasPlayingWhenDisabled = false;
      this._primarySourceWasPlayingLastUpdate = false;
      this._secondarySourceWasPlayingLastUpdate = false;
    }

    private void _SetReferences0()
    {
      this._audioController = (AudioController) null;
      this.primaryAudioSource.clip = (AudioClip) null;
      if ((UnityEngine.Object) this.secondaryAudioSource != (UnityEngine.Object) null)
      {
        this.secondaryAudioSource.playOnAwake = false;
        this.secondaryAudioSource.clip = (AudioClip) null;
      }
      this.subItem = (AudioSubItem) null;
      this.category = (AudioCategory) null;
      this._completelyPlayedDelegate = (AudioObject.AudioEventDelegate) null;
    }

    private void _PlayScheduled(double dspTime)
    {
      if (!(bool) (UnityEngine.Object) this.primaryAudioSource.clip)
      {
        Debug.LogError((object) ("audio.clip == null in " + this.gameObject.name));
      }
      else
      {
        this._playScheduledTimeDsp = dspTime;
        double num = dspTime - AudioSettings.dspTime;
        this._playStartTimeLocal = num + this.audioObjectTime;
        this._playStartTimeSystem = num + AudioController.systemTime;
        this.primaryAudioSource.PlayScheduled(dspTime);
        this._OnPlay();
      }
    }

    private void _PlayDelayed(float delay)
    {
      if (!(bool) (UnityEngine.Object) this.primaryAudioSource.clip)
      {
        Debug.LogError((object) ("audio.clip == null in " + this.gameObject.name));
      }
      else
      {
        this.primaryAudioSource.PlayDelayed(delay);
        this._playScheduledTimeDsp = -1.0;
        this._playStartTimeLocal = this.audioObjectTime + (double) delay;
        this._playStartTimeSystem = AudioController.systemTime + (double) delay;
        this._OnPlay();
      }
    }

    private void _OnPlay()
    {
      this._IsInactive = false;
      this._playTime = this.audioObjectTime;
      this._paused = false;
      this._primaryAudioSourcePaused = false;
      this._secondaryAudioSourcePaused = false;
      this._primaryFader.Set0();
    }

    private void _Stop()
    {
      this._primaryFader.Set0();
      this._secondaryFader.Set0();
      this.primaryAudioSource.Stop();
      if ((bool) (UnityEngine.Object) this.secondaryAudioSource)
        this.secondaryAudioSource.Stop();
      this._paused = false;
      this._primaryAudioSourcePaused = false;
      this._secondaryAudioSourcePaused = false;
      this._primarySourceWasPlayingLastUpdate = false;
      this._secondarySourceWasPlayingLastUpdate = false;
    }

    private void Update()
    {
      if (this._IsInactive)
        return;
      if (!this.IsPaused(false))
      {
        this._audioObjectTime += AudioController.systemDeltaTime;
        this._primaryFader.time = this._audioObjectTime;
        this._secondaryFader.time = this._audioObjectTime;
      }
      if (this._playScheduledTimeDsp > 0.0 && this._audioObjectTime > this._playStartTimeLocal)
        this._playScheduledTimeDsp = -1.0;
      bool flag1 = this.IsPrimaryPlaying();
      bool flag2 = this.IsSecondaryPlaying();
      this._primarySourceWasPlayingLastUpdate = flag1;
      this._secondarySourceWasPlayingLastUpdate = flag2;
      if (!this._paused && !this._applicationPaused)
      {
        if (!flag1 && !flag2)
        {
          bool flag3 = true;
          if (!this._stopRequested && flag3 && this.completelyPlayedDelegate != null)
          {
            this.completelyPlayedDelegate(this);
            flag3 = !this.IsPlaying();
          }
          if (this._isCurrentPlaylistTrack && (bool) (UnityEngine.Object) SingletonMonoBehaviour<AudioController>.DoesInstanceExist())
            SingletonMonoBehaviour<AudioController>.Instance._NotifyPlaylistTrackCompleteleyPlayed(this);
          if (flag3)
          {
            this.DestroyAudioObject();
            return;
          }
        }
        else
        {
          if (!this._stopRequested && this._IsAudioLoopSequenceMode() && !this.IsSecondaryPlaying() && (double) this.timeUntilEnd < 1.0 + (double) Mathf.Max(0.0f, this.audioItem.loopSequenceOverlap) && this._playScheduledTimeDsp < 0.0)
            this._ScheduleNextInLoopSequence();
          if (!this.primaryAudioSource.loop)
          {
            if (this._isCurrentPlaylistTrack && (bool) (UnityEngine.Object) this._audioController && this._audioController.crossfadePlaylist && (double) this.audioTime > (double) this.clipLength - (double) this._audioController.musicCrossFadeTime_Out)
            {
              if ((bool) (UnityEngine.Object) SingletonMonoBehaviour<AudioController>.DoesInstanceExist())
                SingletonMonoBehaviour<AudioController>.Instance._NotifyPlaylistTrackCompleteleyPlayed(this);
            }
            else
            {
              this._StartFadeOutIfNecessary();
              if (flag2)
              {
                this.SwitchAudioSources();
                this._StartFadeOutIfNecessary();
                this.SwitchAudioSources();
              }
            }
          }
        }
      }
      this._UpdateFadeVolume();
    }

    private void _StartFadeOutIfNecessary()
    {
      if (this.subItem == null)
      {
        Debug.LogWarning((object) "subItem == null");
      }
      else
      {
        float audioTime = this.audioTime;
        float num = 0.0f;
        if ((double) this.subItem.FadeOut > 0.0)
          num = this.subItem.FadeOut;
        else if ((double) this._stopClipAtTime > 0.0)
          num = 0.1f;
        if (this.isFadingOutOrScheduled || (double) num <= 0.0 || (double) audioTime <= (double) this.clipLength - (double) num)
          return;
        this.FadeOut(this.subItem.FadeOut);
      }
    }

    private bool _IsAudioLoopSequenceMode()
    {
      AudioItem audioItem = this.audioItem;
      if (audioItem != null)
      {
        switch (audioItem.Loop)
        {
          case AudioItem.LoopMode.LoopSequence:
          case AudioItem.LoopMode.LoopSubitem | AudioItem.LoopMode.LoopSequence:
            return true;
          case AudioItem.LoopMode.PlaySequenceAndLoopLast:
          case AudioItem.LoopMode.IntroLoopOutroSequence:
            return !this.primaryAudioSource.loop;
        }
      }
      return false;
    }

    private bool _ScheduleNextInLoopSequence()
    {
      int num = this.audioItem.loopSequenceCount <= 0 ? this.audioItem.subItems.Length : this.audioItem.loopSequenceCount;
      if (this._finishSequence && (this.audioItem.Loop != AudioItem.LoopMode.IntroLoopOutroSequence || this._loopSequenceCount <= num - 3 || this._loopSequenceCount >= num - 1) || this.audioItem.loopSequenceCount > 0 && this.audioItem.loopSequenceCount <= this._loopSequenceCount + 1)
        return false;
      double dspTime = AudioSettings.dspTime + (double) this.timeUntilEnd + (double) this._GetRandomLoopSequenceDelay(this.audioItem);
      AudioItem audioItem = this.audioItem;
      this.SwitchAudioSources();
      this._audioController.PlayAudioItem(audioItem, this._volumeFromScriptCall, Vector3.zero, useExistingAudioObj: this, dspTime: dspTime);
      ++this._loopSequenceCount;
      if (this.audioItem.Loop == AudioItem.LoopMode.PlaySequenceAndLoopLast || this.audioItem.Loop == AudioItem.LoopMode.IntroLoopOutroSequence)
      {
        if (this.audioItem.Loop == AudioItem.LoopMode.IntroLoopOutroSequence)
        {
          if (!this._finishSequence && num <= this._loopSequenceCount + 2)
            this.primaryAudioSource.loop = true;
        }
        else if (num <= this._loopSequenceCount + 1)
          this.primaryAudioSource.loop = true;
      }
      return true;
    }

    private void _UpdateFadeVolume()
    {
      bool finishedFadeOut;
      float num1 = this._EqualizePowerForCrossfading(this._primaryFader.Get(out finishedFadeOut));
      if (finishedFadeOut)
      {
        if (this._stopRequested)
        {
          this._Stop();
          return;
        }
        if (!this._IsAudioLoopSequenceMode())
        {
          if (!this._shouldStopIfPrimaryFadedOut)
            return;
          this._Stop();
          return;
        }
      }
      if ((double) num1 != (double) this._volumeFromPrimaryFade)
        this._volumeFromPrimaryFade = num1;
      this._ApplyVolumePrimary();
      if (!((UnityEngine.Object) this._audioSource2 != (UnityEngine.Object) null))
        return;
      float num2 = this._EqualizePowerForCrossfading(this._secondaryFader.Get(out finishedFadeOut));
      if (finishedFadeOut)
      {
        this._audioSource2.Stop();
      }
      else
      {
        if ((double) num2 == (double) this._volumeFromSecondaryFade)
          return;
        this._volumeFromSecondaryFade = num2;
        this._ApplyVolumeSecondary();
      }
    }

    private float _EqualizePowerForCrossfading(float v) => !this._audioController.EqualPowerCrossfade ? v : AudioObject.InverseTransformVolume(Mathf.Sin((float) ((double) v * 3.14159274101257 * 0.5)));

    private bool _shouldStopIfPrimaryFadedOut => this._stopAfterFadeoutUserSetting && !this._pauseWithFadeOutRequested;

    private void OnApplicationPause(bool b) => this.SetApplicationPaused(b);

    private void SetApplicationPaused(bool isPaused) => this._applicationPaused = isPaused;

    public void DestroyAudioObject()
    {
      if (this.IsPlaying())
        this._Stop();
      this._IsInactive = true;
      ObjectPoolController.Destroy(this.gameObject);
    }

    public static float TransformVolume(float volume) => Mathf.Pow(volume, 1.6f);

    public static float InverseTransformVolume(float volume) => Mathf.Pow(volume, 0.625f);

    public static float TransformPitch(float pitchSemiTones) => Mathf.Pow(2f, pitchSemiTones / 12f);

    public static float InverseTransformPitch(float pitch) => (float) ((double) Mathf.Log(pitch) / (double) Mathf.Log(2f) * 12.0);

    internal void _ApplyVolumeBoth()
    {
      float totalWithoutFade = this.volumeTotalWithoutFade;
      this.primaryAudioSource.volume = AudioObject.TransformVolume(totalWithoutFade * this._volumeFromPrimaryFade);
      if (!(bool) (UnityEngine.Object) this.secondaryAudioSource)
        return;
      this.secondaryAudioSource.volume = AudioObject.TransformVolume(totalWithoutFade * this._volumeFromSecondaryFade);
    }

    internal void _ApplyVolumePrimary(float volumeMultiplier = 1f)
    {
      float num = AudioObject.TransformVolume(this.volumeTotalWithoutFade * this._volumeFromPrimaryFade * volumeMultiplier);
      if ((double) this.primaryAudioSource.volume == (double) num)
        return;
      this.primaryAudioSource.volume = num;
    }

    internal void _ApplyVolumeSecondary(float volumeMultiplier = 1f)
    {
      if (!(bool) (UnityEngine.Object) this.secondaryAudioSource)
        return;
      float num = AudioObject.TransformVolume(this.volumeTotalWithoutFade * this._volumeFromSecondaryFade * volumeMultiplier);
      if ((double) this.secondaryAudioSource.volume == (double) num)
        return;
      this.secondaryAudioSource.volume = num;
    }

    protected override void OnDestroy()
    {
      base.OnDestroy();
      AudioItem audioItem = this.audioItem;
      if (audioItem != null && audioItem.overrideAudioSourceSettings)
        this._RestoreOverrideAudioSourceSettings();
      this._SetReferences0();
      this.primaryAudioSource.outputAudioMixerGroup = this._audioMixerGroup;
    }

    private void _RestoreOverrideAudioSourceSettings()
    {
      this.primaryAudioSource.minDistance = this._audioSource_MinDistance_Saved;
      this.primaryAudioSource.maxDistance = this._audioSource_MaxDistance_Saved;
      this.primaryAudioSource.spatialBlend = this._audioSource_SpatialBlend_Saved;
      if (!((UnityEngine.Object) this.secondaryAudioSource != (UnityEngine.Object) null))
        return;
      this.secondaryAudioSource.minDistance = this._audioSource_MinDistance_Saved;
      this.secondaryAudioSource.maxDistance = this._audioSource_MaxDistance_Saved;
      this.secondaryAudioSource.spatialBlend = this._audioSource_SpatialBlend_Saved;
    }

    public bool DoesBelongToCategory(string categoryName)
    {
      for (AudioCategory audioCategory = this.category; audioCategory != null; audioCategory = audioCategory.parentCategory)
      {
        if (audioCategory.Name == categoryName)
          return true;
      }
      return false;
    }

    private float _GetRandomLoopSequenceDelay(AudioItem audioItem)
    {
      float num = -audioItem.loopSequenceOverlap;
      if ((double) audioItem.loopSequenceRandomDelay > 0.0)
        num += UnityEngine.Random.Range(0.0f, audioItem.loopSequenceRandomDelay);
      return num;
    }

    public delegate void AudioEventDelegate(AudioObject audioObject);
  }
}
