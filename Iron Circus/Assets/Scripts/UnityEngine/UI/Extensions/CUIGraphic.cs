// Decompiled with JetBrains decompiler
// Type: UnityEngine.UI.Extensions.CUIGraphic
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;

namespace UnityEngine.UI.Extensions
{
  [RequireComponent(typeof (RectTransform))]
  [RequireComponent(typeof (Graphic))]
  [DisallowMultipleComponent]
  [AddComponentMenu("UI/Effects/Extensions/Curly UI Graphic")]
  public class CUIGraphic : BaseMeshEffect
  {
    public static readonly int bottomCurveIdx = 0;
    public static readonly int topCurveIdx = 1;
    [Tooltip("Set true to make the curve/morph to work. Set false to quickly see the original UI.")]
    [SerializeField]
    protected bool isCurved = true;
    [Tooltip("Set true to dynamically change the curve according to the dynamic change of the UI layout")]
    [SerializeField]
    protected bool isLockWithRatio = true;
    [Tooltip("Pick a higher resolution to improve the quality of the curved graphic.")]
    [SerializeField]
    [Range(0.01f, 30f)]
    protected float resolution = 5f;
    protected RectTransform rectTrans;
    [Tooltip("Put in the Graphic you want to curve/morph here.")]
    [SerializeField]
    protected Graphic uiGraphic;
    [Tooltip("Put in the reference Graphic that will be used to tune the bezier curves. Think button image and text.")]
    [SerializeField]
    protected CUIGraphic refCUIGraphic;
    [Tooltip("Do not touch this unless you are sure what you are doing. The curves are (re)generated automatically.")]
    [SerializeField]
    protected CUIBezierCurve[] refCurves;
    [HideInInspector]
    [SerializeField]
    protected Vector3_Array2D[] refCurvesControlRatioPoints;
    protected List<UIVertex> reuse_quads = new List<UIVertex>();

    public bool IsCurved => this.isCurved;

    public bool IsLockWithRatio => this.isLockWithRatio;

    public RectTransform RectTrans => this.rectTrans;

    public Graphic UIGraphic => this.uiGraphic;

    public CUIGraphic RefCUIGraphic => this.refCUIGraphic;

    public CUIBezierCurve[] RefCurves => this.refCurves;

    public Vector3_Array2D[] RefCurvesControlRatioPoints => this.refCurvesControlRatioPoints;

    protected void solveDoubleEquationWithVector(
      float _x_1,
      float _y_1,
      float _x_2,
      float _y_2,
      Vector3 _constant_1,
      Vector3 _contant_2,
      out Vector3 _x,
      out Vector3 _y)
    {
      if ((double) Mathf.Abs(_x_1) > (double) Mathf.Abs(_x_2))
      {
        Vector3 vector3 = _constant_1 * _x_2 / _x_1;
        float num = _y_1 * _x_2 / _x_1;
        _y = (_contant_2 - vector3) / (_y_2 - num);
        if ((double) _x_2 != 0.0)
          _x = (vector3 - num * _y) / _x_2;
        else
          _x = (_constant_1 - _y_1 * _y) / _x_1;
      }
      else
      {
        Vector3 vector3 = _contant_2 * _x_1 / _x_2;
        float num = _y_2 * _x_1 / _x_2;
        _x = (_constant_1 - vector3) / (_y_1 - num);
        if ((double) _x_1 != 0.0)
          _y = (vector3 - num * _x) / _x_1;
        else
          _y = (_contant_2 - _y_2 * _x) / _x_2;
      }
    }

    protected UIVertex uiVertexLerp(UIVertex _a, UIVertex _b, float _time) => new UIVertex()
    {
      position = Vector3.Lerp(_a.position, _b.position, _time),
      normal = Vector3.Lerp(_a.normal, _b.normal, _time),
      tangent = (Vector4) Vector3.Lerp((Vector3) _a.tangent, (Vector3) _b.tangent, _time),
      uv0 = Vector2.Lerp(_a.uv0, _b.uv0, _time),
      uv1 = Vector2.Lerp(_a.uv1, _b.uv1, _time),
      color = (Color32) Color.Lerp((Color) _a.color, (Color) _b.color, _time)
    };

