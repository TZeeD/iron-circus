// Decompiled with JetBrains decompiler
// Type: SpriteParticleEmitter.StaticEmitterContinuousUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SpriteParticleEmitter
{
  public class StaticEmitterContinuousUI : StaticUIImageEmitter
  {
    [Header("Emission")]
    [Tooltip("Particles to emit per second")]
    public float EmissionRate = 1000f;
    protected float ParticlesToEmitThisFrame;
    [Tooltip("Should the transform match target Image Renderer Position?")]
    public bool matchImageRendererPostionData = true;
    [Tooltip("Should the transform match target Image Renderer Scale?")]
    public bool matchImageRendererScale = true;
    private RectTransform targetRectTransform;
    private RectTransform currentRectTransform;
    protected Vector2 offsetXY;
    protected float wMult = 100f;
    protected float hMult = 100f;

    public override event SimpleEvent OnAvailableToPlay;

    protected override void Awake()
    {
      base.Awake();
      this.currentRectTransform = this.GetComponent<RectTransform>();
      this.targetRectTransform = this.imageRenderer.GetComponent<RectTransform>();
    }

    protected override void Update()
    {
      base.Update();
      if (!this.isPlaying || !this.hasCachingEnded)
        return;
      this.ProcessPositionAndScale();
      this.Emit();
    }

    private void ProcessPositionAndScale()
    {
      if (this.matchImageRendererPostionData)
        this.currentRectTransform.position = new Vector3(this.targetRectTransform.position.x, this.targetRectTransform.position.y, this.targetRectTransform.position.z);
      this.currentRectTransform.pivot = this.targetRectTransform.pivot;
      if (this.matchImageRendererPostionData)
      {
        this.currentRectTransform.anchoredPosition = this.targetRectTransform.anchoredPosition;
        this.currentRectTransform.anchorMin = this.targetRectTransform.anchorMin;
        this.currentRectTransform.anchorMax = this.targetRectTransform.anchorMax;
        this.currentRectTransform.offsetMin = this.targetRectTransform.offsetMin;
        this.currentRectTransform.offsetMax = this.targetRectTransform.offsetMax;
      }
      if (this.matchImageRendererScale)
        this.currentRectTransform.localScale = this.targetRectTransform.localScale;
      this.currentRectTransform.rotation = this.targetRectTransform.rotation;
      RectTransform currentRectTransform = this.currentRectTransform;
      Rect rect = this.targetRectTransform.rect;
      double width1 = (double) rect.width;
      rect = this.targetRectTransform.rect;
      double height1 = (double) rect.height;
      Vector2 vector2 = new Vector2((float) width1, (float) height1);
      currentRectTransform.sizeDelta = vector2;
      double num1 = 1.0 - (double) this.currentRectTransform.pivot.x;
      rect = this.currentRectTransform.rect;
      double width2 = (double) rect.width;
      double num2 = num1 * width2;
      rect = this.currentRectTransform.rect;
      double num3 = (double) rect.width / 2.0;
      float x1 = (float) (num2 - num3);
      double num4 = 1.0 - (double) this.currentRectTransform.pivot.y;
      rect = this.currentRectTransform.rect;
      double num5 = -(double) rect.height;
      double num6 = num4 * num5;
      rect = this.currentRectTransform.rect;
      double num7 = (double) rect.height / 2.0;
      float y1 = (float) (num6 + num7);
      this.offsetXY = new Vector2(x1, y1);
      Sprite sprite = this.imageRenderer.sprite;
      double pixelsPerUnit1 = (double) sprite.pixelsPerUnit;
      rect = this.currentRectTransform.rect;
      double width3 = (double) rect.width;
      rect = sprite.rect;
      double x2 = (double) rect.size.x;
      double num8 = width3 / x2;
      this.wMult = (float) (pixelsPerUnit1 * num8);
      double pixelsPerUnit2 = (double) sprite.pixelsPerUnit;
      rect = this.currentRectTransform.rect;
      double height2 = (double) rect.height;
      rect = sprite.rect;
      double y2 = (double) rect.size.y;
      double num9 = height2 / y2;
      this.hMult = (float) (pixelsPerUnit2 * num9);
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
      Vector3 position = this.currentRectTransform.position;
      Quaternion rotation = this.currentRectTransform.rotation;
      Vector3 localScale = this.currentRectTransform.localScale;
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
        Vector3 vector3 = initPositionsCache[index2];
        if (simulationSpace == ParticleSystemSimulationSpace.World)
        {
          zero.x = vector3.x * this.wMult * localScale.x + this.offsetXY.x;
          zero.y = vector3.y * this.hMult * localScale.y - this.offsetXY.y;
          emitParams.position = rotation * zero + position;
          this.particlesSystem.Emit(emitParams, 1);
        }
        else
        {
          zero.x = vector3.x * this.wMult + this.offsetXY.x;
          zero.y = vector3.y * this.hMult - this.offsetXY.y;
          emitParams.position = zero;
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
