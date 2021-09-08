// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ScrollOnSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ScrollOnSelected : MonoBehaviour, ISelectHandler, IEventSystemHandler
  {
    public ScrollThroughButtons buttonScrollController;
    public ScrollOnSelected.buttonSelectionType scrollBy;
    public int rowNumber;
    public int nRows = 1;

    private void Start()
    {
      if (!((Object) MenuController.Instance.buttonFocusManager.currentlySelectedButton == (Object) this.GetComponentInChildren<Selectable>(true)))
        return;
      this.OnSelect((BaseEventData) null);
    }

    public void OnSelect(BaseEventData eventData)
    {
      if (!((Object) this.buttonScrollController != (Object) null))
        return;
      switch (this.scrollBy)
      {
        case ScrollOnSelected.buttonSelectionType.gameObject:
          this.buttonScrollController.ScrollToButton(this.gameObject, this.nRows);
          break;
        case ScrollOnSelected.buttonSelectionType.rowNumber:
          this.buttonScrollController.ScrollToButton(this.rowNumber, this.nRows);
          break;
      }
    }

    public void OnSelectRemote()
    {
      if (!((Object) this.buttonScrollController != (Object) null))
        return;
      switch (this.scrollBy)
      {
        case ScrollOnSelected.buttonSelectionType.gameObject:
          this.buttonScrollController.ScrollToButton(this.gameObject, this.nRows);
          break;
        case ScrollOnSelected.buttonSelectionType.rowNumber:
          this.buttonScrollController.ScrollToButton(this.rowNumber, this.nRows);
          break;
      }
    }

    public enum buttonSelectionType
    {
      gameObject,
      rowNumber,
    }
  }
}
