// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.ShowButtonPromptOnSelect
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
  [RequireComponent(typeof (Selectable))]
  public class ShowButtonPromptOnSelect : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IDeselectHandler
  {
    [SerializeField]
    private GameObject buttonPrompt;

    private void Awake() => this.buttonPrompt.SetActive(false);

    public void OnSelect(BaseEventData eventData) => this.buttonPrompt.SetActive(true);

    public void OnDeselect(BaseEventData eventData) => this.buttonPrompt.SetActive(false);
  }
}
