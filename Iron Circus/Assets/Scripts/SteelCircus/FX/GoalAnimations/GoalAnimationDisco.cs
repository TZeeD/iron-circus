// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.GoalAnimations.GoalAnimationDisco
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.FX.GoalAnimations.Base;
using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.FX.GoalAnimations
{
  public class GoalAnimationDisco : GoalAnimationWithTeamColors
  {
    [SerializeField]
    private TextMeshPro[] tfGoal;
    [SerializeField]
    private TextMeshPro[] tfTeam;
    [SerializeField]
    private Renderer wave;
    [SerializeField]
    private Renderer floor;
    [SerializeField]
    private Transform textContainer;
    [SerializeField]
    private Transform waveContainer;
    [SerializeField]
    private float buildupDuration = 1f;
    [SerializeField]
    private AnimationCurve buildupFloor = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private AnimationCurve buildupWave = AnimationCurve.Linear(4f, 4f, 0.0f, 0.0f);
    [SerializeField]
    private AnimationCurve buildupWaveThreshold = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private AnimationCurve buildupText = AnimationCurve.Linear(4f, 4f, 0.0f, 0.0f);
    [SerializeField]
    private AnimationCurve buildupTextAlpha = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    protected static readonly int _BuildupBGTime = Shader.PropertyToID(nameof (_BuildupBGTime));

    protected override void Start()
    {
      string goalString = this.GetGoalString();
      foreach (TMP_Text tmpText in this.tfGoal)
        tmpText.text = goalString;
      string teamString = this.GetTeamString();
      foreach (TMP_Text tmpText in this.tfTeam)
        tmpText.text = teamString;
      this.StartCoroutine(this.BuildupCR());
    }

    private IEnumerator BuildupCR()
    {
      float time = 0.0f;
      while ((double) time < 1.0)
      {
        time += Time.deltaTime / this.buildupDuration;
        time = Mathf.Clamp01(time);
        this.floor.material.SetFloat(GoalAnimationDisco._BuildupBGTime, this.buildupFloor.Evaluate(time));
        this.wave.material.SetFloat(GoalAnimationDisco._BuildupBGTime, this.buildupWaveThreshold.Evaluate(time));
        foreach (Graphic graphic in this.tfGoal)
          graphic.color = new Color(1f, 1f, 1f, this.buildupTextAlpha.Evaluate(time));
        foreach (Graphic graphic in this.tfTeam)
          graphic.color = new Color(1f, 1f, 1f, this.buildupTextAlpha.Evaluate(time));
        this.waveContainer.transform.localPosition = new Vector3(0.0f, 0.0f, this.buildupWave.Evaluate(time));
        this.textContainer.transform.localPosition = new Vector3(0.0f, 0.0f, this.buildupText.Evaluate(time));
        yield return (object) null;
      }
    }
  }
}
