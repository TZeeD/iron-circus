// Decompiled with JetBrains decompiler
// Type: UIScaleToParentOverTime
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;

public class UIScaleToParentOverTime : MonoBehaviour
{
  public float startScale = 2f;
  public AnimationCurve scaleCurve;
  public float duration;
  public bool loop;

  private void OnEnable() => this.StartCoroutine(this.Scale());

  private void OnDisable() => this.StopAllCoroutines();

  private IEnumerator Scale()
  {
    UIScaleToParentOverTime toParentOverTime = this;
    float t = 0.0f;
    while ((double) t < (double) toParentOverTime.duration)
    {
      float time = t / toParentOverTime.duration;
      float num = Mathf.Lerp(toParentOverTime.startScale, 1f, toParentOverTime.scaleCurve.Evaluate(time));
      Rect rect = (toParentOverTime.transform.parent as RectTransform).rect;
      rect.width *= num;
      rect.height *= num;
      (toParentOverTime.transform as RectTransform).sizeDelta = new Vector2(rect.width, rect.height);
      t += Time.deltaTime;
      yield return (object) null;
    }
    if (toParentOverTime.loop)
      toParentOverTime.StartCoroutine(toParentOverTime.Scale());
  }
}
