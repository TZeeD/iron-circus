// Decompiled with JetBrains decompiler
// Type: UIFadeInImageOnEnable
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class UIFadeInImageOnEnable : MonoBehaviour
{
  public float fadeInDuration;
  private Graphic graphic;

  private void OnEnable()
  {
    this.graphic = this.GetComponent<Graphic>();
    this.StartCoroutine(this.Fade());
  }

  private IEnumerator Fade()
  {
    float t = 0.0f;
    Color c = this.graphic.color;
    while ((double) t < (double) this.fadeInDuration)
    {
      c.a = t / this.fadeInDuration;
      this.graphic.color = c;
      t += Time.deltaTime;
      yield return (object) null;
    }
    c.a = 1f;
    this.graphic.color = c;
  }
}
