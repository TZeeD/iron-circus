// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Popups.IPopup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine.UI;

namespace SteelCircus.UI.Popups
{
  public interface IPopup
  {
    void ShowPopup(
      PopupManager.Popup popupType,
      IPopupSettings popupSettings,
      Action action1 = null,
      Action action2 = null,
      Action action3 = null,
      Action onTimerEnd = null,
      Selectable selectAfterExit = null);

    void HidePopup();

    bool IsActive();
  }
}
