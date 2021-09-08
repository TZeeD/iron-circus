// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.CustomMatchOnBotButtonSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.UI.Menu
{
  public class CustomMatchOnBotButtonSelected : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IDeselectHandler,
    ISubmitHandler,
    IPointerDownHandler
  {
    public CustomLobbyBotTeamAssignButton botPanel;

    public void OnSelect(BaseEventData eventData) => this.botPanel.ShowBorder(true);

    public void OnDeselect(BaseEventData eventData) => this.botPanel.ShowBorder(false);

    public void OnSubmit(BaseEventData eventData) => this.botPanel.RemoveFromTeam();

    public void OnPointerDown(PointerEventData eventData) => this.botPanel.RemoveFromTeam();
  }
}
