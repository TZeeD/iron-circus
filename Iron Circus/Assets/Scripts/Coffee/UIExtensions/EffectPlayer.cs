// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.EffectPlayer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;

namespace Coffee.UIExtensions
{
  [Serializable]
  public class EffectPlayer
  {
    [Header("Effect Player")]
    [Tooltip("Playing.")]
    public bool play;
    [Tooltip("Initial play delay.")]
    [Range(0.0f, 10f)]
    public float initialPlayDelay;
    [Tooltip("Duration.")]
    [Range(0.01f, 10f)]
    public float duration = 1f;
    [Tooltip("Loop.")]
    public bool loop;
    [Tooltip("Delay before looping.")]
    [Range(0.0f, 10f)]
    public float loopDelay;
    [Tooltip("Update mode")]
    public AnimatorUpdateMode updateMode;
    private static List<Action> s_UpdateActions;
    private float _time;
    private Action<float> _callback;

    public void OnEnable(Action<float> callback = null)
    {
      if (EffectPlayer.s_UpdateActions == null)
      {
        EffectPlayer.s_UpdateActions = new List<Action>();
        Canvas.willRenderCanvases += (Canvas.WillRenderCanvases) (() =>
        {
          int count = EffectPlayer.s_UpdateActions.Count;
          for (int index = 0; index < count; ++index)
            EffectPlayer.s_UpdateActions[index]();
        });
      }
      EffectPlayer.s_UpdateActions.Add(new Action(this.OnWillRenderCanvases));
      this._time = !this.play ? 0.0f : -this.initialPlayDelay;
      this._callback = callback;
    }

    public void OnDisable()
    {
      this._callback = (Action<float>) null;
      EffectPlayer.s_UpdateActions.Remove(new Action(this.OnWillRenderCanvases));
    }

    public void Play(Action<float> callback = null)
    {
      this._time = 0.0f;
      this.play = true;
      if (callback == null)
        return;
      this._callback = callback;
    }

    public void Stop() => this.play = false;

    private void OnWillRenderCanvases()
    {
      if (!this.play || !Application.isPlaying || this._callback == null)
        return;
      this._time += this.updateMode == AnimatorUpdateMode.UnscaledTime ? Time.unscaledDeltaTime : Time.deltaTime;
      float num = this._time / this.duration;
      if ((double) this.duration <= (double) this._time)
      {
        this.play = this.loop;
        this._time = this.loop ? -this.loopDelay : 0.0f;
      }
      this._callback(num);
    }
  }
}
