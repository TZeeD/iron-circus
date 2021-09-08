// Decompiled with JetBrains decompiler
// Type: SpriteParticleEmitter.UIParticleRenderer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.UI;

namespace SpriteParticleEmitter
{
  [ExecuteInEditMode]
  [RequireComponent(typeof (CanvasRenderer))]
  [RequireComponent(typeof (ParticleSystem))]
  [AddComponentMenu("UI/Effects/Extensions/UI Particle System")]
  public class UIParticleRenderer : MaskableGraphic
  {
    [Tooltip("Having this enabled run the system in LateUpdate rather than in Update making it faster but less precise (more clunky)")]
    public bool fixedTime = true;
    private Transform _transform;
    private ParticleSystem pSystem;
    private ParticleSystem.Particle[] particles;
    private UIVertex[] _quad = new UIVertex[4];
    private Vector4 imageUV = Vector4.zero;
    private ParticleSystem.TextureSheetAnimationModule textureSheetAnimation;
    private int textureSheetAnimationFrames;
    private Vector2 textureSheetAnimationFrameSize;
    private ParticleSystemRenderer pRenderer;
    private Material currentMaterial;
    private Texture currentTexture;
    private ParticleSystem.MainModule mainModule;

    public override Texture mainTexture => this.currentTexture;

    protected bool Initialize()
    {
      if ((UnityEngine.Object) this._transform == (UnityEngine.Object) null)
        this._transform = this.transform;
      ParticleSystem.MainModule main;
      if ((UnityEngine.Object) this.pSystem == (UnityEngine.Object) null)
      {
        this.pSystem = this.GetComponent<ParticleSystem>();
        if ((UnityEngine.Object) this.pSystem == (UnityEngine.Object) null)
          return false;
        this.mainModule = this.pSystem.main;
        main = this.pSystem.main;
        if (main.maxParticles > 14000)
          this.mainModule.maxParticles = 14000;
        this.pRenderer = this.pSystem.GetComponent<ParticleSystemRenderer>();
        if ((UnityEngine.Object) this.pRenderer != (UnityEngine.Object) null)
          this.pRenderer.enabled = false;
        Material material = new Material(Shader.Find("UI/Particles/Additive"));
        if ((UnityEngine.Object) this.material == (UnityEngine.Object) null)
          this.material = material;
        this.currentMaterial = this.material;
        if ((bool) (UnityEngine.Object) this.currentMaterial && this.currentMaterial.HasProperty("_MainTex"))
        {
          this.currentTexture = this.currentMaterial.mainTexture;
          if ((UnityEngine.Object) this.currentTexture == (UnityEngine.Object) null)
            this.currentTexture = (Texture) Texture2D.whiteTexture;
        }
        this.material = this.currentMaterial;
        this.mainModule.scalingMode = ParticleSystemScalingMode.Hierarchy;
        this.particles = (ParticleSystem.Particle[]) null;
      }
      if (this.particles == null)
      {
        main = this.pSystem.main;
        this.particles = new ParticleSystem.Particle[main.maxParticles];
      }
      this.imageUV = new Vector4(0.0f, 0.0f, 1f, 1f);
      this.textureSheetAnimation = this.pSystem.textureSheetAnimation;
      this.textureSheetAnimationFrames = 0;
      this.textureSheetAnimationFrameSize = Vector2.zero;
      if (this.textureSheetAnimation.enabled)
      {
        this.textureSheetAnimationFrames = this.textureSheetAnimation.numTilesX * this.textureSheetAnimation.numTilesY;
        this.textureSheetAnimationFrameSize = new Vector2(1f / (float) this.textureSheetAnimation.numTilesX, 1f / (float) this.textureSheetAnimation.numTilesY);
      }
      return true;
    }

    protected override void Awake()
    {
      base.Awake();
      if (this.Initialize())
        return;
      this.enabled = false;
    }

