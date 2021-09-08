// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIShiny
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [AddComponentMenu("UI/UIEffect/UIShiny", 2)]
  public class UIShiny : UIEffectBase
  {
    public const string shaderName = "UI/Hidden/UI-Effect-Shiny";
    private static readonly ParameterTexture _ptex = new ParameterTexture(8, 128, "_ParamTex");
    [Tooltip("Location for shiny effect.")]
    [FormerlySerializedAs("m_Location")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_EffectFactor;
    [Tooltip("Width for shiny effect.")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_Width = 0.25f;
    [Tooltip("Rotation for shiny effect.")]
    [SerializeField]
    [Range(-180f, 180f)]
    private float m_Rotation;
    [Tooltip("Softness for shiny effect.")]
    [SerializeField]
    [Range(0.01f, 1f)]
    private float m_Softness = 1f;
    [Tooltip("Brightness for shiny effect.")]
    [FormerlySerializedAs("m_Alpha")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_Brightness = 1f;
    [Tooltip("Gloss factor for shiny effect.")]
    [FormerlySerializedAs("m_Highlight")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_Gloss = 1f;
    [Header("Advanced Option")]
    [Tooltip("The area for effect.")]
    [SerializeField]
    protected EffectArea m_EffectArea;
    [SerializeField]
    private EffectPlayer m_Player;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private bool m_Play;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private bool m_Loop;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    [Range(0.1f, 10f)]
    private float m_Duration = 1f;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    [Range(0.0f, 10f)]
    private float m_LoopDelay = 1f;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private AnimatorUpdateMode m_UpdateMode;
    private float _lastRotation;

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
        value = Mathf.Clamp(value, 0.01f, 1f);
        if (Mathf.Approximately(this.m_Softness, value))
          return;
        this.m_Softness = value;
        this.SetDirty();
      }
    }

    [Obsolete("Use brightness instead (UnityUpgradable) -> brightness")]
    public float alpha
    {
      get => this.m_Brightness;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_Brightness, value))
          return;
        this.m_Brightness = value;
        this.SetDirty();
      }
    }

    public float brightness
    {
      get => this.m_Brightness;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_Brightness, value))
          return;
        this.m_Brightness = value;
        this.SetDirty();
      }
    }

    [Obsolete("Use gloss instead (UnityUpgradable) -> gloss")]
    public float highlight
    {
      get => this.m_Gloss;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_Gloss, value))
          return;
        this.m_Gloss = value;
        this.SetDirty();
      }
    }

    public float gloss
    {
      get => this.m_Gloss;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_Gloss, value))
          return;
        this.m_Gloss = value;
        this.SetDirty();
      }
    }

    public float rotation
    {
      get => this.m_Rotation;
      set
      {
        if (Mathf.Approximately(this.m_Rotation, value))
          return;
        this.m_Rotation = this._lastRotation = value;
        this.SetVerticesDirty();
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

    public override ParameterTexture ptex => UIShiny._ptex;

    protected override void OnEnable()
    {
      base.OnEnable();
      this._player.OnEnable((Action<float>) (f => this.effectFactor = f));
    }

    protected override void OnDisable()
    {
      base.OnDisable();
      this._player.OnDisable();
    }

    public override void ModifyMesh(VertexHelper vh)
    {
      if (!this.isActiveAndEnabled)
        return;
      bool isText = this.isTMPro || this.graphic is Text;
      float normalizedIndex = this.ptex.GetNormalizedIndex((IParameterTexture) this);
      Rect effectArea = this.m_EffectArea.GetEffectArea(vh, this.rectTransform.rect);
      float f = this.m_Rotation * ((float) Math.PI / 180f);
      Vector2 vector2 = new Vector2(Mathf.Cos(f), Mathf.Sin(f));
      vector2.x *= effectArea.height / effectArea.width;
      vector2 = vector2.normalized;
      UIVertex vertex = new UIVertex();
      Matrix2x3 matrix = new Matrix2x3(effectArea, vector2.x, vector2.y);
      for (int index = 0; index < vh.currentVertCount; ++index)
      {
        vh.PopulateUIVertex(ref vertex, index);
        Vector2 nomalizedPos;
        this.m_EffectArea.GetNormalizedFactor(index, matrix, (Vector2) vertex.position, isText, out nomalizedPos);
        vertex.uv0 = new Vector2(Packer.ToFloat(vertex.uv0.x, vertex.uv0.y), Packer.ToFloat(nomalizedPos.y, normalizedIndex));
        vh.SetUIVertex(vertex, index);
      }
    }

    public void Play() => this._player.Play();

    public void Stop() => this._player.Stop();

    protected override void SetDirty()
    {
      foreach (Material material in this.materials)
        this.ptex.RegisterMaterial(material);
      this.ptex.SetData((IParameterTexture) this, 0, this.m_EffectFactor);
      this.ptex.SetData((IParameterTexture) this, 1, this.m_Width);
      this.ptex.SetData((IParameterTexture) this, 2, this.m_Softness);
      this.ptex.SetData((IParameterTexture) this, 3, this.m_Brightness);
      this.ptex.SetData((IParameterTexture) this, 4, this.m_Gloss);
      if (Mathf.Approximately(this._lastRotation, this.m_Rotation) || !(bool) (UnityEngine.Object) this.targetGraphic)
        return;
      this._lastRotation = this.m_Rotation;
      this.SetVerticesDirty();
    }

    private EffectPlayer _player => this.m_Player ?? (this.m_Player = new EffectPlayer());
  }
}