    protected UIVertex uiVertexBerp(
      UIVertex v_bottomLeft,
      UIVertex v_topLeft,
      UIVertex v_topRight,
      UIVertex v_bottomRight,
      float _xTime,
      float _yTime)
    {
      UIVertex _b = this.uiVertexLerp(v_topLeft, v_topRight, _xTime);
      return this.uiVertexLerp(this.uiVertexLerp(v_bottomLeft, v_bottomRight, _xTime), _b, _yTime);
    }

    protected void tessellateQuad(List<UIVertex> _quads, int _thisQuadIdx)
    {
      UIVertex quad1 = _quads[_thisQuadIdx];
      UIVertex quad2 = _quads[_thisQuadIdx + 1];
      UIVertex quad3 = _quads[_thisQuadIdx + 2];
      UIVertex quad4 = _quads[_thisQuadIdx + 3];
      float num1 = 100f / this.resolution;
      int num2 = Mathf.Max(1, Mathf.CeilToInt((quad2.position - quad1.position).magnitude / num1));
      int num3 = Mathf.Max(1, Mathf.CeilToInt((quad3.position - quad2.position).magnitude / num1));
      int num4 = 0;
      for (int index = 0; index < num3; ++index)
      {
        int num5 = 0;
        while (num5 < num2)
        {
          _quads.Add(new UIVertex());
          _quads.Add(new UIVertex());
          _quads.Add(new UIVertex());
          _quads.Add(new UIVertex());
          float _xTime1 = (float) index / (float) num3;
          float _yTime1 = (float) num5 / (float) num2;
          float _xTime2 = (float) (index + 1) / (float) num3;
          float _yTime2 = (float) (num5 + 1) / (float) num2;
          _quads[_quads.Count - 4] = this.uiVertexBerp(quad1, quad2, quad3, quad4, _xTime1, _yTime1);
          _quads[_quads.Count - 3] = this.uiVertexBerp(quad1, quad2, quad3, quad4, _xTime1, _yTime2);
          _quads[_quads.Count - 2] = this.uiVertexBerp(quad1, quad2, quad3, quad4, _xTime2, _yTime2);
          _quads[_quads.Count - 1] = this.uiVertexBerp(quad1, quad2, quad3, quad4, _xTime2, _yTime1);
          ++num5;
          ++num4;
        }
      }
    }

    protected void tessellateGraphic(List<UIVertex> _verts)
    {
      for (int index = 0; index < _verts.Count; index += 6)
      {
        this.reuse_quads.Add(_verts[index]);
        this.reuse_quads.Add(_verts[index + 1]);
        this.reuse_quads.Add(_verts[index + 2]);
        this.reuse_quads.Add(_verts[index + 4]);
      }
      int num = this.reuse_quads.Count / 4;
      for (int index = 0; index < num; ++index)
        this.tessellateQuad(this.reuse_quads, index * 4);
      this.reuse_quads.RemoveRange(0, num * 4);
      _verts.Clear();
      for (int index = 0; index < this.reuse_quads.Count; index += 4)
      {
        _verts.Add(this.reuse_quads[index]);
        _verts.Add(this.reuse_quads[index + 1]);
        _verts.Add(this.reuse_quads[index + 2]);
        _verts.Add(this.reuse_quads[index + 2]);
        _verts.Add(this.reuse_quads[index + 3]);
        _verts.Add(this.reuse_quads[index]);
      }
      this.reuse_quads.Clear();
    }

    protected override void OnRectTransformDimensionsChange()
    {
      if (!this.isLockWithRatio)
        return;
      this.UpdateCurveControlPointPositions();
    }

