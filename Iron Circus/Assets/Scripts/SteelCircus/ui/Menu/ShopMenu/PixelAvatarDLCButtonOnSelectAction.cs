// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.ShopMenu.PixelAvatarDLCButtonOnSelectAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.UI.Menu.ShopMenu
{
  public class PixelAvatarDLCButtonOnSelectAction : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IPointerEnterHandler
  {
    [SerializeField]
    private Animator sheenAnimator;

    public void OnSelect(BaseEventData eventData) => this.sheenAnimator.SetTrigger("sheen");

    public void OnPointerEnter(PointerEventData eventData) => this.sheenAnimator.SetTrigger("sheen");
  }
}
