// Decompiled with JetBrains decompiler
// Type: SteelCircus.Tutorial.TutorialTextBox
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.Tutorial
{
  public class TutorialTextBox : MonoBehaviour
  {
    [SerializeField]
    private GameObject root;
    [SerializeField]
    private Transform boxParent;
    [SerializeField]
    private Image boxBG;
    [SerializeField]
    private Image boxGlow;
    [SerializeField]
    private Image boxOutline;
    [SerializeField]
    private Image illustration;
    [SerializeField]
    private GameObject illustrationSpacer;
    [SerializeField]
    private Image buttonIcon;
    [SerializeField]
    private GameObject buttonSpacer;
    [SerializeField]
    private TMP_Text headline;
    [SerializeField]
    private TMP_Text mainText;
    [SerializeField]
    private RectTransform mainTextPanel;
    [SerializeField]
    private GameObject contents;
    [SerializeField]
    private GameObject contentsPlaceholder;
    [SerializeField]
    private Color infoBGColor;
    [SerializeField]
    private Color errorBGColor;
    [SerializeField]
    private Color infoOutlineColor;
    [SerializeField]
    private Color errorOutlineColor;
    private Color currentBGColor;
    private Color currentOutlineColor;
    private const float contentPadding = 16f;
    private const float minContentTargetWidth = 48f;
    private float contentTargetWidth;
    private float stateAnimationCounter;
    [SerializeField]
    private float stateAnimationDurationPer100Px = 0.3f;
    [SerializeField]
    private AnimationCurve showWidthCurve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private AnimationCurve hideWidthCurve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private AnimationCurve showGlowCurve = AnimationCurve.Constant(0.0f, 1f, 0.0f);
    [SerializeField]
    private AnimationCurve hideGlowCurve = AnimationCurve.Constant(0.0f, 1f, 0.0f);
    public Sprite tmpDebugTex;
    private const int bigBoxHeight = 156;
    private const int smallBoxHeight = 86;
    [SerializeField]
    private Sprite bigBoxBGTex;
    [SerializeField]
    private Sprite bigBoxGlowTex;
    [SerializeField]
    private Sprite bigBoxOutlineTex;
    [SerializeField]
    private Sprite smallBoxBGTex;
    [SerializeField]
    private Sprite smallBoxGlowTex;
    [SerializeField]
    private Sprite smallBoxOutlineTex;
    [SerializeField]
    private float errorPulseMaxScale = 1.1f;
    [SerializeField]
    private float errorPulseFrequency = 0.3f;
    [SerializeField]
    private AnimationCurve errorPulseCurve = AnimationCurve.Linear(0.0f, 1f, 1f, 0.0f);
    [SerializeField]
    private float buttonPulseMaxScale = 1.1f;
    [SerializeField]
    private float buttonPulseMinScale = 0.9f;
    [SerializeField]
    private float buttonPulseFrequency = 0.3f;
    [SerializeField]
    private AnimationCurve buttonPulseCurve = AnimationCurve.Linear(0.0f, 1f, 1f, 0.0f);
    private DigitalInput currentButtonIcon;
    public Action onShow;
    private TutorialTextBox.State state = TutorialTextBox.State.Idle;
    private TutorialTextBox.QueuedMessage currentQueuedMessage;
    private TutorialTextBox.MessageType currentMsgType;

    public float Width => this.contentTargetWidth;

    public float Height => this.root.GetComponent<RectTransform>().sizeDelta.y;

    private void Awake()
    {
      this.Hide(false);
      ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.LastInputSourceChanged);
      this.UpdateIcon();
    }

    private void OnDestroy() => ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.LastInputSourceChanged);

    private void LastInputSourceChanged(InputSource inputSource) => this.UpdateIcon();

    private void UpdateIcon() => this.buttonIcon.sprite = ImiServices.Instance.InputService.GetButtonSprites().GetButtonSprite(this.currentButtonIcon);

    public void ShowPreviousMessage()
    {
      this.root.SetActive(true);
      this.state = TutorialTextBox.State.Showing;
      this.boxParent.localScale = Vector3.one;
      this.stateAnimationCounter = 0.0f;
      this.currentQueuedMessage = (TutorialTextBox.QueuedMessage) null;
      this.UpdateShowing();
      if (this.onShow == null)
        return;
      this.onShow();
    }

    public void Show(
      string headline,
      string mainText = null,
      DigitalInput inputType = DigitalInput.None,
      Sprite illustration = null,
      TutorialTextBox.MessageType msgType = TutorialTextBox.MessageType.Info)
    {
      if (headline.Substring(0, 1) == "@")
        headline = ImiServices.Instance.LocaService.GetLocalizedValue(headline);
      if (mainText != "" && mainText.Substring(0, 1) == "@")
        mainText = ImiServices.Instance.LocaService.GetLocalizedValue(mainText);
      this.currentQueuedMessage = new TutorialTextBox.QueuedMessage();
      this.currentQueuedMessage.headline = headline;
      this.currentQueuedMessage.mainText = mainText;
      this.currentQueuedMessage.msgType = msgType;
      this.currentQueuedMessage.illustration = illustration;
      this.currentQueuedMessage.inputType = inputType;
      if (this.state == TutorialTextBox.State.Disabled)
      {
        this.SetState(TutorialTextBox.State.Showing);
      }
      else
      {
        if (this.state != TutorialTextBox.State.Idle && this.state != TutorialTextBox.State.Showing)
          return;
        this.SetState(TutorialTextBox.State.Hiding);
      }
    }

    public void Hide(bool animate = true)
    {
      this.currentQueuedMessage = (TutorialTextBox.QueuedMessage) null;
      if (!animate)
      {
        this.SetState(TutorialTextBox.State.Disabled);
      }
      else
      {
        if (this.state == TutorialTextBox.State.Hiding)
          return;
        this.SetState(TutorialTextBox.State.Hiding);
      }
    }

    private void SetState(TutorialTextBox.State newState)
    {
      this.state = newState;
      switch (newState)
      {
        case TutorialTextBox.State.Disabled:
          this.root.SetActive(false);
          if (this.currentQueuedMessage == null)
            break;
          this.SetState(TutorialTextBox.State.Showing);
          break;
        case TutorialTextBox.State.Showing:
          this.root.SetActive(true);
          this.boxParent.localScale = Vector3.one;
          this.stateAnimationCounter = 0.0f;
          this.ApplyMessage(this.currentQueuedMessage);
          this.currentQueuedMessage = (TutorialTextBox.QueuedMessage) null;
          this.UpdateShowing();
          if (this.onShow == null)
            break;
          this.onShow();
          break;
        case TutorialTextBox.State.Idle:
          this.stateAnimationCounter = 0.0f;
          break;
        case TutorialTextBox.State.Hiding:
          this.boxParent.localScale = Vector3.one;
          this.stateAnimationCounter = 0.0f;
          this.UpdateHiding();
          break;
      }
    }

    private void ApplyMessage(TutorialTextBox.QueuedMessage msg)
    {
      this.currentMsgType = msg.msgType;
      HorizontalLayoutGroup component1 = this.contents.GetComponent<HorizontalLayoutGroup>();
      RectOffset padding = component1.padding;
      padding.left = padding.right = 16;
      component1.padding = padding;
      if (msg.msgType == TutorialTextBox.MessageType.Info)
      {
        this.currentOutlineColor = this.infoOutlineColor;
        this.currentBGColor = this.infoBGColor;
      }
      else
      {
        this.currentOutlineColor = this.errorOutlineColor;
        this.currentBGColor = this.errorBGColor;
      }
      this.boxBG.color = this.currentBGColor;
      this.currentButtonIcon = msg.inputType;
      this.UpdateIcon();
      this.buttonIcon.gameObject.SetActive((uint) msg.inputType > 0U);
      this.buttonSpacer.gameObject.SetActive((uint) msg.inputType > 0U);
      this.illustration.sprite = msg.illustration;
      this.illustration.gameObject.SetActive((UnityEngine.Object) msg.illustration != (UnityEngine.Object) null);
      this.illustrationSpacer.gameObject.SetActive((UnityEngine.Object) msg.illustration != (UnityEngine.Object) null);
      if ((UnityEngine.Object) msg.illustration != (UnityEngine.Object) null)
      {
        RectTransform component2 = this.illustration.GetComponent<RectTransform>();
        float y = 130f;
        Vector2 vector2 = new Vector2((float) msg.illustration.texture.width * y / (float) msg.illustration.texture.height, y);
        component2.sizeDelta = vector2;
      }
      this.headline.text = msg.headline;
      this.mainText.text = msg.mainText;
      LayoutRebuilder.ForceRebuildLayoutImmediate(this.contents.GetComponent<RectTransform>());
      this.headline.ForceMeshUpdate(true);
      this.headline.rectTransform.sizeDelta = new Vector2(this.headline.renderedWidth, this.headline.rectTransform.sizeDelta.y);
      int a = (int) this.headline.renderedWidth;
      if (msg.mainText != "")
        a = Mathf.Max(a, 300);
      if (this.buttonIcon.IsActive())
        a = a + (int) this.buttonIcon.rectTransform.sizeDelta.x + (int) this.buttonSpacer.GetComponent<RectTransform>().sizeDelta.x;
      do
      {
        this.mainTextPanel.sizeDelta = new Vector2((float) a, this.mainTextPanel.sizeDelta.y);
        LayoutRebuilder.ForceRebuildLayoutImmediate(this.mainTextPanel);
        this.mainText.ForceMeshUpdate(true);
        a += 100;
      }
      while (this.mainText.textInfo.lineCount >= 4 && a < 1500);
      if (msg.mainText == "")
      {
        this.boxBG.sprite = this.smallBoxBGTex;
        this.boxGlow.sprite = this.smallBoxGlowTex;
        this.boxOutline.sprite = this.smallBoxOutlineTex;
        Vector2 sizeDelta = this.root.GetComponent<RectTransform>().sizeDelta;
        sizeDelta.y = 86f;
        this.root.GetComponent<RectTransform>().sizeDelta = sizeDelta;
      }
      else
      {
        this.boxBG.sprite = this.bigBoxBGTex;
        this.boxGlow.sprite = this.bigBoxGlowTex;
        this.boxOutline.sprite = this.bigBoxOutlineTex;
        Vector2 sizeDelta = this.root.GetComponent<RectTransform>().sizeDelta;
        sizeDelta.y = 156f;
        this.root.GetComponent<RectTransform>().sizeDelta = sizeDelta;
      }
      LayoutRebuilder.ForceRebuildLayoutImmediate(this.contents.GetComponent<RectTransform>());
      this.contents.GetComponent<RectTransform>().ForceUpdateRectTransforms();
      Canvas.ForceUpdateCanvases();
      this.contentTargetWidth = this.contents.GetComponent<RectTransform>().sizeDelta.x;
    }

    private void Update()
    {
      switch (this.state)
      {
        case TutorialTextBox.State.Showing:
          this.UpdateShowing();
          break;
        case TutorialTextBox.State.Idle:
          this.UpdateIdle();
          break;
        case TutorialTextBox.State.Hiding:
          this.UpdateHiding();
          break;
      }
      this.UpdateDebugKeys();
    }

    private void UpdateIdle()
    {
      this.stateAnimationCounter += Time.deltaTime;
      if (this.currentMsgType == TutorialTextBox.MessageType.Error)
        this.boxParent.localScale = Vector3.one * Mathf.Lerp(1f, this.errorPulseMaxScale, this.errorPulseCurve.Evaluate(this.stateAnimationCounter / this.errorPulseFrequency % 1f));
      if (!this.buttonIcon.gameObject.activeSelf)
        return;
      this.buttonIcon.transform.localScale = Vector3.one * Mathf.Lerp(this.buttonPulseMinScale, this.buttonPulseMaxScale, this.buttonPulseCurve.Evaluate(this.stateAnimationCounter / this.buttonPulseFrequency % 1f));
    }

    private void UpdateShowing()
    {
      this.stateAnimationCounter = Mathf.Clamp01(this.stateAnimationCounter + Time.deltaTime / (float) ((double) this.stateAnimationDurationPer100Px * (double) Mathf.Sqrt(this.contentTargetWidth) / 100.0));
      this.SetRelativeBoxWidth(this.showWidthCurve.Evaluate(this.stateAnimationCounter));
      this.boxGlow.color = new Color(1f, 1f, 1f, this.showGlowCurve.Evaluate(this.stateAnimationCounter));
      this.boxOutline.color = Color.Lerp(this.currentOutlineColor, Color.white, this.showGlowCurve.Evaluate(this.stateAnimationCounter));
      if ((double) this.stateAnimationCounter < 1.0)
        return;
      this.SetState(TutorialTextBox.State.Idle);
    }

    private void UpdateHiding()
    {
      this.stateAnimationCounter = Mathf.Clamp01(this.stateAnimationCounter + Time.deltaTime / (float) ((double) this.stateAnimationDurationPer100Px * (double) Mathf.Sqrt(this.contentTargetWidth) / 100.0));
      this.SetRelativeBoxWidth(this.hideWidthCurve.Evaluate(this.stateAnimationCounter));
      this.boxGlow.color = new Color(1f, 1f, 1f, this.hideGlowCurve.Evaluate(this.stateAnimationCounter));
      this.boxOutline.color = Color.Lerp(this.currentOutlineColor, Color.white, this.hideGlowCurve.Evaluate(this.stateAnimationCounter));
      if ((double) this.stateAnimationCounter < 1.0)
        return;
      this.SetState(TutorialTextBox.State.Disabled);
    }

    private void SetRelativeBoxWidth(float percent)
    {
      float num = Mathf.LerpUnclamped((float) (16.0 - (double) this.contentTargetWidth / 2.0 + 24.0), 16f, percent);
      HorizontalLayoutGroup component = this.contents.GetComponent<HorizontalLayoutGroup>();
      RectOffset padding = component.padding;
      padding.left = padding.right = (int) num;
      component.padding = padding;
      LayoutRebuilder.MarkLayoutForRebuild(this.contents.GetComponent<RectTransform>());
    }

    private void UpdateDebugKeys()
    {
    }

    public enum MessageType
    {
      Info,
      Error,
    }

    private enum State
    {
      Disabled,
      Showing,
      Idle,
      Hiding,
    }

    private class QueuedMessage
    {
      public string headline;
      public string mainText;
      public TutorialTextBox.MessageType msgType;
      public Sprite illustration;
      public DigitalInput inputType;
    }
  }
}
