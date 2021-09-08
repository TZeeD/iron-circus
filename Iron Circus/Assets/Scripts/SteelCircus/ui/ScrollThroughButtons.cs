// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ScrollThroughButtons
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using System.Collections;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ScrollThroughButtons : MonoBehaviour
  {
    [SerializeField]
    private float scrollPositionOffset;
    [SerializeField]
    private int nButtons;
    [SerializeField]
    public int nScrollElements;
    [SerializeField]
    public int nTotalSections;
    [SerializeField]
    private int currentFirstElement;
    public ScrollThroughButtons.ScrollAxis scrollAxis;
    [SerializeField]
    private float buttonSpacing;
    public GameObject[] allScrollFieldButtons;
    public int nObjectsPerScrollelement;
    public int nVisibleElements;
    private static float scrollCooldown = 0.01f;
    private static bool scrollPaused;
    public Button forwardButton;
    public Button backwardButton;
    public Scrollbar scrollbar;
    public GameObject buttonContainer;
    private InputService input;
    private float lastFrameScrollbarPosition;
    private bool scrollBarChangedThroughCode;

    private void Start() => this.input = ImiServices.Instance.InputService;

    public void SetupScrollView(GameObject[] allButtons, int nSelected = 0)
    {
      this.allScrollFieldButtons = allButtons;
      this.nButtons = allButtons.Length;
      this.nScrollElements = (int) Mathf.Ceil((float) this.nButtons / (float) this.nObjectsPerScrollelement);
      if ((Object) this.scrollbar != (Object) null)
        this.scrollbar.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnScrollBarValueChanged()));
      this.nTotalSections = 0;
      foreach (GameObject scrollFieldButton in this.allScrollFieldButtons)
      {
        if ((Object) scrollFieldButton.GetComponent<ScrollOnSelected>() != (Object) null)
        {
          this.nTotalSections += scrollFieldButton.GetComponent<ScrollOnSelected>().nRows;
        }
        else
        {
          Log.Warning("ScrollElement has no Component ScrollOnSelected");
          ++this.nTotalSections;
        }
      }
      this.nTotalSections = (int) ((double) this.nTotalSections / (double) this.nObjectsPerScrollelement + 0.990000009536743);
      this.UpdateButtonStatus();
    }

    private void Update()
    {
      this.UpdateButtonStatus();
      if (!((Object) MenuController.Instance.currentMenu != (Object) MenuController.Instance.shopBuyPanel) || !((Object) MenuController.Instance.currentMenu != (Object) MenuController.Instance.slotEquipMenu) || !this.gameObject.activeSelf || ScrollThroughButtons.scrollPaused)
        return;
      if ((this.scrollAxis == ScrollThroughButtons.ScrollAxis.scrollY || (Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.shopMenu) && (double) this.input.GetAnalogInput(AnalogInput.UISecondaryScroll).y > 0.200000002980232 && this.currentFirstElement > 0)
      {
        this.ScrollUp(1, true);
        this.StartCoroutine(this.StartScrollCooldown());
        this.FocusOnFirstVisible();
      }
      if ((this.scrollAxis == ScrollThroughButtons.ScrollAxis.scrollY || (Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.shopMenu) && (double) this.input.GetAnalogInput(AnalogInput.UISecondaryScroll).y <= -0.200000002980232 && this.currentFirstElement < this.nTotalSections - this.nVisibleElements)
      {
        this.ScrollDown(1, true);
        this.StartCoroutine(this.StartScrollCooldown());
        this.FocusOnFirstVisible();
      }
      if (this.scrollAxis == ScrollThroughButtons.ScrollAxis.scrollX && (double) this.input.GetAnalogInput(AnalogInput.UISecondaryScroll).x < -0.200000002980232 && this.currentFirstElement > 0)
      {
        this.ScrollUp(1, true);
        this.StartCoroutine(this.StartScrollCooldown());
        this.FocusOnFirstVisible();
      }
      if (this.scrollAxis != ScrollThroughButtons.ScrollAxis.scrollX || (double) this.input.GetAnalogInput(AnalogInput.UISecondaryScroll).x <= 0.200000002980232 || this.currentFirstElement >= this.nTotalSections - this.nVisibleElements)
        return;
      this.ScrollDown(1, true);
      this.StartCoroutine(this.StartScrollCooldown());
      this.FocusOnFirstVisible();
    }

    private IEnumerator StartScrollCooldown()
    {
      ScrollThroughButtons.scrollPaused = true;
      yield return (object) new WaitForSeconds(ScrollThroughButtons.scrollCooldown);
      ScrollThroughButtons.scrollPaused = false;
    }

    public void OnScrollBarValueChanged()
    {
      if (!this.scrollBarChangedThroughCode)
      {
        if ((double) this.lastFrameScrollbarPosition == (double) this.scrollbar.value)
          return;
        this.lastFrameScrollbarPosition = this.scrollbar.value;
        Log.Debug("Scrollbar value changed " + (object) this.scrollbar.value);
        this.ScrollToRow(this.ConvertScrollPositionToRow(this.scrollbar.value), false);
      }
      else
        this.scrollBarChangedThroughCode = false;
    }

    private void UpdateButtonStatus()
    {
      if (this.nTotalSections > this.nVisibleElements)
      {
        if ((Object) this.scrollbar != (Object) null)
        {
          this.scrollbar.gameObject.SetActive(true);
          this.scrollbar.numberOfSteps = this.nScrollElements - (this.nVisibleElements - 1);
          this.scrollbar.size = (float) this.nVisibleElements / (float) this.nScrollElements;
        }
        if ((Object) this.forwardButton != (Object) null && (Object) this.backwardButton != (Object) null)
        {
          this.forwardButton.gameObject.SetActive(true);
          this.backwardButton.gameObject.SetActive(true);
        }
      }
      else
      {
        if ((Object) this.scrollbar != (Object) null)
          this.scrollbar.gameObject.SetActive(false);
        if ((Object) this.forwardButton != (Object) null && (Object) this.backwardButton != (Object) null)
        {
          this.forwardButton.gameObject.SetActive(false);
          this.backwardButton.gameObject.SetActive(false);
        }
      }
      if (!((Object) this.forwardButton != (Object) null) || !((Object) this.backwardButton != (Object) null))
        return;
      if (this.currentFirstElement <= 0)
        this.backwardButton.interactable = false;
      else
        this.backwardButton.interactable = true;
      if (this.currentFirstElement >= this.nTotalSections - this.nVisibleElements)
        this.forwardButton.interactable = false;
      else
        this.forwardButton.interactable = true;
    }

    public void ScrollToButton(GameObject button, int nThickness = 1)
    {
      for (int index = 0; index < this.allScrollFieldButtons.Length; ++index)
      {
        if ((Object) this.allScrollFieldButtons[index] == (Object) button)
          this.ScrollToButton(index / this.nObjectsPerScrollelement, nThickness);
      }
    }

    public void ScrollToButton(int nButtonRow, int nThickness = 1)
    {
      if (nThickness <= 0)
        nThickness = 1;
      if (nButtonRow - this.currentFirstElement < 0 || this.currentFirstElement < 0)
        this.ScrollToRow(nButtonRow);
      if (nButtonRow - this.currentFirstElement <= this.nVisibleElements - 1)
        return;
      this.ScrollToRow(nButtonRow - (this.nVisibleElements - 1) + (nThickness - 1));
    }

    public void ScrollDown(int steps, bool updateScrollbar) => this.ScrollToRow(this.currentFirstElement + steps, updateScrollbar);

    public void ScrollUp(int steps, bool updateScrollbar) => this.ScrollToRow(this.currentFirstElement - steps, updateScrollbar);

    public void ScrollDown(int steps) => this.ScrollDown(steps, true);

    public void ScrollUp(int steps) => this.ScrollUp(steps, true);

    private void FocusOnFirstVisible()
    {
      if (ImiServices.Instance.InputService.GetLastInputSource() == InputSource.Mouse)
        return;
      foreach (GameObject scrollFieldButton in this.allScrollFieldButtons)
      {
        if (scrollFieldButton.GetComponent<ScrollOnSelected>().rowNumber >= this.currentFirstElement)
        {
          scrollFieldButton.GetComponentInChildren<Selectable>().Select();
          scrollFieldButton.GetComponentInChildren<Selectable>().OnSelect((BaseEventData) null);
          break;
        }
      }
    }

    public void ScrollToRow(int nRow, bool updateScrollbar = true)
    {
      if ((Object) this.scrollbar != (Object) null & updateScrollbar)
      {
        this.scrollBarChangedThroughCode = true;
        this.scrollbar.value = this.ConvertRowToScrollPosition(nRow);
      }
      if (this.scrollAxis == ScrollThroughButtons.ScrollAxis.scrollX)
        this.buttonContainer.GetComponent<RectTransform>().anchoredPosition = new Vector2((float) (-1.0 * ((double) this.buttonSpacing * (double) nRow)) + this.scrollPositionOffset, 0.0f);
      else
        this.buttonContainer.GetComponent<RectTransform>().anchoredPosition = new Vector2(0.0f, this.buttonSpacing * (float) nRow + this.scrollPositionOffset);
      this.currentFirstElement = nRow;
    }

    private float ConvertRowToScrollPosition(int nRow) => this.scrollbar.numberOfSteps == 0 ? 0.0f : (float) nRow / (float) (this.scrollbar.numberOfSteps - 1);

    private int ConvertScrollPositionToRow(float scrollPosition) => (int) ((double) scrollPosition * (double) (this.scrollbar.numberOfSteps - 1));

    private int GetFirstElementFromForwardTransform() => this.scrollAxis == ScrollThroughButtons.ScrollAxis.scrollX ? (int) (((double) this.buttonContainer.GetComponent<RectTransform>().anchoredPosition.x + (double) this.scrollPositionOffset) / (double) this.buttonSpacing) : (int) (((double) this.buttonContainer.GetComponent<RectTransform>().anchoredPosition.y - (double) this.scrollPositionOffset) / (double) this.buttonSpacing);

    public void ForceUpdateLayout()
    {
      this.ScrollToRow(this.currentFirstElement);
      LayoutRebuilder.ForceRebuildLayoutImmediate(this.buttonContainer.GetComponent<RectTransform>());
    }

    public enum ScrollAxis
    {
      scrollX,
      scrollY,
    }
  }
}
