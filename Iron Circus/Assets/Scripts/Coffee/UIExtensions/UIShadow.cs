// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIShadow
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [RequireComponent(typeof (Graphic))]
  [AddComponentMenu("UI/UIEffect/UIShadow", 100)]
  public class UIShadow : BaseMeshEffect, IParameterTexture
  {
    [Tooltip("How far is the blurring shadow from the graphic.")]
    [FormerlySerializedAs("m_Blur")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_BlurFactor = 1f;
    [Tooltip("Shadow effect style.")]
    [SerializeField]
    private ShadowStyle m_Style = ShadowStyle.Shadow;
    [HideInInspector]
    [Obsolete]
    [SerializeField]
    private List<UIShadow.AdditionalShadow> m_AdditionalShadows = new List<UIShadow.AdditionalShadow>();
    [SerializeField]
    private Color m_EffectColor = new Color(0.0f, 0.0f, 0.0f, 0.5f);
    [SerializeField]
    private Vector2 m_EffectDistance = new Vector2(1f, -1f);
    [SerializeField]
    private bool m_UseGraphicAlpha = true;
    private const float kMaxEffectDistance = 600f;
    private int _graphicVertexCount;
    private static readonly List<UIShadow> tmpShadows = new List<UIShadow>();
    private UIEffect _uiEffect;
    private static readonly List<UIVertex> s_Verts = new List<UIVertex>(4096);

    public Color effectColor
    {
      get => this.m_EffectColor;
      set
      {
        this.m_EffectColor = value;
        if (!((UnityEngine.Object) this.graphic != (UnityEngine.Object) null))
          return;
        this.graphic.SetVerticesDirty();
      }
    }

    public Vector2 effectDistance
    {
      get => this.m_EffectDistance;
      set
      {
        if ((double) value.x > 600.0)
          value.x = 600f;
        if ((double) value.x < -600.0)
          value.x = -600f;
        if ((double) value.y > 600.0)
          value.y = 600f;
        if ((double) value.y < -600.0)
          value.y = -600f;
        if (this.m_EffectDistance == value)
          return;
        this.m_EffectDistance = value;
        if (!((UnityEngine.Object) this.graphic != (UnityEngine.Object) null))
          return;
        this.graphic.SetVerticesDirty();
      }
    }

    public bool useGraphicAlpha
    {
      get => this.m_UseGraphicAlpha;
      set
      {
        this.m_UseGraphicAlpha = value;
        if (!((UnityEngine.Object) this.graphic != (UnityEngine.Object) null))
          return;
        this.graphic.SetVerticesDirty();
      }
    }

    [Obsolete("Use blurFactor instead (UnityUpgradable) -> blurFactor")]
    public float blur
    {
      get => this.m_BlurFactor;
      set
      {
        this.m_BlurFactor = Mathf.Clamp(value, 0.0f, 2f);
        this._SetDirty();
      }
    }

    public float blurFactor
    {
      get => this.m_BlurFactor;
      set
      {
        this.m_BlurFactor = Mathf.Clamp(value, 0.0f, 2f);
        this._SetDirty();
      }
    }

    public ShadowStyle style
    {
      get => this.m_Style;
      set
      {
        this.m_Style = value;
        this._SetDirty();
      }
    }

    public int parameterIndex { get; set; }

    public ParameterTexture ptex { get; private set; }

    protected override void OnEnable()
    {
      base.OnEnable();
      this._uiEffect = this.GetComponent<UIEffect>();
      if (!(bool) (UnityEngine.Object) this._uiEffect)
        return;
      this.ptex = this._uiEffect.ptex;
      this.ptex.Register((IParameterTexture) this);
    }

    protected override void OnDisable()
    {
      base.OnDisable();
      this._uiEffect = (UIEffect) null;
      if (this.ptex == null)
        return;
      this.ptex.Unregister((IParameterTexture) this);
      this.ptex = (ParameterTexture) null;
    }

    public override void ModifyMesh(VertexHelper vh)
    {
      if (!this.isActiveAndEnabled || vh.currentVertCount <= 0 || this.m_Style == ShadowStyle.None)
        return;
      vh.GetUIVertexStream(UIShadow.s_Verts);
      this.GetComponents<UIShadow>(UIShadow.tmpShadows);
      foreach (UIShadow tmpShadow in UIShadow.tmpShadows)
      {
        if (tmpShadow.isActiveAndEnabled)
        {
          if ((UnityEngine.Object) tmpShadow == (UnityEngine.Object) this)
          {
            using (List<UIShadow>.Enumerator enumerator = UIShadow.tmpShadows.GetEnumerator())
            {
              while (enumerator.MoveNext())
                enumerator.Current._graphicVertexCount = UIShadow.s_Verts.Count;
              break;
            }
          }
          else
            break;
        }
      }
      UIShadow.tmpShadows.Clear();
      this._uiEffect = this._uiEffect ?? this.GetComponent<UIEffect>();
      int start = UIShadow.s_Verts.Count - this._graphicVertexCount;
      int count = UIShadow.s_Verts.Count;
      if (this.ptex != null && (bool) (UnityEngine.Object) this._uiEffect && this._uiEffect.isActiveAndEnabled)
      {
        this.ptex.SetData((IParameterTexture) this, 0, this._uiEffect.effectFactor);
        this.ptex.SetData((IParameterTexture) this, 1, byte.MaxValue);
        this.ptex.SetData((IParameterTexture) this, 2, this.m_BlurFactor);
      }
      this._ApplyShadow(UIShadow.s_Verts, this.effectColor, ref start, ref count, this.effectDistance, this.style, this.useGraphicAlpha);
      vh.Clear();
      vh.AddUIVertexTriangleStream(UIShadow.s_Verts);
      UIShadow.s_Verts.Clear();
    }

    private void _ApplyShadow(
      List<UIVertex> verts,
      Color color,
      ref int start,
      ref int end,
      Vector2 effectDistance,
      ShadowStyle style,
      bool useGraphicAlpha)
    {
      if (style == ShadowStyle.None || (double) color.a <= 0.0)
        return;
      this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, effectDistance.x, effectDistance.y, useGraphicAlpha);
      if (ShadowStyle.Shadow3 == style)
      {
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, effectDistance.x, 0.0f, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, 0.0f, effectDistance.y, useGraphicAlpha);
      }
      else if (ShadowStyle.Outline == style)
      {
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, effectDistance.x, -effectDistance.y, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, -effectDistance.x, effectDistance.y, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, -effectDistance.x, -effectDistance.y, useGraphicAlpha);
      }
      else
      {
        if (ShadowStyle.Outline8 != style)
          return;
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, effectDistance.x, -effectDistance.y, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, -effectDistance.x, effectDistance.y, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, -effectDistance.x, -effectDistance.y, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, -effectDistance.x, 0.0f, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, 0.0f, -effectDistance.y, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, effectDistance.x, 0.0f, useGraphicAlpha);
        this._ApplyShadowZeroAlloc(UIShadow.s_Verts, color, ref start, ref end, 0.0f, effectDistance.y, useGraphicAlpha);
      }
    }

    private void _ApplyShadowZeroAlloc(
      List<UIVertex> verts,
      Color color,
      ref int start,
      ref int end,
      float x,
      float y,
      bool useGraphicAlpha)
    {
      int num1 = end - start;
      int num2 = verts.Count + num1;
      if (verts.Capacity < num2)
        verts.Capacity *= 2;
      float y1 = this.ptex == null || !(bool) (UnityEngine.Object) this._uiEffect || !this._uiEffect.isActiveAndEnabled ? -1f : this.ptex.GetNormalizedIndex((IParameterTexture) this);
      UIVertex uiVertex = new UIVertex();
      for (int index = 0; index < num1; ++index)
        verts.Add(uiVertex);
      for (int index = verts.Count - 1; num1 <= index; --index)
        verts[index] = verts[index - num1];
      for (int index = 0; index < num1; ++index)
      {
        UIVertex vert = verts[index + start + num1];
        Vector3 position = vert.position;
        vert.position.Set(position.x + x, position.y + y, position.z);
        Color effectColor = this.effectColor;
        effectColor.a = useGraphicAlpha ? (float) ((double) color.a * (double) vert.color.a / (double) byte.MaxValue) : color.a;
        vert.color = (Color32) effectColor;
        if (0.0 <= (double) y1)
          vert.uv0 = new Vector2(vert.uv0.x, y1);
        verts[index] = vert;
      }
      start = end;
      end = verts.Count;
    }

    private void _SetDirty()
    {
      if (!(bool) (UnityEngine.Object) this.graphic)
        return;
      this.graphic.SetVerticesDirty();
    }

    [Obsolete]
    [Serializable]
    public class AdditionalShadow
    {
      [FormerlySerializedAs("shadowBlur")]
      [Range(0.0f, 1f)]
      public float blur = 0.25f;
      [FormerlySerializedAs("shadowMode")]
      public ShadowStyle style = ShadowStyle.Shadow;
      [FormerlySerializedAs("shadowColor")]
      public Color effectColor = Color.black;
      public Vector2 effectDistance = new Vector2(1f, -1f);
      public bool useGraphicAlpha = true;
    }
  }
}
