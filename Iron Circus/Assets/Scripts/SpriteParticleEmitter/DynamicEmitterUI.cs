// Decompiled with JetBrains decompiler
// Type: SpriteParticleEmitter.DynamicEmitterUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Assertions.Comparers;

namespace SpriteParticleEmitter
{
  [RequireComponent(typeof (UIParticleRenderer))]
  public class DynamicEmitterUI : EmitterBaseUI
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
    [Tooltip("Should the transform match target Image Renderer Position?")]
    public bool matchImageRendererPostionData;
    [Tooltip("Should the transform match target Image Renderer Scale?")]
    public bool matchImageRendererScale;
    private RectTransform targetRectTransform;
    private RectTransform currentRectTransform;
    protected Vector2 offsetXY;
    protected float wMult = 100f;
    protected float hMult = 100f;

    protected override void Awake()
    {
      base.Awake();
      if (this.PlayOnAwake)
        this.isPlaying = true;
      this.currentRectTransform = this.GetComponent<RectTransform>();
      this.targetRectTransform = this.imageRenderer.GetComponent<RectTransform>();
      if ((double) this.mainModule.maxParticles >= (double) this.EmissionRate)
        return;
      this.mainModule.maxParticles = Mathf.CeilToInt(this.EmissionRate);
    }

