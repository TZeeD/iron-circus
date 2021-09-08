// Decompiled with JetBrains decompiler
// Type: PlayerFloorBallCatchDisplay
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

public class PlayerFloorBallCatchDisplay : MonoBehaviour
{
  public AnimationCurve scaleCurve;
  public AnimationCurve secondaryRadiusCurve;
  public float initialScale = 4f;
  public float animationDuration = 2f;
  private float animationCounter;
  public float outerAlpha = 0.8f;
  public float innerAlpha = 0.5f;
  private Material circleMaterial;
  private Team team;
  private ColorsConfig colorsConfig;

  private void Awake() => this.circleMaterial = this.GetComponent<Renderer>().material;

  public void Setup(ColorsConfig colorsConfig, Team team)
  {
    this.team = team;
    this.colorsConfig = colorsConfig;
    this.SetupMaterial();
  }

  private void SetupMaterial()
  {
    Color color1 = this.colorsConfig.MiddleColor(this.team);
    Color color2 = this.colorsConfig.LightColor(this.team);
    color1.a *= this.innerAlpha;
    color2.a *= this.outerAlpha;
    this.circleMaterial.color = color1;
    this.circleMaterial.SetColor("_Color2", color2);
  }

  private void Update()
  {
    if ((double) this.animationCounter <= 0.0)
      return;
    this.UpdateAnimation();
  }

  public void Animate()
  {
    this.animationCounter = this.animationDuration;
    this.UpdateAnimation();
  }

  private void UpdateAnimation()
  {
    this.animationCounter = Mathf.Max(this.animationCounter - Time.deltaTime, 0.0f);
    float time = (float) (1.0 - (double) this.animationCounter / (double) this.animationDuration);
    float num = this.scaleCurve.Evaluate(time) * this.initialScale;
    this.circleMaterial.SetFloat("_C2Radius", this.secondaryRadiusCurve.Evaluate(time));
    this.transform.localScale = Vector3.one * num;
  }
}
