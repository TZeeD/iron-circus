// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ScaleModelState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.Utils.Extensions;
using Imi.SteelCircus.GameElements;
using SteelCircus.GameElements;
using UnityEngine;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ScaleModelState : SkillState
  {
    public ConfigValue<float> scaleTo;
    public ConfigValue<float> scaleDuration;
    public ConfigValue<Curve> scaleCurve;
    private Vector3 originalScale;
    private Transform transform;
    private float startTime;

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    protected override void EnterDerived()
    {
      this.startTime = (float) ScTime.TicksToSeconds(this.skillGraph.GetTick(), this.skillGraph.GetFixedTimeStep());
      if (!((Object) this.transform == (Object) null))
        return;
      GameEntity owner = this.skillGraph.GetOwner();
      if (!owner.hasUnityView)
        return;
      this.transform = owner.unityView.gameObject.GetComponentInChildren<Player>().ViewTransform;
      this.originalScale = this.transform.localScale;
      this.transform.localScale = Vector3.one * this.scaleTo.Get();
    }

    protected override void TickDerived()
    {
      float num = (float) ScTime.TicksToSeconds(this.skillGraph.GetTick(), this.skillGraph.GetFixedTimeStep()) - this.startTime;
      if (!((Object) this.transform != (Object) null))
        return;
      float v1 = this.scaleTo.Get();
      float t1 = num / this.scaleDuration.Get();
      float t2 = this.scaleCurve.Get().Evaluate(t1);
      this.transform.localScale = Vector3.one * MathExtensions.Interpolate(this.originalScale.y, v1, t2);
    }

    protected override void ExitDerived()
    {
      if (!((Object) this.transform != (Object) null))
        return;
      this.transform.localScale = this.originalScale;
      this.transform = (Transform) null;
    }
  }
}
