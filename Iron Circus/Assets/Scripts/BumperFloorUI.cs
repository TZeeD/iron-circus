// Decompiled with JetBrains decompiler
// Type: BumperFloorUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;

public class BumperFloorUI : MonoBehaviour
{
  public Transform hitParent;
  public ParticleSystem particles;
  public float hitAnimationDuration = 0.3f;
  public Transform hitCircle;
  public float hitCircleScale = 4f;
  public AnimationCurve hitCircleCurve;
  public Gradient hitCircleGradient;
  private Material hitCircleMat;
  public Transform hitArrow;
  public float hitArrowScale = 4f;
  public AnimationCurve hitArrowShapeCurve;
  public AnimationCurve hitArrowScaleCurve;
  public Gradient hitArrowGradient;
  private Material hitArrowMat;

  private void Awake()
  {
    this.hitCircleMat = this.hitCircle.GetComponent<MeshRenderer>().material;
    this.hitCircle.localScale = Vector3.one * (1f / 1000f);
    this.hitArrowMat = this.hitArrow.GetComponent<MeshRenderer>().material;
    this.hitArrow.localScale = Vector3.one * (1f / 1000f);
  }

  public void OnHit(float angle)
  {
    this.hitParent.localEulerAngles = new Vector3(0.0f, -angle, 0.0f);
    this.particles.Emit(60);
    this.StopAllCoroutines();
    this.StartCoroutine(this.OnHitCR());
  }

  private IEnumerator OnHitCR()
  {
    float counter = 0.0f;
    while ((double) counter < (double) this.hitAnimationDuration)
    {
      counter += Time.deltaTime;
      float time = Mathf.Min(counter / this.hitAnimationDuration, 1f);
      this.hitCircle.localScale = Vector3.one * this.hitCircleCurve.Evaluate(time) * this.hitCircleScale;
      this.hitCircleMat.color = this.hitCircleGradient.Evaluate(time);
      this.hitArrow.localScale = Vector3.one * this.hitArrowScaleCurve.Evaluate(time) * this.hitArrowScale;
      this.hitArrowMat.color = this.hitArrowGradient.Evaluate(time);
      this.hitArrowMat.SetFloat("_Threshold", this.hitArrowShapeCurve.Evaluate(time));
      yield return (object) null;
    }
  }
}
