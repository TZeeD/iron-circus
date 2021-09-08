// Decompiled with JetBrains decompiler
// Type: UIScreen
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ui;
using SteelCircus.Core.Services;
using System.Collections;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;
using UnityEngine.UI;

public class UIScreen : MonoBehaviour
{
  public bool activeOnStart;
  public bool isDebugMenu;
  public UIScreen parent;
  public float fadeDuration = 0.5f;
  public Selectable selectOnActive;
  [FormerlySerializedAs("goToUIScreenButtons")]
  public GoToUIScreenButton[] goToUiScreenButtons;
  public GameObject[] hideWhenActive;
  public UIScreenState[] uiScreenState;
  public bool blockReturning;
  private Selectable lastSelectedButton;
  private InputService input;
  private CanvasGroup canvasGroup;
  private EventSystem eventSystem;
  private UIScreen returnTo;
  private Animation animationComp;
  private UiScreenStateMachine stateMachine;

  public void Start()
  {
    this.eventSystem = EventSystem.current;
    this.input = ImiServices.Instance.InputService;
    this.canvasGroup = this.GetComponent<CanvasGroup>();
    if ((Object) this.canvasGroup == (Object) null)
      this.canvasGroup = this.gameObject.AddComponent<CanvasGroup>();
    this.SetupStates(this.canvasGroup);
    this.canvasGroup.ignoreParentGroups = true;
    this.SetupUiScreenNavigationButtons();
    if (this.activeOnStart)
    {
      this.canvasGroup.alpha = 1f;
      this.SetUiScreenActive(true);
      this.ResetSelectedBtn();
    }
    else
    {
      this.canvasGroup.alpha = 0.0f;
      this.SetUiScreenActive(false);
    }
  }

  private void SetupStates(CanvasGroup canvasGroup)
  {
    if (this.uiScreenState == null || this.uiScreenState.Length == 0)
      return;
    this.animationComp = this.GetComponent<Animation>();
    int entryState = this.isDebugMenu ? 1 : 0;
    this.stateMachine = new UiScreenStateMachine(canvasGroup, this.animationComp, this.uiScreenState, entryState);
    this.animationComp.wrapMode = WrapMode.Once;
    this.stateMachine.Start();
  }

  private void SetupUiScreenNavigationButtons()
  {
    foreach (GoToUIScreenButton toUiScreenButton in this.goToUiScreenButtons)
    {
      GoToUIScreenButton goToUiScreenButton = toUiScreenButton;
      if ((Object) goToUiScreenButton.button == (Object) null)
        Debug.LogWarning((object) "<color=red>Missing Button reference in 'Go to Screen' list!</color>", (Object) this.gameObject);
      else if ((Object) goToUiScreenButton.screen == (Object) null)
        Debug.LogWarning((object) "<color=red>Missing Screen reference in 'Go to Screen' list!</color>", (Object) this.gameObject);
      else
        goToUiScreenButton.button.onClick.AddListener((UnityAction) (() => this.GoToScreen(goToUiScreenButton.screen)));
    }
  }

  private void CacheSelectedButton()
  {
    GameObject selectedGameObject = this.eventSystem.currentSelectedGameObject;
    if ((Object) selectedGameObject != (Object) null)
      this.lastSelectedButton = selectedGameObject.GetComponent<Selectable>();
    else
      this.lastSelectedButton = this.selectOnActive;
  }

  public void EnterScreen(UIScreen callingScreen = null, bool forceReset = false) => this.StartCoroutine(this.EnterDelayed(callingScreen, forceReset));

  private IEnumerator EnterDelayed(UIScreen callingScreen, bool forceReset = false)
  {
    UIScreen uiScreen = this;
    yield return (object) null;
    uiScreen.gameObject.SetActive(true);
    uiScreen.returnTo = callingScreen;
    if ((Object) uiScreen.returnTo != (Object) null | forceReset)
    {
      uiScreen.eventSystem.SetSelectedGameObject((GameObject) null, (BaseEventData) null);
      uiScreen.lastSelectedButton = (Selectable) null;
      if (uiScreen.stateMachine != null)
        uiScreen.stateMachine.Reset();
    }
    uiScreen.SetUiScreenActive(true);
    uiScreen.ResetSelectedBtn();
    uiScreen.StartCoroutine(uiScreen.Fade(0.0f, 1f, uiScreen.fadeDuration, false));
  }

  public void ExitScreen()
  {
    this.CacheSelectedButton();
    this.eventSystem.SetSelectedGameObject((GameObject) null);
    this.SetUiScreenActive(false);
    this.StartCoroutine(this.Fade(1f, 0.0f, this.fadeDuration, true));
  }

  public void SetUiScreenActive(bool active)
  {
    this.canvasGroup.interactable = active;
    this.canvasGroup.blocksRaycasts = active;
    this.ShowHideWhenActiveObjects(!active);
  }

  private void ResetSelectedBtn()
  {
    if ((Object) this.lastSelectedButton != (Object) null)
      this.lastSelectedButton.Select();
    else if ((Object) this.selectOnActive != (Object) null)
      this.selectOnActive.Select();
    else
      Debug.LogWarning((object) "You must choose a UIElement that is active when the screen is shown (set via 'Select On Active')!", (Object) this.gameObject);
  }

  private IEnumerator Fade(float from, float to, float duration, bool deactivate)
  {
    UIScreen uiScreen = this;
    float start = 0.0f;
    while ((double) start < (double) duration)
    {
      uiScreen.canvasGroup.alpha = Mathf.Lerp(from, to, start / duration);
      start += Time.deltaTime;
      yield return (object) null;
    }
    uiScreen.canvasGroup.alpha = to;
    if (deactivate)
      uiScreen.gameObject.SetActive(false);
  }

  public void SelectDefaultButton() => this.selectOnActive.Select();

  private void GoToScreen(UIScreen nextScreen, bool returning = false)
  {
    this.ExitScreen();
    nextScreen.EnterScreen(returning ? (UIScreen) null : this);
  }

  private void ShowHideWhenActiveObjects(bool show)
  {
    foreach (GameObject gameObject in this.hideWhenActive)
    {
      if ((bool) (Object) gameObject)
        gameObject.SetActive(show);
    }
  }

  private void ReturnToPreviousScreen()
  {
    if ((Object) this.returnTo != (Object) null && !this.returnTo.blockReturning)
    {
      this.GoToScreen(this.returnTo, true);
      this.returnTo = (UIScreen) null;
      this.lastSelectedButton = (Selectable) null;
    }
    else if ((Object) this.parent != (Object) null && !this.parent.blockReturning)
      this.GoToScreen(this.parent, true);
    else
      Debug.LogWarning((object) "Can't back out of a UIScreen with no parent and no previous screen that are not blocked for return!", (Object) this.gameObject);
  }

  private void Update()
  {
    if (!this.canvasGroup.interactable || !this.input.GetButtonUp(DigitalInput.UICancel) || this.stateMachine == null || this.stateMachine.ReturnToPreviousState())
      return;
    this.ReturnToPreviousScreen();
  }
}
