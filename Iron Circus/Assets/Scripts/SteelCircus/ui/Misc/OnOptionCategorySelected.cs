// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.OnOptionCategorySelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
  public class OnOptionCategorySelected : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IDeselectHandler,
    IPointerEnterHandler,
    IPointerExitHandler
  {
    [SerializeField]
    private GameObject selectedBackground;
    [SerializeField]
    private RectTransform lockedGroup;
    [SerializeField]
    private TextMeshProUGUI text;
    private Button button;

    private void Start()
    {
      this.button = this.GetComponent<Button>();
      if (this.button.interactable && (Object) this.lockedGroup != (Object) null)
      {
        this.lockedGroup.gameObject.SetActive(false);
        this.text.color = this.text.color.WithAlpha(1f);
      }
      else
      {
        this.lockedGroup.gameObject.SetActive(true);
        this.text.color = this.text.color.WithAlpha(0.25f);
      }
    }

    public void OnSelect(BaseEventData eventData)
    {
    }

    public void OnDeselect(BaseEventData eventData)
    {
    }

    public void OnPointerEnter(PointerEventData eventData) => this.Select();

    public void OnPointerExit(PointerEventData eventData) => this.Deselect();

    private void Select() => this.selectedBackground.SetActive(true);

    private void Deselect() => this.selectedBackground.SetActive(false);

    public void SetSelectedState() => this.Select();

    public void SetDeselectedState() => this.Deselect();
  }
}
