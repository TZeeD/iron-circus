// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.Extensions.TransformExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.Utils.Extensions
{
  public static class TransformExtensions
  {
    public static void SetToIdentity(this Transform t)
    {
      t.localPosition = t.localEulerAngles = Vector3.zero;
      t.localScale = Vector3.one;
    }

    public static void ReparentAndKeepLocalSpace(this Transform t, Transform newParent)
    {
      Vector3 localPosition = t.localPosition;
      Vector3 localEulerAngles = t.localEulerAngles;
      Vector3 localScale = t.localScale;
      t.parent = newParent;
      t.localPosition = localPosition;
      t.localEulerAngles = localEulerAngles;
      t.localScale = localScale;
    }

    public static Transform FindDeepChild(this Transform parent, string name)
    {
      Transform transform = parent.Find(name);
      if ((Object) transform != (Object) null)
        return transform;
      foreach (Transform parent1 in parent)
      {
        Transform deepChild = parent1.FindDeepChild(name);
        if ((Object) deepChild != (Object) null)
          return deepChild;
      }
      return (Transform) null;
    }
  }
}
