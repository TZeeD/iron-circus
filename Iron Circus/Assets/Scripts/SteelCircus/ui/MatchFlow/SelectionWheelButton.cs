// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MatchFlow.SelectionWheelButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.MatchFlow
{
  [RequireComponent(typeof (Button))]
  public class SelectionWheelButton : 
    MonoBehaviour,
    IPointerEnterHandler,
    IEventSystemHandler,
    IPointerExitHandler
  {
    [SerializeField]
    private int buttonIndex;
    [SerializeField]
    private BaseSelectionWheel selectionWheel;

    public void OnPointerEnter(PointerEventData eventData) => this.selectionWheel.SetSelectedIndex(this.buttonIndex);

    public void OnPointerExit(PointerEventData eventData) => this.selectionWheel.SetSelectedIndex(-1);
  }
}
