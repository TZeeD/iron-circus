// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Floor.FloorMatchBallDisplay
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Floor
{
  public class FloorMatchBallDisplay : MonoBehaviour
  {
    [SerializeField]
    private RawImage circleBG;
    [SerializeField]
    private Transform textParent;
    [SerializeField]
    private RawImage circleFG;
    [SerializeField]
    private float buildUpDuration = 0.5f;
    [SerializeField]
    private AnimationCurve circleBuildUpCurve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private AnimationCurve textBuildUpCurve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private AnimationCurve fgBuildUpCurve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private AnimationCurve fgAlphaCurve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private AnimationCurve textRotationCurve = AnimationCurve.Linear(10f, 10f, 1f, 1f);
    [SerializeField]
    private float textRotationSpeed = 10f;
    [SerializeField]
    private Color bgColorAlpha;
    [SerializeField]
    private Color fgColorAlpha;
    [SerializeField]
    private Color textColorAlpha;
    [SerializeField]
    private Color bgColorBeta;
    [SerializeField]
    private Color fgColorBeta;
    [SerializeField]
    private Color textColorBeta;
    [SerializeField]
    private Color bgColorTie;
    [SerializeField]
    private Color fgColorTie;
    [SerializeField]
    private Color textColorTie;
    private float animCounter;

    private void Awake() => this.Hide();

    public void Show(Team team)
    {
      Color color1;
      Color color2;
      Color color3;
      switch (team)
      {
        case Team.Alpha:
          color1 = this.bgColorAlpha;
          color2 = this.fgColorAlpha;
          color3 = this.textColorAlpha;
          break;
        case Team.Beta:
          color1 = this.bgColorBeta;
          color2 = this.fgColorBeta;
          color3 = this.textColorBeta;
          break;
        default:
          color1 = this.bgColorTie;
          color2 = this.fgColorTie;
          color3 = this.textColorTie;
          break;
      }
      foreach (Graphic componentsInChild in this.textParent.GetComponentsInChildren<Text>())
        componentsInChild.color = color3;
      this.circleBG.color = color1;
      this.circleFG.color = color2;
      this.gameObject.SetActive(true);
      this.animCounter = 0.0f;
    }

    public void Show(string textToDisplay)
    {
      Color bgColorAlpha = this.bgColorAlpha;
      Color fgColorAlpha = this.fgColorAlpha;
      Color textColorAlpha = this.textColorAlpha;
      foreach (Text componentsInChild in this.textParent.GetComponentsInChildren<Text>())
      {
        componentsInChild.text = textToDisplay;
        componentsInChild.color = textColorAlpha;
      }
      this.circleBG.color = bgColorAlpha;
      this.circleFG.color = fgColorAlpha;
      this.gameObject.SetActive(true);
      this.animCounter = 0.0f;
    }

    public void Hide() => this.gameObject.SetActive(false);

    private void LateUpdate()
    {
      this.animCounter += Time.deltaTime;
      if ((double) this.animCounter > (double) this.buildUpDuration)
      {
        this.circleBG.transform.localScale = Vector3.one;
        this.textParent.transform.localScale = Vector3.one;
        this.textParent.Rotate(Vector3.forward, this.textRotationSpeed * Time.deltaTime);
        this.circleFG.gameObject.SetActive(false);
      }
      else
      {
        this.circleFG.gameObject.SetActive(true);
        float time = this.animCounter / this.buildUpDuration;
        this.circleBG.transform.localScale = Vector3.one * this.circleBuildUpCurve.Evaluate(time);
        this.textParent.transform.localScale = Vector3.one * this.textBuildUpCurve.Evaluate(time);
        this.textParent.Rotate(Vector3.forward, this.textRotationSpeed * Time.deltaTime * this.textRotationCurve.Evaluate(time));
        this.circleFG.transform.localScale = Vector3.one * this.fgBuildUpCurve.Evaluate(time);
        Color color = this.circleFG.color;
        color.a = this.fgAlphaCurve.Evaluate(time);
        this.circleFG.color = color;
      }
    }
  }
}
