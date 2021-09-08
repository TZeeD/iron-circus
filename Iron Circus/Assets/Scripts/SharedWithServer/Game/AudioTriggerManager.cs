// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Game.AudioTriggerManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ClockStone;
using Imi.Diagnostics;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

namespace SharedWithServer.Game
{
  public static class AudioTriggerManager
  {
    public static GameObject audioPrefabSpreadBlend = (GameObject) null;
    public static GameObject audioPrefab3D = (GameObject) null;
    public static AudioMixer masterMixer = (AudioMixer) null;
    private static float allyVolume = 0.75f;
    private static float enemyVolume = 0.85f;
    private static Dictionary<AudioTriggerManager.AudioKey, AudioObject> activeAudio = new Dictionary<AudioTriggerManager.AudioKey, AudioObject>(50);

    static AudioTriggerManager()
    {
      AudioTriggerManager.audioPrefabSpreadBlend = Resources.Load<GameObject>("Audio/AudioObjects/AudioObject_SpreadBlend");
      AudioTriggerManager.audioPrefab3D = Resources.Load<GameObject>("Audio/AudioObjects/AudioObject_3D");
      AudioTriggerManager.masterMixer = Resources.Load<AudioMixer>("Audio/AudioMixer_Wobbler");
    }

    [Obsolete]
    public static void PlayAudioOneShot(SkillGraph instigator, string audioId, bool play2D = false) => AudioController.Play(audioId, instigator.GetOwner().unityView.gameObject.transform);

    public static void StopAllAudioWithId(SkillGraph instigator, string audioId) => AudioController.Stop(audioId);

    public static void PlayAudio(SkillGraph instigator, string audioId, bool doNotTrack = false)
    {
      AudioTriggerManager.AudioKey key = new AudioTriggerManager.AudioKey(instigator, audioId);
      if (!doNotTrack && AudioTriggerManager.activeAudio.ContainsKey(key))
        return;
      float volumeIfRemote = 1f;
      if (!instigator.GetOwner().isLocalEntity && instigator.GetOwner().hasPlayerTeam && Contexts.sharedInstance.game.HasLocalEntity() && Contexts.sharedInstance.game.GetFirstLocalEntity().hasPlayerTeam)
        volumeIfRemote = instigator.GetOwner().playerTeam.value != Contexts.sharedInstance.game.GetFirstLocalEntity().playerTeam.value ? AudioTriggerManager.enemyVolume : AudioTriggerManager.allyVolume;
      AudioObject audioObject1 = AudioTriggerManager.PlayAudioUnwatched2DIfLocal(audioId, instigator.GetOwner(), volumeIfRemote: volumeIfRemote);
      if ((UnityEngine.Object) audioObject1 == (UnityEngine.Object) null)
      {
        Log.Warning(string.Format("The AudioObject you tried to start was null: {0} - {1}", (object) key.audioId, (object) key.instigator));
      }
      else
      {
        if (doNotTrack)
          return;
        audioObject1.completelyPlayedDelegate = (AudioObject.AudioEventDelegate) (audioObject =>
        {
          if (!AudioTriggerManager.activeAudio.ContainsKey(key))
            return;
          AudioTriggerManager.activeAudio.Remove(key);
        });
        AudioTriggerManager.activeAudio.Add(key, audioObject1);
      }
    }

    public static AudioObject PlayAudioUnwatched2DIfLocal(
      string audioId,
      GameEntity entity,
      float volumeIfLocal = 1f,
      float volumeIfRemote = 1f)
    {
      float volume = volumeIfRemote;
      if (entity.isLocalEntity)
      {
        AudioTriggerManager.SetAudioPrefab(audioId, AudioTriggerManager.audioPrefabSpreadBlend);
        volume = volumeIfLocal;
      }
      GameObject gameObject = entity.unityView.gameObject;
      AudioObject audioObject = AudioController.Play(audioId, gameObject.transform, volume);
      AudioTriggerManager.SetAudioPrefab(audioId, AudioTriggerManager.audioPrefab3D);
      return audioObject;
    }

    public static void StopAudio(SkillGraph instigator, string audioId)
    {
      AudioTriggerManager.AudioKey key = new AudioTriggerManager.AudioKey(instigator, audioId);
      if (!AudioTriggerManager.activeAudio.ContainsKey(key))
        return;
      AudioObject audioObject = AudioTriggerManager.activeAudio[key];
      AudioTriggerManager.activeAudio.Remove(key);
      if ((UnityEngine.Object) audioObject != (UnityEngine.Object) null)
      {
        audioObject.transform.SetParent((Transform) null);
        audioObject.Stop();
      }
      else
        Log.Error(string.Format("The AudioObject you tried to stop was null: {0} - {1}", (object) key.audioId, (object) key.instigator));
    }

    public static void SetAudioMixerValue(string exposedParamName, float value) => AudioTriggerManager.masterMixer.SetFloat(exposedParamName, value);

    private static void SetAudioPrefab(string audioID, GameObject audioObjectPrefab)
    {
      AudioItem audioItem = AudioController.GetAudioItem(audioID);
      if (audioItem == null)
        Log.Error("The AudioItem [" + audioID + "] you tried to start was not found!");
      else
        audioItem.category.AudioObjectPrefab = audioObjectPrefab;
    }

    private struct AudioKey
    {
      public SkillGraph instigator;
      public string audioId;

      public AudioKey(SkillGraph instigator, string audioId)
      {
        this.instigator = instigator;
        this.audioId = audioId;
      }
    }
  }
}