    public void Refresh()
    {
      this.ReportSet();
      for (int index = 0; index < this.refCurves.Length; ++index)
      {
        CUIBezierCurve refCurve = this.refCurves[index];
        if (refCurve.ControlPoints != null)
        {
          Vector3[] controlPoints = refCurve.ControlPoints;
          for (int _idx = 0; _idx < CUIBezierCurve.CubicBezierCurvePtNum; ++_idx)
          {
            Vector3 vector3 = controlPoints[_idx];
            ref Vector3 local1 = ref vector3;
            double x = (double) vector3.x;
            Rect rect = this.rectTrans.rect;
            double num1 = (double) rect.width * (double) this.rectTrans.pivot.x;
            double num2 = x + num1;
            rect = this.rectTrans.rect;
            double width = (double) rect.width;
            double num3 = num2 / width;
            local1.x = (float) num3;
            ref Vector3 local2 = ref vector3;
            double y = (double) vector3.y;
            rect = this.rectTrans.rect;
            double num4 = (double) rect.height * (double) this.rectTrans.pivot.y;
            double num5 = y + num4;
            rect = this.rectTrans.rect;
            double height = (double) rect.height;
            double num6 = num5 / height;
            local2.y = (float) num6;
            this.refCurvesControlRatioPoints[index][_idx] = vector3;
          }
        }
      }
      if (!((UnityEngine.Object) this.uiGraphic != (UnityEngine.Object) null))
        return;
      this.uiGraphic.enabled = false;
      this.uiGraphic.enabled = true;
    }

    protected override void Awake()
    {
      base.Awake();
      this.OnRectTransformDimensionsChange();
    }

    protected override void OnEnable()
    {
      base.OnEnable();
      this.OnRectTransformDimensionsChange();
    }

    public virtual void ReportSet()
    {
      if ((UnityEngine.Object) this.rectTrans == (UnityEngine.Object) null)
        this.rectTrans = this.GetComponent<RectTransform>();
      if (this.refCurves == null)
        this.refCurves = new CUIBezierCurve[2];
      bool flag = true;
      for (int index = 0; index < 2; ++index)
        flag &= (UnityEngine.Object) this.refCurves[index] != (UnityEngine.Object) null;
      if (!(flag & this.refCurves.Length == 2))
      {
        CUIBezierCurve[] refCurves = this.refCurves;
        for (int index = 0; index < 2; ++index)
        {
          if ((UnityEngine.Object) this.refCurves[index] == (UnityEngine.Object) null)
          {
            GameObject gameObject = new GameObject();
            gameObject.transform.SetParent(this.transform);
            gameObject.transform.localPosition = Vector3.zero;
            gameObject.transform.localEulerAngles = Vector3.zero;
            if (index == 0)
              gameObject.name = "BottomRefCurve";
            else
              gameObject.name = "TopRefCurve";
            refCurves[index] = gameObject.AddComponent<CUIBezierCurve>();
          }
          else
            refCurves[index] = this.refCurves[index];
          refCurves[index].ReportSet();
        }
        this.refCurves = refCurves;
      }
      if (this.refCurvesControlRatioPoints == null)
      {
        this.refCurvesControlRatioPoints = new Vector3_Array2D[this.refCurves.Length];
        for (int index = 0; index < this.refCurves.Length; ++index)
          this.refCurvesControlRatioPoints[index].array = new Vector3[this.refCurves[index].ControlPoints.Length];
        this.FixTextToRectTrans();
        this.Refresh();
      }
      for (int index = 0; index < 2; ++index)
        this.refCurves[index].OnRefresh = new Action(this.Refresh);
    }

    public void FixTextToRectTrans()
    {
      for (int index1 = 0; index1 < this.refCurves.Length; ++index1)
      {
        CUIBezierCurve refCurve = this.refCurves[index1];
        for (int index2 = 0; index2 < CUIBezierCurve.CubicBezierCurvePtNum; ++index2)
        {
          if (refCurve.ControlPoints != null)
          {
            Vector3[] controlPoints = refCurve.ControlPoints;
            Rect rect;
            if (index1 == 0)
            {
              ref Vector3 local = ref controlPoints[index2];
              rect = this.rectTrans.rect;
              double num = -(double) rect.height * (double) this.rectTrans.pivot.y;
              local.y = (float) num;
            }
            else
            {
              ref Vector3 local = ref controlPoints[index2];
              rect = this.rectTrans.rect;
              double height = (double) rect.height;
              rect = this.rectTrans.rect;
              double num1 = (double) rect.height * (double) this.rectTrans.pivot.y;
              double num2 = height - num1;
              local.y = (float) num2;
            }
            ref Vector3 local1 = ref controlPoints[index2];
            rect = this.rectTrans.rect;
            double num3 = (double) rect.width * (double) index2 / (double) (CUIBezierCurve.CubicBezierCurvePtNum - 1);
            local1.x = (float) num3;
            ref float local2 = ref controlPoints[index2].x;
            double num4 = (double) local2;
            rect = this.rectTrans.rect;
            double num5 = (double) rect.width * (double) this.rectTrans.pivot.x;
            local2 = (float) (num4 - num5);
            controlPoints[index2].z = 0.0f;
          }
        }
      }
    }

