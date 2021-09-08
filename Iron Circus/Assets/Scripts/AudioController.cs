// Decompiled with JetBrains decompiler
// Type: AudioController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ClockStone;
using Imi.Diagnostics;
using System;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("ClockStone/Audio/AudioController")]
public class AudioController : 
  SingletonMonoBehaviour<AudioController>,
  ISerializationCallbackReceiver
{
  public const string AUDIO_TOOLKIT_VERSION = "9.0";
  public GameObject AudioObjectPrefab;
  public bool Persistent;
  public bool UnloadAudioClipsOnDestroy;
  public bool UsePooledAudioObjects = true;
  public bool PlayWithZeroVolume;
  public bool EqualPowerCrossfade;
  public float musicCrossFadeTime;
  public float ambienceSoundCrossFadeTime;
  public bool specifyCrossFadeInAndOutSeperately;
  [SerializeField]
  private float _musicCrossFadeTime_In;
  [SerializeField]
  private float _musicCrossFadeTime_Out;
  [SerializeField]
  private float _ambienceSoundCrossFadeTime_In;
  [SerializeField]
  private float _ambienceSoundCrossFadeTime_Out;
  public AudioCategory[] AudioCategories;
  public Playlist[] musicPlaylists = new Playlist[1];
  public Action<Playlist> playlistFinishedEvent;
  [Obsolete]
  public string[] musicPlaylist;
  public bool loopPlaylist;
  public bool shufflePlaylist;
  public bool crossfadePlaylist;
  public float delayBetweenPlaylistTracks = 1f;
  protected static PoolableReference<AudioObject> _currentMusicReference = new PoolableReference<AudioObject>();
  protected static PoolableReference<AudioObject> _currentAmbienceReference = new PoolableReference<AudioObject>();
  private string _currentPlaylistName;
  protected AudioListener _currentAudioListener;
  private static Transform _musicParent = (Transform) null;
  private static Transform _ambienceParent = (Transform) null;
  private bool _musicEnabled = true;
  private bool _ambienceSoundEnabled = true;
  private bool _soundMuted;
  private bool _categoriesValidated;
  [SerializeField]
  private bool _isAdditionalAudioController;
  [SerializeField]
  private bool _audioDisabled;
  private Dictionary<string, AudioItem> _audioItems;
  private static List<int> _playlistPlayed;
  private static bool _isPlaylistPlaying = false;
  [SerializeField]
  private float _volume = 1f;
  private static double _systemTime;
  private static double _lastSystemTime = -1.0;
  private static double _systemDeltaTime = -1.0;
  private static List<AudioController> _additionalControllerToRegister;
  private List<AudioController> _additionalAudioControllers;
  public AudioController_CurrentInspectorSelection _currentInspectorSelection = new AudioController_CurrentInspectorSelection();

  public bool DisableAudio
  {
    set
    {
      if (value == this._audioDisabled)
        return;
      int num = value ? 1 : 0;
      this._audioDisabled = value;
    }
    get => this._audioDisabled;
  }

  public bool isAdditionalAudioController
  {
    get => this._isAdditionalAudioController;
    set => this._isAdditionalAudioController = value;
  }

  public float Volume
  {
    get => this._volume;
    set
    {
      if ((double) value == (double) this._volume)
        return;
      this._volume = value;
      this._ApplyVolumeChange();
    }
  }

  public bool musicEnabled
  {
    get => this._musicEnabled;
    set
    {
      if (this._musicEnabled == value)
        return;
      this._musicEnabled = value;
      if (!(bool) (UnityEngine.Object) AudioController._currentMusic)
        return;
      if (value)
      {
        if (!AudioController._currentMusic.IsPaused())
          return;
        AudioController._currentMusic.Play();
      }
      else
        AudioController._currentMusic.Pause();
    }
  }

  public bool ambienceSoundEnabled
  {
    get => this._ambienceSoundEnabled;
    set
    {
      if (this._ambienceSoundEnabled == value)
        return;
      this._ambienceSoundEnabled = value;
      if (!(bool) (UnityEngine.Object) AudioController._currentAmbienceSound)
        return;
      if (value)
      {
        if (!AudioController._currentAmbienceSound.IsPaused())
          return;
        AudioController._currentAmbienceSound.Play();
      }
      else
        AudioController._currentAmbienceSound.Pause();
    }
  }

  public bool soundMuted
  {
    get => this._soundMuted;
    set
    {
      this._soundMuted = value;
      this._ApplyVolumeChange();
    }
  }

  public float musicCrossFadeTime_In
  {
    get => this.specifyCrossFadeInAndOutSeperately ? this._musicCrossFadeTime_In : this.musicCrossFadeTime;
    set => this._musicCrossFadeTime_In = value;
  }

  public float musicCrossFadeTime_Out
  {
    get => this.specifyCrossFadeInAndOutSeperately ? this._musicCrossFadeTime_Out : this.musicCrossFadeTime;
    set => this._musicCrossFadeTime_Out = value;
  }

  public float ambienceSoundCrossFadeTime_In
  {
    get => this.specifyCrossFadeInAndOutSeperately ? this._ambienceSoundCrossFadeTime_In : this.ambienceSoundCrossFadeTime;
    set => this._ambienceSoundCrossFadeTime_In = value;
  }

  public float ambienceSoundCrossFadeTime_Out
  {
    get => this.specifyCrossFadeInAndOutSeperately ? this._ambienceSoundCrossFadeTime_Out : this.ambienceSoundCrossFadeTime;
    set => this._ambienceSoundCrossFadeTime_Out = value;
  }

  public static double systemTime => AudioController._systemTime;

  public static double systemDeltaTime => AudioController._systemDeltaTime;

  public static Transform musicParent
  {
    set => AudioController._musicParent = value;
    get => AudioController._musicParent;
  }

  public static Transform ambienceParent
  {
    set => AudioController._ambienceParent = value;
    get => AudioController._ambienceParent;
  }

  public static AudioObject PlayMusic(
    string audioID,
    float volume = 1f,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    AudioController._isPlaylistPlaying = false;
    return SingletonMonoBehaviour<AudioController>.Instance._PlayMusic(audioID, volume, delay, startTime);
  }

  public static AudioObject PlayMusic(
    string audioID,
    Vector3 worldPosition,
    Transform parentObj = null,
    float volume = 1f,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    AudioController._isPlaylistPlaying = false;
    return SingletonMonoBehaviour<AudioController>.Instance._PlayMusic(audioID, worldPosition, parentObj, volume, delay, startTime);
  }

  public static AudioObject PlayMusic(
    string audioID,
    Transform parentObj,
    float volume = 1f,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    AudioController._isPlaylistPlaying = false;
    return SingletonMonoBehaviour<AudioController>.Instance._PlayMusic(audioID, parentObj.position, parentObj, volume, delay, startTime);
  }

  public static bool StopMusic() => SingletonMonoBehaviour<AudioController>.Instance._StopMusic(0.0f);

  public static bool StopMusic(float fadeOut) => SingletonMonoBehaviour<AudioController>.Instance._StopMusic(fadeOut);

  public static bool PauseMusic(float fadeOut = 0.0f) => SingletonMonoBehaviour<AudioController>.Instance._PauseMusic(fadeOut);

  public static bool IsMusicPaused() => (UnityEngine.Object) AudioController._currentMusic != (UnityEngine.Object) null && AudioController._currentMusic.IsPaused();

  public static bool UnpauseMusic(float fadeIn = 0.0f)
  {
    if (!SingletonMonoBehaviour<AudioController>.Instance._musicEnabled || !((UnityEngine.Object) AudioController._currentMusic != (UnityEngine.Object) null) || !AudioController._currentMusic.IsPaused())
      return false;
    AudioController._currentMusic.Unpause(fadeIn);
    return true;
  }

  public static AudioObject PlayAmbienceSound(
    string audioID,
    float volume = 1f,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    return SingletonMonoBehaviour<AudioController>.Instance._PlayAmbienceSound(audioID, volume, delay, startTime);
  }

  public static AudioObject PlayAmbienceSound(
    string audioID,
    Vector3 worldPosition,
    Transform parentObj = null,
    float volume = 1f,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    return SingletonMonoBehaviour<AudioController>.Instance._PlayAmbienceSound(audioID, worldPosition, parentObj, volume, delay, startTime);
  }

  public static AudioObject PlayAmbienceSound(
    string audioID,
    Transform parentObj,
    float volume = 1f,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    return SingletonMonoBehaviour<AudioController>.Instance._PlayAmbienceSound(audioID, parentObj.position, parentObj, volume, delay, startTime);
  }

  public static bool StopAmbienceSound() => SingletonMonoBehaviour<AudioController>.Instance._StopAmbienceSound(0.0f);

  public static bool StopAmbienceSound(float fadeOut) => SingletonMonoBehaviour<AudioController>.Instance._StopAmbienceSound(fadeOut);

  public static bool PauseAmbienceSound(float fadeOut = 0.0f) => SingletonMonoBehaviour<AudioController>.Instance._PauseAmbienceSound(fadeOut);

  public static bool IsAmbienceSoundPaused() => (UnityEngine.Object) AudioController._currentAmbienceSound != (UnityEngine.Object) null && AudioController._currentAmbienceSound.IsPaused();

  public static bool UnpauseAmbienceSound(float fadeIn = 0.0f)
  {
    if (!SingletonMonoBehaviour<AudioController>.Instance._ambienceSoundEnabled || !((UnityEngine.Object) AudioController._currentAmbienceSound != (UnityEngine.Object) null) || !AudioController._currentAmbienceSound.IsPaused())
      return false;
    AudioController._currentAmbienceSound.Unpause(fadeIn);
    return true;
  }

  public static int EnqueueMusic(string audioID) => SingletonMonoBehaviour<AudioController>.Instance._EnqueueMusic(audioID);

  private Playlist _GetCurrentPlaylist() => string.IsNullOrEmpty(this._currentPlaylistName) ? (Playlist) null : this.GetPlaylistByName(this._currentPlaylistName);

  public Playlist GetPlaylistByName(string playlistName)
  {
    for (int index = 0; index < this.musicPlaylists.Length; ++index)
    {
      if (playlistName == this.musicPlaylists[index].name)
        return this.musicPlaylists[index];
    }
    if (this._additionalAudioControllers != null)
    {
      for (int index1 = 0; index1 < this._additionalAudioControllers.Count; ++index1)
      {
        AudioController additionalAudioController = this._additionalAudioControllers[index1];
        for (int index2 = 0; index2 < additionalAudioController.musicPlaylists.Length; ++index2)
        {
          if (playlistName == additionalAudioController.musicPlaylists[index2].name)
            return additionalAudioController.musicPlaylists[index2];
        }
      }
    }
    return (Playlist) null;
  }

  public static string[] GetMusicPlaylist(string playlistName = null)
  {
    Playlist playlist = !string.IsNullOrEmpty(playlistName) ? SingletonMonoBehaviour<AudioController>.Instance.GetPlaylistByName(playlistName) : SingletonMonoBehaviour<AudioController>.Instance._GetCurrentPlaylist();
    if (playlist == null)
      return (string[]) null;
    string[] strArray = new string[playlist.playlistItems != null ? playlist.playlistItems.Length : 0];
    if (strArray.Length != 0)
      Array.Copy((Array) playlist.playlistItems, (Array) strArray, strArray.Length);
    return strArray;
  }

  public static bool SetCurrentMusicPlaylist(string playlistName)
  {
    if (SingletonMonoBehaviour<AudioController>.Instance.GetPlaylistByName(playlistName) == null)
    {
      Debug.LogError((object) ("Playlist with name " + playlistName + " not found"));
      return false;
    }
    SingletonMonoBehaviour<AudioController>.Instance._currentPlaylistName = playlistName;
    return true;
  }

  public static AudioObject PlayMusicPlaylist(string playlistName = null) => !string.IsNullOrEmpty(playlistName) && !AudioController.SetCurrentMusicPlaylist(playlistName) ? (AudioObject) null : SingletonMonoBehaviour<AudioController>.Instance._PlayMusicPlaylist();

  public static AudioObject PlayNextMusicOnPlaylist() => AudioController.IsPlaylistPlaying() ? SingletonMonoBehaviour<AudioController>.Instance._PlayNextMusicOnPlaylist(0.0f) : (AudioObject) null;

  public static AudioObject PlayPreviousMusicOnPlaylist() => AudioController.IsPlaylistPlaying() ? SingletonMonoBehaviour<AudioController>.Instance._PlayPreviousMusicOnPlaylist(0.0f) : (AudioObject) null;

  public static bool IsPlaylistPlaying()
  {
    if (!AudioController._isPlaylistPlaying)
      return false;
    if ((bool) (UnityEngine.Object) AudioController._currentMusic)
      return true;
    AudioController._isPlaylistPlaying = false;
    return false;
  }

  public static void ClearPlaylists() => SingletonMonoBehaviour<AudioController>.Instance.musicPlaylists = (Playlist[]) null;

  public static void AddPlaylist(string playlistName, string[] audioItemIDs) => ArrayHelper.AddArrayElement<Playlist>(ref SingletonMonoBehaviour<AudioController>.Instance.musicPlaylists, new Playlist(playlistName, audioItemIDs));

  public static AudioObject Play(string audioID)
  {
    AudioListener currentAudioListener = AudioController.GetCurrentAudioListener();
    if (!((UnityEngine.Object) currentAudioListener == (UnityEngine.Object) null))
      return AudioController.Play(audioID, currentAudioListener.transform.position + currentAudioListener.transform.forward, (Transform) null, 1f);
    Debug.LogWarning((object) "No AudioListener found in the scene");
    return (AudioObject) null;
  }

  public static AudioObject Play(
    string audioID,
    float volume,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    AudioListener currentAudioListener = AudioController.GetCurrentAudioListener();
    if (!((UnityEngine.Object) currentAudioListener == (UnityEngine.Object) null))
      return AudioController.Play(audioID, currentAudioListener.transform.position + currentAudioListener.transform.forward, (Transform) null, volume, delay, startTime);
    Debug.LogWarning((object) "No AudioListener found in the scene");
    return (AudioObject) null;
  }

  public static AudioObject Play(string audioID, Transform parentObj) => AudioController.Play(audioID, parentObj.position, parentObj, 1f);

  public static AudioObject Play(
    string audioID,
    Transform parentObj,
    float volume,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    return AudioController.Play(audioID, parentObj.position, parentObj, volume, delay, startTime);
  }

  public static AudioObject Play(
    string audioID,
    Vector3 worldPosition,
    Transform parentObj = null)
  {
    return SingletonMonoBehaviour<AudioController>.Instance._PlayEx(audioID, AudioChannelType.Default, 1f, worldPosition, parentObj, 0.0f, 0.0f, false);
  }

  public static AudioObject Play(
    string audioID,
    Vector3 worldPosition,
    Transform parentObj,
    float volume,
    float delay = 0.0f,
    float startTime = 0.0f)
  {
    return SingletonMonoBehaviour<AudioController>.Instance._PlayEx(audioID, AudioChannelType.Default, volume, worldPosition, parentObj, delay, startTime, false);
  }

  public static AudioObject PlayScheduled(
    string audioID,
    double dspTime,
    Vector3 worldPosition,
    Transform parentObj = null,
    float volume = 1f,
    float startTime = 0.0f)
  {
    return SingletonMonoBehaviour<AudioController>.Instance._PlayEx(audioID, AudioChannelType.Default, volume, worldPosition, parentObj, 0.0f, startTime, false, dspTime);
  }

  public static AudioObject PlayAfter(
    string audioID,
    AudioObject playingAudio,
    double deltaDspTime = 0.0,
    float volume = 1f,
    float startTime = 0.0f)
  {
    double dspTime1 = AudioSettings.dspTime;
    if (playingAudio.IsPlaying())
      dspTime1 += (double) playingAudio.timeUntilEnd;
    double dspTime2 = dspTime1 + deltaDspTime;
    return AudioController.PlayScheduled(audioID, dspTime2, playingAudio.transform.position, playingAudio.transform.parent, volume, startTime);
  }

  public static bool Stop(string audioID, float fadeOutLength)
  {
    if (SingletonMonoBehaviour<AudioController>.Instance._GetAudioItem(audioID) == null)
    {
      Debug.LogWarning((object) ("Audio item with name '" + audioID + "' does not exist"));
      return false;
    }
    List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects(audioID);
    for (int index = 0; index < playingAudioObjects.Count; ++index)
    {
      AudioObject audioObject = playingAudioObjects[index];
      if ((double) fadeOutLength < 0.0)
        audioObject.Stop();
      else
        audioObject.Stop(fadeOutLength);
    }
    return playingAudioObjects.Count > 0;
  }

  public static bool Stop(string audioID) => AudioController.Stop(audioID, -1f);

  public static void StopAll(float fadeOutLength)
  {
    SingletonMonoBehaviour<AudioController>.Instance._StopMusic(fadeOutLength);
    SingletonMonoBehaviour<AudioController>.Instance._StopAmbienceSound(fadeOutLength);
    List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects();
    for (int index = 0; index < playingAudioObjects.Count; ++index)
    {
      AudioObject audioObject = playingAudioObjects[index];
      if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null)
        audioObject.Stop(fadeOutLength);
    }
  }

  public static void StopAll() => AudioController.StopAll(-1f);

  public static void PauseAll(float fadeOutLength = 0.0f)
  {
    SingletonMonoBehaviour<AudioController>.Instance._PauseMusic(fadeOutLength);
    SingletonMonoBehaviour<AudioController>.Instance._PauseAmbienceSound(fadeOutLength);
    List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects();
    for (int index = 0; index < playingAudioObjects.Count; ++index)
    {
      AudioObject audioObject = playingAudioObjects[index];
      if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null)
        audioObject.Pause(fadeOutLength);
    }
  }

  public static void UnpauseAll(float fadeInLength = 0.0f)
  {
    AudioController.UnpauseMusic(fadeInLength);
    AudioController.UnpauseAmbienceSound(fadeInLength);
    List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects(true);
    AudioController instance = SingletonMonoBehaviour<AudioController>.Instance;
    for (int index = 0; index < playingAudioObjects.Count; ++index)
    {
      AudioObject audioObject = playingAudioObjects[index];
      if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null && audioObject.IsPaused() && (instance.musicEnabled || !((UnityEngine.Object) AudioController._currentMusic == (UnityEngine.Object) audioObject)) && (instance.ambienceSoundEnabled || !((UnityEngine.Object) AudioController._currentAmbienceSound == (UnityEngine.Object) audioObject)))
        audioObject.Unpause(fadeInLength);
    }
  }

  public static void PauseCategory(string categoryName, float fadeOutLength = 0.0f)
  {
    if ((UnityEngine.Object) AudioController._currentMusic != (UnityEngine.Object) null && AudioController._currentMusic.category.Name == categoryName)
      AudioController.PauseMusic(fadeOutLength);
    if ((UnityEngine.Object) AudioController._currentAmbienceSound != (UnityEngine.Object) null && AudioController._currentAmbienceSound.category.Name == categoryName)
      AudioController.PauseAmbienceSound(fadeOutLength);
    List<AudioObject> objectsInCategory = AudioController.GetPlayingAudioObjectsInCategory(categoryName);
    for (int index = 0; index < objectsInCategory.Count; ++index)
      objectsInCategory[index].Pause(fadeOutLength);
  }

  public static void UnpauseCategory(string categoryName, float fadeInLength = 0.0f)
  {
    if ((UnityEngine.Object) AudioController._currentMusic != (UnityEngine.Object) null && AudioController._currentMusic.category.Name == categoryName)
      AudioController.UnpauseMusic(fadeInLength);
    if ((UnityEngine.Object) AudioController._currentAmbienceSound != (UnityEngine.Object) null && AudioController._currentAmbienceSound.category.Name == categoryName)
      AudioController.UnpauseAmbienceSound(fadeInLength);
    List<AudioObject> objectsInCategory = AudioController.GetPlayingAudioObjectsInCategory(categoryName, true);
    for (int index = 0; index < objectsInCategory.Count; ++index)
    {
      AudioObject audioObject = objectsInCategory[index];
      if (audioObject.IsPaused())
        audioObject.Unpause(fadeInLength);
    }
  }

  public static void StopCategory(string categoryName, float fadeOutLength = 0.0f)
  {
    if ((UnityEngine.Object) AudioController._currentMusic != (UnityEngine.Object) null && AudioController._currentMusic.category.Name == categoryName)
      AudioController.StopMusic(fadeOutLength);
    if ((UnityEngine.Object) AudioController._currentAmbienceSound != (UnityEngine.Object) null && AudioController._currentAmbienceSound.category.Name == categoryName)
      AudioController.StopAmbienceSound(fadeOutLength);
    List<AudioObject> objectsInCategory = AudioController.GetPlayingAudioObjectsInCategory(categoryName);
    for (int index = 0; index < objectsInCategory.Count; ++index)
      objectsInCategory[index].Stop(fadeOutLength);
  }

  public static bool IsPlaying(string audioID) => AudioController.GetPlayingAudioObjects(audioID).Count > 0;

  public static List<AudioObject> GetPlayingAudioObjects(
    string audioID,
    bool includePausedAudio = false)
  {
    List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects(includePausedAudio);
    List<AudioObject> audioObjectList = new List<AudioObject>(playingAudioObjects.Count);
    for (int index = 0; index < playingAudioObjects.Count; ++index)
    {
      AudioObject audioObject = playingAudioObjects[index];
      if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null && audioObject.audioID == audioID)
        audioObjectList.Add(audioObject);
    }
    return audioObjectList;
  }

  public static List<AudioObject> GetPlayingAudioObjectsInCategory(
    string categoryName,
    bool includePausedAudio = false)
  {
    List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects(includePausedAudio);
    List<AudioObject> audioObjectList = new List<AudioObject>(playingAudioObjects.Count);
    for (int index = 0; index < playingAudioObjects.Count; ++index)
    {
      AudioObject audioObject = playingAudioObjects[index];
      if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null && audioObject.DoesBelongToCategory(categoryName))
        audioObjectList.Add(audioObject);
    }
    return audioObjectList;
  }

  public static List<AudioObject> GetPlayingAudioObjects(bool includePausedAudio = false)
  {
    object[] allOfType = RegisteredComponentController.GetAllOfType(typeof (AudioObject));
    List<AudioObject> audioObjectList = new List<AudioObject>(allOfType.Length);
    for (int index = 0; index < allOfType.Length; ++index)
    {
      AudioObject audioObject = (AudioObject) allOfType[index];
      if (audioObject.IsPlaying() || includePausedAudio && audioObject.IsPaused())
        audioObjectList.Add(audioObject);
    }
    return audioObjectList;
  }

  public static int GetPlayingAudioObjectsCount(string audioID, bool includePausedAudio = false)
  {
    List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects(includePausedAudio);
    int num = 0;
    for (int index = 0; index < playingAudioObjects.Count; ++index)
    {
      AudioObject audioObject = playingAudioObjects[index];
      if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null && audioObject.audioID == audioID)
        ++num;
    }
    return num;
  }

  public static void EnableMusic(bool b) => SingletonMonoBehaviour<AudioController>.Instance.musicEnabled = b;

  public static void EnableAmbienceSound(bool b) => SingletonMonoBehaviour<AudioController>.Instance.ambienceSoundEnabled = b;

  public static void MuteSound(bool b) => SingletonMonoBehaviour<AudioController>.Instance.soundMuted = b;

  public static bool IsMusicEnabled() => SingletonMonoBehaviour<AudioController>.Instance.musicEnabled;

  public static bool IsAmbienceSoundEnabled() => SingletonMonoBehaviour<AudioController>.Instance.ambienceSoundEnabled;

  public static bool IsSoundMuted() => SingletonMonoBehaviour<AudioController>.Instance.soundMuted;

  public static AudioListener GetCurrentAudioListener()
  {
    AudioController instance = SingletonMonoBehaviour<AudioController>.Instance;
    if ((UnityEngine.Object) instance._currentAudioListener != (UnityEngine.Object) null && (UnityEngine.Object) instance._currentAudioListener.gameObject == (UnityEngine.Object) null)
      instance._currentAudioListener = (AudioListener) null;
    if ((UnityEngine.Object) instance._currentAudioListener == (UnityEngine.Object) null)
      instance._currentAudioListener = (AudioListener) UnityEngine.Object.FindObjectOfType(typeof (AudioListener));
    return instance._currentAudioListener;
  }

  public static AudioObject GetCurrentMusic() => AudioController._currentMusic;

  public static AudioObject GetCurrentAmbienceSound() => AudioController._currentAmbienceSound;

  public static AudioCategory GetCategory(string name)
  {
    AudioController instance = SingletonMonoBehaviour<AudioController>.Instance;
    AudioCategory category1 = instance._GetCategory(name);
    if (category1 != null)
      return category1;
    if (instance._additionalAudioControllers != null)
    {
      for (int index = 0; index < instance._additionalAudioControllers.Count; ++index)
      {
        AudioCategory category2 = instance._additionalAudioControllers[index]._GetCategory(name);
        if (category2 != null)
          return category2;
      }
    }
    return (AudioCategory) null;
  }

  public static void SetCategoryVolume(string name, float volume)
  {
    List<AudioCategory> allCategories = AudioController._GetAllCategories(name);
    if (allCategories.Count == 0)
    {
      Debug.LogWarning((object) ("No audio category with name " + name));
    }
    else
    {
      for (int index = 0; index < allCategories.Count; ++index)
        allCategories[index].Volume = volume;
    }
  }

  public static float GetCategoryVolume(string name)
  {
    AudioCategory category = AudioController.GetCategory(name);
    if (category != null)
      return category.Volume;
    Debug.LogWarning((object) ("No audio category with name " + name));
    return 0.0f;
  }

  public static void FadeOutCategory(string name, float fadeOutLength, float startToFadeTime = 0.0f)
  {
    List<AudioCategory> allCategories = AudioController._GetAllCategories(name);
    if (allCategories.Count == 0)
    {
      Debug.LogWarning((object) ("No audio category with name " + name));
    }
    else
    {
      for (int index = 0; index < allCategories.Count; ++index)
        allCategories[index].FadeOut(fadeOutLength, startToFadeTime);
    }
  }

  public static void FadeInCategory(string name, float fadeInTime, bool stopCurrentFadeOut = true)
  {
    List<AudioCategory> allCategories = AudioController._GetAllCategories(name);
    if (allCategories.Count == 0)
    {
      Debug.LogWarning((object) ("No audio category with name " + name));
    }
    else
    {
      for (int index = 0; index < allCategories.Count; ++index)
        allCategories[index].FadeIn(fadeInTime, stopCurrentFadeOut);
    }
  }

  public static void SetGlobalVolume(float volume)
  {
    AudioController instance = SingletonMonoBehaviour<AudioController>.Instance;
    instance.Volume = volume;
    if (instance._additionalAudioControllers == null)
      return;
    for (int index = 0; index < instance._additionalAudioControllers.Count; ++index)
      instance._additionalAudioControllers[index].Volume = volume;
  }

  public static float GetGlobalVolume() => SingletonMonoBehaviour<AudioController>.Instance.Volume;

  public static AudioCategory NewCategory(string categoryName)
  {
    int index = SingletonMonoBehaviour<AudioController>.Instance.AudioCategories != null ? SingletonMonoBehaviour<AudioController>.Instance.AudioCategories.Length : 0;
    AudioCategory[] audioCategories = SingletonMonoBehaviour<AudioController>.Instance.AudioCategories;
    SingletonMonoBehaviour<AudioController>.Instance.AudioCategories = new AudioCategory[index + 1];
    if (index > 0)
      audioCategories.CopyTo((Array) SingletonMonoBehaviour<AudioController>.Instance.AudioCategories, 0);
    AudioCategory audioCategory = new AudioCategory(SingletonMonoBehaviour<AudioController>.Instance);
    audioCategory.Name = categoryName;
    SingletonMonoBehaviour<AudioController>.Instance.AudioCategories[index] = audioCategory;
    SingletonMonoBehaviour<AudioController>.Instance._InvalidateCategories();
    return audioCategory;
  }

  public static void RemoveCategory(string categoryName)
  {
    int num1 = -1;
    int num2 = SingletonMonoBehaviour<AudioController>.Instance.AudioCategories == null ? 0 : SingletonMonoBehaviour<AudioController>.Instance.AudioCategories.Length;
    for (int index = 0; index < num2; ++index)
    {
      if (SingletonMonoBehaviour<AudioController>.Instance.AudioCategories[index].Name == categoryName)
      {
        num1 = index;
        break;
      }
    }
    if (num1 == -1)
    {
      Debug.LogError((object) ("AudioCategory does not exist: " + categoryName));
    }
    else
    {
      AudioCategory[] audioCategoryArray = new AudioCategory[SingletonMonoBehaviour<AudioController>.Instance.AudioCategories.Length - 1];
      for (int index = 0; index < num1; ++index)
        audioCategoryArray[index] = SingletonMonoBehaviour<AudioController>.Instance.AudioCategories[index];
      for (int index = num1 + 1; index < SingletonMonoBehaviour<AudioController>.Instance.AudioCategories.Length; ++index)
        audioCategoryArray[index - 1] = SingletonMonoBehaviour<AudioController>.Instance.AudioCategories[index];
      SingletonMonoBehaviour<AudioController>.Instance.AudioCategories = audioCategoryArray;
      SingletonMonoBehaviour<AudioController>.Instance._InvalidateCategories();
    }
  }

  public static void AddToCategory(AudioCategory category, AudioItem audioItem)
  {
    int index = category.AudioItems != null ? category.AudioItems.Length : 0;
    AudioItem[] audioItems = category.AudioItems;
    category.AudioItems = new AudioItem[index + 1];
    if (index > 0)
      audioItems.CopyTo((Array) category.AudioItems, 0);
    category.AudioItems[index] = audioItem;
    SingletonMonoBehaviour<AudioController>.Instance._InvalidateCategories();
  }

  public static AudioItem AddToCategory(
    AudioCategory category,
    AudioClip audioClip,
    string audioID)
  {
    AudioItem audioItem = new AudioItem();
    audioItem.Name = audioID;
    audioItem.subItems = new AudioSubItem[1];
    audioItem.subItems[0] = new AudioSubItem()
    {
      Clip = audioClip
    };
    AudioController.AddToCategory(category, audioItem);
    return audioItem;
  }

  public static bool RemoveAudioItem(string audioID)
  {
    AudioItem audioItem = SingletonMonoBehaviour<AudioController>.Instance._GetAudioItem(audioID);
    if (audioItem == null)
      return false;
    int indexOf = audioItem.category._GetIndexOf(audioItem);
    if (indexOf < 0)
      return false;
    AudioItem[] audioItems = audioItem.category.AudioItems;
    AudioItem[] audioItemArray = new AudioItem[audioItems.Length - 1];
    for (int index = 0; index < indexOf; ++index)
      audioItemArray[index] = audioItems[index];
    for (int index = indexOf + 1; index < audioItems.Length; ++index)
      audioItemArray[index - 1] = audioItems[index];
    audioItem.category.AudioItems = audioItemArray;
    if (SingletonMonoBehaviour<AudioController>.Instance._categoriesValidated)
      SingletonMonoBehaviour<AudioController>.Instance._audioItems.Remove(audioID);
    return true;
  }

  public static bool IsValidAudioID(string audioID) => SingletonMonoBehaviour<AudioController>.Instance._GetAudioItem(audioID) != null;

  public static AudioItem GetAudioItem(string audioID) => SingletonMonoBehaviour<AudioController>.Instance._GetAudioItem(audioID);

  public static void DetachAllAudios(GameObject gameObjectWithAudios)
  {
    foreach (Component componentsInChild in gameObjectWithAudios.GetComponentsInChildren<AudioObject>(true))
      componentsInChild.transform.parent = (Transform) null;
  }

  public static float GetAudioItemMaxDistance(string audioID)
  {
    AudioItem audioItem = AudioController.GetAudioItem(audioID);
    return audioItem.overrideAudioSourceSettings ? audioItem.audioSource_MaxDistance : audioItem.category.GetAudioObjectPrefab().GetComponent<AudioSource>().maxDistance;
  }

  public void UnloadAllAudioClips()
  {
    for (int index = 0; index < this.AudioCategories.Length; ++index)
      this.AudioCategories[index].UnloadAllAudioClips();
  }

  private static AudioObject _currentMusic
  {
    set => AudioController._currentMusicReference.Set(value, true);
    get => AudioController._currentMusicReference.Get();
  }

  private static AudioObject _currentAmbienceSound
  {
    set => AudioController._currentAmbienceReference.Set(value, true);
    get => AudioController._currentAmbienceReference.Get();
  }

  private void _ApplyVolumeChange()
  {
    List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects(true);
    for (int index = 0; index < playingAudioObjects.Count; ++index)
    {
      AudioObject audioObject = playingAudioObjects[index];
      if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null)
        audioObject._ApplyVolumeBoth();
    }
  }

  internal AudioItem _GetAudioItem(string audioID)
  {
    this._ValidateCategories();
    AudioItem audioItem;
    return this._audioItems.TryGetValue(audioID, out audioItem) ? audioItem : (AudioItem) null;
  }

  protected AudioObject _PlayMusic(
    string audioID,
    float volume,
    float delay,
    float startTime)
  {
    if (!((UnityEngine.Object) AudioController._musicParent == (UnityEngine.Object) null))
      return this._PlayMusic(audioID, AudioController._musicParent.position, AudioController._musicParent, volume, delay, startTime);
    AudioListener currentAudioListener = AudioController.GetCurrentAudioListener();
    if (!((UnityEngine.Object) currentAudioListener == (UnityEngine.Object) null))
      return this._PlayMusic(audioID, currentAudioListener.transform.position + currentAudioListener.transform.forward, (Transform) null, volume, delay, startTime);
    Debug.LogWarning((object) "No AudioListener found in the scene");
    return (AudioObject) null;
  }

  protected AudioObject _PlayAmbienceSound(
    string audioID,
    float volume,
    float delay,
    float startTime)
  {
    if (!((UnityEngine.Object) AudioController._ambienceParent == (UnityEngine.Object) null))
      return this._PlayAmbienceSound(audioID, AudioController._ambienceParent.position, AudioController._ambienceParent, volume, delay, startTime);
    AudioListener currentAudioListener = AudioController.GetCurrentAudioListener();
    if (!((UnityEngine.Object) currentAudioListener == (UnityEngine.Object) null))
      return this._PlayAmbienceSound(audioID, currentAudioListener.transform.position + currentAudioListener.transform.forward, (Transform) null, volume, delay, startTime);
    Debug.LogWarning((object) "No AudioListener found in the scene");
    return (AudioObject) null;
  }

  protected bool _StopMusic(float fadeOutLength)
  {
    if (!((UnityEngine.Object) AudioController._currentMusic != (UnityEngine.Object) null))
      return false;
    AudioController._currentMusic.Stop(fadeOutLength);
    AudioController._currentMusic = (AudioObject) null;
    return true;
  }

  protected bool _PauseMusic(float fadeOut)
  {
    if (!((UnityEngine.Object) AudioController._currentMusic != (UnityEngine.Object) null))
      return false;
    AudioController._currentMusic.Pause(fadeOut);
    return true;
  }

  protected bool _StopAmbienceSound(float fadeOutLength)
  {
    if (!((UnityEngine.Object) AudioController._currentAmbienceSound != (UnityEngine.Object) null))
      return false;
    AudioController._currentAmbienceSound.Stop(fadeOutLength);
    AudioController._currentAmbienceSound = (AudioObject) null;
    return true;
  }

  protected bool _PauseAmbienceSound(float fadeOut)
  {
    if (!((UnityEngine.Object) AudioController._currentAmbienceSound != (UnityEngine.Object) null))
      return false;
    AudioController._currentAmbienceSound.Pause(fadeOut);
    return true;
  }

  protected AudioObject _PlayMusic(
    string audioID,
    Vector3 position,
    Transform parentObj,
    float volume,
    float delay,
    float startTime)
  {
    if (!AudioController.IsMusicEnabled())
      return (AudioObject) null;
    bool flag;
    if ((UnityEngine.Object) AudioController._currentMusic != (UnityEngine.Object) null && AudioController._currentMusic.IsPlaying())
    {
      flag = true;
      AudioController._currentMusic.Stop(this.musicCrossFadeTime_Out);
    }
    else
      flag = false;
    if ((double) this.musicCrossFadeTime_In <= 0.0)
      flag = false;
    AudioController._currentMusic = this._PlayEx(audioID, AudioChannelType.Music, volume, position, parentObj, delay, startTime, false, startVolumeMultiplier: (flag ? 0.0f : 1f));
    if (flag && (bool) (UnityEngine.Object) AudioController._currentMusic)
      AudioController._currentMusic.FadeIn(this.musicCrossFadeTime_In);
    return AudioController._currentMusic;
  }

  protected AudioObject _PlayAmbienceSound(
    string audioID,
    Vector3 position,
    Transform parentObj,
    float volume,
    float delay,
    float startTime)
  {
    if (!AudioController.IsAmbienceSoundEnabled())
      return (AudioObject) null;
    bool flag;
    if ((UnityEngine.Object) AudioController._currentAmbienceSound != (UnityEngine.Object) null && AudioController._currentAmbienceSound.IsPlaying())
    {
      flag = true;
      AudioController._currentAmbienceSound.Stop(this.ambienceSoundCrossFadeTime_Out);
    }
    else
      flag = false;
    if ((double) this.ambienceSoundCrossFadeTime_In <= 0.0)
      flag = false;
    AudioController._currentAmbienceSound = this._PlayEx(audioID, AudioChannelType.Ambience, volume, position, parentObj, delay, startTime, false, startVolumeMultiplier: (flag ? 0.0f : 1f));
    if (flag && (bool) (UnityEngine.Object) AudioController._currentAmbienceSound)
      AudioController._currentAmbienceSound.FadeIn(this.ambienceSoundCrossFadeTime_In);
    return AudioController._currentAmbienceSound;
  }

  protected int _EnqueueMusic(string audioID)
  {
    Playlist currentPlaylist = this._GetCurrentPlaylist();
    int length = currentPlaylist != null ? this.musicPlaylists.Length + 1 : 1;
    string[] strArray = new string[length];
    currentPlaylist?.playlistItems.CopyTo((Array) strArray, 0);
    strArray[length - 1] = audioID;
    currentPlaylist.playlistItems = strArray;
    return length;
  }

  protected AudioObject _PlayMusicPlaylist()
  {
    this._ResetLastPlayedList();
    return this._PlayNextMusicOnPlaylist(0.0f);
  }

  private AudioObject _PlayMusicTrackWithID(
    int nextTrack,
    float delay,
    bool addToPlayedList)
  {
    if (nextTrack < 0)
      return (AudioObject) null;
    AudioController._playlistPlayed.Add(nextTrack);
    AudioController._isPlaylistPlaying = true;
    AudioObject audioObject = this._PlayMusic(this._GetCurrentPlaylist().playlistItems[nextTrack], 1f, delay, 0.0f);
    if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null)
    {
      audioObject._isCurrentPlaylistTrack = true;
      audioObject.primaryAudioSource.loop = false;
    }
    return audioObject;
  }

  internal AudioObject _PlayNextMusicOnPlaylist(float delay) => this._PlayMusicTrackWithID(this._GetNextMusicTrack(), delay, true);

  internal AudioObject _PlayPreviousMusicOnPlaylist(float delay) => this._PlayMusicTrackWithID(this._GetPreviousMusicTrack(), delay, false);

  private void _ResetLastPlayedList() => AudioController._playlistPlayed.Clear();

  protected int _GetNextMusicTrack()
  {
    Playlist currentPlaylist = this._GetCurrentPlaylist();
    if (currentPlaylist == null || currentPlaylist.playlistItems == null)
    {
      Debug.LogWarning((object) "There is no current playlist set");
      return -1;
    }
    if (currentPlaylist.playlistItems.Length == 1)
      return 0;
    return this.shufflePlaylist ? this._GetNextMusicTrackShuffled() : this._GetNextMusicTrackInOrder();
  }

  protected int _GetPreviousMusicTrack()
  {
    if (this._GetCurrentPlaylist().playlistItems.Length == 1)
      return 0;
    return this.shufflePlaylist ? this._GetPreviousMusicTrackShuffled() : this._GetPreviousMusicTrackInOrder();
  }

  private int _GetPreviousMusicTrackShuffled()
  {
    if (AudioController._playlistPlayed.Count < 2)
      return -1;
    int num = AudioController._playlistPlayed[AudioController._playlistPlayed.Count - 2];
    this._RemoveLastPlayedOnList();
    this._RemoveLastPlayedOnList();
    return num;
  }

  private void _RemoveLastPlayedOnList() => AudioController._playlistPlayed.RemoveAt(AudioController._playlistPlayed.Count - 1);

  private int _GetNextMusicTrackShuffled()
  {
    HashSet<int> intSet = new HashSet<int>();
    int num1 = AudioController._playlistPlayed.Count;
    Playlist currentPlaylist = this._GetCurrentPlaylist();
    if (this.loopPlaylist)
    {
      int num2 = Mathf.Clamp(currentPlaylist.playlistItems.Length / 4, 2, 10);
      if (num1 > currentPlaylist.playlistItems.Length - num2)
      {
        num1 = currentPlaylist.playlistItems.Length - num2;
        if (num1 < 1)
          num1 = 1;
      }
    }
    else if (num1 >= currentPlaylist.playlistItems.Length)
      return -1;
    for (int index = 0; index < num1; ++index)
      intSet.Add(AudioController._playlistPlayed[AudioController._playlistPlayed.Count - 1 - index]);
    List<int> intList = new List<int>();
    for (int index = 0; index < currentPlaylist.playlistItems.Length; ++index)
    {
      if (!intSet.Contains(index))
        intList.Add(index);
    }
    return intList[UnityEngine.Random.Range(0, intList.Count)];
  }

  private int _GetNextMusicTrackInOrder()
  {
    if (AudioController._playlistPlayed.Count == 0)
      return 0;
    int num = AudioController._playlistPlayed[AudioController._playlistPlayed.Count - 1] + 1;
    Playlist currentPlaylist = this._GetCurrentPlaylist();
    if (num >= currentPlaylist.playlistItems.Length)
    {
      if (!this.loopPlaylist)
        return -1;
      num = 0;
    }
    return num;
  }

  private int _GetPreviousMusicTrackInOrder()
  {
    Playlist currentPlaylist = this._GetCurrentPlaylist();
    if (AudioController._playlistPlayed.Count < 2)
      return this.loopPlaylist ? currentPlaylist.playlistItems.Length - 1 : -1;
    int num = AudioController._playlistPlayed[AudioController._playlistPlayed.Count - 1] - 1;
    this._RemoveLastPlayedOnList();
    this._RemoveLastPlayedOnList();
    if (num < 0)
    {
      if (!this.loopPlaylist)
        return -1;
      num = currentPlaylist.playlistItems.Length - 1;
    }
    return num;
  }

  protected AudioObject _PlayEx(
    string audioID,
    AudioChannelType channel,
    float volume,
    Vector3 worldPosition,
    Transform parentObj,
    float delay,
    float startTime,
    bool playWithoutAudioObject,
    double dspTime = 0.0,
    AudioObject useExistingAudioObject = null,
    float startVolumeMultiplier = 1f)
  {
    if (this._audioDisabled)
      return (AudioObject) null;
    AudioItem audioItem = this._GetAudioItem(audioID);
    if (audioItem == null)
    {
      Log.Warning("Audio item with name '" + audioID + "' does not exist");
      return (AudioObject) null;
    }
    if (audioItem._lastPlayedTime > 0.0 && dspTime == 0.0 && AudioController.systemTime - audioItem._lastPlayedTime < (double) audioItem.MinTimeBetweenPlayCalls)
      return (AudioObject) null;
    if (audioItem.MaxInstanceCount > 0)
    {
      List<AudioObject> playingAudioObjects = AudioController.GetPlayingAudioObjects(audioID);
      if (playingAudioObjects.Count >= audioItem.MaxInstanceCount)
      {
        bool flag = playingAudioObjects.Count > audioItem.MaxInstanceCount;
        AudioObject audioObject = (AudioObject) null;
        for (int index = 0; index < playingAudioObjects.Count; ++index)
        {
          if ((flag || !playingAudioObjects[index].isFadingOut) && ((UnityEngine.Object) audioObject == (UnityEngine.Object) null || playingAudioObjects[index].startedPlayingAtTime < audioObject.startedPlayingAtTime))
            audioObject = playingAudioObjects[index];
        }
        if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null)
          audioObject.Stop(flag ? 0.0f : 0.2f);
      }
    }
    return this.PlayAudioItem(audioItem, volume, worldPosition, parentObj, delay, startTime, playWithoutAudioObject, useExistingAudioObject, dspTime, channel, startVolumeMultiplier);
  }

  public AudioObject PlayAudioItem(
    AudioItem sndItem,
    float volume,
    Vector3 worldPosition,
    Transform parentObj = null,
    float delay = 0.0f,
    float startTime = 0.0f,
    bool playWithoutAudioObject = false,
    AudioObject useExistingAudioObj = null,
    double dspTime = 0.0,
    AudioChannelType channel = AudioChannelType.Default,
    float startVolumeMultiplier = 1f)
  {
    AudioObject audioObject1 = (AudioObject) null;
    sndItem._lastPlayedTime = AudioController.systemTime;
    AudioSubItem[] audioSubItemArray = AudioControllerHelper._ChooseSubItems(sndItem, useExistingAudioObj);
    if (audioSubItemArray == null || audioSubItemArray.Length == 0)
      return (AudioObject) null;
    for (int index = 0; index < audioSubItemArray.Length; ++index)
    {
      AudioSubItem subItem = audioSubItemArray[index];
      if (subItem != null)
      {
        AudioObject audioObject2 = this.PlayAudioSubItem(subItem, volume, worldPosition, parentObj, delay, startTime, playWithoutAudioObject, useExistingAudioObj, dspTime, channel, startVolumeMultiplier);
        if ((bool) (UnityEngine.Object) audioObject2)
        {
          audioObject1 = audioObject2;
          audioObject1.audioID = sndItem.Name;
          if (sndItem.overrideAudioSourceSettings)
          {
            audioObject2._audioSource_MinDistance_Saved = audioObject2.primaryAudioSource.minDistance;
            audioObject2._audioSource_MaxDistance_Saved = audioObject2.primaryAudioSource.maxDistance;
            audioObject2._audioSource_SpatialBlend_Saved = audioObject2.primaryAudioSource.spatialBlend;
            audioObject2.primaryAudioSource.minDistance = sndItem.audioSource_MinDistance;
            audioObject2.primaryAudioSource.maxDistance = sndItem.audioSource_MaxDistance;
            audioObject2.primaryAudioSource.spatialBlend = sndItem.spatialBlend;
            if ((UnityEngine.Object) audioObject2.secondaryAudioSource != (UnityEngine.Object) null)
            {
              audioObject2.secondaryAudioSource.minDistance = sndItem.audioSource_MinDistance;
              audioObject2.secondaryAudioSource.maxDistance = sndItem.audioSource_MaxDistance;
              audioObject2.secondaryAudioSource.spatialBlend = sndItem.spatialBlend;
            }
          }
        }
      }
    }
    return audioObject1;
  }

  internal AudioCategory _GetCategory(string name)
  {
    for (int index = 0; index < this.AudioCategories.Length; ++index)
    {
      AudioCategory audioCategory = this.AudioCategories[index];
      if (audioCategory.Name == name)
        return audioCategory;
    }
    return (AudioCategory) null;
  }

  private void Update()
  {
    if (this._isAdditionalAudioController)
      return;
    AudioController._UpdateSystemTime();
  }

  private static void _UpdateSystemTime()
  {
    double timeSinceLaunch = SystemTime.timeSinceLaunch;
    if (AudioController._lastSystemTime >= 0.0)
    {
      AudioController._systemDeltaTime = timeSinceLaunch - AudioController._lastSystemTime;
      if (AudioController._systemDeltaTime > (double) Time.maximumDeltaTime + 0.00999999977648258)
        AudioController._systemDeltaTime = (double) Time.deltaTime;
      AudioController._systemTime += AudioController._systemDeltaTime;
    }
    else
    {
      AudioController._systemDeltaTime = 0.0;
      AudioController._systemTime = 0.0;
    }
    AudioController._lastSystemTime = timeSinceLaunch;
  }

  protected override void Awake()
  {
    base.Awake();
    if (!this.Persistent)
      return;
    UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object) this.gameObject);
  }

  private void OnEnable()
  {
    if (this.isAdditionalAudioController)
    {
      if ((bool) (UnityEngine.Object) SingletonMonoBehaviour<AudioController>.DoesInstanceExist())
      {
        SingletonMonoBehaviour<AudioController>.Instance._RegisterAdditionalAudioController(this);
      }
      else
      {
        if (AudioController._additionalControllerToRegister == null)
          AudioController._additionalControllerToRegister = new List<AudioController>();
        AudioController._additionalControllerToRegister.Add(this);
      }
    }
    else
    {
      if (AudioController._additionalControllerToRegister == null)
        return;
      for (int index = 0; index < AudioController._additionalControllerToRegister.Count; ++index)
      {
        AudioController ac = AudioController._additionalControllerToRegister[index];
        if ((bool) (UnityEngine.Object) ac && ac.enabled)
          SingletonMonoBehaviour<AudioController>.Instance._RegisterAdditionalAudioController(ac);
      }
      AudioController._additionalControllerToRegister = (List<AudioController>) null;
    }
  }

  private void OnDisable()
  {
    if (!this.isAdditionalAudioController || !(bool) (UnityEngine.Object) SingletonMonoBehaviour<AudioController>.DoesInstanceExist())
      return;
    SingletonMonoBehaviour<AudioController>.Instance._UnregisterAdditionalAudioController(this);
  }

  public override bool isSingletonObject => !this._isAdditionalAudioController;

  protected override void OnDestroy()
  {
    if (this.UnloadAudioClipsOnDestroy)
      this.UnloadAllAudioClips();
    base.OnDestroy();
  }

  private void AwakeSingleton()
  {
    AudioController._UpdateSystemTime();
    if ((UnityEngine.Object) this.AudioObjectPrefab == (UnityEngine.Object) null)
      Log.Error("No AudioObject prefab specified in AudioController. To make your own AudioObject prefab create an empty game object, add Unity's AudioSource, the AudioObject script, and the PoolableObject script (if pooling is wanted ). Then create a prefab and set it in the AudioController.");
    else
      this._ValidateAudioObjectPrefab(this.AudioObjectPrefab);
    this._ValidateCategories();
    if (AudioController._playlistPlayed == null)
    {
      AudioController._playlistPlayed = new List<int>();
      AudioController._isPlaylistPlaying = false;
    }
    this._SetDefaultCurrentPlaylist();
  }

  protected void _ValidateCategories()
  {
    if (this._categoriesValidated)
      return;
    this.InitializeAudioItems();
    this._categoriesValidated = true;
  }

  protected void _InvalidateCategories() => this._categoriesValidated = false;

  public void InitializeAudioItems()
  {
    if (this.isAdditionalAudioController)
      return;
    this._audioItems = new Dictionary<string, AudioItem>();
    this._InitializeAudioItems(this);
    if (this._additionalAudioControllers == null)
      return;
    for (int index = 0; index < this._additionalAudioControllers.Count; ++index)
    {
      AudioController additionalAudioController = this._additionalAudioControllers[index];
      if ((UnityEngine.Object) additionalAudioController != (UnityEngine.Object) null)
        this._InitializeAudioItems(additionalAudioController);
    }
  }

  private void _InitializeAudioItems(AudioController audioController)
  {
    for (int index = 0; index < audioController.AudioCategories.Length; ++index)
    {
      AudioCategory audioCategory = audioController.AudioCategories[index];
      audioCategory.audioController = audioController;
      audioCategory._AnalyseAudioItems(this._audioItems);
      if ((bool) (UnityEngine.Object) audioCategory.AudioObjectPrefab)
        this._ValidateAudioObjectPrefab(audioCategory.AudioObjectPrefab);
    }
  }

  private void _RegisterAdditionalAudioController(AudioController ac)
  {
    if (this._additionalAudioControllers == null)
      this._additionalAudioControllers = new List<AudioController>();
    this._additionalAudioControllers.Add(ac);
    this._InvalidateCategories();
    this._SyncCategoryVolumes(ac, this);
  }

  private void _SyncCategoryVolumes(AudioController toSync, AudioController syncWith)
  {
    for (int index = 0; index < toSync.AudioCategories.Length; ++index)
    {
      AudioCategory audioCategory = toSync.AudioCategories[index];
      AudioCategory category = syncWith._GetCategory(audioCategory.Name);
      if (category != null)
        audioCategory.Volume = category.Volume;
    }
  }

  private void _UnregisterAdditionalAudioController(AudioController ac)
  {
    if (this._additionalAudioControllers != null)
    {
      for (int index = 0; index < this._additionalAudioControllers.Count; ++index)
      {
        if ((UnityEngine.Object) this._additionalAudioControllers[index] == (UnityEngine.Object) ac)
        {
          this._additionalAudioControllers.RemoveAt(index);
          this._InvalidateCategories();
          break;
        }
      }
    }
    else
      Debug.LogWarning((object) ("_UnregisterAdditionalAudioController: AudioController " + ac.name + " not found"));
  }

  private static List<AudioCategory> _GetAllCategories(string name)
  {
    AudioController instance = SingletonMonoBehaviour<AudioController>.Instance;
    List<AudioCategory> audioCategoryList = new List<AudioCategory>();
    AudioCategory category1 = instance._GetCategory(name);
    if (category1 != null)
      audioCategoryList.Add(category1);
    if (instance._additionalAudioControllers != null)
    {
      for (int index = 0; index < instance._additionalAudioControllers.Count; ++index)
      {
        AudioCategory category2 = instance._additionalAudioControllers[index]._GetCategory(name);
        if (category2 != null)
          audioCategoryList.Add(category2);
      }
    }
    return audioCategoryList;
  }

  public AudioObject PlayAudioSubItem(
    AudioSubItem subItem,
    float volume,
    Vector3 worldPosition,
    Transform parentObj,
    float delay,
    float startTime,
    bool playWithoutAudioObject,
    AudioObject useExistingAudioObj,
    double dspTime = 0.0,
    AudioChannelType channel = AudioChannelType.Default,
    float startVolumeMultiplier = 1f)
  {
    this._ValidateCategories();
    AudioItem audioItem = subItem.item;
    switch (subItem.SubItemType)
    {
      case AudioSubItemType.Item:
        if (subItem.ItemModeAudioID.Length != 0)
          return this._PlayEx(subItem.ItemModeAudioID, channel, volume, worldPosition, parentObj, delay, startTime, playWithoutAudioObject, dspTime, useExistingAudioObj);
        Debug.LogWarning((object) ("No item specified in audio sub-item with ITEM mode (audio item: '" + audioItem.Name + "')"));
        return (AudioObject) null;
      default:
        if ((UnityEngine.Object) subItem.Clip == (UnityEngine.Object) null)
          return (AudioObject) null;
        AudioCategory category = audioItem.category;
        float num = subItem.Volume * audioItem.Volume * volume;
        if ((double) subItem.RandomVolume != 0.0 || (double) audioItem.loopSequenceRandomVolume != 0.0)
        {
          float max = subItem.RandomVolume + audioItem.loopSequenceRandomVolume;
          num = Mathf.Clamp01(num + UnityEngine.Random.Range(-max, max));
        }
        float volume1 = num * category.VolumeTotal;
        AudioController audioController = this._GetAudioController(subItem);
        if (!audioController.PlayWithZeroVolume && ((double) volume1 <= 0.0 || (double) this.Volume <= 0.0))
          return (AudioObject) null;
        GameObject prefab = category.GetAudioObjectPrefab();
        if ((UnityEngine.Object) prefab == (UnityEngine.Object) null)
          prefab = !((UnityEngine.Object) audioController.AudioObjectPrefab != (UnityEngine.Object) null) ? this.AudioObjectPrefab : audioController.AudioObjectPrefab;
        if (playWithoutAudioObject)
        {
          prefab.GetComponent<AudioSource>().PlayOneShot(subItem.Clip, AudioObject.TransformVolume(volume1));
          return (AudioObject) null;
        }
        GameObject gameObject;
        AudioObject audioObject;
        if ((UnityEngine.Object) useExistingAudioObj == (UnityEngine.Object) null)
        {
          if (audioItem.DestroyOnLoad)
          {
            gameObject = !audioController.UsePooledAudioObjects ? ObjectPoolController.InstantiateWithoutPool(prefab, worldPosition, Quaternion.identity) : ObjectPoolController.Instantiate(prefab, worldPosition, Quaternion.identity);
          }
          else
          {
            gameObject = ObjectPoolController.InstantiateWithoutPool(prefab, worldPosition, Quaternion.identity);
            UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object) gameObject);
          }
          if ((bool) (UnityEngine.Object) parentObj)
            gameObject.transform.parent = parentObj;
          audioObject = gameObject.gameObject.GetComponent<AudioObject>();
        }
        else
        {
          gameObject = useExistingAudioObj.gameObject;
          audioObject = useExistingAudioObj;
        }
        audioObject.subItem = subItem;
        if (useExistingAudioObj == null)
          audioObject._lastChosenSubItemIndex = audioItem._lastChosen;
        audioObject.primaryAudioSource.clip = subItem.Clip;
        gameObject.name = "AudioObject:" + audioObject.primaryAudioSource.clip.name;
        audioObject.primaryAudioSource.pitch = AudioObject.TransformPitch(subItem.PitchShift);
        audioObject.primaryAudioSource.panStereo = subItem.Pan2D;
        if (subItem.RandomStartPosition)
          startTime = UnityEngine.Random.Range(0.0f, audioObject.clipLength);
        audioObject.primaryAudioSource.time = startTime + subItem.ClipStartTime;
        audioObject.primaryAudioSource.loop = audioItem.Loop == AudioItem.LoopMode.LoopSubitem || audioItem.Loop == (AudioItem.LoopMode.LoopSubitem | AudioItem.LoopMode.LoopSequence);
        audioObject._volumeExcludingCategory = num;
        audioObject._volumeFromScriptCall = volume;
        audioObject.category = category;
        audioObject.channel = channel;
        if ((double) subItem.FadeIn > 0.0)
          audioObject.FadeIn(subItem.FadeIn);
        audioObject._ApplyVolumePrimary(startVolumeMultiplier);
        if ((bool) (UnityEngine.Object) category.GetAudioMixerGroup())
          audioObject.primaryAudioSource.outputAudioMixerGroup = category.audioMixerGroup;
        if ((double) subItem.RandomPitch != 0.0 || (double) audioItem.loopSequenceRandomPitch != 0.0)
        {
          float max = subItem.RandomPitch + audioItem.loopSequenceRandomPitch;
          audioObject.primaryAudioSource.pitch *= AudioObject.TransformPitch(UnityEngine.Random.Range(-max, max));
        }
        if ((double) subItem.RandomDelay > 0.0)
          delay += UnityEngine.Random.Range(0.0f, subItem.RandomDelay);
        if (dspTime > 0.0)
          audioObject.PlayScheduled(dspTime + (double) delay + (double) subItem.Delay + (double) audioItem.Delay);
        else
          audioObject.Play(delay + subItem.Delay + audioItem.Delay);
        if ((double) subItem.FadeIn > 0.0)
          audioObject.FadeIn(subItem.FadeIn);
        return audioObject;
    }
  }

  private AudioController _GetAudioController(AudioSubItem subItem) => subItem.item != null && subItem.item.category != null ? subItem.item.category.audioController : this;

  internal void _NotifyPlaylistTrackCompleteleyPlayed(AudioObject audioObject)
  {
    audioObject._isCurrentPlaylistTrack = false;
    if (!AudioController.IsPlaylistPlaying() || !((UnityEngine.Object) AudioController._currentMusic == (UnityEngine.Object) audioObject) || !((UnityEngine.Object) this._PlayNextMusicOnPlaylist(this.delayBetweenPlaylistTracks) == (UnityEngine.Object) null))
      return;
    AudioController._isPlaylistPlaying = false;
    if (this.playlistFinishedEvent == null)
      return;
    this.playlistFinishedEvent(this._GetCurrentPlaylist());
  }

  private void _ValidateAudioObjectPrefab(GameObject audioPrefab)
  {
    if (this.UsePooledAudioObjects)
    {
      if ((UnityEngine.Object) audioPrefab.GetComponent<PoolableObject>() == (UnityEngine.Object) null)
        Debug.LogWarning((object) "AudioObject prefab does not have the PoolableObject component. Pooling will not work.");
      else
        ObjectPoolController.Preload(audioPrefab);
    }
    if (!((UnityEngine.Object) audioPrefab.GetComponent<AudioObject>() == (UnityEngine.Object) null))
      return;
    Debug.LogError((object) "AudioObject prefab must have the AudioObject script component!");
  }

  public void OnAfterDeserialize()
  {
    if (this.musicPlaylist == null || this.musicPlaylist.Length == 0)
      return;
    List<string> stringList = new List<string>((IEnumerable<string>) this.musicPlaylist);
    this.musicPlaylists[0] = new Playlist();
    this.musicPlaylists[0].playlistItems = stringList.ToArray();
    this.musicPlaylist = (string[]) null;
  }

  public void OnBeforeSerialize()
  {
  }

  private void _SetDefaultCurrentPlaylist()
  {
    if (this.musicPlaylists == null || this.musicPlaylists.Length < 1 || this.musicPlaylists[0] == null)
      return;
    this._currentPlaylistName = this.musicPlaylists[0].name;
  }
}
