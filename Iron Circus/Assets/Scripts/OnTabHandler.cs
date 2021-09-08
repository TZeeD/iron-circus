// Decompiled with JetBrains decompiler
// Type: OnTabHandler
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class OnTabHandler : MonoBehaviour
{
  private InputService input;

  private void Start() => this.input = ImiServices.Instance.InputService;

  private void Update()
  {
    if (!this.input.GetButtonDown(DigitalInput.UINext) && !this.input.GetButtonDown(DigitalInput.UIPrevious) || !((Object) EventSystem.current.currentSelectedGameObject != (Object) null))
      return;
    Selectable componentInChildren = EventSystem.current.currentSelectedGameObject.GetComponentInChildren<Selectable>();
    if ((Object) componentInChildren == (Object) null)
      return;
    if (this.input.GetButtonDown(DigitalInput.UINext))
    {
      if (this.Select(componentInChildren.FindSelectableOnDown()))
        return;
      this.Select(componentInChildren.FindSelectableOnRight());
    }
    else
    {
      if (this.Select(componentInChildren.FindSelectableOnUp()))
        return;
      this.Select(componentInChildren.FindSelectableOnLeft());
    }
  }

  private bool Select(Selectable selectable)
  {
    if (!((Object) selectable != (Object) null) || !selectable.IsInteractable() || !selectable.isActiveAndEnabled)
      return false;
    selectable.Select();
    return true;
  }
}
