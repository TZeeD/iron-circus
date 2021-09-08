// Decompiled with JetBrains decompiler
// Type: MatchBallAnim
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Utils.Extensions;
using TMPro;
using UnityEngine;

public class MatchBallAnim : MonoBehaviour
{
  public TextMeshProUGUI text;
  [Header("Settings")]
  public AnimationCurve scaleCurve;
  public float duration;
  public float textScaleDuration;
  public float startScale;
  public float startSpacing;
  private float t;
  private float originalCharSpacing;

  private void OnEnable()
  {
    this.t = 0.0f;
    this.originalCharSpacing = this.text.characterSpacing;
  }

  private void Update()
  {
    if ((double) this.t >= (double) this.duration)
    {
      this.gameObject.SetActive(false);
    }
    else
    {
      float time = Mathf.Clamp01(this.t / this.textScaleDuration);
      float t = this.scaleCurve.Evaluate(time);
      this.text.transform.localScale = Vector3.one * MathExtensions.Interpolate(this.startScale, 1f, t);
      this.text.alpha = time;
      this.text.characterSpacing = MathExtensions.Interpolate(this.startSpacing, this.originalCharSpacing, t);
      this.t += Time.deltaTime;
    }
  }
}
