// Decompiled with JetBrains decompiler
// Type: SpriteParticleEmitter.StaticSpriteEmitter
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Assertions.Comparers;

namespace SpriteParticleEmitter
{
  public class StaticSpriteEmitter : EmitterBase
  {
    [Header("Awake Options")]
    [Tooltip("Activating this will force CacheOnAwake")]
    public bool PlayOnAwake = true;
    [Tooltip("Should the system cache on Awake method? - Static emission needs to be cached first, if this property is not checked the CacheSprite() method should be called by code. (Refer to manual for further explanation)")]
    public bool CacheOnAwake = true;
    protected bool hasCachingEnded;
    protected int particlesCacheCount;
    protected float particleStartSize;
    protected Vector3[] particleInitPositionsCache;
    protected Color[] particleInitColorCache;

    public override event SimpleEvent OnCacheEnded;

    public override event SimpleEvent OnAvailableToPlay;

    protected override void Awake()
    {
      base.Awake();
      if (this.PlayOnAwake)
      {
        this.isPlaying = true;
        this.CacheOnAwake = true;
      }
      if (!this.CacheOnAwake)
        return;
      this.CacheSprite();
    }

    public virtual void CacheSprite(bool relativeToParent = false)
    {
      this.hasCachingEnded = false;
      this.particlesCacheCount = 0;
      Sprite sprite = this.spriteRenderer.sprite;
      float r = this.EmitFromColor.r;
      float g = this.EmitFromColor.g;
      float b = this.EmitFromColor.b;
      Vector3 position = this.spriteRenderer.gameObject.transform.position;
      Quaternion rotation = this.spriteRenderer.gameObject.transform.rotation;
      Vector3 lossyScale = this.spriteRenderer.gameObject.transform.lossyScale;
      bool flipX = this.spriteRenderer.flipX;
      bool flipY = this.spriteRenderer.flipY;
      float pixelsPerUnit = sprite.pixelsPerUnit;
      if ((UnityEngine.Object) this.spriteRenderer == (UnityEngine.Object) null || (UnityEngine.Object) this.spriteRenderer.sprite == (UnityEngine.Object) null)
        Debug.LogError((object) "Sprite reference missing");
      float x1 = (float) (int) sprite.rect.size.x;
      float y1 = (float) (int) sprite.rect.size.y;
      this.particleStartSize = 1f / pixelsPerUnit;
      this.particleStartSize *= this.mainModule.startSize.constant;
      float num1 = sprite.pivot.x / pixelsPerUnit;
      float num2 = sprite.pivot.y / pixelsPerUnit;
      Color[] pixels = sprite.texture.GetPixels((int) sprite.rect.position.x, (int) sprite.rect.position.y, (int) x1, (int) y1);
      float redTolerance = this.RedTolerance;
      float greenTolerance = this.GreenTolerance;
      float blueTolerance = this.BlueTolerance;
      float num3 = x1 * y1;
      List<Color> colorList = new List<Color>();
      List<Vector3> vector3List = new List<Vector3>();
      for (int index = 0; (double) index < (double) num3; ++index)
      {
        Color color = pixels[index];
        if ((double) color.a > 0.0 && (!this.UseEmissionFromColor || FloatComparer.AreEqual(r, color.r, redTolerance) && FloatComparer.AreEqual(g, color.g, greenTolerance) && FloatComparer.AreEqual(b, color.b, blueTolerance)))
        {
          float x2 = (float) index % x1 / pixelsPerUnit - num1;
          float y2 = (float) index / x1 / pixelsPerUnit - num2;
          if (flipX)
            x2 = (float) ((double) x1 / (double) pixelsPerUnit - (double) x2 - (double) num1 * 2.0);
          if (flipY)
            y2 = (float) ((double) y1 / (double) pixelsPerUnit - (double) y2 - (double) num2 * 2.0);
          Vector3 vector3 = !relativeToParent ? new Vector3(x2, y2, 0.0f) : rotation * new Vector3(x2 * lossyScale.x, y2 * lossyScale.y, 0.0f) + position;
          vector3List.Add(vector3);
          colorList.Add(color);
          ++this.particlesCacheCount;
        }
      }
      this.particleInitPositionsCache = vector3List.ToArray();
      this.particleInitColorCache = colorList.ToArray();
      if (this.particlesCacheCount <= 0)
      {
        Debug.LogWarning((object) "Caching particle emission went wrong. This is most probably because couldn't find wanted color in sprite");
      }
      else
      {
        vector3List.Clear();
        colorList.Clear();
        GC.Collect();
        this.hasCachingEnded = true;
        if (this.OnCacheEnded == null)
          return;
        this.OnCacheEnded();
      }
    }

    protected virtual void Update()
    {
    }

    public override void Play()
    {
    }

    public override void Stop()
    {
    }

    public override void Pause()
    {
    }

    public override bool IsPlaying() => this.isPlaying;

    public override bool IsAvailableToPlay() => this.hasCachingEnded;
  }
}
