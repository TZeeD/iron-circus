// Decompiled with JetBrains decompiler
// Type: IdleSpiceAnimationTimer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.UI.Config;
using UnityEngine;

public class IdleSpiceAnimationTimer : StateMachineBehaviour
{
  public IdleSpiceTimingConfig idleTiming;
  [Header("Only if no 'Idle Timing' is set above")]
  public float minIdleDuration = 45f;
  public float maxIdleDuration = 60f;
  private float startTime;
  private float triggerActionInTime;
  private bool triggered;

  public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
  {
    this.startTime = Time.time;
    this.triggerActionInTime = !((Object) this.idleTiming != (Object) null) ? Random.Range(this.minIdleDuration, this.maxIdleDuration) : Random.Range(this.idleTiming.minInterval, this.idleTiming.maxInterval);
    this.triggered = false;
  }

  public override void OnStateUpdate(
    Animator animator,
    AnimatorStateInfo stateInfo,
    int layerIndex)
  {
    if (this.triggered || (double) Time.time <= (double) this.startTime + (double) this.triggerActionInTime)
      return;
    animator.SetTrigger("selectedTurntableAction");
    this.triggered = true;
  }
}
