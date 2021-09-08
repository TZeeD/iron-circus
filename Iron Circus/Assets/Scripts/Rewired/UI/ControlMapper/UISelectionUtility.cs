// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.UISelectionUtility
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired.Utils;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  public static class UISelectionUtility
  {
    public static Selectable FindNextSelectable(
      Selectable selectable,
      Transform transform,
      Vector3 direction)
    {
      RectTransform rectTransform = transform as RectTransform;
      if ((Object) rectTransform == (Object) null)
        return (Selectable) null;
      IList<Selectable> allSelectables = (IList<Selectable>) Selectable.allSelectables;
      int count = allSelectables.Count;
      direction.Normalize();
      Vector2 vector2 = (Vector2) direction;
      Vector2 pointOnRectEdge = (Vector2) UITools.GetPointOnRectEdge(rectTransform, vector2);
      bool flag = vector2 == Vector2.right * -1f || vector2 == Vector2.right;
      float num1 = float.PositiveInfinity;
      float num2 = float.PositiveInfinity;
      Selectable selectable1 = (Selectable) null;
      Selectable selectable2 = (Selectable) null;
      Vector2 point2 = pointOnRectEdge + vector2 * 999999f;
      for (int index = 0; index < count; ++index)
      {
        Selectable selectable3 = allSelectables[index];
        if (!((Object) selectable3 == (Object) selectable) && !((Object) selectable3 == (Object) null) && selectable3.navigation.mode != Navigation.Mode.None && (selectable3.IsInteractable() ? 1 : (ReflectionTools.GetPrivateField<Selectable, bool>(selectable3, "m_GroupsAllowInteraction") ? 1 : 0)) != 0)
        {
          RectTransform transform1 = selectable3.transform as RectTransform;
          if (!((Object) transform1 == (Object) null))
          {
            Rect rect = UITools.InvertY(UITools.TransformRectTo((Transform) transform1, transform, transform1.rect));
            float sqrMagnitude1;
            if (MathTools.LineIntersectsRect(pointOnRectEdge, point2, rect, out sqrMagnitude1))
            {
              if (flag)
                sqrMagnitude1 *= 0.25f;
              if ((double) sqrMagnitude1 < (double) num2)
              {
                num2 = sqrMagnitude1;
                selectable2 = selectable3;
              }
            }
            Vector2 to = (Vector2) UnityTools.TransformPoint((Transform) transform1, transform, (Vector3) transform1.rect.center) - pointOnRectEdge;
            if ((double) Mathf.Abs(Vector2.Angle(vector2, to)) <= 75.0)
            {
              float sqrMagnitude2 = to.sqrMagnitude;
              if ((double) sqrMagnitude2 < (double) num1)
              {
                num1 = sqrMagnitude2;
                selectable1 = selectable3;
              }
            }
          }
        }
      }
      if (!((Object) selectable2 != (Object) null) || !((Object) selectable1 != (Object) null))
        return selectable2 ?? selectable1;
      return (double) num2 > (double) num1 ? selectable1 : selectable2;
    }
  }
}
