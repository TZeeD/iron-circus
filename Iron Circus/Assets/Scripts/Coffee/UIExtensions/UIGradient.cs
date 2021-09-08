// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIGradient
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [DisallowMultipleComponent]
  [AddComponentMenu("UI/MeshEffectForTextMeshPro/UIGradient", 101)]
  public class UIGradient : BaseMeshEffect
  {
    [Tooltip("Gradient Direction.")]
    [SerializeField]
    private UIGradient.Direction m_Direction;
    [Tooltip("Color1: Top or Left.")]
    [SerializeField]
    private Color m_Color1 = Color.white;
    [Tooltip("Color2: Bottom or Right.")]
    [SerializeField]
    private Color m_Color2 = Color.white;
    [Tooltip("Color3: For diagonal.")]
    [SerializeField]
    private Color m_Color3 = Color.white;
    [Tooltip("Color4: For diagonal.")]
    [SerializeField]
    private Color m_Color4 = Color.white;
    [Tooltip("Gradient rotation.")]
    [SerializeField]
    [Range(-180f, 180f)]
    private float m_Rotation;
    [Tooltip("Gradient offset for Horizontal, Vertical or Angle.")]
    [SerializeField]
    [Range(-1f, 1f)]
    private float m_Offset1;
    [Tooltip("Gradient offset for Diagonal.")]
    [SerializeField]
    [Range(-1f, 1f)]
    private float m_Offset2;
    [Tooltip("Gradient style for Text.")]
    [SerializeField]
    private UIGradient.GradientStyle m_GradientStyle;
    [Tooltip("Color space to correct color.")]
    [SerializeField]
    private ColorSpace m_ColorSpace = ColorSpace.Uninitialized;
    [Tooltip("Ignore aspect ratio.")]
    [SerializeField]
    private bool m_IgnoreAspectRatio = true;
    private static readonly Vector2[] s_SplitedCharacterPosition = new Vector2[4]
    {
      Vector2.up,
      Vector2.one,
      Vector2.right,
      Vector2.zero
    };

    public Graphic targetGraphic => this.graphic;

    public UIGradient.Direction direction
    {
      get => this.m_Direction;
      set
      {
        if (this.m_Direction == value)
          return;
        this.m_Direction = value;
        this.SetVerticesDirty();
      }
    }

    public Color color1
    {
      get => this.m_Color1;
      set
      {
        if (!(this.m_Color1 != value))
          return;
        this.m_Color1 = value;
        this.SetVerticesDirty();
      }
    }

    public Color color2
    {
      get => this.m_Color2;
      set
      {
        if (!(this.m_Color2 != value))
          return;
        this.m_Color2 = value;
        this.SetVerticesDirty();
      }
    }

    public Color color3
    {
      get => this.m_Color3;
      set
      {
        if (!(this.m_Color3 != value))
          return;
        this.m_Color3 = value;
        this.SetVerticesDirty();
      }
    }

    public Color color4
    {
      get => this.m_Color4;
      set
      {
        if (!(this.m_Color4 != value))
          return;
        this.m_Color4 = value;
        this.SetVerticesDirty();
      }
    }

    public float rotation
    {
      get
      {
        if (this.m_Direction == UIGradient.Direction.Horizontal)
          return -90f;
        return this.m_Direction != UIGradient.Direction.Vertical ? this.m_Rotation : 0.0f;
      }
      set
      {
        if (Mathf.Approximately(this.m_Rotation, value))
          return;
        this.m_Rotation = value;
        this.SetVerticesDirty();
      }
    }

    public float offset
    {
      get => this.m_Offset1;
      set
      {
        if ((double) this.m_Offset1 == (double) value)
          return;
        this.m_Offset1 = value;
        this.SetVerticesDirty();
      }
    }

    public Vector2 offset2
    {
      get => new Vector2(this.m_Offset2, this.m_Offset1);
      set
      {
        if ((double) this.m_Offset1 == (double) value.y && (double) this.m_Offset2 == (double) value.x)
          return;
        this.m_Offset1 = value.y;
        this.m_Offset2 = value.x;
        this.SetVerticesDirty();
      }
    }

    public UIGradient.GradientStyle gradientStyle
    {
      get => this.m_GradientStyle;
      set
      {
        if (this.m_GradientStyle == value)
          return;
        this.m_GradientStyle = value;
        this.SetVerticesDirty();
      }
    }

    public ColorSpace colorSpace
    {
      get => this.m_ColorSpace;
      set
      {
        if (this.m_ColorSpace == value)
          return;
        this.m_ColorSpace = value;
        this.SetVerticesDirty();
      }
    }

    public bool ignoreAspectRatio
    {
      get => this.m_IgnoreAspectRatio;
      set
      {
        if (this.m_IgnoreAspectRatio == value)
          return;
        this.m_IgnoreAspectRatio = value;
        this.SetVerticesDirty();
      }
    }

    public override void ModifyMesh(VertexHelper vh)
    {
      if (!this.IsActive())
        return;
      Rect rect = new Rect();
      UIVertex vertex = new UIVertex();
      if (this.m_GradientStyle == UIGradient.GradientStyle.Rect)
        rect = this.graphic.rectTransform.rect;
      else if (this.m_GradientStyle == UIGradient.GradientStyle.Split)
        rect.Set(0.0f, 0.0f, 1f, 1f);
      else if (this.m_GradientStyle == UIGradient.GradientStyle.Fit)
      {
        rect.xMin = rect.yMin = float.MaxValue;
        rect.xMax = rect.yMax = float.MinValue;
        for (int i = 0; i < vh.currentVertCount; ++i)
        {
          vh.PopulateUIVertex(ref vertex, i);
          rect.xMin = Mathf.Min(rect.xMin, vertex.position.x);
          rect.yMin = Mathf.Min(rect.yMin, vertex.position.y);
          rect.xMax = Mathf.Max(rect.xMax, vertex.position.x);
          rect.yMax = Mathf.Max(rect.yMax, vertex.position.y);
        }
      }
      float f = this.rotation * ((float) Math.PI / 180f);
      Vector2 vector2_1 = new Vector2(Mathf.Cos(f), Mathf.Sin(f));
      if (!this.m_IgnoreAspectRatio && UIGradient.Direction.Angle <= this.m_Direction)
      {
        vector2_1.x *= rect.height / rect.width;
        vector2_1 = vector2_1.normalized;
      }
      UIGradient.Matrix2x3 matrix2x3 = new UIGradient.Matrix2x3(rect, vector2_1.x, vector2_1.y);
      for (int i = 0; i < vh.currentVertCount; ++i)
      {
        vh.PopulateUIVertex(ref vertex, i);
        Vector2 vector2_2 = this.m_GradientStyle != UIGradient.GradientStyle.Split ? matrix2x3 * (Vector2) vertex.position + this.offset2 : matrix2x3 * UIGradient.s_SplitedCharacterPosition[i % 4] + this.offset2;
        Color color = this.direction != UIGradient.Direction.Diagonal ? Color.LerpUnclamped(this.m_Color2, this.m_Color1, vector2_2.y) : Color.LerpUnclamped(Color.LerpUnclamped(this.m_Color1, this.m_Color2, vector2_2.x), Color.LerpUnclamped(this.m_Color3, this.m_Color4, vector2_2.x), vector2_2.y);
        ref Color32 local = ref vertex.color;
        local = (Color32) ((Color) local * (this.m_ColorSpace == ColorSpace.Gamma ? color.gamma : (this.m_ColorSpace == ColorSpace.Linear ? color.linear : color)));
        vh.SetUIVertex(vertex, i);
      }
    }

    public enum Direction
    {
      Horizontal,
      Vertical,
      Angle,
      Diagonal,
    }

    public enum GradientStyle
    {
      Rect,
      Fit,
      Split,
    }

    private struct Matrix2x3
    {
      public float m00;
      public float m01;
      public float m02;
      public float m10;
      public float m11;
      public float m12;

      public Matrix2x3(Rect rect, float cos, float sin)
      {
        float num1 = (float) (-(double) rect.xMin / (double) rect.width - 0.5);
        float num2 = (float) (-(double) rect.yMin / (double) rect.height - 0.5);
        this.m00 = cos / rect.width;
        this.m01 = -sin / rect.height;
        this.m02 = (float) ((double) num1 * (double) cos - (double) num2 * (double) sin + 0.5);
        this.m10 = sin / rect.width;
        this.m11 = cos / rect.height;
        this.m12 = (float) ((double) num1 * (double) sin + (double) num2 * (double) cos + 0.5);
      }

      public static Vector2 operator *(UIGradient.Matrix2x3 m, Vector2 v) => new Vector2((float) ((double) m.m00 * (double) v.x + (double) m.m01 * (double) v.y) + m.m02, (float) ((double) m.m10 * (double) v.x + (double) m.m11 * (double) v.y) + m.m12);
    }
  }
}