    public void ReferenceCUIForBCurves()
    {
      Vector3 localPosition = this.rectTrans.localPosition;
      ref float local1 = ref localPosition.x;
      double num1 = (double) local1;
      Rect rect1 = this.rectTrans.rect;
      double num2 = -(double) rect1.width * (double) this.rectTrans.pivot.x;
      rect1 = this.refCUIGraphic.rectTrans.rect;
      double num3 = (double) rect1.width * (double) this.refCUIGraphic.rectTrans.pivot.x;
      double num4 = num2 + num3;
      local1 = (float) (num1 + num4);
      ref float local2 = ref localPosition.y;
      double num5 = (double) local2;
      Rect rect2 = this.rectTrans.rect;
      double num6 = -(double) rect2.height * (double) this.rectTrans.pivot.y;
      rect2 = this.refCUIGraphic.rectTrans.rect;
      double num7 = (double) rect2.height * (double) this.refCUIGraphic.rectTrans.pivot.y;
      double num8 = num6 + num7;
      local2 = (float) (num5 + num8);
      Vector3 vector3_1 = new Vector3(localPosition.x / this.refCUIGraphic.RectTrans.rect.width, localPosition.y / this.refCUIGraphic.RectTrans.rect.height, localPosition.z);
      Vector3 vector3_2 = new Vector3((localPosition.x + this.rectTrans.rect.width) / this.refCUIGraphic.RectTrans.rect.width, (localPosition.y + this.rectTrans.rect.height) / this.refCUIGraphic.RectTrans.rect.height, localPosition.z);
      this.refCurves[0].ControlPoints[0] = this.refCUIGraphic.GetBCurveSandwichSpacePoint(vector3_1.x, vector3_1.y) - this.rectTrans.localPosition;
      this.refCurves[0].ControlPoints[3] = this.refCUIGraphic.GetBCurveSandwichSpacePoint(vector3_2.x, vector3_1.y) - this.rectTrans.localPosition;
      this.refCurves[1].ControlPoints[0] = this.refCUIGraphic.GetBCurveSandwichSpacePoint(vector3_1.x, vector3_2.y) - this.rectTrans.localPosition;
      this.refCurves[1].ControlPoints[3] = this.refCUIGraphic.GetBCurveSandwichSpacePoint(vector3_2.x, vector3_2.y) - this.rectTrans.localPosition;
      for (int index = 0; index < this.refCurves.Length; ++index)
      {
        CUIBezierCurve refCurve = this.refCurves[index];
        float _yTime = index == 0 ? vector3_1.y : vector3_2.y;
        Vector3 sandwichSpacePoint1 = this.refCUIGraphic.GetBCurveSandwichSpacePoint(vector3_1.x, _yTime);
        Vector3 sandwichSpacePoint2 = this.refCUIGraphic.GetBCurveSandwichSpacePoint(vector3_2.x, _yTime);
        float f1 = 0.25f;
        float f2 = 0.75f;
        Vector3 sandwichSpacePoint3 = this.refCUIGraphic.GetBCurveSandwichSpacePoint((float) (((double) vector3_1.x * 0.75 + (double) vector3_2.x * 0.25) / 1.0), _yTime);
        Vector3 sandwichSpacePoint4 = this.refCUIGraphic.GetBCurveSandwichSpacePoint((float) (((double) vector3_1.x * 0.25 + (double) vector3_2.x * 0.75) / 1.0), _yTime);
        float _x_1 = 3f * f2 * f2 * f1;
        float _y_1 = 3f * f2 * f1 * f1;
        float _x_2 = 3f * f1 * f1 * f2;
        float _y_2 = 3f * f1 * f2 * f2;
        Vector3 vector3_3 = Mathf.Pow(f2, 3f) * sandwichSpacePoint1;
        Vector3 _constant_1 = sandwichSpacePoint3 - vector3_3 - Mathf.Pow(f1, 3f) * sandwichSpacePoint2;
        Vector3 _contant_2 = sandwichSpacePoint4 - Mathf.Pow(f1, 3f) * sandwichSpacePoint1 - Mathf.Pow(f2, 3f) * sandwichSpacePoint2;
        Vector3 _x;
        Vector3 _y;
        this.solveDoubleEquationWithVector(_x_1, _y_1, _x_2, _y_2, _constant_1, _contant_2, out _x, out _y);
        refCurve.ControlPoints[1] = _x - this.rectTrans.localPosition;
        refCurve.ControlPoints[2] = _y - this.rectTrans.localPosition;
      }
    }

