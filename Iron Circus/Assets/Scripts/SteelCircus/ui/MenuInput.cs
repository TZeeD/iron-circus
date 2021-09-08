// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MenuInput
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using SteelCircus.UI.Popups;
using UnityEngine;

namespace SteelCircus.UI
{
  public class MenuInput : MonoBehaviour
  {
    private InputService input;
    public SimplePromptSwitch buttonPromts;

    private void Start() => this.input = ImiServices.Instance.InputService;

    private void Update()
    {
      bool flag = false;
      if ((Object) PopupManager.Instance != (Object) null)
        flag = PopupManager.Instance.IsActive();
      if (this.input.GetButtonDown(DigitalInput.UICancel) && !flag)
        this.buttonPromts.BackButtonInvoke();
      if (this.input.GetButtonDown(DigitalInput.UIMatchMakingLeave) && !flag && ImiServices.Instance.MatchmakingService.IsMatchmaking())
        ImiServices.Instance.MatchmakingService.CancelMatchmaking();
      if (!this.input.GetButtonDown(DigitalInput.UIShortcut) || flag)
        return;
      Debug.Log((object) "Got Button Prompt: UIShortcut");
      this.buttonPromts.ShortcutButtonInvoke();
    }
  }
}
