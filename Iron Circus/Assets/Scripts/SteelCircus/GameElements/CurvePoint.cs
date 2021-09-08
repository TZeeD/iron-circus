// Decompiled with JetBrains decompiler
// Type: SteelCircus.GameElements.CurvePoint
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace SteelCircus.GameElements
{
  [Serializable]
  public struct CurvePoint
  {
    public float time;
    public float value;
    public float inSlope;
    public float outSlope;
    public int leftTangentMode;
    public int rightTangentMode;

    public CurvePoint(
      float time,
      float value,
      float inSlope,
      float outSlope,
      int leftTangentMode = 0,
      int rightTangentMode = 0)
    {
      this.time = time;
      this.value = value;
      this.inSlope = inSlope;
      this.outSlope = outSlope;
      this.leftTangentMode = leftTangentMode;
      this.rightTangentMode = rightTangentMode;
    }
  }
}
