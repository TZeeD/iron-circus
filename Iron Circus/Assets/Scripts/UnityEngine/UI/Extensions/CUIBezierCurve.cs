// Decompiled with JetBrains decompiler
// Type: UnityEngine.UI.Extensions.CUIBezierCurve
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace UnityEngine.UI.Extensions
{
  public class CUIBezierCurve : MonoBehaviour
  {
    public static readonly int CubicBezierCurvePtNum = 4;
    [SerializeField]
    protected Vector3[] controlPoints;
    public Action OnRefresh;

    public Vector3[] ControlPoints => this.controlPoints;

    public void Refresh()
    {
      if (this.OnRefresh == null)
        return;
      this.OnRefresh();
    }

    public Vector3 GetPoint(float _time)
    {
      float num = 1f - _time;
      return num * num * num * this.controlPoints[0] + 3f * num * num * _time * this.controlPoints[1] + 3f * num * _time * _time * this.controlPoints[2] + _time * _time * _time * this.controlPoints[3];
    }

    public Vector3 GetTangent(float _time)
    {
      float num = 1f - _time;
      return 3f * num * num * (this.controlPoints[1] - this.controlPoints[0]) + 6f * num * _time * (this.controlPoints[2] - this.controlPoints[1]) + 3f * _time * _time * (this.controlPoints[3] - this.controlPoints[2]);
    }

    public void ReportSet()
    {
      if (this.controlPoints == null)
      {
        this.controlPoints = new Vector3[CUIBezierCurve.CubicBezierCurvePtNum];
        this.controlPoints[0] = new Vector3(0.0f, 0.0f, 0.0f);
        this.controlPoints[1] = new Vector3(0.0f, 1f, 0.0f);
        this.controlPoints[2] = new Vector3(1f, 1f, 0.0f);
        this.controlPoints[3] = new Vector3(1f, 0.0f, 0.0f);
      }
      int length = this.controlPoints.Length;
      int bezierCurvePtNum = CUIBezierCurve.CubicBezierCurvePtNum;
    }
  }
}
