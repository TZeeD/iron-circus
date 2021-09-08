// Decompiled with JetBrains decompiler
// Type: AudioTriggerBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ClockStone;
using UnityEngine;

public abstract class AudioTriggerBase : MonoBehaviour
{
  public AudioTriggerBase.EventType triggerEvent;

  protected virtual void Awake() => this._CheckEvent(AudioTriggerBase.EventType.Awake);

  protected virtual void Start() => this._CheckEvent(AudioTriggerBase.EventType.Start);

  protected virtual void OnDestroy()
  {
    if (this.triggerEvent != AudioTriggerBase.EventType.OnDestroy || !(bool) (Object) SingletonMonoBehaviour<AudioController>.DoesInstanceExist())
      return;
    this._CheckEvent(AudioTriggerBase.EventType.OnDestroy);
  }

  protected virtual void OnCollisionEnter() => this._CheckEvent(AudioTriggerBase.EventType.OnCollisionEnter);

  protected virtual void OnCollisionExit() => this._CheckEvent(AudioTriggerBase.EventType.OnCollisionExit);

  protected virtual void OnEnable() => this._CheckEvent(AudioTriggerBase.EventType.OnEnable);

  protected virtual void OnDisable() => this._CheckEvent(AudioTriggerBase.EventType.OnDisable);

  protected abstract void _OnEventTriggered();

  protected virtual void _CheckEvent(AudioTriggerBase.EventType eventType)
  {
    if (this.triggerEvent != eventType)
      return;
    this._OnEventTriggered();
  }

  public enum EventType
  {
    Start,
    Awake,
    OnDestroy,
    OnCollisionEnter,
    OnCollisionExit,
    OnEnable,
    OnDisable,
  }
}
