// Decompiled with JetBrains decompiler
// Type: TutorialTextAttachedToPlayer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TutorialTextAttachedToPlayer : MonoBehaviour
{
  [SerializeField]
  private Image buttonIconInput1;
  [SerializeField]
  private Image buttonIconInput2;
  [SerializeField]
  private TMP_Text header;
  [SerializeField]
  private TMP_Text text;
  private DigitalInput input1Type;
  private DigitalInput input2Type;
  [SerializeField]
  private GameObject floorContainer;

  private void Start()
  {
    ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.LastInputSourceChanged);
    this.UpdateIcon();
  }

  private void OnDestroy() => ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.LastInputSourceChanged);

  private void LastInputSourceChanged(InputSource inputSource) => this.UpdateIcon();

  private void OnEnable() => this.floorContainer.SetActive(true);

  private void OnDisable()
  {
    if (!((UnityEngine.Object) this.floorContainer != (UnityEngine.Object) null))
      return;
    this.floorContainer.SetActive(false);
  }

  public void SetContent(
    string headerTxt,
    string mainTxt,
    DigitalInput input = DigitalInput.None,
    DigitalInput input2 = DigitalInput.None)
  {
    this.input1Type = input;
    this.input2Type = input2;
    this.header.text = ImiServices.Instance.LocaService.GetLocalizedValue(headerTxt);
    this.text.text = ImiServices.Instance.LocaService.GetLocalizedValue(mainTxt);
    this.UpdateIcon();
  }

  private void UpdateIcon()
  {
    ButtonSpriteSet buttonSprites = ImiServices.Instance.InputService.GetButtonSprites();
    this.buttonIconInput1.gameObject.SetActive((uint) this.input1Type > 0U);
    this.buttonIconInput1.sprite = buttonSprites.GetButtonSprite(this.input1Type);
    this.buttonIconInput2.gameObject.SetActive((uint) this.input2Type > 0U);
    this.buttonIconInput2.sprite = buttonSprites.GetButtonSprite(this.input2Type);
  }
}
