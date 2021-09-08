// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.SelectedButtonColorChange
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
  public class SelectedButtonColorChange : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IDeselectHandler,
    IPointerEnterHandler,
    IPointerExitHandler
  {
    public Color deselectedColor = Color.white;
    public Color selectedColor = new Color(1f, 0.6196079f, 0.2901961f, 1f);
    [SerializeField]
    private GameObject slashes;
    private Text text;

    private void Awake() => this.text = this.GetComponentInChildren<Text>(true);

    public void OnSelect(BaseEventData eventData)
    {
      this.text.color = this.selectedColor;
      this.text.fontStyle = FontStyle.Bold;
      this.slashes.SetActive(true);
    }

    public void OnDeselect(BaseEventData eventData)
    {
      this.text.color = this.deselectedColor;
      this.text.fontStyle = FontStyle.Normal;
      this.slashes.SetActive(false);
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
      this.text.color = this.selectedColor;
      this.text.fontStyle = FontStyle.Bold;
      this.slashes.SetActive(true);
    }

    public void OnPointerExit(PointerEventData eventData)
    {
      this.text.color = this.deselectedColor;
      this.text.fontStyle = FontStyle.Normal;
      this.slashes.SetActive(false);
    }
  }
}
