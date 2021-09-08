﻿// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.CanvasScalerFitter
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired.Utils;
using System;
using UnityEngine;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  [RequireComponent(typeof (CanvasScalerExt))]
  public class CanvasScalerFitter : MonoBehaviour
  {
    [SerializeField]
    private CanvasScalerFitter.BreakPoint[] breakPoints;
    private CanvasScalerExt canvasScaler;
    private int screenWidth;
    private int screenHeight;
    private Action ScreenSizeChanged;

    private void OnEnable()
    {
      this.canvasScaler = this.GetComponent<CanvasScalerExt>();
      this.Update();
      this.canvasScaler.ForceRefresh();
    }

    private void Update()
    {
      if (Screen.width == this.screenWidth && Screen.height == this.screenHeight)
        return;
      this.screenWidth = Screen.width;
      this.screenHeight = Screen.height;
      this.UpdateSize();
    }

    private void UpdateSize()
    {
      if (this.canvasScaler.uiScaleMode != CanvasScaler.ScaleMode.ScaleWithScreenSize || this.breakPoints == null)
        return;
      float num1 = (float) Screen.width / (float) Screen.height;
      float num2 = float.PositiveInfinity;
      int index1 = 0;
      for (int index2 = 0; index2 < this.breakPoints.Length; ++index2)
      {
        float num3 = Mathf.Abs(num1 - this.breakPoints[index2].screenAspectRatio);
        if (((double) num3 <= (double) this.breakPoints[index2].screenAspectRatio || MathTools.IsNear(this.breakPoints[index2].screenAspectRatio, 0.01f)) && (double) num3 < (double) num2)
        {
          num2 = num3;
          index1 = index2;
        }
      }
      this.canvasScaler.referenceResolution = this.breakPoints[index1].referenceResolution;
    }

    [Serializable]
    private class BreakPoint
    {
      [SerializeField]
      public string name;
      [SerializeField]
      public float screenAspectRatio;
      [SerializeField]
      public Vector2 referenceResolution;
    }
  }
}
