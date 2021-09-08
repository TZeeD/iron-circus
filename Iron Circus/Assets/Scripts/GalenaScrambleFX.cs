// Decompiled with JetBrains decompiler
// Type: GalenaScrambleFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.Utils.Extensions;
using Jitter.LinearMath;
using SteelCircus.FX.Skills;
using UnityEngine;

public class GalenaScrambleFX : MonoBehaviour, IVfx
{
  [SerializeField]
  private Color trailColorAlpha;
  [SerializeField]
  private Color trailColorBeta;
  [SerializeField]
  private Color tubeColorAlpha;
  [SerializeField]
  private Color tubeColorBeta;
  [SerializeField]
  private Transform[] spheres;
  [SerializeField]
  private float rotationSpeed = 6.283185f;
  [SerializeField]
  private float oscillationSpeed = 3f;
  [SerializeField]
  private MeshRenderer tubeRenderer;
  [SerializeField]
  private AnimationCurve tubeIntensity = AnimationCurve.Linear(0.0f, 1f, 1f, 0.0f);
  [SerializeField]
  private Transform tubeParent;
  [SerializeField]
  private MeshRenderer normalsRenderer;
  [SerializeField]
  private float fadeOutDuration = 0.2f;
  public float width = 6f;
  public float thickness = 1f;
  public float centerY = 1f;
  public float lerpPhaseDuration = 0.5f;
  private Vector3[] initialPositions;
  private float animationCounter;
  private float duration;
  public float tmpSpeed = 10f;
  public float tmpDuration = 1f;
  private SkillVar<JVector> dir;
  private SkillVar<JVector> pos;

  public void SetOwner(GameEntity entity)
  {
    Transform transform = entity.unityView.gameObject.transform;
    this.transform.position = transform.position;
    this.transform.rotation = transform.rotation;
    int num = (int) entity.playerTeam.value;
    Color color1 = num == 1 ? this.tubeColorAlpha : this.tubeColorBeta;
    Color color2 = num == 1 ? this.trailColorAlpha : this.trailColorBeta;
    this.tubeRenderer.material.color = color1;
    Material material = this.spheres[0].GetComponent<TrailRenderer>().material;
    material.color = color2;
    foreach (Component sphere in this.spheres)
      sphere.GetComponent<TrailRenderer>().sharedMaterial = material;
  }

  public void SetArgs(object args)
  {
  }

  public void SetSkillGraph(SkillGraph graph)
  {
    this.dir = graph.GetVar<JVector>("AimDir");
    this.pos = graph.GetVar<JVector>("SweepPos");
    ScrambleConfig config = (ScrambleConfig) graph.GetConfig();
    this.width = config.sweepWidth;
    this.thickness = 1f;
    this.duration = config.sweepDistance / config.sweepSpeed;
    this.tubeParent.localScale = new Vector3(this.width, this.thickness * 0.5f, this.thickness * 0.5f);
  }

  private void UpdateTransform()
  {
    if (this.pos == null)
      return;
    this.transform.position = this.pos.Get().ToVector3();
    this.transform.rotation = Quaternion.LookRotation(this.dir.Get().ToVector3());
  }

  private void Start()
  {
    this.initialPositions = new Vector3[this.spheres.Length];
    for (int index = 0; index < this.spheres.Length; ++index)
    {
      Vector3 position = this.spheres[index].position;
      this.initialPositions[index] = position;
    }
    this.UpdateTransform();
  }

  private void Update()
  {
    this.UpdateTransform();
    float num1 = 1f - Mathf.Clamp01((this.animationCounter - (this.duration - this.fadeOutDuration)) / this.fadeOutDuration);
    this.normalsRenderer.material.color = new Color(num1, num1, num1, 1f);
    this.tubeRenderer.material.SetFloat("_Intensity", this.tubeIntensity.Evaluate(Mathf.Clamp01(this.animationCounter / this.duration)));
    this.animationCounter += Time.deltaTime;
    float num2 = (float) (this.spheres.Length / 2);
    for (int index = 0; index < this.spheres.Length; ++index)
    {
      float num3 = (float) (index % 2 * 2 - 1);
      double num4 = 6.28318548202515 * (double) (index / 2) / (double) num2;
      float num5 = (float) (num4 + (double) this.animationCounter * (double) this.rotationSpeed);
      float x = (float) (((double) Mathf.Sin((float) (num4 + (double) this.animationCounter * (double) this.oscillationSpeed)) * 0.5 + 0.5) * (double) this.width / 2.0) * num3;
      Vector2 vector2 = (Vector2.up * this.thickness * 0.5f).Rotate((float) ((double) num5 * 180.0 / 3.14159274101257 % 360.0));
      Vector3 b = new Vector3(x, vector2.x + this.centerY, vector2.y);
      if ((double) this.animationCounter <= (double) this.lerpPhaseDuration)
        b = Vector3.Lerp(this.transform.InverseTransformPoint(this.initialPositions[index]), b, this.animationCounter / this.lerpPhaseDuration);
      this.spheres[index].localPosition = b;
    }
  }
}
