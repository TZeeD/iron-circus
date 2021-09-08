// Decompiled with JetBrains decompiler
// Type: FloorBorderUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Rendering;
using Imi.SteelCircus.Utils;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using System.Collections;
using UnityEngine;

public class FloorBorderUI : MonoBehaviour
{
  [SerializeField]
  private Renderer borderMesh;
  [SerializeField]
  private Color outerColor;
  [SerializeField]
  private Color innerColor;
  [SerializeField]
  private Color outerColorOvertime;
  [SerializeField]
  private Color innerColorOvertime;
  [SerializeField]
  private Color outerColorWhenExpanded;
  [SerializeField]
  private Color innerColorWhenExpanded;
  [SerializeField]
  private AnimationCurve expansionColorLerp;
  [SerializeField]
  private float textSpeed = 0.3f;
  [SerializeField]
  private float bgSpeed = 2.3f;
  [SerializeField]
  private Texture2D lastMinuteTexture;
  [SerializeField]
  private Texture2D lastSecondsTexture;
  [SerializeField]
  private Texture2D overtimeGoldenGoalTexture;
  [SerializeField]
  private float showLastSecondsMessageAtTime = 10f;
  [SerializeField]
  private float expansionDuration = 0.3f;
  [SerializeField]
  private AnimationCurve expansionCurve;
  [SerializeField]
  private float stayDurationLastMinute = 8f;
  [SerializeField]
  private float stayDurationLastSeconds = 4f;
  [SerializeField]
  private float closeDuration = 0.5f;
  private const float threeSecondsRemaining = 3f;
  private Material borderMaterial;
  private float currentExpansion;
  private float prevTime = -1f;

  private void Start()
  {
    this.borderMaterial = this.borderMesh.material;
    this.borderMesh.gameObject.SetActive(false);
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
  }

