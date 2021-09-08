// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.ScrollRectSelectableChild
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired.Utils;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  [RequireComponent(typeof (Selectable))]
  public class ScrollRectSelectableChild : MonoBehaviour, ISelectHandler, IEventSystemHandler
  {
    public bool useCustomEdgePadding;
    public float customEdgePadding = 50f;
    private ScrollRect parentScrollRect;
    private Selectable _selectable;

    private RectTransform parentScrollRectContentTransform => this.parentScrollRect.content;

    private Selectable selectable => this._selectable ?? (this._selectable = this.GetComponent<Selectable>());

    private RectTransform rectTransform => this.transform as RectTransform;

    private void Start()
    {
      this.parentScrollRect = this.transform.GetComponentInParent<ScrollRect>();
      if (!((Object) this.parentScrollRect == (Object) null))
        return;
      Debug.LogError((object) "Rewired Control Mapper: No ScrollRect found! This component must be a child of a ScrollRect!");
    }

    public void OnSelect(BaseEventData eventData)
    {
      if ((Object) this.parentScrollRect == (Object) null || !(eventData is AxisEventData))
        return;
      RectTransform transform = this.parentScrollRect.transform as RectTransform;
      Rect child = MathTools.TransformRect(this.rectTransform.rect, (Transform) this.rectTransform, (Transform) transform);
      Rect rect1 = transform.rect;
      Rect rect2 = transform.rect;
      float num = !this.useCustomEdgePadding ? child.height : this.customEdgePadding;
      rect2.yMax -= num;
      rect2.yMin += num;
      Vector2 offset;
      if (MathTools.RectContains(rect2, child) || !MathTools.GetOffsetToContainRect(rect2, child, out offset))
        return;
      Vector2 anchoredPosition = this.parentScrollRectContentTransform.anchoredPosition;
      anchoredPosition.x = Mathf.Clamp(anchoredPosition.x + offset.x, 0.0f, Mathf.Abs(rect1.width - this.parentScrollRectContentTransform.sizeDelta.x));
      anchoredPosition.y = Mathf.Clamp(anchoredPosition.y + offset.y, 0.0f, Mathf.Abs(rect1.height - this.parentScrollRectContentTransform.sizeDelta.y));
      this.parentScrollRectContentTransform.anchoredPosition = anchoredPosition;
    }
  }
}
