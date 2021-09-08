// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.Matrix2x3
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Coffee.UIExtensions
{
  public struct Matrix2x3
  {
    public float m00;
    public float m01;
    public float m02;
    public float m10;
    public float m11;
    public float m12;

    public Matrix2x3(Rect rect, float cos, float sin)
    {
      float num1 = (float) (-(double) rect.xMin / (double) rect.width - 0.5);
      float num2 = (float) (-(double) rect.yMin / (double) rect.height - 0.5);
      this.m00 = cos / rect.width;
      this.m01 = -sin / rect.height;
      this.m02 = (float) ((double) num1 * (double) cos - (double) num2 * (double) sin + 0.5);
      this.m10 = sin / rect.width;
      this.m11 = cos / rect.height;
      this.m12 = (float) ((double) num1 * (double) sin + (double) num2 * (double) cos + 0.5);
    }

    public static Vector2 operator *(Matrix2x3 m, Vector2 v) => new Vector2((float) ((double) m.m00 * (double) v.x + (double) m.m01 * (double) v.y) + m.m02, (float) ((double) m.m10 * (double) v.x + (double) m.m11 * (double) v.y) + m.m12);
  }
}