  private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    if (matchState != Imi.SharedWithServer.Game.MatchState.Overtime)
      return;
    this.outerColor = this.outerColorOvertime;
    this.innerColor = this.innerColorOvertime;
    this.ShowOvertime();
  }

  private void Update()
  {
    this.UpdateTime();
    this.AnimateMaterialTextureOffsets();
    this.SetMaterialExpansionAttributes();
  }

  private void UpdateTime()
  {
    float remainingTime = MatchUtils.GetRemainingTime();
    if ((double) remainingTime <= 66.0 && (double) this.prevTime > 66.0)
    {
      if (ImiServices.Instance.isInMatchService.CurrentArena.Contains("Arena_Shenzhen"))
        AudioController.PlayMusic("Music1MinuteRemainingShenzhen");
      else if (ImiServices.Instance.isInMatchService.CurrentArena.Contains("Arena_Mars"))
        AudioController.PlayMusic("Music1MinuteRemainingMars");
    }
    if (Contexts.sharedInstance.meta.hasMetaMatch && !Contexts.sharedInstance.meta.metaMatch.isOvertime)
    {
      if ((double) remainingTime <= 60.0 && (double) this.prevTime > 60.0)
        this.ShowLastMinute();
      if ((double) remainingTime <= (double) this.showLastSecondsMessageAtTime && (double) this.prevTime > (double) this.showLastSecondsMessageAtTime)
        this.ShowLastSeconds();
    }
    if ((double) remainingTime <= 3.0 && (double) this.prevTime > 3.0)
    {
      AudioController.Stop("10SecondsRemainingCrowd", 3f);
      AudioController.Play("3SecondsRemainingCrowd");
    }
    this.MatchEndBuzzer(remainingTime);
    this.prevTime = remainingTime;
  }

  private void AnimateMaterialTextureOffsets()
  {
    Vector4 vector1 = this.borderMaterial.GetVector(ShaderConstants._MainTex_ST);
    Vector4 vector2 = this.borderMaterial.GetVector(ShaderConstants._MainTex2_ST);
    vector1.z += Time.deltaTime * this.textSpeed;
    vector2.z += Time.deltaTime * this.bgSpeed;
    this.borderMaterial.SetVector(ShaderConstants._MainTex_ST, vector1);
    this.borderMaterial.SetVector(ShaderConstants._MainTex2_ST, vector2);
  }

  private void SetMaterialExpansionAttributes()
  {
    this.borderMaterial.SetFloat(ShaderConstants._Expansion, this.currentExpansion);
    this.borderMaterial.color = Color.Lerp(this.outerColor, this.outerColorWhenExpanded, this.expansionColorLerp.Evaluate(this.currentExpansion));
    this.borderMaterial.SetColor(ShaderConstants._InnerColor, Color.Lerp(this.innerColor, this.innerColorWhenExpanded, this.expansionColorLerp.Evaluate(this.currentExpansion)));
  }

  private void ShowLastMinute()
  {
    this.borderMaterial.mainTexture = (Texture) this.lastMinuteTexture;
    this.borderMesh.gameObject.SetActive(true);
    this.StartCoroutine(this.Animate(this.stayDurationLastMinute));
    AudioController.Play("Announcer1MinuteLeft");
    AudioController.Play("MatchRemainingTimeThump");
    AudioController.Play("1MinuteRemainingCrowd");
    AudioController.Play("AmbienceCrowd1MinuteRemaining");
  }

  private void ShowLastSeconds()
  {
    this.borderMaterial.mainTexture = (Texture) this.lastSecondsTexture;
    this.borderMesh.gameObject.SetActive(true);
    this.StartCoroutine(this.Animate(this.stayDurationLastSeconds));
    AudioController.Play("MatchRemainingTimeThump");
    AudioController.Play("10SecondsRemainingCrowd");
    AudioController.Play("Announcer10SecondsLeft");
  }

  private void ShowOvertime()
  {
    this.borderMaterial.mainTexture = (Texture) this.overtimeGoldenGoalTexture;
    this.borderMesh.gameObject.SetActive(true);
    this.StartCoroutine(this.Animate(70f));
  }

  private void MatchEndBuzzer(float currTime)
  {
    if ((double) currTime <= 5.0 && (double) this.prevTime > 5.0)
      AudioController.Play("MatchEndingCountdown");
    if ((double) currTime <= 4.0 && (double) this.prevTime > 4.0)
      AudioController.Play("MatchEndingCountdown");
    if ((double) currTime <= 3.0 && (double) this.prevTime > 3.0)
      AudioController.Play("MatchEndingCountdown");
    if ((double) currTime <= 2.0 && (double) this.prevTime > 2.0)
      AudioController.Play("MatchEndingCountdown");
    if ((double) currTime > 1.0 || (double) this.prevTime <= 1.0)
      return;
    AudioController.Play("MatchEndingCountdownFinal");
  }

  private IEnumerator Animate(float stayDuration)
  {
    this.borderMaterial.SetFloat(ShaderConstants._Mask, 0.0f);
    this.currentExpansion = 0.0f;
    float time = 0.0f;
    while ((double) time < (double) this.expansionDuration)
    {
      time += Time.deltaTime;
      this.currentExpansion = 1f - this.expansionCurve.Evaluate(Mathf.Clamp01(time / this.expansionDuration));
      yield return (object) null;
    }
    while ((double) time < (double) this.expansionDuration + (double) stayDuration)
    {
      time += Time.deltaTime;
      yield return (object) null;
    }
    while ((double) time < (double) this.expansionDuration + (double) stayDuration + (double) this.closeDuration)
    {
      time += Time.deltaTime;
      float num = Mathf.Clamp01((time - (this.expansionDuration + stayDuration)) / this.closeDuration);
      this.borderMaterial.SetFloat(ShaderConstants._Mask, num);
      yield return (object) null;
    }
    this.borderMesh.gameObject.SetActive(false);
  }
}
