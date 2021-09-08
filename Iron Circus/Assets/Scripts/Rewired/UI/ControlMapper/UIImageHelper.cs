// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.UIImageHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  [RequireComponent(typeof (Image))]
  public class UIImageHelper : MonoBehaviour
  {
    [SerializeField]
    private UIImageHelper.State enabledState;
    [SerializeField]
    private UIImageHelper.State disabledState;
    private bool currentState;

    public void SetEnabledState(bool newState)
    {
      this.currentState = newState;
      UIImageHelper.State state = newState ? this.enabledState : this.disabledState;
      if (state == null)
        return;
      Image component = this.gameObject.GetComponent<Image>();
      if ((UnityEngine.Object) component == (UnityEngine.Object) null)
        Debug.LogError((object) "Image is missing!");
      else
        state.Set(component);
    }

    public void SetEnabledStateColor(Color color) => this.enabledState.color = color;

    public void SetDisabledStateColor(Color color) => this.disabledState.color = color;

    public void Refresh()
    {
      UIImageHelper.State state = this.currentState ? this.enabledState : this.disabledState;
      Image component = this.gameObject.GetComponent<Image>();
      if ((UnityEngine.Object) component == (UnityEngine.Object) null)
        return;
      state.Set(component);
    }

    [Serializable]
    private class State
    {
      [SerializeField]
      public Color color;

      public void Set(Image image)
      {
        if ((UnityEngine.Object) image == (UnityEngine.Object) null)
          return;
        image.color = this.color;
      }
    }
  }
}
