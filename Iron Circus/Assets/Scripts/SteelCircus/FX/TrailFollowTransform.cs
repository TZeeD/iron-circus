// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.TrailFollowTransform
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Utils.Smoothing;
using UnityEngine;

namespace SteelCircus.FX
{
  public class TrailFollowTransform : FollowTransform
  {
    public AnimationCurve moveSpeedToTrailLength = AnimationCurve.Linear(0.0f, 0.1f, 20f, 0.1f);
    [SerializeField]
    private float debugAvgDistance;
    private const float minTrailLength = 0.09f;
    private Vector3 prevTargetPos;
    private TrailRenderer trail;
    private FilteredFloat avgDistance;
    private Material trailMat;
    private Color trailMatOriginalColor;

    public override Transform Target
    {
      get => this.target;
      set
      {
        this.target = value;
        this.prevTargetPos = this.target.position;
      }
    }

    protected override void Start()
    {
      this.trail = this.GetComponent<TrailRenderer>();
      this.avgDistance = new FilteredFloat(0.05f);
      this.trailMat = this.trail.material;
      this.trailMatOriginalColor = this.trailMat.color;
    }

    protected override void Update()
    {
      base.Update();
      this.avgDistance.Add((this.transform.position - this.prevTargetPos).magnitude / Time.deltaTime, Time.time);
      float simpleAverage = this.avgDistance.GetSimpleAverage();
      this.debugAvgDistance = simpleAverage;
      float num = this.moveSpeedToTrailLength.Evaluate(simpleAverage);
      this.trail.time = num;
      this.trailMat.color = (double) num < 0.0900000035762787 ? new Color(1f, 1f, 1f, 0.0f) : this.trailMatOriginalColor;
      this.prevTargetPos = this.target.position;
    }
  }
}
