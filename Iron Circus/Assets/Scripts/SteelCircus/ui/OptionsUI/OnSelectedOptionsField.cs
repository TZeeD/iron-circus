// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.OnSelectedOptionsField
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class OnSelectedOptionsField : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IDeselectHandler
  {
    [SerializeField]
    private Image sliderBackgroundImage;
    [SerializeField]
    private Sprite deselectedSprite;
    [SerializeField]
    private Sprite selectedSprite;
    [SerializeField]
    private Image leftArrowIcon;
    [SerializeField]
    private Image rightArrowIcon;

    public void OnSelect(BaseEventData eventData) => this.SelectSlider();

    public void OnDeselect(BaseEventData eventData) => this.DeselectSlider();

    private void OnDisable() => this.DeselectSlider();

    private void SelectSlider()
    {
      if ((Object) this.leftArrowIcon != (Object) null)
        this.leftArrowIcon.color = Color.black;
      if ((Object) this.rightArrowIcon != (Object) null)
        this.rightArrowIcon.color = Color.black;
      this.sliderBackgroundImage.sprite = this.selectedSprite;
      foreach (Graphic componentsInChild in this.GetComponentsInChildren<Text>())
        componentsInChild.color = Color.black;
    }

    private void DeselectSlider()
    {
      if ((Object) this.leftArrowIcon != (Object) null)
        this.leftArrowIcon.color = Color.white;
      if ((Object) this.rightArrowIcon != (Object) null)
        this.rightArrowIcon.color = Color.white;
      this.sliderBackgroundImage.sprite = this.deselectedSprite;
      foreach (Graphic componentsInChild in this.GetComponentsInChildren<Text>())
        componentsInChild.color = Color.white;
    }
  }
}
