﻿// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.Window
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  [RequireComponent(typeof (CanvasGroup))]
  public class Window : MonoBehaviour
  {
    public Image backgroundImage;
    public GameObject content;
    private bool _initialized;
    private int _id = -1;
    private RectTransform _rectTransform;
    private Text _titleText;
    private List<Text> _contentText;
    private GameObject _defaultUIElement;
    private Action<int> _updateCallback;
    private Func<int, bool> _isFocusedCallback;
    private Window.Timer _timer;
    private CanvasGroup _canvasGroup;
    public UnityAction cancelCallback;
    private GameObject lastUISelection;

    public bool hasFocus => this._isFocusedCallback != null && this._isFocusedCallback(this._id);

    public int id => this._id;

    public RectTransform rectTransform
    {
      get
      {
        if ((UnityEngine.Object) this._rectTransform == (UnityEngine.Object) null)
          this._rectTransform = this.gameObject.GetComponent<RectTransform>();
        return this._rectTransform;
      }
    }

    public Text titleText => this._titleText;

    public List<Text> contentText => this._contentText;

    public GameObject defaultUIElement
    {
      get => this._defaultUIElement;
      set => this._defaultUIElement = value;
    }

    public Action<int> updateCallback
    {
      get => this._updateCallback;
      set => this._updateCallback = value;
    }

    public Window.Timer timer => this._timer;

    public int width
    {
      get => (int) this.rectTransform.sizeDelta.x;
      set
      {
        Vector2 sizeDelta = this.rectTransform.sizeDelta;
        sizeDelta.x = (float) value;
        this.rectTransform.sizeDelta = sizeDelta;
      }
    }

    public int height
    {
      get => (int) this.rectTransform.sizeDelta.y;
      set
      {
        Vector2 sizeDelta = this.rectTransform.sizeDelta;
        sizeDelta.y = (float) value;
        this.rectTransform.sizeDelta = sizeDelta;
      }
    }

    protected bool initialized => this._initialized;

    private void OnEnable() => this.StartCoroutine("OnEnableAsync");

    protected virtual void Update()
    {
      if (!this._initialized || !this.hasFocus)
        return;
      this.CheckUISelection();
      if (this._updateCallback == null)
        return;
      this._updateCallback(this._id);
    }

    public virtual void Initialize(int id, Func<int, bool> isFocusedCallback)
    {
      if (this._initialized)
      {
        Debug.LogError((object) "Window is already initialized!");
      }
      else
      {
        this._id = id;
        this._isFocusedCallback = isFocusedCallback;
        this._timer = new Window.Timer();
        this._contentText = new List<Text>();
        this._canvasGroup = this.GetComponent<CanvasGroup>();
        this._initialized = true;
      }
    }

    public void SetSize(int width, int height) => this.rectTransform.sizeDelta = new Vector2((float) width, (float) height);

    public void CreateTitleText(GameObject prefab, Vector2 offset) => this.CreateText(prefab, ref this._titleText, "Title Text", UIPivot.TopCenter, UIAnchor.TopHStretch, offset);

    public void CreateTitleText(GameObject prefab, Vector2 offset, string text)
    {
      this.CreateTitleText(prefab, offset);
      this.SetTitleText(text);
    }

    public void AddContentText(GameObject prefab, UIPivot pivot, UIAnchor anchor, Vector2 offset)
    {
      Text textComponent = (Text) null;
      this.CreateText(prefab, ref textComponent, "Content Text", pivot, anchor, offset);
      this._contentText.Add(textComponent);
    }

    public void AddContentText(
      GameObject prefab,
      UIPivot pivot,
      UIAnchor anchor,
      Vector2 offset,
      string text)
    {
      this.AddContentText(prefab, pivot, anchor, offset);
      this.SetContentText(text, this._contentText.Count - 1);
    }

    public void AddContentImage(GameObject prefab, UIPivot pivot, UIAnchor anchor, Vector2 offset) => this.CreateImage(prefab, "Image", pivot, anchor, offset);

    public void AddContentImage(
      GameObject prefab,
      UIPivot pivot,
      UIAnchor anchor,
      Vector2 offset,
      string text)
    {
      this.AddContentImage(prefab, pivot, anchor, offset);
    }

    public void CreateButton(
      GameObject prefab,
      UIPivot pivot,
      UIAnchor anchor,
      Vector2 offset,
      string buttonText,
      UnityAction confirmCallback,
      UnityAction cancelCallback,
      bool setDefault)
    {
      if ((UnityEngine.Object) prefab == (UnityEngine.Object) null)
        return;
      ButtonInfo buttonInfo;
      GameObject button = this.CreateButton(prefab, "Button", anchor, pivot, offset, out buttonInfo);
      if ((UnityEngine.Object) button == (UnityEngine.Object) null)
        return;
      UnityEngine.UI.Button component = button.GetComponent<UnityEngine.UI.Button>();
      if (confirmCallback != null)
        component.onClick.AddListener(confirmCallback);
      CustomButton customButton = component as CustomButton;
      if (cancelCallback != null && (UnityEngine.Object) customButton != (UnityEngine.Object) null)
        customButton.CancelEvent += cancelCallback;
      if ((UnityEngine.Object) buttonInfo.text != (UnityEngine.Object) null)
        buttonInfo.text.text = buttonText;
      if (!setDefault)
        return;
      this._defaultUIElement = button;
    }

    public string GetTitleText(string text) => (UnityEngine.Object) this._titleText == (UnityEngine.Object) null ? string.Empty : this._titleText.text;

    public void SetTitleText(string text)
    {
      if ((UnityEngine.Object) this._titleText == (UnityEngine.Object) null)
        return;
      this._titleText.text = text;
    }

    public string GetContentText(int index) => this._contentText == null || this._contentText.Count <= index || (UnityEngine.Object) this._contentText[index] == (UnityEngine.Object) null ? string.Empty : this._contentText[index].text;

    public float GetContentTextHeight(int index) => this._contentText == null || this._contentText.Count <= index || (UnityEngine.Object) this._contentText[index] == (UnityEngine.Object) null ? 0.0f : this._contentText[index].rectTransform.sizeDelta.y;

    public void SetContentText(string text, int index)
    {
      if (this._contentText == null || this._contentText.Count <= index || (UnityEngine.Object) this._contentText[index] == (UnityEngine.Object) null)
        return;
      this._contentText[index].text = text;
    }

    public void SetUpdateCallback(Action<int> callback) => this.updateCallback = callback;

    public virtual void TakeInputFocus()
    {
      if ((UnityEngine.Object) EventSystem.current == (UnityEngine.Object) null)
        return;
      EventSystem.current.SetSelectedGameObject(this._defaultUIElement);
      this.Enable();
    }

    public virtual void Enable() => this._canvasGroup.interactable = true;

    public virtual void Disable() => this._canvasGroup.interactable = false;

    public virtual void Cancel()
    {
      if (!this.initialized || this.cancelCallback == null)
        return;
      this.cancelCallback();
    }

    private void CreateText(
      GameObject prefab,
      ref Text textComponent,
      string name,
      UIPivot pivot,
      UIAnchor anchor,
      Vector2 offset)
    {
      if ((UnityEngine.Object) prefab == (UnityEngine.Object) null || (UnityEngine.Object) this.content == (UnityEngine.Object) null)
        return;
      if ((UnityEngine.Object) textComponent != (UnityEngine.Object) null)
      {
        Debug.LogError((object) ("Window already has " + name + "!"));
      }
      else
      {
        GameObject gameObject = UITools.InstantiateGUIObject<Text>(prefab, this.content.transform, name, (Vector2) pivot, anchor.min, anchor.max, offset);
        if ((UnityEngine.Object) gameObject == (UnityEngine.Object) null)
          return;
        textComponent = gameObject.GetComponent<Text>();
      }
    }

    private void CreateImage(
      GameObject prefab,
      string name,
      UIPivot pivot,
      UIAnchor anchor,
      Vector2 offset)
    {
      if ((UnityEngine.Object) prefab == (UnityEngine.Object) null || (UnityEngine.Object) this.content == (UnityEngine.Object) null)
        return;
      UITools.InstantiateGUIObject<Image>(prefab, this.content.transform, name, (Vector2) pivot, anchor.min, anchor.max, offset);
    }

    private GameObject CreateButton(
      GameObject prefab,
      string name,
      UIAnchor anchor,
      UIPivot pivot,
      Vector2 offset,
      out ButtonInfo buttonInfo)
    {
      buttonInfo = (ButtonInfo) null;
      if ((UnityEngine.Object) prefab == (UnityEngine.Object) null)
        return (GameObject) null;
      GameObject gameObject = UITools.InstantiateGUIObject<ButtonInfo>(prefab, this.content.transform, name, (Vector2) pivot, anchor.min, anchor.max, offset);
      if ((UnityEngine.Object) gameObject == (UnityEngine.Object) null)
        return (GameObject) null;
      buttonInfo = gameObject.GetComponent<ButtonInfo>();
      if ((UnityEngine.Object) gameObject.GetComponent<UnityEngine.UI.Button>() == (UnityEngine.Object) null)
      {
        Debug.Log((object) "Button prefab is missing Button component!");
        return (GameObject) null;
      }
      if (!((UnityEngine.Object) buttonInfo == (UnityEngine.Object) null))
        return gameObject;
      Debug.Log((object) "Button prefab is missing ButtonInfo component!");
      return (GameObject) null;
    }

    private IEnumerator OnEnableAsync()
    {
      yield return (object) 1;
      if (!((UnityEngine.Object) EventSystem.current == (UnityEngine.Object) null))
      {
        if ((UnityEngine.Object) this.defaultUIElement != (UnityEngine.Object) null)
          EventSystem.current.SetSelectedGameObject(this.defaultUIElement);
        else
          EventSystem.current.SetSelectedGameObject((GameObject) null);
      }
    }

    private void CheckUISelection()
    {
      if (!this.hasFocus || (UnityEngine.Object) EventSystem.current == (UnityEngine.Object) null)
        return;
      if ((UnityEngine.Object) EventSystem.current.currentSelectedGameObject == (UnityEngine.Object) null)
        this.RestoreDefaultOrLastUISelection();
      this.lastUISelection = EventSystem.current.currentSelectedGameObject;
    }

    private void RestoreDefaultOrLastUISelection()
    {
      if (!this.hasFocus)
        return;
      if ((UnityEngine.Object) this.lastUISelection == (UnityEngine.Object) null || !this.lastUISelection.activeInHierarchy)
        this.SetUISelection(this._defaultUIElement);
      else
        this.SetUISelection(this.lastUISelection);
    }

    private void SetUISelection(GameObject selection)
    {
      if ((UnityEngine.Object) EventSystem.current == (UnityEngine.Object) null)
        return;
      EventSystem.current.SetSelectedGameObject(selection);
    }

    public class Timer
    {
      private bool _started;
      private float end;

      public bool started => this._started;

      public bool finished
      {
        get
        {
          if (!this.started || (double) Time.realtimeSinceStartup < (double) this.end)
            return false;
          this._started = false;
          return true;
        }
      }

      public float remaining => !this._started ? 0.0f : this.end - Time.realtimeSinceStartup;

      public void Start(float length)
      {
        this.end = Time.realtimeSinceStartup + length;
        this._started = true;
      }

      public void Stop() => this._started = false;
    }
  }
}
