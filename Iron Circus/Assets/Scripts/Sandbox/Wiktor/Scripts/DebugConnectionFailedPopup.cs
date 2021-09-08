// Decompiled with JetBrains decompiler
// Type: Sandbox.Wiktor.Scripts.DebugConnectionFailedPopup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using SteelCircus.UI.Popups;
using System;
using UnityEngine;
using UnityEngine.UI;

namespace Sandbox.Wiktor.Scripts
{
  public class DebugConnectionFailedPopup : MonoBehaviour
  {
    private void Start() => Events.Global.OnEventConnectionNotOk += new Events.EventConnectionNotOk(this.OnConnectionNotOk);

    private void OnConnectionNotOk(string message, string info)
    {
      Events.Global.OnEventConnectionNotOk -= new Events.EventConnectionNotOk(this.OnConnectionNotOk);
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup(message + "Description", "OK", title: message), new Action(this.GoBackToMenu), new Action(this.GoBackToMenu), (Action) null, (Action) null, (Selectable) null);
      Cursor.visible = true;
    }

    private void GoBackToMenu()
    {
      ImiServices.Instance.GoBackToMenu();
      PopupManager.Instance.HidePopup();
    }

    private void OnDestroy() => Events.Global.OnEventConnectionNotOk -= new Events.EventConnectionNotOk(this.OnConnectionNotOk);
  }
}
