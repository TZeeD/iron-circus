// Decompiled with JetBrains decompiler
// Type: SpriteParticleEmitter.StaticEmitterContinuous
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SpriteParticleEmitter
{
  public class StaticEmitterContinuous : StaticSpriteEmitter
  {
    [Header("Emission")]
    [Tooltip("Particles to emit per second")]
    public float EmissionRate = 1000f;
    protected float ParticlesToEmitThisFrame;

    public override event SimpleEvent OnAvailableToPlay;

    protected override void Update()
    {
      base.Update();
      if (!this.isPlaying || !this.hasCachingEnded)
        return;
      this.Emit();
    }

    public override void CacheSprite(bool relativeToParent = false)
    {
      base.CacheSprite();
      if (this.OnAvailableToPlay == null)
        return;
      this.OnAvailableToPlay();
    }

    protected void Emit()
    {
      if (!this.hasCachingEnded)
        return;
      this.ParticlesToEmitThisFrame += this.EmissionRate * Time.deltaTime;
      Vector3 position = this.spriteRenderer.gameObject.transform.position;
      Quaternion rotation = this.spriteRenderer.gameObject.transform.rotation;
      Vector3 lossyScale = this.spriteRenderer.gameObject.transform.lossyScale;
      ParticleSystemSimulationSpace simulationSpace = this.SimulationSpace;
      int particlesCacheCount = this.particlesCacheCount;
      float particleStartSize = this.particleStartSize;
      int particlesToEmitThisFrame = (int) this.ParticlesToEmitThisFrame;
      if (this.particlesCacheCount <= 0)
        return;
      Color[] particleInitColorCache = this.particleInitColorCache;
      Vector3[] initPositionsCache = this.particleInitPositionsCache;
      Vector3 zero = Vector3.zero;
      for (int index1 = 0; index1 < particlesToEmitThisFrame; ++index1)
      {
        int index2 = Random.Range(0, particlesCacheCount);
        ParticleSystem.EmitParams emitParams = new ParticleSystem.EmitParams();
        if (this.UsePixelSourceColor)
          emitParams.startColor = (Color32) particleInitColorCache[index2];
        emitParams.startSize = particleStartSize;
        if (simulationSpace == ParticleSystemSimulationSpace.World)
        {
          Vector3 vector3 = initPositionsCache[index2];
          zero.x = vector3.x * lossyScale.x;
          zero.y = vector3.y * lossyScale.y;
          emitParams.position = rotation * zero + position;
          this.particlesSystem.Emit(emitParams, 1);
        }
        else
        {
          emitParams.position = initPositionsCache[index2];
          this.particlesSystem.Emit(emitParams, 1);
        }
      }
      this.ParticlesToEmitThisFrame -= (float) particlesToEmitThisFrame;
    }

    public override void Play()
    {
      if (!this.isPlaying)
        this.particlesSystem.Play();
      this.isPlaying = true;
    }

    public override void Stop() => this.isPlaying = false;

    public override void Pause()
    {
      if (this.isPlaying)
        this.particlesSystem.Pause();
      this.isPlaying = false;
    }
  }
}
