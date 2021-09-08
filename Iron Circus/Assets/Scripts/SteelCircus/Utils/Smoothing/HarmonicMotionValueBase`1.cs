// Decompiled with JetBrains decompiler
// Type: SteelCircus.Utils.Smoothing.HarmonicMotionValueBase`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using DigitalSalmon;
using UnityEngine;

namespace SteelCircus.Utils.Smoothing
{
  public abstract class HarmonicMotionValueBase<T>
  {
    protected float dampingRatio = 1f;
    protected float angularFrequency = 3f;
    protected bool isDirty = true;
    public bool recalcCoefficientsEveryStep;
    protected HarmonicMotion.DampenedSpringMotionParams coefficients;
    public T targetValue;
    public T velocity;
    public T currentValue;

    public float DampingRatio
    {
      get => this.dampingRatio;
      set
      {
        this.dampingRatio = value;
        this.isDirty = true;
      }
    }

    public float AngularFrequency
    {
      get => this.angularFrequency;
      set
      {
        this.angularFrequency = value;
        this.isDirty = true;
      }
    }

    public T Step() => this.Step(Time.deltaTime);

    public T Step(float deltaTime)
    {
      if (this.isDirty || this.recalcCoefficientsEveryStep)
      {
        this.coefficients = HarmonicMotion.CalcDampedSpringMotionParams(this.dampingRatio, this.angularFrequency, deltaTime);
        this.isDirty = false;
      }
      this.Calc();
      return this.currentValue;
    }

    protected abstract void Calc();
  }
}
