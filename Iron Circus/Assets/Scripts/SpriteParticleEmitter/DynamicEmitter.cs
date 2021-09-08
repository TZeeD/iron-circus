// Decompiled with JetBrains decompiler
// Type: SpriteParticleEmitter.DynamicEmitter
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Assertions.Comparers;

namespace SpriteParticleEmitter
{
  public class DynamicEmitter : EmitterBase
  {
    [Tooltip("Start emitting as soon as able")]
    public bool PlayOnAwake = true;
    [Header("Emission")]
    [Tooltip("Particles to emit per second")]
    public float EmissionRate = 1000f;
    protected float ParticlesToEmitThisFrame;
    [Tooltip("Should the system cache sprites data? (Refer to manual for further explanation)")]
    public bool CacheSprites = true;
    private Color[] colorCache = new Color[1];
    private int[] indexCache = new int[1];
    protected Dictionary<Sprite, Color[]> spritesSoFar = new Dictionary<Sprite, Color[]>();

    protected override void Awake()
    {
      base.Awake();
      if (this.PlayOnAwake)
        this.isPlaying = true;
      if ((double) this.mainModule.maxParticles >= (double) this.EmissionRate)
        return;
      this.mainModule.maxParticles = Mathf.CeilToInt(this.EmissionRate);
    }

    protected void Update()
    {
      if (!this.isPlaying)
        return;
      this.ParticlesToEmitThisFrame += this.EmissionRate * Time.deltaTime;
      int particlesToEmitThisFrame = (int) this.ParticlesToEmitThisFrame;
      if (particlesToEmitThisFrame > 0)
        this.Emit(particlesToEmitThisFrame);
      this.ParticlesToEmitThisFrame -= (float) particlesToEmitThisFrame;
    }

    public void Emit(int emitCount)
    {
      Sprite sprite = this.spriteRenderer.sprite;
      float r = this.EmitFromColor.r;
      float g = this.EmitFromColor.g;
      float b = this.EmitFromColor.b;
      Vector3 vector3_1 = this.spriteRenderer.gameObject.transform.position;
      Quaternion quaternion = this.spriteRenderer.gameObject.transform.rotation;
      Vector3 vector3_2 = this.spriteRenderer.gameObject.transform.lossyScale;
      if (this.SimulationSpace == ParticleSystemSimulationSpace.Local)
      {
        vector3_1 = Vector3.zero;
        vector3_2 = Vector3.one;
        quaternion = Quaternion.identity;
      }
      bool flipX = this.spriteRenderer.flipX;
      bool flipY = this.spriteRenderer.flipY;
      float pixelsPerUnit = sprite.pixelsPerUnit;
      float x = (float) (int) sprite.rect.size.x;
      float y = (float) (int) sprite.rect.size.y;
      float num1 = 1f / pixelsPerUnit * this.mainModule.startSize.constant;
      float num2 = sprite.pivot.x / pixelsPerUnit;
      float num3 = sprite.pivot.y / pixelsPerUnit;
      Color[] pixels;
      if (this.CacheSprites)
      {
        if (this.spritesSoFar.ContainsKey(sprite))
        {
          pixels = this.spritesSoFar[sprite];
        }
        else
        {
          pixels = sprite.texture.GetPixels((int) sprite.rect.position.x, (int) sprite.rect.position.y, (int) x, (int) y);
          this.spritesSoFar.Add(sprite, pixels);
        }
      }
      else
        pixels = sprite.texture.GetPixels((int) sprite.rect.position.x, (int) sprite.rect.position.y, (int) x, (int) y);
      float redTolerance = this.RedTolerance;
      float greenTolerance = this.GreenTolerance;
      float blueTolerance = this.BlueTolerance;
      float num4 = x * y;
      Color[] colorCache = this.colorCache;
      int[] indexCache = this.indexCache;
      if ((double) colorCache.Length < (double) num4)
      {
        this.colorCache = new Color[(int) num4];
        this.indexCache = new int[(int) num4];
        colorCache = this.colorCache;
        indexCache = this.indexCache;
      }
      int index1 = 0;
      for (int index2 = 0; (double) index2 < (double) num4; ++index2)
      {
        Color color = pixels[index2];
        if ((double) color.a > 0.0 && (!this.UseEmissionFromColor || FloatComparer.AreEqual(r, color.r, redTolerance) && FloatComparer.AreEqual(g, color.g, greenTolerance) && FloatComparer.AreEqual(b, color.b, blueTolerance)))
        {
          colorCache[index1] = color;
          indexCache[index1] = index2;
          ++index1;
        }
      }
      if (index1 <= 0)
        return;
      Vector3 zero = Vector3.zero;
      for (int index3 = 0; index3 < emitCount; ++index3)
      {
        int index4 = Random.Range(0, index1 - 1);
        int num5;
        float num6 = (float) (num5 = indexCache[index4]) % x / pixelsPerUnit - num2;
        float num7 = (float) num5 / x / pixelsPerUnit - num3;
        if (flipX)
          num6 = (float) ((double) x / (double) pixelsPerUnit - (double) num6 - (double) num2 * 2.0);
        if (flipY)
          num7 = (float) ((double) y / (double) pixelsPerUnit - (double) num7 - (double) num3 * 2.0);
        zero.x = num6 * vector3_2.x;
        zero.y = num7 * vector3_2.y;
        ParticleSystem.EmitParams emitParams = new ParticleSystem.EmitParams();
        emitParams.position = quaternion * zero + vector3_1;
        if (this.UsePixelSourceColor)
          emitParams.startColor = (Color32) colorCache[index4];
        emitParams.startSize = num1;
        this.particlesSystem.Emit(emitParams, 1);
      }
    }

