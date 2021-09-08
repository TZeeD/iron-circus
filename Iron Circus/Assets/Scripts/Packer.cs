// Decompiled with JetBrains decompiler
// Type: Packer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public static class Packer
{
  public static float ToFloat(float x, float y, float z, float w)
  {
    x = (double) x < 0.0 ? 0.0f : (1.0 < (double) x ? 1f : x);
    y = (double) y < 0.0 ? 0.0f : (1.0 < (double) y ? 1f : y);
    z = (double) z < 0.0 ? 0.0f : (1.0 < (double) z ? 1f : z);
    w = (double) w < 0.0 ? 0.0f : (1.0 < (double) w ? 1f : w);
    return (float) ((Mathf.FloorToInt(w * 63f) << 18) + (Mathf.FloorToInt(z * 63f) << 12) + (Mathf.FloorToInt(y * 63f) << 6) + Mathf.FloorToInt(x * 63f));
  }

  public static float ToFloat(Vector4 factor) => Packer.ToFloat(Mathf.Clamp01(factor.x), Mathf.Clamp01(factor.y), Mathf.Clamp01(factor.z), Mathf.Clamp01(factor.w));

  public static float ToFloat(float x, float y, float z)
  {
    x = (double) x < 0.0 ? 0.0f : (1.0 < (double) x ? 1f : x);
    y = (double) y < 0.0 ? 0.0f : (1.0 < (double) y ? 1f : y);
    z = (double) z < 0.0 ? 0.0f : (1.0 < (double) z ? 1f : z);
    return (float) ((Mathf.FloorToInt(z * (float) byte.MaxValue) << 16) + (Mathf.FloorToInt(y * (float) byte.MaxValue) << 8) + Mathf.FloorToInt(x * (float) byte.MaxValue));
  }

  public static float ToFloat(float x, float y)
  {
    x = (double) x < 0.0 ? 0.0f : (1.0 < (double) x ? 1f : x);
    y = (double) y < 0.0 ? 0.0f : (1.0 < (double) y ? 1f : y);
    return (float) ((Mathf.FloorToInt(y * 4095f) << 12) + Mathf.FloorToInt(x * 4095f));
  }
}
