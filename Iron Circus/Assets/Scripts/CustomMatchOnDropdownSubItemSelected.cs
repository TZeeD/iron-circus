// Decompiled with JetBrains decompiler
// Type: CustomMatchOnDropdownSubItemSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class CustomMatchOnDropdownSubItemSelected : 
  MonoBehaviour,
  ISelectHandler,
  IEventSystemHandler,
  IDeselectHandler,
  IPointerEnterHandler,
  IPointerExitHandler
{
  [SerializeField]
  private Text dropdownTxt;
  [SerializeField]
  private Image dropdownCheckmarkImg;
  public ScrollRect parentScrollRect;
  public RectTransform contentPanel;

  public void SnapTo()
  {
    if (ImiServices.Instance.InputService.GetLastInputSource() == InputSource.Mouse)
      return;
    Canvas.ForceUpdateCanvases();
    this.contentPanel.anchoredPosition = (Vector2) this.parentScrollRect.transform.InverseTransformPoint(this.contentPanel.position) - (Vector2) this.parentScrollRect.transform.InverseTransformPoint(this.GetComponent<RectTransform>().position);
  }

  private void SetUiSelected()
  {
    this.dropdownTxt.color = Color.black;
    this.dropdownCheckmarkImg.color = Color.black;
  }

  private void SetUiDeselected()
  {
    this.dropdownTxt.color = Color.white;
    this.dropdownCheckmarkImg.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
  }

  public void OnSelect(BaseEventData eventData)
  {
    this.SnapTo();
    this.SetUiSelected();
  }

  public void OnDeselect(BaseEventData eventData) => this.SetUiDeselected();

  public void OnPointerEnter(PointerEventData eventData) => this.SetUiSelected();

  public void OnPointerExit(PointerEventData eventData) => this.SetUiDeselected();
}
