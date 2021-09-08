// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ScrollOnSelectedRemote
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.UI
{
  public class ScrollOnSelectedRemote : MonoBehaviour, ISelectHandler, IEventSystemHandler
  {
    public ScrollOnSelected scrollHelper;

    public void OnSelect(BaseEventData eventData)
    {
      if (!((Object) this.scrollHelper != (Object) null))
        return;
      this.scrollHelper.OnSelectRemote();
    }
  }
}
