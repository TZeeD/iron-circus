// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.ScreenFader
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
  public class ScreenFader : MonoBehaviour
  {
    [SerializeField]
    private GameObject panelGameObject;
    [SerializeField]
    private Image panel;

    public void Fade(float duration) => this.StartCoroutine(this.FadeIEnumerator(duration));

    public void FadeIn(float duration) => this.StartCoroutine(this.FadeInIEnumerator(duration));

    public void FadeOut(float duration) => this.StartCoroutine(this.FadeOutIEnumerator(duration));

    private IEnumerator FadeInIEnumerator(float duration)
    {
      for (float i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        this.panel.color = new Color(this.panel.color.r, this.panel.color.g, this.panel.color.b, i / duration);
        yield return (object) null;
      }
      this.panel.color = new Color(this.panel.color.r, this.panel.color.g, this.panel.color.b, 1f);
    }

    private IEnumerator FadeOutIEnumerator(float duration)
    {
      for (float i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        this.panel.color = new Color(this.panel.color.r, this.panel.color.g, this.panel.color.b, (float) (1.0 - (double) i / (double) duration));
        yield return (object) null;
      }
      this.panel.color = new Color(this.panel.color.r, this.panel.color.g, this.panel.color.b, 0.0f);
    }

    private IEnumerator FadeIEnumerator(float duration)
    {
      ScreenFader screenFader = this;
      yield return (object) screenFader.StartCoroutine(screenFader.FadeInIEnumerator(duration / 2f));
      yield return (object) screenFader.StartCoroutine(screenFader.FadeOutIEnumerator(duration / 2f));
    }
  }
}
