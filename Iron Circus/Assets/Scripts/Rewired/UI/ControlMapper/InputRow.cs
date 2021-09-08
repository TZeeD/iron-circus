// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.InputRow
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  public class InputRow : MonoBehaviour
  {
    public Text label;
    private int rowIndex;
    private Action<int, ButtonInfo> inputFieldActivatedCallback;

    public ButtonInfo[] buttons { get; private set; }

    public void Initialize(
      int rowIndex,
      string label,
      Action<int, ButtonInfo> inputFieldActivatedCallback)
    {
      this.rowIndex = rowIndex;
      this.label.text = label;
      this.inputFieldActivatedCallback = inputFieldActivatedCallback;
      this.buttons = this.transform.GetComponentsInChildren<ButtonInfo>(true);
    }

    public void OnButtonActivated(ButtonInfo buttonInfo)
    {
      if (this.inputFieldActivatedCallback == null)
        return;
      this.inputFieldActivatedCallback(this.rowIndex, buttonInfo);
    }
  }
}
