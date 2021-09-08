// Decompiled with JetBrains decompiler
// Type: ScrollRectScroller
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ScrollRectScroller : 
  MonoBehaviour,
  IPointerExitHandler,
  IEventSystemHandler,
  IPointerEnterHandler
{
  public float scrollSpeed;
  public bool onlyOnSelected;
  private bool mouseFocus;
  private ScrollRect target;
  private Player input;

  private void Start()
  {
    this.target = this.GetComponentInChildren<ScrollRect>();
    this.input = ReInput.players.GetPlayer(0);
  }

  private void Update()
  {
    if (!this.target.verticalScrollbar.gameObject.activeInHierarchy)
      this.target.verticalNormalizedPosition = 0.0f;
    if (!this.gameObject.activeInHierarchy || !this.target.gameObject.activeInHierarchy || this.onlyOnSelected && !((Object) EventSystem.current.currentSelectedGameObject == (Object) this.gameObject) && !this.mouseFocus || (double) this.input.GetAxis("UIVertical_R") <= 0.100000001490116 && (double) this.input.GetAxis("UIVertical_R") >= -0.100000001490116)
      return;
    this.ScrollVertical(this.scrollSpeed * this.input.GetAxis("UIVertical_R"));
  }

  private void ScrollVertical(float speed)
  {
    this.target.verticalNormalizedPosition += speed * Time.deltaTime / this.target.verticalScrollbar.size;
    if ((double) this.target.verticalNormalizedPosition > 1.0)
      this.target.verticalNormalizedPosition = 1f;
    if ((double) this.target.verticalNormalizedPosition >= 0.0)
      return;
    this.target.verticalNormalizedPosition = 0.0f;
  }

  public void OnPointerExit(PointerEventData eventData) => this.mouseFocus = true;

  public void OnPointerEnter(PointerEventData eventData) => this.mouseFocus = false;
}
