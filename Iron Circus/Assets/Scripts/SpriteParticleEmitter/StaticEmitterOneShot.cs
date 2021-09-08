// Decompiled with JetBrains decompiler
// Type: SpriteParticleEmitter.StaticEmitterOneShot
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;

namespace SpriteParticleEmitter
{
  public class StaticEmitterOneShot : StaticSpriteEmitter
  {
    [Tooltip("Must the script disable referenced spriteRenderer component?")]
    public bool HideOriginalSpriteOnPlay = true;
    [Header("Silent Emission")]
    [Tooltip("Should start Silent Emitting as soon as has cache ended? (Refer to manual for further explanation)")]
    public bool SilentEmitOnAwake = true;
    [Tooltip("Silent emission can be expensive. This defines the lower limit fps can go before continue silent emission on next frame (Refer to manual for further explanation)")]
    public float WantedFPSDuringSilentEmission = 60f;
    protected bool SilentEmissionEnded;
    protected bool hasSilentEmissionAlreadyBeenShot;

    public override event SimpleEvent OnAvailableToPlay;

    protected override void Awake()
    {
      base.Awake();
      this.SilentEmissionEnded = false;
      if (!this.SilentEmitOnAwake)
        return;
      this.EmitSilently();
    }

    public override void CacheSprite(bool relativeToParent = false)
    {
      base.CacheSprite(this.SimulationSpace == ParticleSystemSimulationSpace.World);
      if (this.mainModule.maxParticles < this.particlesCacheCount)
        this.mainModule.maxParticles = Mathf.CeilToInt((float) this.particlesCacheCount);
      this.SilentEmissionEnded = false;
      this.hasSilentEmissionAlreadyBeenShot = false;
    }

    public void EmitSilently() => this.StartCoroutine(this.EmitParticlesSilently());

    private IEnumerator EmitParticlesSilently()
    {
      StaticEmitterOneShot staticEmitterOneShot = this;
      staticEmitterOneShot.hasSilentEmissionAlreadyBeenShot = false;
      staticEmitterOneShot.SilentEmissionEnded = false;
      staticEmitterOneShot.isPlaying = false;
      float time = Time.realtimeSinceStartup;
      float LastTimeSaved = Time.realtimeSinceStartup;
      float waitTimeMax = 1000f / staticEmitterOneShot.WantedFPSDuringSilentEmission;
      staticEmitterOneShot.particlesSystem.Clear();
      staticEmitterOneShot.particlesSystem.Pause();
      Color[] colorCache = staticEmitterOneShot.particleInitColorCache;
      Vector3[] posCache = staticEmitterOneShot.particleInitPositionsCache;
      float pStartSize = staticEmitterOneShot.particleStartSize;
      int length = staticEmitterOneShot.particlesCacheCount;
      ParticleSystem ps = staticEmitterOneShot.particlesSystem;
      for (int i = 0; i < length; ++i)
      {
        if (i % 3 == 0)
          LastTimeSaved = Time.realtimeSinceStartup;
        ParticleSystem.EmitParams emitParams = new ParticleSystem.EmitParams();
        if (staticEmitterOneShot.UsePixelSourceColor)
          emitParams.startColor = (Color32) colorCache[i];
        emitParams.startSize = pStartSize;
        emitParams.position = posCache[i];
        ps.Emit(emitParams, 1);
        if ((double) LastTimeSaved - (double) time > (double) waitTimeMax)
        {
          staticEmitterOneShot.particlesSystem.Pause();
          time = LastTimeSaved;
          yield return (object) null;
        }
      }
      staticEmitterOneShot.particlesSystem.Pause();
      staticEmitterOneShot.SilentEmissionEnded = true;
      if (staticEmitterOneShot.OnAvailableToPlay != null)
        staticEmitterOneShot.OnAvailableToPlay();
    }

    public void SetHideSpriteOnPlay(bool hideOriginalSprite) => this.HideOriginalSpriteOnPlay = hideOriginalSprite;

    private bool PlayOneShot()
    {
      if (this.HideOriginalSpriteOnPlay)
        this.spriteRenderer.enabled = false;
      if (!this.SilentEmissionEnded)
      {
        Debug.LogError((object) "Silent particles haven't been emitted yet. Particles need to be emitted silently first for PlayOneShot to work (Please Refer to manual)");
        return false;
      }
      this.particlesSystem.Play();
      this.isPlaying = true;
      this.hasSilentEmissionAlreadyBeenShot = true;
      return true;
    }

    public override void Play()
    {
      if (!this.IsAvailableToPlay())
        return;
      if (!this.hasSilentEmissionAlreadyBeenShot)
      {
        if (this.isPlaying)
          return;
        this.PlayOneShot();
      }
      else
      {
        if (this.isPlaying)
          return;
        this.particlesSystem.Play();
        this.isPlaying = true;
      }
    }

    public override void Stop()
    {
      if (this.isPlaying)
        this.particlesSystem.Pause();
      this.isPlaying = false;
    }

    public override void Pause()
    {
      if (this.isPlaying)
        this.particlesSystem.Pause();
      this.isPlaying = false;
    }

    public void Reset() => this.EmitSilently();

    public override bool IsAvailableToPlay() => this.hasCachingEnded && !this.isPlaying && this.SilentEmissionEnded;
  }
}
