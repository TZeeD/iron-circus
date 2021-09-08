// Decompiled with JetBrains decompiler
// Type: BaseSelectionWheel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using Imi.SteelCircus.Core;
using SteelCircus.Core.Services;
using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public abstract class BaseSelectionWheel : MonoBehaviour
{
  public Button button0;
  public Button button1;
  public Button button2;
  public Button button3;
  protected int selectedItemIndex;
  protected InputService input;
  protected ulong playerId;
  protected InputController inputController;
  protected GameContext gameContext;
  protected static readonly float stickTriggerThreshold = 0.5f;
  private Vector2 originalPos;
  private RectTransform _transform;

  public virtual void Initialize(
    GameContext gameContext,
    InputController inputController,
    ulong playerId)
  {
    this.gameContext = gameContext;
    this.inputController = inputController;
    this.playerId = playerId;
    this.input = ImiServices.Instance.InputService;
    this._transform = this.GetComponent<RectTransform>();
    this.originalPos = this._transform.anchoredPosition;
    this.PopulateSelectionWheel();
    this.input.lastInputSourceChangedEvent += new Action<InputSource>(this.LastInputSourceChanged);
    this.LastInputSourceChanged(this.input.GetLastInputSource());
  }

  public void Cleanup() => this.input.lastInputSourceChangedEvent -= new Action<InputSource>(this.LastInputSourceChanged);

  private void LastInputSourceChanged(InputSource source)
  {
    bool flag = source == InputSource.Keyboard || source == InputSource.Mouse;
    foreach (Component componentsInChild in this.GetComponentsInChildren<Button>(true))
      componentsInChild.GetComponent<Image>().raycastTarget = flag;
  }

  public void SetSelectedIndex(int index) => this.selectedItemIndex = index;

  protected virtual bool ProcessSelectionInput(Vector2 stickInput)
  {
    if ((double) stickInput.x > 0.5)
    {
      this.selectedItemIndex = 1;
      this.button1.Select();
      return true;
    }
    if ((double) stickInput.x < -0.5)
    {
      this.selectedItemIndex = 3;
      this.button3.Select();
      return true;
    }
    if ((double) stickInput.y > 0.5)
    {
      this.selectedItemIndex = 2;
      this.button2.Select();
      return true;
    }
    if ((double) stickInput.y >= -0.5)
      return false;
    this.selectedItemIndex = 0;
    this.button0.Select();
    return true;
  }

  private void Update() => this.UpdateInput();

  protected virtual void UpdateInput() => this.ProcessSelectionInput(this.input.GetAnalogInput(AnalogInput.Aim));

  public virtual void SelectItem(int index) => this.CloseSelectionWheel(false);

  public virtual void SubmitSelection()
  {
  }

  protected abstract bool AllowSelectionWheel();

  public virtual void ShowSelectionWheel()
  {
    if (!this.AllowSelectionWheel())
      return;
    this.selectedItemIndex = -1;
    if (this.input.GetLastInputSource() == InputSource.Keyboard || this.input.GetLastInputSource() == InputSource.Mouse)
    {
      Vector2 localPoint;
      RectTransformUtility.ScreenPointToLocalPointInRectangle(this._transform, this.input.GetMousePosition(), (Camera) null, out localPoint);
      this._transform.anchoredPosition += localPoint;
      Vector2 anchoredPosition = this.GetComponentInParent<SelectionWheels>().GetComponent<RectTransform>().anchoredPosition;
      Vector2 localScale = (Vector2) this.GetComponentInParent<SelectionWheels>().GetComponent<RectTransform>().localScale;
      float max1 = 0.0f;
      float min1 = 0.0f;
      float min2 = (float) ((double) max1 - (double) this._transform.sizeDelta.x - 2.0 * (double) anchoredPosition.x) / localScale.x;
      float max2 = (float) ((double) min1 + (double) this._transform.sizeDelta.y - 2.0 * (double) anchoredPosition.y) / localScale.y;
      this._transform.anchoredPosition = new Vector2(Mathf.Clamp(this._transform.anchoredPosition.x, min2, max1), Mathf.Clamp(this._transform.anchoredPosition.y, min1, max2));
    }
    else
      this._transform.anchoredPosition = this.originalPos;
    this.gameObject.SetActive(true);
  }

  public virtual void CloseSelectionWheel(bool submitSelection = true)
  {
    if (!this.IsWheelOpen())
      return;
    if (submitSelection)
      this.SubmitSelection();
    EventSystem.current.SetSelectedGameObject((GameObject) null);
    this.gameObject.SetActive(false);
  }

  protected abstract void PopulateSelectionWheel();

  public bool IsWheelOpen() => this.gameObject.activeInHierarchy;
}
