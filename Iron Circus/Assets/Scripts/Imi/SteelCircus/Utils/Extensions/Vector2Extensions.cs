// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.Extensions.Vector2Extensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace Imi.SteelCircus.Utils.Extensions
{
  public static class Vector2Extensions
  {
    public static Vector2 Rotate(this Vector2 v, float degrees)
    {
      float num1 = Mathf.Sin(degrees * ((float) Math.PI / 180f));
      float num2 = Mathf.Cos(degrees * ((float) Math.PI / 180f));
      float x = v.x;
      float y = v.y;
      v.x = (float) ((double) num2 * (double) x - (double) num1 * (double) y);
      v.y = (float) ((double) num1 * (double) x + (double) num2 * (double) y);
      return v;
    }
  }
}