    protected void Update()
    {
      if (!this.isPlaying)
        return;
      if ((Object) this.imageRenderer == (Object) null)
      {
        Debug.LogError((object) "Image Renderer component not referenced in DynamicEmitterUI component");
        this.isPlaying = false;
      }
      else
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
        double num1 = 1.0 - (double) this.targetRectTransform.pivot.x;
        rect = this.targetRectTransform.rect;
        double width2 = (double) rect.width;
        double num2 = num1 * width2;
        rect = this.targetRectTransform.rect;
        double num3 = (double) rect.width / 2.0;
        float x1 = (float) (num2 - num3);
        double num4 = 1.0 - (double) this.targetRectTransform.pivot.y;
        rect = this.targetRectTransform.rect;
        double num5 = -(double) rect.height;
        double num6 = num4 * num5;
        rect = this.targetRectTransform.rect;
        double num7 = (double) rect.height / 2.0;
        float y1 = (float) (num6 + num7);
        this.offsetXY = new Vector2(x1, y1);
        Sprite sprite = this.imageRenderer.sprite;
        double pixelsPerUnit1 = (double) sprite.pixelsPerUnit;
        rect = this.targetRectTransform.rect;
        double width3 = (double) rect.width;
        rect = sprite.rect;
        double x2 = (double) rect.size.x;
        double num8 = width3 / x2;
        this.wMult = (float) (pixelsPerUnit1 * num8);
        double pixelsPerUnit2 = (double) sprite.pixelsPerUnit;
        rect = this.targetRectTransform.rect;
        double height2 = (double) rect.height;
        rect = sprite.rect;
        double y2 = (double) rect.size.y;
        double num9 = height2 / y2;
        this.hMult = (float) (pixelsPerUnit2 * num9);
        this.ParticlesToEmitThisFrame += this.EmissionRate * Time.deltaTime;
        int particlesToEmitThisFrame = (int) this.ParticlesToEmitThisFrame;
        if (particlesToEmitThisFrame > 0)
          this.Emit(particlesToEmitThisFrame);
        this.ParticlesToEmitThisFrame -= (float) particlesToEmitThisFrame;
      }
    }

    public void Emit(int emitCount)
    {
      Sprite key = this.imageRenderer.sprite;
      if ((bool) (Object) this.imageRenderer.overrideSprite)
        key = this.imageRenderer.overrideSprite;
      float r = this.EmitFromColor.r;
      float g = this.EmitFromColor.g;
      float b = this.EmitFromColor.b;
      float pixelsPerUnit = key.pixelsPerUnit;
      float x1 = (float) (int) key.rect.size.x;
      Rect rect = key.rect;
      float y1 = (float) (int) rect.size.y;
      ParticleSystem.MinMaxCurve startSize = this.mainModule.startSize;
      float num1 = key.pivot.x / pixelsPerUnit;
      float num2 = key.pivot.y / pixelsPerUnit;
      Color[] pixels;
      if (this.CacheSprites)
      {
        if (this.spritesSoFar.ContainsKey(key))
        {
          pixels = this.spritesSoFar[key];
        }
        else
        {
          Texture2D texture = key.texture;
          rect = key.rect;
          int x2 = (int) rect.position.x;
          rect = key.rect;
          int y2 = (int) rect.position.y;
          int blockWidth = (int) x1;
          int blockHeight = (int) y1;
          pixels = texture.GetPixels(x2, y2, blockWidth, blockHeight);
          this.spritesSoFar.Add(key, pixels);
        }
      }
      else
      {
        Texture2D texture = key.texture;
        rect = key.rect;
        int x3 = (int) rect.position.x;
        rect = key.rect;
        int y3 = (int) rect.position.y;
        int blockWidth = (int) x1;
        int blockHeight = (int) y1;
        pixels = texture.GetPixels(x3, y3, blockWidth, blockHeight);
      }
      float redTolerance = this.RedTolerance;
      float greenTolerance = this.GreenTolerance;
      float blueTolerance = this.BlueTolerance;
      float num3 = x1 * y1;
      Color[] colorCache = this.colorCache;
      int[] indexCache = this.indexCache;
      if ((double) colorCache.Length < (double) num3)
      {
        this.colorCache = new Color[(int) num3];
        this.indexCache = new int[(int) num3];
        colorCache = this.colorCache;
        indexCache = this.indexCache;
      }
      int index1 = 0;
      for (int index2 = 0; (double) index2 < (double) num3; ++index2)
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
        int num4;
        float num5 = (float) (num4 = indexCache[index4]) % x1 / pixelsPerUnit - num1;
        float num6 = (float) num4 / x1 / pixelsPerUnit - num2;
        ParticleSystem.EmitParams emitParams = new ParticleSystem.EmitParams();
        zero.x = num5 * this.wMult + this.offsetXY.x;
        zero.y = num6 * this.hMult - this.offsetXY.y;
        emitParams.position = zero;
        if (this.UsePixelSourceColor)
          emitParams.startColor = (Color32) colorCache[index4];
        emitParams.startSize = startSize.constant;
        this.particlesSystem.Emit(emitParams, 1);
      }
    }

    public void EmitAll(bool hideSprite = true)
    {
      if (hideSprite)
        this.imageRenderer.enabled = false;
      Sprite sprite = this.imageRenderer.sprite;
      float r = this.EmitFromColor.r;
      float g = this.EmitFromColor.g;
      float b = this.EmitFromColor.b;
      float pixelsPerUnit = sprite.pixelsPerUnit;
      float x1 = (float) (int) sprite.rect.size.x;
      float y1 = (float) (int) sprite.rect.size.y;
      float constant = this.mainModule.startSize.constant;
      float num1 = sprite.pivot.x / pixelsPerUnit;
      float num2 = sprite.pivot.y / pixelsPerUnit;
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
      float num3 = x1 * y1;
      Vector3 zero = Vector3.zero;
      for (int index = 0; (double) index < (double) num3; ++index)
      {
        Color color = pixels[index];
        if ((double) color.a > 0.0 && (!this.UseEmissionFromColor || FloatComparer.AreEqual(r, color.r, redTolerance) && FloatComparer.AreEqual(g, color.g, greenTolerance) && FloatComparer.AreEqual(b, color.b, blueTolerance)))
        {
          float num4 = (float) index % x1 / pixelsPerUnit - num1;
          float num5 = (float) index / x1 / pixelsPerUnit - num2;
          ParticleSystem.EmitParams emitParams = new ParticleSystem.EmitParams();
          zero.x = num4 * this.wMult + this.offsetXY.x;
          zero.y = num5 * this.hMult - this.offsetXY.y;
          emitParams.position = zero;
          if (this.UsePixelSourceColor)
            emitParams.startColor = (Color32) color;
          emitParams.startSize = constant;
          this.particlesSystem.Emit(emitParams, 1);
        }
      }
    }

    public void RestoreSprite() => this.imageRenderer.enabled = true;

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
