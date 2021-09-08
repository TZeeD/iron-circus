// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.BaseMeshEffect
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [ExecuteInEditMode]
  public abstract class BaseMeshEffect : UIBehaviour, IMeshModifier
  {
    private static readonly Material[] s_EmptyMaterials = new Material[0];
    private bool _initialized;
    private CanvasRenderer _canvasRenderer;
    private RectTransform _rectTransform;
    private Graphic _graphic;
    private Material[] _materials = new Material[1];

    public Graphic graphic
    {
      get
      {
        this.Initialize();
        return this._graphic;
      }
    }

    public CanvasRenderer canvasRenderer
    {
      get
      {
        this.Initialize();
        return this._canvasRenderer;
      }
    }

    public RectTransform rectTransform
    {
      get
      {
        this.Initialize();
        return this._rectTransform;
      }
    }

    public virtual AdditionalCanvasShaderChannels requiredChannels => AdditionalCanvasShaderChannels.None;

    public bool isTMPro => false;

    public virtual Material material
    {
      get => (bool) (UnityEngine.Object) this.graphic ? this.graphic.material : (Material) null;
      set
      {
        if (!(bool) (UnityEngine.Object) this.graphic)
          return;
        this.graphic.material = value;
      }
    }

    public virtual Material[] materials
    {
      get
      {
        if (!(bool) (UnityEngine.Object) this.graphic)
          return BaseMeshEffect.s_EmptyMaterials;
        this._materials[0] = this.graphic.material;
        return this._materials;
      }
    }

    public virtual void ModifyMesh(Mesh mesh)
    {
    }

    public virtual void ModifyMesh(VertexHelper vh)
    {
    }

    public virtual void SetVerticesDirty()
    {
      if (!(bool) (UnityEngine.Object) this.graphic)
        return;
      this.graphic.SetVerticesDirty();
    }

    public void ShowTMProWarning(
      Shader shader,
      Shader mobileShader,
      Shader spriteShader,
      Action<Material> onCreatedMaterial)
    {
    }

    protected virtual bool isLegacyMeshModifier => false;

    protected virtual void Initialize()
    {
      if (this._initialized)
        return;
      this._initialized = true;
      this._graphic = this._graphic ?? this.GetComponent<Graphic>();
      this._canvasRenderer = this._canvasRenderer ?? this.GetComponent<CanvasRenderer>();
      this._rectTransform = this._rectTransform ?? this.GetComponent<RectTransform>();
    }

    protected override void OnEnable()
    {
      this._initialized = false;
      this.SetVerticesDirty();
      if (!(bool) (UnityEngine.Object) this.graphic)
        return;
      AdditionalCanvasShaderChannels requiredChannels = this.requiredChannels;
      Canvas canvas = this.graphic.canvas;
      if (!(bool) (UnityEngine.Object) canvas || (canvas.additionalShaderChannels & requiredChannels) == requiredChannels)
        return;
      Debug.LogWarningFormat((UnityEngine.Object) this, "Enable {1} of Canvas.additionalShaderChannels to use {0}.", (object) this.GetType().Name, (object) requiredChannels);
    }

    protected override void OnDisable() => this.SetVerticesDirty();

    protected virtual void LateUpdate()
    {
    }

    protected override void OnDidApplyAnimationProperties() => this.SetVerticesDirty();
  }
}
