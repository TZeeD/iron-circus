// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIEffect
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
  [ExecuteInEditMode]
  [RequireComponent(typeof (Graphic))]
  [DisallowMultipleComponent]
  [AddComponentMenu("UI/UIEffect/UIEffect", 1)]
  public class UIEffect : UIEffectBase
  {
    public const string shaderName = "UI/Hidden/UI-Effect";
    private static readonly ParameterTexture _ptex = new ParameterTexture(4, 1024, "_ParamTex");
    [FormerlySerializedAs("m_ToneLevel")]
    [Tooltip("Effect factor between 0(no effect) and 1(complete effect).")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_EffectFactor = 1f;
    [Tooltip("Color effect factor between 0(no effect) and 1(complete effect).")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_ColorFactor = 1f;
    [FormerlySerializedAs("m_Blur")]
    [Tooltip("How far is the blurring from the graphic.")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_BlurFactor = 1f;
    [FormerlySerializedAs("m_ToneMode")]
    [Tooltip("Effect mode")]
    [SerializeField]
    private EffectMode m_EffectMode;
    [Tooltip("Color effect mode")]
    [SerializeField]
    private ColorMode m_ColorMode;
    [Tooltip("Blur effect mode")]
    [SerializeField]
    private BlurMode m_BlurMode;
    [Tooltip("Advanced blurring remove common artifacts in the blur effect for uGUI.")]
    [SerializeField]
    private bool m_AdvancedBlur;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_ShadowBlur = 1f;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private ShadowStyle m_ShadowStyle;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private Color m_ShadowColor = Color.black;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private Vector2 m_EffectDistance = new Vector2(1f, -1f);
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private bool m_UseGraphicAlpha = true;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private Color m_EffectColor = Color.white;
    [Obsolete]
    [HideInInspector]
    [SerializeField]
    private List<UIShadow.AdditionalShadow> m_AdditionalShadows = new List<UIShadow.AdditionalShadow>();

    public override AdditionalCanvasShaderChannels requiredChannels
    {
      get
      {
        if (!this.advancedBlur)
          return AdditionalCanvasShaderChannels.None;
        return !this.isTMPro ? AdditionalCanvasShaderChannels.TexCoord1 : AdditionalCanvasShaderChannels.TexCoord1 | AdditionalCanvasShaderChannels.TexCoord2;
      }
    }

    [Obsolete("Use effectFactor instead (UnityUpgradable) -> effectFactor")]
    public float toneLevel
    {
      get => this.m_EffectFactor;
      set
      {
        this.m_EffectFactor = Mathf.Clamp(value, 0.0f, 1f);
        this.SetDirty();
      }
    }

    public float effectFactor
    {
      get => this.m_EffectFactor;
      set
      {
        this.m_EffectFactor = Mathf.Clamp(value, 0.0f, 1f);
        this.SetDirty();
      }
    }

    public float colorFactor
    {
      get => this.m_ColorFactor;
      set
      {
        this.m_ColorFactor = Mathf.Clamp(value, 0.0f, 1f);
        this.SetDirty();
      }
    }

    [Obsolete("Use blurFactor instead (UnityUpgradable) -> blurFactor")]
    public float blur
    {
      get => this.m_BlurFactor;
      set
      {
        this.m_BlurFactor = Mathf.Clamp(value, 0.0f, 1f);
        this.SetDirty();
      }
    }

    [Obsolete("Use effectFactor instead (UnityUpgradable) -> effectFactor")]
    public float blurFactor
    {
      get => this.m_BlurFactor;
      set
      {
        this.m_BlurFactor = Mathf.Clamp(value, 0.0f, 1f);
        this.SetDirty();
      }
    }

    [Obsolete("Use effectMode instead (UnityUpgradable) -> effectMode")]
    public EffectMode toneMode => this.m_EffectMode;

    public EffectMode effectMode => this.m_EffectMode;

    public ColorMode colorMode => this.m_ColorMode;

    public BlurMode blurMode => this.m_BlurMode;

    public Color effectColor
    {
      get => this.graphic.color;
      set
      {
        this.graphic.color = value;
        this.SetDirty();
      }
    }

    public override ParameterTexture ptex => UIEffect._ptex;

    public bool advancedBlur
    {
      get
      {
        if (!this.isTMPro)
          return this.m_AdvancedBlur;
        return (bool) (UnityEngine.Object) this.material && this.material.IsKeywordEnabled("EX");
      }
    }

    public override void ModifyMesh(VertexHelper vh)
    {
      if (!this.isActiveAndEnabled)
        return;
      float normalizedIndex = this.ptex.GetNormalizedIndex((IParameterTexture) this);
      if (this.m_BlurMode != BlurMode.None && this.advancedBlur)
      {
        vh.GetUIVertexStream(UIEffectBase.tempVerts);
        vh.Clear();
        int count1 = UIEffectBase.tempVerts.Count;
        int count2 = this.targetGraphic is Text || this.isTMPro ? 6 : count1;
        Rect posBounds = new Rect();
        Rect uvBounds = new Rect();
        Vector3 a = new Vector3();
        Vector3 vector3_1 = new Vector3();
        Vector3 vector3_2 = new Vector3();
        float num = (float) ((double) this.blurMode * 6.0 * 2.0);
        for (int start = 0; start < count1; start += count2)
        {
          UIEffect.GetBounds(UIEffectBase.tempVerts, start, count2, ref posBounds, ref uvBounds, true);
          Vector2 vector2 = new Vector2(Packer.ToFloat(uvBounds.xMin, uvBounds.yMin), Packer.ToFloat(uvBounds.xMax, uvBounds.yMax));
          for (int index1 = 0; index1 < count2; index1 += 6)
          {
            Vector3 position1 = UIEffectBase.tempVerts[start + index1 + 1].position;
            Vector3 position2 = UIEffectBase.tempVerts[start + index1 + 4].position;
            bool flag = count2 == 6 || !posBounds.Contains(position1) || !posBounds.Contains(position2);
            if (flag)
            {
              Vector3 uv0_1 = (Vector3) UIEffectBase.tempVerts[start + index1 + 1].uv0;
              Vector3 uv0_2 = (Vector3) UIEffectBase.tempVerts[start + index1 + 4].uv0;
              Vector3 b1 = (position1 + position2) / 2f;
              Vector3 vector3_3 = uv0_2;
              Vector3 b2 = (uv0_1 + vector3_3) / 2f;
              a = position1 - position2;
              a.x = (float) (1.0 + (double) num / (double) Mathf.Abs(a.x));
              a.y = (float) (1.0 + (double) num / (double) Mathf.Abs(a.y));
              a.z = (float) (1.0 + (double) num / (double) Mathf.Abs(a.z));
              vector3_1 = b1 - Vector3.Scale(a, b1);
              vector3_2 = b2 - Vector3.Scale(a, b2);
            }
            for (int index2 = 0; index2 < 6; ++index2)
            {
              UIVertex tempVert = UIEffectBase.tempVerts[start + index1 + index2];
              Vector3 position3 = tempVert.position;
              Vector2 uv0 = tempVert.uv0;
              if (flag && ((double) position3.x < (double) posBounds.xMin || (double) posBounds.xMax < (double) position3.x))
              {
                position3.x = position3.x * a.x + vector3_1.x;
                uv0.x = uv0.x * a.x + vector3_2.x;
              }
              if (flag && ((double) position3.y < (double) posBounds.yMin || (double) posBounds.yMax < (double) position3.y))
              {
                position3.y = position3.y * a.y + vector3_1.y;
                uv0.y = uv0.y * a.y + vector3_2.y;
              }
              tempVert.uv0 = new Vector2(Packer.ToFloat((float) (((double) uv0.x + 0.5) / 2.0), (float) (((double) uv0.y + 0.5) / 2.0)), normalizedIndex);
              tempVert.position = position3;
              if (this.isTMPro)
                tempVert.uv2 = vector2;
              else
                tempVert.uv1 = vector2;
              UIEffectBase.tempVerts[start + index1 + index2] = tempVert;
            }
          }
        }
        vh.AddUIVertexTriangleStream(UIEffectBase.tempVerts);
        UIEffectBase.tempVerts.Clear();
      }
      else
      {
        int currentVertCount = vh.currentVertCount;
        UIVertex vertex = new UIVertex();
        for (int i = 0; i < currentVertCount; ++i)
        {
          vh.PopulateUIVertex(ref vertex, i);
          Vector2 uv0 = vertex.uv0;
          vertex.uv0 = new Vector2(Packer.ToFloat((float) (((double) uv0.x + 0.5) / 2.0), (float) (((double) uv0.y + 0.5) / 2.0)), normalizedIndex);
          vh.SetUIVertex(vertex, i);
        }
      }
    }

    protected override void SetDirty()
    {
      foreach (Material material in this.materials)
        this.ptex.RegisterMaterial(material);
      this.ptex.SetData((IParameterTexture) this, 0, this.m_EffectFactor);
      this.ptex.SetData((IParameterTexture) this, 1, this.m_ColorFactor);
      this.ptex.SetData((IParameterTexture) this, 2, this.m_BlurFactor);
    }

    private static void GetBounds(
      List<UIVertex> verts,
      int start,
      int count,
      ref Rect posBounds,
      ref Rect uvBounds,
      bool global)
    {
      Vector2 vector2_1 = new Vector2(float.MaxValue, float.MaxValue);
      Vector2 vector2_2 = new Vector2(float.MinValue, float.MinValue);
      Vector2 vector2_3 = new Vector2(float.MaxValue, float.MaxValue);
      Vector2 vector2_4 = new Vector2(float.MinValue, float.MinValue);
      for (int index = start; index < start + count; ++index)
      {
        UIVertex vert = verts[index];
        Vector2 uv0 = vert.uv0;
        Vector3 position = vert.position;
        if ((double) vector2_1.x >= (double) position.x && (double) vector2_1.y >= (double) position.y)
          vector2_1 = (Vector2) position;
        else if ((double) vector2_2.x <= (double) position.x && (double) vector2_2.y <= (double) position.y)
          vector2_2 = (Vector2) position;
        if ((double) vector2_3.x >= (double) uv0.x && (double) vector2_3.y >= (double) uv0.y)
          vector2_3 = uv0;
        else if ((double) vector2_4.x <= (double) uv0.x && (double) vector2_4.y <= (double) uv0.y)
          vector2_4 = uv0;
      }
      posBounds.Set(vector2_1.x + 1f / 1000f, vector2_1.y + 1f / 1000f, (float) ((double) vector2_2.x - (double) vector2_1.x - 1.0 / 500.0), (float) ((double) vector2_2.y - (double) vector2_1.y - 1.0 / 500.0));
      uvBounds.Set(vector2_3.x, vector2_3.y, vector2_4.x - vector2_3.x, vector2_4.y - vector2_3.y);
    }

    public enum BlurEx
    {
      None,
      Ex,
    }
  }
}
