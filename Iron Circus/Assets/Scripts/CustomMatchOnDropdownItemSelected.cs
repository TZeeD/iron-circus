// Decompiled with JetBrains decompiler
// Type: CustomMatchOnDropdownItemSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class CustomMatchOnDropdownItemSelected : 
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
  private Text dropdownTypeTxt;
  [SerializeField]
  private Image dropdownArrowImg;

  private void SetUiSelected()
  {
    this.dropdownTxt.color = Color.black;
    this.dropdownTypeTxt.color = Color.black;
    this.dropdownArrowImg.color = Color.black;
  }

  private void SetUiDeselected()
  {
    this.dropdownTxt.color = Color.white;
    this.dropdownTypeTxt.color = Color.white;
    this.dropdownArrowImg.color = Color.white;
  }

  public void OnSelect(BaseEventData eventData) => this.SetUiSelected();

  public void OnDeselect(BaseEventData eventData) => this.SetUiDeselected();

  public void OnPointerEnter(PointerEventData eventData) => this.SetUiSelected();

  public void OnPointerExit(PointerEventData eventData) => this.SetUiDeselected();
}
