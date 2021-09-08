// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ui.ShowOnSelect
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;

namespace Imi.SteelCircus.ui
{
  public class ShowOnSelect : MonoBehaviour, ISelectHandler, IEventSystemHandler, IDeselectHandler
  {
    public GameObject[] showOnSelect;

    public void OnSelect(BaseEventData eventData) => this.ShowObjects(true);

    public void OnDeselect(BaseEventData eventData) => this.ShowObjects(false);

    private void ShowObjects(bool show)
    {
      if (this.showOnSelect == null)
        return;
      foreach (GameObject gameObject in this.showOnSelect)
      {
        if ((Object) gameObject != (Object) null)
          gameObject.SetActive(show);
      }
    }
  }
}
