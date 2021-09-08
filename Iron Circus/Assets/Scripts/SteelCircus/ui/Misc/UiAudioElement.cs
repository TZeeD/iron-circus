// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.UiAudioElement
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
  public class UiAudioElement : 
    MonoBehaviour,
    ISubmitHandler,
    IEventSystemHandler,
    ISelectHandler,
    IPointerClickHandler
  {
    private Button button;
    private Slider slider;
    [SerializeField]
    [Header("Leave empty for generic confirm sound")]
    private string confirmAudioHookName;

    private void Start()
    {
      if (string.IsNullOrEmpty(this.confirmAudioHookName))
        this.confirmAudioHookName = "Confirm";
      this.button = this.GetComponent<Button>();
      this.slider = this.GetComponent<Slider>();
      if (!((Object) this.slider != (Object) null))
        return;
      this.slider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
    }

    public void OnSelect(BaseEventData eventData) => AudioController.Play("Hover");

    public void OnSubmit(BaseEventData eventData)
    {
      if ((Object) this.button == (Object) null)
        return;
      AudioController.Play(this.confirmAudioHookName);
    }

    public void OnSliderValueChange() => AudioController.Play("Hover");

    public void OnPointerClick(PointerEventData eventData)
    {
      if ((Object) this.button == (Object) null)
        return;
      AudioController.Play(this.confirmAudioHookName);
    }
  }
}
