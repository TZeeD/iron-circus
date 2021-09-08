// Decompiled with JetBrains decompiler
// Type: ClockStone.PlayAudio
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace ClockStone
{
  public class PlayAudio : AudioTriggerBase
  {
    public string audioID;
    public PlayAudio.SoundType soundType;
    public PlayAudio.PlayPosition position;
    public float volume = 1f;
    public float delay;
    public float startTime;

    protected override void Awake()
    {
      if (this.triggerEvent == AudioTriggerBase.EventType.OnDestroy && this.position == PlayAudio.PlayPosition.ChildObject)
      {
        this.position = PlayAudio.PlayPosition.ObjectPosition;
        Debug.LogWarning((object) "OnDestroy event can not be used with ChildObject");
      }
      base.Awake();
    }

    private void _Play()
    {
      switch (this.position)
      {
        case PlayAudio.PlayPosition.Global:
          AudioController.Play(this.audioID, this.volume, this.delay, this.startTime);
          break;
        case PlayAudio.PlayPosition.ChildObject:
          AudioController.Play(this.audioID, this.transform, this.volume, this.delay, this.startTime);
          break;
        case PlayAudio.PlayPosition.ObjectPosition:
          AudioController.Play(this.audioID, this.transform.position, (Transform) null, this.volume, this.delay, this.startTime);
          break;
      }
    }

    protected override void _OnEventTriggered()
    {
      if (string.IsNullOrEmpty(this.audioID))
        return;
      switch (this.soundType)
      {
        case PlayAudio.SoundType.SFX:
          this._Play();
          break;
        case PlayAudio.SoundType.Music:
          this._PlayMusic();
          break;
        case PlayAudio.SoundType.AmbienceSound:
          this._PlayAmbienceSound();
          break;
      }
    }

    private void _PlayMusic()
    {
      switch (this.position)
      {
        case PlayAudio.PlayPosition.Global:
          AudioController.PlayMusic(this.audioID, this.volume, this.delay, this.startTime);
          break;
        case PlayAudio.PlayPosition.ChildObject:
          AudioController.PlayMusic(this.audioID, this.transform, this.volume, this.delay, this.startTime);
          break;
        case PlayAudio.PlayPosition.ObjectPosition:
          AudioController.PlayMusic(this.audioID, this.transform.position, volume: this.volume, delay: this.delay, startTime: this.startTime);
          break;
      }
    }

    private void _PlayAmbienceSound()
    {
      switch (this.position)
      {
        case PlayAudio.PlayPosition.Global:
          AudioController.PlayAmbienceSound(this.audioID, this.volume, this.delay, this.startTime);
          break;
        case PlayAudio.PlayPosition.ChildObject:
          AudioController.PlayAmbienceSound(this.audioID, this.transform, this.volume, this.delay, this.startTime);
          break;
        case PlayAudio.PlayPosition.ObjectPosition:
          AudioController.PlayAmbienceSound(this.audioID, this.transform.position, volume: this.volume, delay: this.delay, startTime: this.startTime);
          break;
      }
    }

    public enum PlayPosition
    {
      Global,
      ChildObject,
      ObjectPosition,
    }

    public enum SoundType
    {
      SFX,
      Music,
      AmbienceSound,
    }
  }
}
