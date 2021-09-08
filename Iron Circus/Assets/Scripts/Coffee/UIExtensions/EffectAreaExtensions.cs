// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.EffectAreaExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  public static class EffectAreaExtensions
  {
    private static readonly Rect rectForCharacter = new Rect(0.0f, 0.0f, 1f, 1f);
    private static readonly Vector2[] splitedCharacterPosition = new Vector2[4]
    {
      Vector2.up,
      Vector2.one,
      Vector2.right,
      Vector2.zero
    };

    public static Rect GetEffectArea(
      this EffectArea area,
      VertexHelper vh,
      Rect rectangle,
      float aspectRatio = -1f)
    {
      Rect rect = new Rect();
      switch (area)
      {
        case EffectArea.RectTransform:
          rect = rectangle;
          break;
        case EffectArea.Fit:
          UIVertex vertex = new UIVertex();
          float num1 = float.MaxValue;
          float num2 = float.MaxValue;
          float a1 = float.MinValue;
          float a2 = float.MinValue;
          for (int i = 0; i < vh.currentVertCount; ++i)
          {
            vh.PopulateUIVertex(ref vertex, i);
            float x = vertex.position.x;
            float y = vertex.position.y;
            num1 = Mathf.Min(num1, x);
            num2 = Mathf.Min(num2, y);
            a1 = Mathf.Max(a1, x);
            a2 = Mathf.Max(a2, y);
          }
          rect.Set(num1, num2, a1 - num1, a2 - num2);
          break;
        case EffectArea.Character:
          rect = EffectAreaExtensions.rectForCharacter;
          break;
        default:
          rect = rectangle;
          break;
      }
      if (0.0 < (double) aspectRatio)
      {
        if ((double) rect.width < (double) rect.height)
          rect.width = rect.height * aspectRatio;
        else
          rect.height = rect.width / aspectRatio;
      }
      return rect;
    }

    public static void GetPositionFactor(
      this EffectArea area,
      int index,
      Rect rect,
      Vector2 position,
      bool isText,
      bool isTMPro,
      out float x,
      out float y)
    {
      if (isText && area == EffectArea.Character)
      {
        index = isTMPro ? (index + 3) % 4 : index % 4;
        x = EffectAreaExtensions.splitedCharacterPosition[index].x;
        y = EffectAreaExtensions.splitedCharacterPosition[index].y;
      }
      else if (area == EffectArea.Fit)
      {
        x = Mathf.Clamp01((position.x - rect.xMin) / rect.width);
        y = Mathf.Clamp01((position.y - rect.yMin) / rect.height);
      }
      else
      {
        x = Mathf.Clamp01((float) ((double) position.x / (double) rect.width + 0.5));
        y = Mathf.Clamp01((float) ((double) position.y / (double) rect.height + 0.5));
      }
    }

    public static void GetNormalizedFactor(
      this EffectArea area,
      int index,
      Matrix2x3 matrix,
      Vector2 position,
      bool isText,
      out Vector2 nomalizedPos)
    {
      if (isText && area == EffectArea.Character)
        nomalizedPos = matrix * EffectAreaExtensions.splitedCharacterPosition[(index + 3) % 4];
      else
        nomalizedPos = matrix * position;
    }
  }
}
