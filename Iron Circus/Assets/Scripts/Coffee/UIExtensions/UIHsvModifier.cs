// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIHsvModifier
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [AddComponentMenu("UI/UIEffect/UIHsvModifier", 4)]
  public class UIHsvModifier : UIEffectBase
  {
    public const string shaderName = "UI/Hidden/UI-Effect-HSV";
    private static readonly ParameterTexture _ptex = new ParameterTexture(7, 128, "_ParamTex");
    [Header("Target")]
    [Tooltip("Target color to affect hsv shift.")]
    [SerializeField]
    [ColorUsage(false)]
    private Color m_TargetColor = Color.red;
    [Tooltip("Color range to affect hsv shift [0 ~ 1].")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_Range = 0.1f;
    [Header("Adjustment")]
    [Tooltip("Hue shift [-0.5 ~ 0.5].")]
    [SerializeField]
    [Range(-0.5f, 0.5f)]
    private float m_Hue;
    [Tooltip("Saturation shift [-0.5 ~ 0.5].")]
    [SerializeField]
    [Range(-0.5f, 0.5f)]
    private float m_Saturation;
    [Tooltip("Value shift [-0.5 ~ 0.5].")]
    [SerializeField]
    [Range(-0.5f, 0.5f)]
    private float m_Value;

    public Color targetColor
    {
      get => this.m_TargetColor;
      set
      {
        if (!(this.m_TargetColor != value))
          return;
        this.m_TargetColor = value;
        this.SetDirty();
      }
    }

    public float range
    {
      get => this.m_Range;
      set
      {
        value = Mathf.Clamp(value, 0.0f, 1f);
        if (Mathf.Approximately(this.m_Range, value))
          return;
        this.m_Range = value;
        this.SetDirty();
      }
    }

    public float saturation
    {
      get => this.m_Saturation;
      set
      {
        value = Mathf.Clamp(value, -0.5f, 0.5f);
        if (Mathf.Approximately(this.m_Saturation, value))
          return;
        this.m_Saturation = value;
        this.SetDirty();
      }
    }

    public float value
    {
      get => this.m_Value;
      set
      {
        value = Mathf.Clamp(value, -0.5f, 0.5f);
        if (Mathf.Approximately(this.m_Value, value))
          return;
        this.m_Value = value;
        this.SetDirty();
      }
    }

    public float hue
    {
      get => this.m_Hue;
      set
      {
        value = Mathf.Clamp(value, -0.5f, 0.5f);
        if (Mathf.Approximately(this.m_Hue, value))
          return;
        this.m_Hue = value;
        this.SetDirty();
      }
    }

    public override ParameterTexture ptex => UIHsvModifier._ptex;

    public override void ModifyMesh(VertexHelper vh)
    {
      if (!this.isActiveAndEnabled)
        return;
      float normalizedIndex = this.ptex.GetNormalizedIndex((IParameterTexture) this);
      UIVertex vertex = new UIVertex();
      int currentVertCount = vh.currentVertCount;
      for (int i = 0; i < currentVertCount; ++i)
      {
        vh.PopulateUIVertex(ref vertex, i);
        vertex.uv0 = new Vector2(Packer.ToFloat(vertex.uv0.x, vertex.uv0.y), normalizedIndex);
        vh.SetUIVertex(vertex, i);
      }
    }

    protected override void SetDirty()
    {
      float H;
      float S;
      float V;
      Color.RGBToHSV(this.m_TargetColor, out H, out S, out V);
      foreach (Material material in this.materials)
        this.ptex.RegisterMaterial(material);
      this.ptex.SetData((IParameterTexture) this, 0, H);
      this.ptex.SetData((IParameterTexture) this, 1, S);
      this.ptex.SetData((IParameterTexture) this, 2, V);
      this.ptex.SetData((IParameterTexture) this, 3, this.m_Range);
      this.ptex.SetData((IParameterTexture) this, 4, this.m_Hue + 0.5f);
      this.ptex.SetData((IParameterTexture) this, 5, this.m_Saturation + 0.5f);
      this.ptex.SetData((IParameterTexture) this, 6, this.m_Value + 0.5f);
    }
  }
}
