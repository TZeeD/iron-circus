// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.OnSmallTileSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
  public class OnSmallTileSelected : 
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
    private GameObject outline;
    [SerializeField]
    private Text text;
    [SerializeField]
    private RectTransform lockIcon;
    [SerializeField]
    private Font normalFont;
    [SerializeField]
    private Font boldFont;
    private Vector2 slashInsidePos = (Vector2) new Vector3(-20f, -20f);
    private Vector2 slashOutsidePos = (Vector2) new Vector3(-60f, -20f);
    private Coroutine scaleCoroutine;
    private Coroutine descaleCoroutine;
    private Button button;

    private void Start()
    {
      this.button = this.GetComponent<Button>();
      if (!((Object) this.lockIcon != (Object) null))
        return;
      if (this.button.interactable)
      {
        this.lockIcon.gameObject.SetActive(false);
      }
      else
      {
        this.lockIcon.gameObject.SetActive(true);
        this.text.color = this.text.color.WithAlpha(0.25f);
        this.lockIcon.gameObject.GetComponent<Image>().color = this.lockIcon.gameObject.GetComponent<Image>().color.WithAlpha(0.25f);
      }
    }

    public void OnSelect(BaseEventData eventData) => this.SetButtonSelected();

    public void OnDeselect(BaseEventData eventData) => this.SetButtonDeselected();

    public void OnPointerEnter(PointerEventData eventData)
    {
      if ((Object) this.button != (Object) null && !this.button.interactable)
        return;
      this.SetButtonSelected();
    }

    public void OnPointerExit(PointerEventData eventData)
    {
      if ((Object) this.button != (Object) null && !this.button.interactable)
        return;
      this.SetButtonDeselected();
    }

    public void SetButtonDeselected()
    {
      if ((Object) this.normalFont != (Object) null)
        this.text.font = this.normalFont;
      else
        this.text.fontStyle = FontStyle.Normal;
      this.outline.gameObject.SetActive(false);
    }

    private void SetButtonSelected()
    {
      if ((Object) this.boldFont != (Object) null)
        this.text.font = this.boldFont;
      else
        this.text.fontStyle = FontStyle.Bold;
      this.outline.gameObject.SetActive(true);
    }
  }
}
