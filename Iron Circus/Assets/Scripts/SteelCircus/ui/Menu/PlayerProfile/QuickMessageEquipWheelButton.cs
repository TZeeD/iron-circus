// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.PlayerProfile.QuickMessageEquipWheelButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.UI.Menu.PlayerProfile
{
  public class QuickMessageEquipWheelButton : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IPointerClickHandler
  {
    public QuickMessageEquipWheel equipWheel;
    public int buttonId;

    public void OnSelect(BaseEventData eventData) => this.equipWheel.SetLastSelected(this.buttonId);

    public void OnPointerClick(PointerEventData eventData) => this.equipWheel.SetLastSelected(this.buttonId);
  }
}
