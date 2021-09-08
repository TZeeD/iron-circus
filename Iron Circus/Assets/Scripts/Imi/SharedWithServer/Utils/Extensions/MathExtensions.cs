// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.Extensions.MathExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Utils.Extensions
{
  public static class MathExtensions
  {
    public static T Clamp<T>(this T val, T min, T max) where T : IComparable<T>
    {
      if (val.CompareTo(min) < 0)
        return min;
      return val.CompareTo(max) > 0 ? max : val;
    }

    public static float Interpolate(float v0, float v1, float t) => (float) ((1.0 - (double) t) * (double) v0 + (double) t * (double) v1);
  }
}
