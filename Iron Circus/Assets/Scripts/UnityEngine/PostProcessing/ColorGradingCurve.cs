﻿// Decompiled with JetBrains decompiler
// Type: UnityEngine.PostProcessing.ColorGradingCurve
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace UnityEngine.PostProcessing
{
  [Serializable]
  public sealed class ColorGradingCurve
  {
    public AnimationCurve curve;
    [SerializeField]
    private bool m_Loop;
    [SerializeField]
    private float m_ZeroValue;
    [SerializeField]
    private float m_Range;
    private AnimationCurve m_InternalLoopingCurve;

    public ColorGradingCurve(AnimationCurve curve, float zeroValue, bool loop, Vector2 bounds)
    {
      this.curve = curve;
      this.m_ZeroValue = zeroValue;
      this.m_Loop = loop;
      this.m_Range = bounds.magnitude;
    }

    public void Cache()
    {
      if (!this.m_Loop)
        return;
      int length = this.curve.length;
      if (length < 2)
        return;
      if (this.m_InternalLoopingCurve == null)
        this.m_InternalLoopingCurve = new AnimationCurve();
      Keyframe key1 = this.curve[length - 1];
      key1.time -= this.m_Range;
      Keyframe key2 = this.curve[0];
      key2.time += this.m_Range;
      this.m_InternalLoopingCurve.keys = this.curve.keys;
      this.m_InternalLoopingCurve.AddKey(key1);
      this.m_InternalLoopingCurve.AddKey(key2);
    }

    public float Evaluate(float t)
    {
      if (this.curve.length == 0)
        return this.m_ZeroValue;
      return !this.m_Loop || this.curve.length == 1 ? this.curve.Evaluate(t) : this.m_InternalLoopingCurve.Evaluate(t);
    }
  }
}
