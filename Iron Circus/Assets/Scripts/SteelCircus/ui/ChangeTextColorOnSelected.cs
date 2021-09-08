// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ChangeTextColorOnSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.UI
{
  public class ChangeTextColorOnSelected : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IPointerEnterHandler,
    IPointerExitHandler,
    IDeselectHandler
  {
    public bool automaticallyDetermineColors;
    public List<TextMeshProUGUI> textObjects;
    public Color targetColor;
    public Color[] storedColors;

    private void Awake()
    {
      if (this.automaticallyDetermineColors)
        this.StoreColors();
      if (!((Object) EventSystem.current.currentSelectedGameObject == (Object) this.gameObject))
        return;
      this.SetColor();
    }

    public void SaveColors(Color[] colors) => this.storedColors = colors;

    public void StoreColors()
    {
      this.storedColors = new Color[this.textObjects.Count];
      for (int index = 0; index < this.textObjects.Count; ++index)
        this.storedColors[index] = this.textObjects[index].color;
    }

    public void SetColor()
    {
      for (int index = 0; index < this.textObjects.Count; ++index)
        this.textObjects[index].color = this.targetColor;
    }

    public void UnsetColor()
    {
      for (int index = 0; index < this.textObjects.Count; ++index)
        this.textObjects[index].color = this.storedColors[index];
    }

    public void OnSelect(BaseEventData eventData) => this.SetColor();

    public void OnPointerEnter(PointerEventData eventData) => this.SetColor();

    public void OnPointerExit(PointerEventData eventData) => this.UnsetColor();

    public void OnDeselect(BaseEventData eventData) => this.UnsetColor();
  }
}
