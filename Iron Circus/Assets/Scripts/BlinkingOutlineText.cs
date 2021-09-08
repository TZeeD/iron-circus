// Decompiled with JetBrains decompiler
// Type: BlinkingOutlineText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using UnityEngine;
using UnityEngine.UI;

public class BlinkingOutlineText : MonoBehaviour
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

  private void Start()
  {
    if (!((Object) this.outlineReference == (Object) null))
      return;
    Log.Error("Outline not set");
    this.enabled = false;
  }

  private void SetHighlightColor(Color color) => this.outlineReference.effectColor = color;

  private void Update() => this.SetHighlightColor(Color.Lerp(this.a, this.b, Mathf.PingPong(Time.time * this.frequency, 1f)));
}
