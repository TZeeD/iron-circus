// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIDissolve
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [AddComponentMenu("UI/UIEffect/UIDissolve", 3)]
  public class UIDissolve : UIEffectBase
  {
    public const string shaderName = "UI/Hidden/UI-Effect-Dissolve";
    private static readonly ParameterTexture _ptex = new ParameterTexture(8, 128, "_ParamTex");
    [Tooltip("Current location[0-1] for dissolve effect. 0 is not dissolved, 1 is completely dissolved.")]
    [FormerlySerializedAs("m_Location")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_EffectFactor = 0.5f;
    [Tooltip("Edge width.")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_Width = 0.5f;
    [Tooltip("Edge softness.")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_Softness = 0.5f;
    [Tooltip("Edge color.")]
    [SerializeField]
    [ColorUsage(false)]
    private Color m_Color = new Color(0.0f, 0.25f, 1f);
    [Tooltip("Edge color effect mode.")]
    [SerializeField]
    private ColorMode m_ColorMode = ColorMode.Add;
    [Tooltip("Noise texture for dissolving (single channel texture).")]
    [SerializeField]
    private Texture m_NoiseTexture;
    [Header("Advanced Option")]
    [Tooltip("The area for effect.")]
    [SerializeField]
    protected EffectArea m_EffectArea;
    [Tooltip("Keep effect aspect ratio.")]
    [SerializeField]
    private bool m_KeepAspectRatio;
    [Header("Effect Player")]
    [SerializeField]
    private EffectPlayer m_Player;
    [HideInInspector]
    [SerializeField]
    private bool m_ReverseAnimation;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    [Range(0.1f, 10f)]
    private float m_Duration = 1f;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private AnimatorUpdateMode m_UpdateMode;
    private MaterialCache _materialCache;

    [Obsolete("Use effectFactor instead (UnityUpgradable) -> effectFactor")]
    public float location
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

    public float width
    {
      get => this.m_Width;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_Width, value))
          return;
        this.m_Width = value;
        this.SetDirty();
      }
    }

    public float softness
    {
      get => this.m_Softness;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_Softness, value))
          return;
        this.m_Softness = value;
        this.SetDirty();
      }
    }

    public Color color
    {
      get => this.m_Color;
      set
      {
        if (!(this.m_Color != value))
          return;
        this.m_Color = value;
        this.SetDirty();
      }
    }

    public Texture noiseTexture
    {
      get => this.m_NoiseTexture ?? this.material.GetTexture("_NoiseTex");
      set
      {
        if (!((UnityEngine.Object) this.m_NoiseTexture != (UnityEngine.Object) value))
          return;
        this.m_NoiseTexture = value;
        if (!(bool) (UnityEngine.Object) this.graphic)
          return;
        this.ModifyMaterial();
      }
    }

    public EffectArea effectArea
    {
      get => this.m_EffectArea;
      set
      {
        if (this.m_EffectArea == value)
          return;
        this.m_EffectArea = value;
        this.SetVerticesDirty();
      }
    }

    public bool keepAspectRatio
    {
      get => this.m_KeepAspectRatio;
      set
      {
        if (this.m_KeepAspectRatio == value)
          return;
        this.m_KeepAspectRatio = value;
        this.SetVerticesDirty();
      }
    }

    public ColorMode colorMode => this.m_ColorMode;

    [Obsolete("Use Play/Stop method instead")]
    public bool play
    {
      get => this._player.play;
      set => this._player.play = value;
    }

    [Obsolete]
    public bool loop
    {
      get => this._player.loop;
      set => this._player.loop = value;
    }

    public float duration
    {
      get => this._player.duration;
      set => this._player.duration = Mathf.Max(value, 0.1f);
    }

    [Obsolete]
    public float loopDelay
    {
      get => this._player.loopDelay;
      set => this._player.loopDelay = Mathf.Max(value, 0.0f);
    }

    public AnimatorUpdateMode updateMode
    {
      get => this._player.updateMode;
      set => this._player.updateMode = value;
    }

    public override ParameterTexture ptex => UIDissolve._ptex;

    public override void ModifyMaterial()
    {
      if (this.isTMPro)
        return;
      ulong hash = (ulong) (((bool) (UnityEngine.Object) this.m_NoiseTexture ? (long) (uint) this.m_NoiseTexture.GetInstanceID() : 0L) + 4294967296L + ((long) this.m_ColorMode << 36));
      if (this._materialCache != null && ((long) this._materialCache.hash != (long) hash || !this.isActiveAndEnabled || !(bool) (UnityEngine.Object) this.m_EffectMaterial))
      {
        MaterialCache.Unregister(this._materialCache);
        this._materialCache = (MaterialCache) null;
      }
      if (!this.isActiveAndEnabled || !(bool) (UnityEngine.Object) this.m_EffectMaterial)
        this.material = (Material) null;
      else if (!(bool) (UnityEngine.Object) this.m_NoiseTexture)
        this.material = this.m_EffectMaterial;
      else if (this._materialCache != null && (long) this._materialCache.hash == (long) hash)
      {
        this.material = this._materialCache.material;
      }
      else
      {
        this._materialCache = MaterialCache.Register(hash, this.m_NoiseTexture, (Func<Material>) (() =>
        {
          Material material = new Material(this.m_EffectMaterial);
          material.name = material.name + "_" + this.m_NoiseTexture.name;
          material.SetTexture("_NoiseTex", this.m_NoiseTexture);
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
      Texture noiseTexture = this.noiseTexture;
      float aspectRatio = !this.m_KeepAspectRatio || !(bool) (UnityEngine.Object) noiseTexture ? -1f : (float) noiseTexture.width / (float) noiseTexture.height;
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

    protected override void SetDirty()
    {
      foreach (Material material in this.materials)
        this.ptex.RegisterMaterial(material);
      this.ptex.SetData((IParameterTexture) this, 0, this.m_EffectFactor);
      this.ptex.SetData((IParameterTexture) this, 1, this.m_Width);
      this.ptex.SetData((IParameterTexture) this, 2, this.m_Softness);
      this.ptex.SetData((IParameterTexture) this, 4, this.m_Color.r);
      this.ptex.SetData((IParameterTexture) this, 5, this.m_Color.g);
      this.ptex.SetData((IParameterTexture) this, 6, this.m_Color.b);
    }

    public void Play() => this._player.Play();

    public void Stop() => this._player.Stop();

    protected override void OnEnable()
    {
      base.OnEnable();
      if (this.m_ReverseAnimation)
        this._player.OnEnable((Action<float>) (f => this.effectFactor = 1f - f));
      else
        this._player.OnEnable((Action<float>) (f => this.effectFactor = f));
    }

    protected override void OnDisable()
    {
      base.OnDisable();
      MaterialCache.Unregister(this._materialCache);
      this._materialCache = (MaterialCache) null;
      this._player.OnDisable();
    }

    private EffectPlayer _player => this.m_Player ?? (this.m_Player = new EffectPlayer());
  }
}
