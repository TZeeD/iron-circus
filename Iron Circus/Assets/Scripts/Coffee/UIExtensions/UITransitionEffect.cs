// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UITransitionEffect
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [AddComponentMenu("UI/UIEffect/UITransitionEffect", 5)]
  public class UITransitionEffect : UIEffectBase
  {
    public const string shaderName = "UI/Hidden/UI-Effect-Transition";
    private static readonly ParameterTexture _ptex = new ParameterTexture(8, 128, "_ParamTex");
    [Tooltip("Effect mode.")]
    [SerializeField]
    private UITransitionEffect.EffectMode m_EffectMode = UITransitionEffect.EffectMode.Cutoff;
    [Tooltip("Effect factor between 0(hidden) and 1(shown).")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_EffectFactor = 1f;
    [Tooltip("Transition texture (single channel texture).")]
    [SerializeField]
    private Texture m_TransitionTexture;
    [Header("Advanced Option")]
    [Tooltip("The area for effect.")]
    [SerializeField]
    private EffectArea m_EffectArea;
    [Tooltip("Keep effect aspect ratio.")]
    [SerializeField]
    private bool m_KeepAspectRatio;
    [Tooltip("Dissolve edge width.")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_DissolveWidth = 0.5f;
    [Tooltip("Dissolve edge softness.")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_DissolveSoftness = 0.5f;
    [Tooltip("Dissolve edge color.")]
    [SerializeField]
    [ColorUsage(false)]
    private Color m_DissolveColor = new Color(0.0f, 0.25f, 1f);
    [Tooltip("Disable graphic's raycast target on hidden.")]
    [SerializeField]
    private bool m_PassRayOnHidden;
    [Header("Effect Player")]
    [SerializeField]
    private EffectPlayer m_Player;
    private MaterialCache _materialCache;

    public float effectFactor
    {
      get => this.m_EffectFactor;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_EffectFactor, value))
          return;
        this.m_EffectFactor = value;
        this.SetDirty();
      }
    }

    public Texture transitionTexture
    {
      get => this.m_TransitionTexture;
      set
      {
        if (!((UnityEngine.Object) this.m_TransitionTexture != (UnityEngine.Object) value))
          return;
        this.m_TransitionTexture = value;
        if (!(bool) (UnityEngine.Object) this.graphic)
          return;
        this.ModifyMaterial();
      }
    }

    public UITransitionEffect.EffectMode effectMode => this.m_EffectMode;

    public bool keepAspectRatio
    {
      get => this.m_KeepAspectRatio;
      set
      {
        if (this.m_KeepAspectRatio == value)
          return;
        this.m_KeepAspectRatio = value;
        this.targetGraphic.SetVerticesDirty();
      }
    }

    public override ParameterTexture ptex => UITransitionEffect._ptex;

    public float dissolveWidth
    {
      get => this.m_DissolveWidth;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_DissolveWidth, value))
          return;
        this.m_DissolveWidth = value;
        this.SetDirty();
      }
    }

    public float dissolveSoftness
    {
      get => this.m_DissolveSoftness;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_DissolveSoftness, value))
          return;
        this.m_DissolveSoftness = value;
        this.SetDirty();
      }
    }

    public Color dissolveColor
    {
      get => this.m_DissolveColor;
      set
      {
        if (!(this.m_DissolveColor != value))
          return;
        this.m_DissolveColor = value;
        this.SetDirty();
      }
    }

    public float duration
    {
      get => this._player.duration;
      set => this._player.duration = Mathf.Max(value, 0.1f);
    }

    public bool passRayOnHidden
    {
      get => this.m_PassRayOnHidden;
      set => this.m_PassRayOnHidden = value;
    }

    public AnimatorUpdateMode updateMode
    {
      get => this._player.updateMode;
      set => this._player.updateMode = value;
    }

    public void Show()
    {
      this._player.loop = false;
      this._player.Play((Action<float>) (f => this.effectFactor = f));
    }

    public void Hide()
    {
      this._player.loop = false;
      this._player.Play((Action<float>) (f => this.effectFactor = 1f - f));
    }

    public override void ModifyMaterial()
    {
      if (this.isTMPro)
        return;
      ulong hash = (ulong) (((bool) (UnityEngine.Object) this.m_TransitionTexture ? (long) (uint) this.m_TransitionTexture.GetInstanceID() : 0L) + 8589934592L + ((long) this.m_EffectMode << 36));
      if (this._materialCache != null && ((long) this._materialCache.hash != (long) hash || !this.isActiveAndEnabled || !(bool) (UnityEngine.Object) this.m_EffectMaterial))
      {
        MaterialCache.Unregister(this._materialCache);
        this._materialCache = (MaterialCache) null;
      }
      if (!this.isActiveAndEnabled || !(bool) (UnityEngine.Object) this.m_EffectMaterial)
        this.material = (Material) null;
      else if (!(bool) (UnityEngine.Object) this.m_TransitionTexture)
        this.material = this.m_EffectMaterial;
      else if (this._materialCache != null && (long) this._materialCache.hash == (long) hash)
      {
        this.material = this._materialCache.material;
      }
      else
      {
        this._materialCache = MaterialCache.Register(hash, this.m_TransitionTexture, (Func<Material>) (() =>
        {
          Material material = new Material(this.m_EffectMaterial);
          material.name = material.name + "_" + this.m_TransitionTexture.name;
          material.SetTexture("_NoiseTex", this.m_TransitionTexture);
          return material;
        }));
        this.material = this._materialCache.material;
      }
    }

    public override void ModifyMesh(VertexHelper vh)
    {
      if (!this.isActiveAndEnabled)
        return;
      bool isText = this.isTMPro || this.graphic is Text;
      float normalizedIndex = this.ptex.GetNormalizedIndex((IParameterTexture) this);
      Texture transitionTexture = this.transitionTexture;
      float aspectRatio = !this.m_KeepAspectRatio || !(bool) (UnityEngine.Object) transitionTexture ? -1f : (float) transitionTexture.width / (float) transitionTexture.height;
      Rect effectArea = this.m_EffectArea.GetEffectArea(vh, this.rectTransform.rect, aspectRatio);
      UIVertex vertex = new UIVertex();
      int currentVertCount = vh.currentVertCount;
      for (int index = 0; index < currentVertCount; ++index)
      {
        vh.PopulateUIVertex(ref vertex, index);
        float x;
        float y;
        this.m_EffectArea.GetPositionFactor(index, effectArea, (Vector2) vertex.position, isText, this.isTMPro, out x, out y);
        vertex.uv0 = new Vector2(Packer.ToFloat(vertex.uv0.x, vertex.uv0.y), Packer.ToFloat(x, y, normalizedIndex));
        vh.SetUIVertex(vertex, index);
      }
    }

    protected override void OnEnable()
    {
      base.OnEnable();
      this._player.OnEnable();
      this._player.loop = false;
    }

    protected override void OnDisable()
    {
      base.OnDisable();
      MaterialCache.Unregister(this._materialCache);
      this._materialCache = (MaterialCache) null;
      this._player.OnDisable();
    }

    protected override void SetDirty()
    {
      foreach (Material material in this.materials)
        this.ptex.RegisterMaterial(material);
      this.ptex.SetData((IParameterTexture) this, 0, this.m_EffectFactor);
      if (this.m_EffectMode == UITransitionEffect.EffectMode.Dissolve)
      {
        this.ptex.SetData((IParameterTexture) this, 1, this.m_DissolveWidth);
        this.ptex.SetData((IParameterTexture) this, 2, this.m_DissolveSoftness);
        this.ptex.SetData((IParameterTexture) this, 4, this.m_DissolveColor.r);
        this.ptex.SetData((IParameterTexture) this, 5, this.m_DissolveColor.g);
        this.ptex.SetData((IParameterTexture) this, 6, this.m_DissolveColor.b);
      }
      if (!this.m_PassRayOnHidden)
        return;
      this.targetGraphic.raycastTarget = 0.0 < (double) this.m_EffectFactor;
    }

    private EffectPlayer _player => this.m_Player ?? (this.m_Player = new EffectPlayer());

    public enum EffectMode
    {
      Fade = 1,
      Cutoff = 2,
      Dissolve = 3,
    }
  }
}
