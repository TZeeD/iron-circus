// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.KennyFlameController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Rendering;
using Imi.SteelCircus.Utils.Extensions;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.FX
{
  public class KennyFlameController : MonoBehaviour
  {
    [SerializeField]
    private GameObject flamePrefab;
    [SerializeField]
    private string rootBoneName = "TSM3WorldJoint";
    private Transform rootBone;
    [SerializeField]
    private KennyFlameSettings flameSettings;
    [SerializeField]
    private Animator animator;
    private Dictionary<KennyFlameAnimationCurve, List<KennyFlame>> flames = new Dictionary<KennyFlameAnimationCurve, List<KennyFlame>>();
    private readonly int FlameOthersID = Animator.StringToHash("flame_others");
    private readonly int FlameLeftFootID = Animator.StringToHash("flame_left_foot");
    private readonly int FlameRightFootID = Animator.StringToHash("flame_right_foot");
    private readonly int FlameLeftLowerArmID = Animator.StringToHash("flame_left_lower_arm");
    private readonly int FlameRightLowerArmID = Animator.StringToHash("flame_right_lower_arm");
    private readonly int FlameLeftLowerLegID = Animator.StringToHash("flame_left_lower_leg");
    private readonly int FlameRightLowerLegID = Animator.StringToHash("flame_right_lower_leg");

    private void Start()
    {
      this.rootBone = this.transform.FindDeepChild(this.rootBoneName);
      int layer = this.GetComponentInChildren<Renderer>().gameObject.layer;
      foreach (KennyFlameSettings.FlameDescription flame in this.flameSettings.flames)
      {
        GameObject go = Object.Instantiate<GameObject>(this.flamePrefab);
        go.SetLayer((Layer) layer);
        Transform deepChild = this.rootBone.FindDeepChild(flame.parentBoneName);
        Transform transform = go.transform;
        transform.parent = deepChild;
        transform.localPosition = flame.localPos;
        transform.localScale = flame.localScale;
        transform.localEulerAngles = flame.localEuler;
        KennyFlame component = go.GetComponent<KennyFlame>();
        KennyFlameAnimationCurve animationCurve = flame.animationCurve;
        if (!this.flames.ContainsKey(animationCurve))
          this.flames[animationCurve] = new List<KennyFlame>();
        this.flames[animationCurve].Add(component);
      }
    }

    private void Update()
    {
      this.UpdateFlame(KennyFlameAnimationCurve.Others, this.FlameOthersID);
      this.UpdateFlame(KennyFlameAnimationCurve.LeftFoot, this.FlameLeftFootID);
      this.UpdateFlame(KennyFlameAnimationCurve.RightFoot, this.FlameRightFootID);
      this.UpdateFlame(KennyFlameAnimationCurve.LeftLowerArm, this.FlameLeftLowerArmID);
      this.UpdateFlame(KennyFlameAnimationCurve.RightLowerArm, this.FlameRightLowerArmID);
      this.UpdateFlame(KennyFlameAnimationCurve.LeftLowerLeg, this.FlameLeftLowerLegID);
      this.UpdateFlame(KennyFlameAnimationCurve.RightLowerLeg, this.FlameRightLowerLegID);
    }

    private void UpdateFlame(KennyFlameAnimationCurve type, int animatorPropID)
    {
      if (!this.flames.ContainsKey(type))
        return;
      float intensity = this.animator.GetFloat(animatorPropID);
      List<KennyFlame> flame = this.flames[type];
      for (int index = 0; index < flame.Count; ++index)
        flame[index].SetIntensity(intensity);
    }
  }
}