    public void EmitAll(bool hideSprite = true)
    {
      if (hideSprite)
        this.spriteRenderer.enabled = false;
      Sprite sprite = this.spriteRenderer.sprite;
      float r = this.EmitFromColor.r;
      float g = this.EmitFromColor.g;
      float b = this.EmitFromColor.b;
      Vector3 vector3_1 = this.spriteRenderer.gameObject.transform.position;
      Quaternion quaternion = this.spriteRenderer.gameObject.transform.rotation;
      Vector3 vector3_2 = this.spriteRenderer.gameObject.transform.lossyScale;
      if (this.SimulationSpace == ParticleSystemSimulationSpace.Local)
      {
        vector3_1 = Vector3.zero;
        vector3_2 = Vector3.one;
        quaternion = Quaternion.identity;
      }
      bool flipX = this.spriteRenderer.flipX;
      bool flipY = this.spriteRenderer.flipY;
      float pixelsPerUnit = sprite.pixelsPerUnit;
      float x1 = (float) (int) sprite.rect.size.x;
      float y1 = (float) (int) sprite.rect.size.y;
      float num1 = 1f / pixelsPerUnit * this.mainModule.startSize.constant;
      float num2 = sprite.pivot.x / pixelsPerUnit;
      float num3 = sprite.pivot.y / pixelsPerUnit;
      Color[] pixels;
      if (this.CacheSprites)
      {
        if (this.spritesSoFar.ContainsKey(sprite))
        {
          pixels = this.spritesSoFar[sprite];
        }
        else
        {
          Texture2D texture = sprite.texture;
          Rect rect = sprite.rect;
          int x2 = (int) rect.position.x;
          rect = sprite.rect;
          int y2 = (int) rect.position.y;
          int blockWidth = (int) x1;
          int blockHeight = (int) y1;
          pixels = texture.GetPixels(x2, y2, blockWidth, blockHeight);
          this.spritesSoFar.Add(sprite, pixels);
        }
      }
      else
      {
        Texture2D texture = sprite.texture;
        Rect rect = sprite.rect;
        int x3 = (int) rect.position.x;
        rect = sprite.rect;
        int y3 = (int) rect.position.y;
        int blockWidth = (int) x1;
        int blockHeight = (int) y1;
        pixels = texture.GetPixels(x3, y3, blockWidth, blockHeight);
      }
      float redTolerance = this.RedTolerance;
      float greenTolerance = this.GreenTolerance;
      float blueTolerance = this.BlueTolerance;
      float num4 = x1 * y1;
      Vector3 zero = Vector3.zero;
      for (int index = 0; (double) index < (double) num4; ++index)
      {
        Color color = pixels[index];
        if ((double) color.a > 0.0 && (!this.UseEmissionFromColor || FloatComparer.AreEqual(r, color.r, redTolerance) && FloatComparer.AreEqual(g, color.g, greenTolerance) && FloatComparer.AreEqual(b, color.b, blueTolerance)))
        {
          float num5 = (float) index % x1 / pixelsPerUnit - num2;
          float num6 = (float) index / x1 / pixelsPerUnit - num3;
          if (flipX)
            num5 = (float) ((double) x1 / (double) pixelsPerUnit - (double) num5 - (double) num2 * 2.0);
          if (flipY)
            num6 = (float) ((double) y1 / (double) pixelsPerUnit - (double) num6 - (double) num3 * 2.0);
          zero.x = num5 * vector3_2.x;
          zero.y = num6 * vector3_2.y;
          ParticleSystem.EmitParams emitParams = new ParticleSystem.EmitParams();
          emitParams.position = quaternion * zero + vector3_1;
          if (this.UsePixelSourceColor)
            emitParams.startColor = (Color32) color;
          emitParams.startSize = num1;
          this.particlesSystem.Emit(emitParams, 1);
        }
      }
    }

    public void RestoreSprite() => this.spriteRenderer.enabled = true;

    public override void Play()
    {
      if (!this.isPlaying)
        this.particlesSystem.Play();
      this.isPlaying = true;
    }

    public override void Pause()
    {
      if (this.isPlaying)
        this.particlesSystem.Pause();
      this.isPlaying = false;
    }

    public override void Stop() => this.isPlaying = false;

    public override bool IsPlaying() => this.isPlaying;

    public override bool IsAvailableToPlay() => true;

    public void ClearCachedSprites() => this.spritesSoFar = new Dictionary<Sprite, Color[]>();
  }
}
