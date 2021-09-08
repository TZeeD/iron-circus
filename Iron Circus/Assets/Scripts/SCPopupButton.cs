// Decompiled with JetBrains decompiler
// Type: SCPopupButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using System;
using TMPro;
using UnityEngine.Events;
using UnityEngine.UI;

public class SCPopupButton
{
  public Action action;
  public Button button;
  public TextMeshProUGUI buttonTextObject;
  public string buttonText;

  public SCPopupButton(Action action, string buttonText)
  {
    this.action = action;
    this.buttonText = buttonText;
  }

  public void SetButtonFunction(Button button, TextMeshProUGUI buttonTextObject)
  {
    this.button = button;
    this.buttonTextObject = buttonTextObject;
    if (!((UnityEngine.Object) buttonTextObject != (UnityEngine.Object) null) || !((UnityEngine.Object) button != (UnityEngine.Object) null))
      return;
    button.onClick.AddListener((UnityAction) (() => this.action()));
    if (this.buttonText.StartsWith("@"))
      buttonTextObject.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.buttonText);
    else
      buttonTextObject.text = this.buttonText;
  }
}
