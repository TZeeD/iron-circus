// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ui.BlinkingOutline
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Imi.SteelCircus.ui
{
  public class BlinkingOutline : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IDeselectHandler,
    IPointerEnterHandler,
    IPointerExitHandler
  {
    [SerializeField]
    private Outline outlineReference;
    [SerializeField]
    private Color a;
    [SerializeField]
    private Color b;
    [Space]
    [Tooltip("as in blinks per second.")]
    [SerializeField]
    private float frequency = 1f;
    private bool isSelected;
    private Color notSelectedColor;

    private void Start()
    {
      if ((Object) this.outlineReference == (Object) null)
      {
        Log.Error("Outline not set");
        this.enabled = false;
      }
      else
        this.notSelectedColor = this.outlineReference.effectColor;
    }

    public void OnSelect(BaseEventData eventData) => this.isSelected = true;

    public void OnDeselect(BaseEventData data)
    {
      this.isSelected = false;
      this.SetHighlightColor(this.notSelectedColor);
    }

    private void SetHighlightColor(Color color) => this.outlineReference.effectColor = color;

    private void Update()
    {
      if (!this.isSelected)
        return;
      this.SetHighlightColor(Color.Lerp(this.a, this.b, Mathf.PingPong(Time.time * this.frequency, 1f)));
    }

    public void OnPointerEnter(PointerEventData eventData) => this.isSelected = true;

    public void OnPointerExit(PointerEventData eventData)
    {
      this.isSelected = false;
      this.SetHighlightColor(this.notSelectedColor);
    }
  }
}
