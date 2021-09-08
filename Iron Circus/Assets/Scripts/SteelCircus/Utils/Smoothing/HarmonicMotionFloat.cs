// Decompiled with JetBrains decompiler
// Type: SteelCircus.Utils.Smoothing.HarmonicMotionFloat
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using DigitalSalmon;

namespace SteelCircus.Utils.Smoothing
{
  public class HarmonicMotionFloat : HarmonicMotionValueBase<float>
  {
    protected override void Calc() => HarmonicMotion.Calculate(ref this.currentValue, ref this.velocity, this.targetValue, this.coefficients);
  }
}
