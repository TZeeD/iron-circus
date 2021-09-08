// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ui.UiScreenStateMachine
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Imi.SteelCircus.ui
{
  public class UiScreenStateMachine
  {
    public Animation animation;
    public UIScreenState[] states;
    public int entryState;
    private UIScreenState currentState;
    private CanvasGroup canvasGroup;

    public UiScreenStateMachine(
      CanvasGroup canvasGroup,
      Animation animation,
      UIScreenState[] states,
      int entryState)
    {
      this.canvasGroup = canvasGroup;
      this.animation = animation;
      this.states = states;
      this.entryState = entryState;
      this.SetupStateButtons();
    }

    public void Start() => this.EnterState(this.states[this.entryState]);

    public void Reset()
    {
      this.currentState = (UIScreenState) null;
      foreach (UIScreenState state in this.states)
        state.previousState = (UIScreenState) null;
      this.Start();
    }

    private void SetupStateButtons()
    {
      foreach (UIScreenState state1 in this.states)
      {
        UIScreenState state = state1;
        foreach (Button enterButton in state.enterButtons)
        {
          if ((Object) enterButton != (Object) null)
            enterButton.onClick.AddListener((UnityAction) (() => this.EnterState(state)));
          else
            Debug.LogWarning((object) "<color=red>There is an empty slot for an 'enter UIScreen state button', did you forget to set a button to enter the state?!</color>", (Object) this.canvasGroup.gameObject);
        }
      }
    }

    private void EnterState(UIScreenState newState, bool returningToNewState = false)
    {
      UIScreenState currentState = this.currentState;
      this.currentState = newState;
      if (!returningToNewState)
      {
        if (currentState != null)
          currentState.lastSelected = EventSystem.current.currentSelectedGameObject.GetComponent<Selectable>();
        newState.previousState = currentState;
      }
      else
        currentState.previousState = (UIScreenState) null;
      this.canvasGroup.interactable = false;
      this.animation.Play(newState.animation.name);
      if (!((Object) newState.selectOnEnter != (Object) null))
        return;
      this.animation.gameObject.GetComponent<UIScreen>().StartCoroutine(this.FinishStateChange(!returningToNewState || !((Object) newState.lastSelected != (Object) null) ? (Selectable) newState.selectOnEnter : newState.lastSelected));
    }

    private IEnumerator FinishStateChange(Selectable select)
    {
      while (this.animation.isPlaying)
        yield return (object) new WaitForEndOfFrame();
      this.canvasGroup.interactable = true;
      if ((Object) select != (Object) null)
        select.Select();
    }

    public bool ReturnToPreviousState()
    {
      if (this.currentState == null || this.currentState.previousState == null)
        return false;
      this.EnterState(this.currentState.previousState, true);
      return true;
    }
  }
}