    protected override void OnPopulateMesh(VertexHelper vh)
    {
      vh.Clear();
      if (!this.gameObject.activeInHierarchy)
        return;
      Vector2 zero1 = Vector2.zero;
      Vector2 zero2 = Vector2.zero;
      Vector2 zero3 = Vector2.zero;
      int particles = this.pSystem.GetParticles(this.particles);
      for (int index = 0; index < particles; ++index)
      {
        ParticleSystem.Particle particle = this.particles[index];
        Vector2 vector2_1 = (Vector2) (this.mainModule.simulationSpace == ParticleSystemSimulationSpace.Local ? particle.position : this._transform.InverseTransformPoint(particle.position));
        float f1 = (float) (-(double) particle.rotation * (Math.PI / 180.0));
        float f2 = f1 + 1.570796f;
        Color32 currentColor = particle.GetCurrentColor(this.pSystem);
        float num1 = particle.GetCurrentSize(this.pSystem) * 0.5f;
        if (this.mainModule.scalingMode == ParticleSystemScalingMode.Shape)
          vector2_1 /= this.canvas.scaleFactor;
        Vector4 imageUv = this.imageUV;
        if (this.textureSheetAnimation.enabled)
        {
          float num2 = Mathf.Repeat(this.textureSheetAnimation.frameOverTime.curveMin.Evaluate((float) (1.0 - (double) particle.remainingLifetime / (double) particle.startLifetime)) * (float) this.textureSheetAnimation.cycleCount, 1f);
          int num3 = 0;
          switch (this.textureSheetAnimation.animation)
          {
            case ParticleSystemAnimationType.WholeSheet:
              num3 = Mathf.FloorToInt(num2 * (float) this.textureSheetAnimationFrames);
              break;
            case ParticleSystemAnimationType.SingleRow:
              num3 = Mathf.FloorToInt(num2 * (float) this.textureSheetAnimation.numTilesX) + this.textureSheetAnimation.rowIndex * this.textureSheetAnimation.numTilesX;
              break;
          }
          int num4 = num3 % this.textureSheetAnimationFrames;
          imageUv.x = (float) (num4 % this.textureSheetAnimation.numTilesX) * this.textureSheetAnimationFrameSize.x;
          imageUv.y = (float) Mathf.FloorToInt((float) (num4 / this.textureSheetAnimation.numTilesX)) * this.textureSheetAnimationFrameSize.y;
          imageUv.z = imageUv.x + this.textureSheetAnimationFrameSize.x;
          imageUv.w = imageUv.y + this.textureSheetAnimationFrameSize.y;
        }
        zero1.x = imageUv.x;
        zero1.y = imageUv.y;
        this._quad[0] = UIVertex.simpleVert;
        this._quad[0].color = currentColor;
        this._quad[0].uv0 = zero1;
        zero1.x = imageUv.x;
        zero1.y = imageUv.w;
        this._quad[1] = UIVertex.simpleVert;
        this._quad[1].color = currentColor;
        this._quad[1].uv0 = zero1;
        zero1.x = imageUv.z;
        zero1.y = imageUv.w;
        this._quad[2] = UIVertex.simpleVert;
        this._quad[2].color = currentColor;
        this._quad[2].uv0 = zero1;
        zero1.x = imageUv.z;
        zero1.y = imageUv.y;
        this._quad[3] = UIVertex.simpleVert;
        this._quad[3].color = currentColor;
        this._quad[3].uv0 = zero1;
        if ((double) f1 == 0.0)
        {
          zero2.x = vector2_1.x - num1;
          zero2.y = vector2_1.y - num1;
          zero3.x = vector2_1.x + num1;
          zero3.y = vector2_1.y + num1;
          zero1.x = zero2.x;
          zero1.y = zero2.y;
          this._quad[0].position = (Vector3) zero1;
          zero1.x = zero2.x;
          zero1.y = zero3.y;
          this._quad[1].position = (Vector3) zero1;
          zero1.x = zero3.x;
          zero1.y = zero3.y;
          this._quad[2].position = (Vector3) zero1;
          zero1.x = zero3.x;
          zero1.y = zero2.y;
          this._quad[3].position = (Vector3) zero1;
        }
        else
        {
          Vector2 vector2_2 = new Vector2(Mathf.Cos(f1), Mathf.Sin(f1)) * num1;
          Vector2 vector2_3 = new Vector2(Mathf.Cos(f2), Mathf.Sin(f2)) * num1;
          this._quad[0].position = (Vector3) (vector2_1 - vector2_2 - vector2_3);
          this._quad[1].position = (Vector3) (vector2_1 - vector2_2 + vector2_3);
          this._quad[2].position = (Vector3) (vector2_1 + vector2_2 + vector2_3);
          this._quad[3].position = (Vector3) (vector2_1 + vector2_2 - vector2_3);
        }
        vh.AddUIVertexQuad(this._quad);
      }
    }

    private void Update()
    {
      if (this.fixedTime || !Application.isPlaying)
        return;
      this.pSystem.Simulate(Time.unscaledDeltaTime, false, false, true);
      this.SetAllDirty();
      if ((!((UnityEngine.Object) this.currentMaterial != (UnityEngine.Object) null) || !((UnityEngine.Object) this.currentTexture != (UnityEngine.Object) this.currentMaterial.mainTexture)) && (!((UnityEngine.Object) this.material != (UnityEngine.Object) null) || !((UnityEngine.Object) this.currentMaterial != (UnityEngine.Object) null) || !((UnityEngine.Object) this.material.shader != (UnityEngine.Object) this.currentMaterial.shader)))
        return;
      this.pSystem = (ParticleSystem) null;
      this.Initialize();
    }

    private void LateUpdate()
    {
      if (!Application.isPlaying)
        this.SetAllDirty();
      else if (this.fixedTime)
      {
        this.pSystem.Simulate(Time.unscaledDeltaTime, false, false, true);
        this.SetAllDirty();
        if ((UnityEngine.Object) this.currentMaterial != (UnityEngine.Object) null && (UnityEngine.Object) this.currentTexture != (UnityEngine.Object) this.currentMaterial.mainTexture || (UnityEngine.Object) this.material != (UnityEngine.Object) null && (UnityEngine.Object) this.currentMaterial != (UnityEngine.Object) null && (UnityEngine.Object) this.material.shader != (UnityEngine.Object) this.currentMaterial.shader)
        {
          this.pSystem = (ParticleSystem) null;
          this.Initialize();
        }
      }
      if ((UnityEngine.Object) this.material == (UnityEngine.Object) this.currentMaterial)
        return;
      this.pSystem = (ParticleSystem) null;
      this.Initialize();
    }
  }
}
