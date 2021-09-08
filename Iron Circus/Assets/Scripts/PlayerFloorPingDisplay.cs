// Decompiled with JetBrains decompiler
// Type: PlayerFloorPingDisplay
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

public class PlayerFloorPingDisplay : MonoBehaviour
{
  [Header("Line")]
  public Transform lineParent;
  public Transform lineTransform;
  public SpriteRenderer lineSprite;
  public AnimationCurve linePosCurve;
  public AnimationCurve lineLengthCurve;
  public float lineLengthBase = 2f;
  public float lineLengthDistScale = 0.2f;
  public float lineAlpha = 0.3f;
  [Header("Circle")]
  public MeshRenderer circle;
  public AnimationCurve scaleCurve;
  public AnimationCurve outlineRadiusCurve;
  public AnimationCurve secondaryRadiusCurve;
  public float initialScale = 4f;
  public float animationDuration = 2f;
  private float animationCounter;
  public AnimationCurve outerAlphaCurve;
  public AnimationCurve innerAlphaCurve;
  private Material circleMaterial;
  private Team team;
  private ColorsConfig colorsConfig;
  private Transform pingTarget;
  private Player player;

  private void Awake()
  {
    this.circleMaterial = this.circle.material;
    this.lineParent.gameObject.SetActive(false);
    this.pingTarget = (Transform) null;
  }

  public void Setup(ColorsConfig colorsConfig, Team team, Player player)
  {
    this.team = team;
    this.colorsConfig = colorsConfig;
    this.player = player;
    this.SetupMaterial();
  }

  private void SetupMaterial()
  {
    Color color1 = this.colorsConfig.MiddleColor(this.team);
    Color color2 = this.colorsConfig.LightColor(this.team);
    Color color3 = color2;
    color3.a = this.lineAlpha;
    this.lineSprite.color = color3;
    this.circleMaterial.color = color1;
    this.circleMaterial.SetColor("_Color2", color2);
  }

  private void Update()
  {
    if ((double) this.animationCounter > 0.0)
    {
      this.UpdateAnimation();
    }
    else
    {
      this.circle.transform.localScale = Vector3.one * (1f / 1000f);
      this.pingTarget = (Transform) null;
    }
    this.lineParent.gameObject.SetActive((Object) this.pingTarget != (Object) null);
  }

  public void Animate(Transform pingTarget = null)
  {
    this.animationCounter = this.animationDuration;
    if ((Object) pingTarget != (Object) null)
      this.lineParent.gameObject.SetActive(true);
    this.pingTarget = pingTarget;
    this.UpdateAnimation();
  }

  private void UpdateAnimation()
  {
    this.animationCounter = Mathf.Max(this.animationCounter - Time.deltaTime, 0.0f);
    float time = (float) (1.0 - (double) this.animationCounter / (double) this.animationDuration);
    float num1 = this.scaleCurve.Evaluate(time) * this.initialScale;
    this.circleMaterial.SetFloat("_MinRadius", this.secondaryRadiusCurve.Evaluate(time));
    this.circleMaterial.SetFloat("_C2Radius", this.outlineRadiusCurve.Evaluate(time));
    this.circle.transform.localScale = Vector3.one * num1;
    Color color1 = this.circleMaterial.color;
    Color color2 = this.circleMaterial.GetColor("_Color2");
    color1.a = this.innerAlphaCurve.Evaluate(time);
    color2.a = this.outerAlphaCurve.Evaluate(time);
    this.circleMaterial.color = color1;
    this.circleMaterial.SetColor("_Color2", color2);
    if (!((Object) this.pingTarget != (Object) null))
      return;
    float num2 = this.lineLengthCurve.Evaluate(time);
    float num3 = this.linePosCurve.Evaluate(time);
    Vector3 vector3 = this.pingTarget.transform.position - this.player.transform.position;
    vector3.y = 0.0f;
    if (vector3 != Vector3.zero)
      this.lineParent.localRotation = Quaternion.LookRotation(vector3);
    float num4 = num2 * (this.lineLengthBase + this.lineLengthDistScale * vector3.magnitude);
    this.lineTransform.localPosition = Vector3.forward * Mathf.Max(this.lineParent.InverseTransformVector(vector3).magnitude * num3 - num4, 0.0f);
    Vector3 localScale = this.lineTransform.localScale;
    localScale.z = num4;
    this.lineTransform.localScale = localScale;
  }
}
