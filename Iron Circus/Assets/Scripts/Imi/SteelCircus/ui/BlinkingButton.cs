// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ui.BlinkingButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Imi.SteelCircus.ui
{
  [RequireComponent(typeof (Button))]
  public class BlinkingButton : MonoBehaviour, ISelectHandler, IEventSystemHandler, IDeselectHandler
  {
    [SerializeField]
    private Color a;
    [SerializeField]
    private Color b;
    [Space]
    [Tooltip("as in blinks per second.")]
    [SerializeField]
    private float frequency = 1f;
    private Button buttonReference;
    private bool isSelected;

    private void Start() => this.buttonReference = this.GetComponent<Button>();

    public void OnSelect(BaseEventData eventData) => this.isSelected = true;

    public void OnDeselect(BaseEventData data)
    {
      this.isSelected = false;
      this.SetHighlighted(this.a);
    }

    private void SetHighlighted(Color color)
    {
      ColorBlock colors = this.buttonReference.colors;
      colors.highlightedColor = color;
      this.buttonReference.colors = colors;
    }

    private void Update()
    {
      if (!this.isSelected)
        return;
      this.SetHighlighted(Color.Lerp(this.a, this.b, Mathf.PingPong(Time.time * this.frequency, 1f)));
    }
  }
}
