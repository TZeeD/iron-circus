// Decompiled with JetBrains decompiler
// Type: SwitchButtonSprite
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SwitchButtonSprite : MonoBehaviour
{
  public DigitalInput actionType;
  public List<DigitalInput> optionalFallbackActionTypes;
  public bool hideForKBM;

  private void Start() => ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.ControllerChangedDelegate);

  private void OnEnable() => this.SetSprite();

  private void OnDestroy() => ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.ControllerChangedDelegate);

  private void ControllerChangedDelegate(InputSource inputSource) => this.SetSprite();

  public void SetSprite()
  {
    if (this.hideForKBM)
    {
      switch (ImiServices.Instance.InputService.GetLastInputSource())
      {
        case InputSource.Keyboard:
        case InputSource.Mouse:
          this.gameObject.GetComponent<Image>().enabled = false;
          break;
        default:
          this.gameObject.GetComponent<Image>().enabled = true;
          break;
      }
    }
    else
      this.gameObject.GetComponent<Image>().enabled = true;
    Sprite sprite1 = ImiServices.Instance.InputService.GetButtonSprites().GetButtonSprite(this.actionType);
    if ((UnityEngine.Object) sprite1 == (UnityEngine.Object) null)
    {
      bool flag = false;
      Sprite sprite2 = (Sprite) null;
      if (this.optionalFallbackActionTypes.Count > 0)
      {
        foreach (DigitalInput fallbackActionType in this.optionalFallbackActionTypes)
        {
          sprite2 = ImiServices.Instance.InputService.GetButtonSprite(fallbackActionType);
          if ((UnityEngine.Object) sprite2 != (UnityEngine.Object) null)
          {
            flag = true;
            break;
          }
        }
      }
      if (flag)
        sprite1 = sprite2;
    }
    else
      this.gameObject.GetComponent<Image>().color = new Color(1f, 1f, 1f, 1f);
    this.gameObject.GetComponent<Image>().sprite = sprite1;
  }
}