    public override void ModifyMesh(Mesh _mesh)
    {
      if (!this.IsActive())
        return;
      using (VertexHelper vh = new VertexHelper(_mesh))
      {
        this.ModifyMesh(vh);
        vh.FillMesh(_mesh);
      }
    }

    public override void ModifyMesh(VertexHelper _vh)
    {
      if (!this.IsActive())
        return;
      List<UIVertex> uiVertexList = new List<UIVertex>();
      _vh.GetUIVertexStream(uiVertexList);
      this.modifyVertices(uiVertexList);
      _vh.Clear();
      _vh.AddUIVertexTriangleStream(uiVertexList);
    }

    protected virtual void modifyVertices(List<UIVertex> _verts)
    {
      if (!this.IsActive())
        return;
      this.tessellateGraphic(_verts);
      if (!this.isCurved)
        return;
      for (int index = 0; index < _verts.Count; ++index)
      {
        UIVertex vert = _verts[index];
        Vector3 sandwichSpacePoint = this.GetBCurveSandwichSpacePoint((vert.position.x + this.rectTrans.rect.width * this.rectTrans.pivot.x) / this.rectTrans.rect.width, (vert.position.y + this.rectTrans.rect.height * this.rectTrans.pivot.y) / this.rectTrans.rect.height);
        vert.position.x = sandwichSpacePoint.x;
        vert.position.y = sandwichSpacePoint.y;
        vert.position.z = sandwichSpacePoint.z;
        _verts[index] = vert;
      }
    }

    public void UpdateCurveControlPointPositions()
    {
      this.ReportSet();
      for (int index = 0; index < this.refCurves.Length; ++index)
      {
        CUIBezierCurve refCurve = this.refCurves[index];
        for (int _idx = 0; _idx < this.refCurves[index].ControlPoints.Length; ++_idx)
        {
          Vector3 vector3 = this.refCurvesControlRatioPoints[index][_idx];
          ref Vector3 local1 = ref vector3;
          double x = (double) vector3.x;
          Rect rect = this.rectTrans.rect;
          double width = (double) rect.width;
          double num1 = x * width;
          rect = this.rectTrans.rect;
          double num2 = (double) rect.width * (double) this.rectTrans.pivot.x;
          double num3 = num1 - num2;
          local1.x = (float) num3;
          ref Vector3 local2 = ref vector3;
          double y = (double) vector3.y;
          rect = this.rectTrans.rect;
          double height = (double) rect.height;
          double num4 = y * height;
          rect = this.rectTrans.rect;
          double num5 = (double) rect.height * (double) this.rectTrans.pivot.y;
          double num6 = num4 - num5;
          local2.y = (float) num6;
          refCurve.ControlPoints[_idx] = vector3;
        }
      }
    }

    public Vector3 GetBCurveSandwichSpacePoint(float _xTime, float _yTime) => this.refCurves[0].GetPoint(_xTime) * (1f - _yTime) + this.refCurves[1].GetPoint(_xTime) * _yTime;

    public Vector3 GetBCurveSandwichSpaceTangent(float _xTime, float _yTime) => this.refCurves[0].GetTangent(_xTime) * (1f - _yTime) + this.refCurves[1].GetTangent(_xTime) * _yTime;
  }
}
