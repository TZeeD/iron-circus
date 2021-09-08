// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.Extensions.Vector3Extensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.Utils.Extensions
{
  public static class Vector3Extensions
  {
    public static Vector3 GetForwardVector(Quaternion q) => q * Vector3.forward;

    public static Vector3 GetBackwardVector(Quaternion q) => q * Vector3.back;

    public static Vector3 GetLeftVector(Quaternion q) => q * Vector3.left;

    public static Vector3 GetRightVector(Quaternion q) => q * Vector3.right;

    public static Vector3 GetUpVector(Quaternion q) => q * Vector3.up;

    public static Vector3 GetDownVector(Quaternion q) => q * Vector3.down;

    public static Vector3 GetAverageVector3(params Vector3[] vectors)
    {
      Vector3 zero = Vector3.zero;
      if (vectors.Length == 0)
        return zero;
      for (int index = 0; index < vectors.Length; ++index)
        zero += vectors[index];
      return zero / (float) vectors.Length;
    }

    public static Vector3 Abs(this Vector3 origin) => new Vector3(Mathf.Abs(origin.x), Mathf.Abs(origin.y), Mathf.Abs(origin.z));

    public static Vector3 Mul(this Vector3 first, Vector3 other)
    {
      first.Scale(other);
      return first;
    }
  }
}
