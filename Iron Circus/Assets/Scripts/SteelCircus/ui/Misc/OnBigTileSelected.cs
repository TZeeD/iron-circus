// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.OnBigTileSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
  public class OnBigTileSelected : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IDeselectHandler,
    IPointerEnterHandler,
    IPointerExitHandler
  {
    [SerializeField]
    private Image backgroundSelected;
    [SerializeField]
    private Image backgroundDeselected;
    [SerializeField]
    private RectTransform lockedGroup;
    [SerializeField]
    private RectTransform outline;
    [SerializeField]
    private RectTransform slashes;
    [SerializeField]
    private Text text;
    [SerializeField]
    private float zoomInDuration = 1f;
    [SerializeField]
    private float zoomOutDuration = 0.5f;
    [SerializeField]
    private float minScale = 1f;
    [SerializeField]
    private float maxScale = 1.2f;
    [SerializeField]
    private Material grayscaleMat;
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
      if (!((Object) this.grayscaleMat != (Object) null))
        return;
      if (this.button.interactable && (Object) this.lockedGroup != (Object) null)
      {
        this.lockedGroup.gameObject.SetActive(false);
      }
      else
      {
        this.backgroundDeselected.material = new Material(this.grayscaleMat);
        this.backgroundSelected.material = new Material(this.grayscaleMat);
        this.lockedGroup.gameObject.SetActive(true);
        this.backgroundDeselected.material.SetFloat("_EffectAmount", 1f);
        this.backgroundSelected.material.SetFloat("_EffectAmount", 1f);
        this.text.color = this.text.color.WithAlpha(0.25f);
        this.lockedGroup.gameObject.GetComponent<Image>().color = this.lockedGroup.gameObject.GetComponent<Image>().color.WithAlpha(0.25f);
      }
    }

    public void OnSelect(BaseEventData eventData) => this.SetButtonSelected();

    public void OnDeselect(BaseEventData eventData) => this.SetButtonDeselected();

    public void OnPointerEnter(PointerEventData eventData)
    {
      this.SetButtonSelected();
      this.GetComponent<Button>().Select();
    }

    public void OnPointerExit(PointerEventData eventData) => this.SetButtonDeselected();

    private void SetButtonDeselected()
    {
      if ((Object) this.button != (Object) null && !this.button.interactable)
        return;
      if (this.scaleCoroutine != null)
      {
        this.StopCoroutine(this.scaleCoroutine);
        this.scaleCoroutine = (Coroutine) null;
      }
      this.backgroundSelected.gameObject.SetActive(false);
      this.slashes.localPosition = (Vector3) this.slashInsidePos;
      if ((Object) this.normalFont != (Object) null)
        this.text.font = this.normalFont;
      else
        this.text.fontStyle = FontStyle.Normal;
      this.descaleCoroutine = this.StartCoroutine(this.DeScaleImage(this.zoomOutDuration));
    }

    private void SetButtonSelected()
    {
      if ((Object) this.button != (Object) null && !this.button.interactable)
        return;
      if (this.descaleCoroutine != null)
      {
        this.StopCoroutine(this.descaleCoroutine);
        this.descaleCoroutine = (Coroutine) null;
      }
      this.backgroundSelected.gameObject.SetActive(true);
      this.slashes.gameObject.SetActive(true);
      if ((Object) this.boldFont != (Object) null)
        this.text.font = this.boldFont;
      else
        this.text.fontStyle = FontStyle.Bold;
      this.slashes.localPosition = (Vector3) this.slashOutsidePos;
      this.scaleCoroutine = this.StartCoroutine(this.ScaleImage(this.zoomInDuration));
    }

    private IEnumerator ScaleImage(float duration)
    {
      for (float i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        float t = i / duration;
        this.backgroundSelected.rectTransform.localScale = Vector3.Lerp(this.backgroundSelected.rectTransform.localScale, new Vector3(this.maxScale, this.maxScale, 0.0f), t);
        this.backgroundDeselected.rectTransform.localScale = Vector3.Lerp(this.backgroundSelected.rectTransform.localScale, new Vector3(this.maxScale, this.maxScale, 0.0f), t);
        this.outline.localScale = Vector3.Lerp(this.outline.localScale, new Vector3(1f, 1f, 0.0f), t);
        this.slashes.localPosition = Vector3.Lerp(this.slashes.localPosition, (Vector3) this.slashInsidePos, t);
        yield return (object) null;
      }
    }

    private IEnumerator DeScaleImage(float duration)
    {
      for (float i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        float t = i / duration;
        this.backgroundSelected.rectTransform.localScale = Vector3.Lerp(this.backgroundSelected.rectTransform.localScale, new Vector3(this.minScale, this.minScale, 0.0f), t);
        this.backgroundDeselected.rectTransform.localScale = Vector3.Lerp(this.backgroundSelected.rectTransform.localScale, new Vector3(this.minScale, this.minScale, 0.0f), t);
        this.outline.localScale = Vector3.Lerp(this.outline.localScale, new Vector3(1.1f, 1.1f, 0.0f), t);
        this.slashes.localPosition = Vector3.Lerp(this.slashes.localPosition, (Vector3) this.slashOutsidePos, t);
        if ((Object) this.lockedGroup != (Object) null)
          this.lockedGroup.localScale = Vector3.Lerp(this.lockedGroup.localScale, new Vector3(this.minScale, this.minScale, 0.0f), t);
        yield return (object) null;
      }
      if ((Object) this.lockedGroup != (Object) null && !this.button.interactable)
        this.slashes.gameObject.SetActive(false);
    }
  }
}
