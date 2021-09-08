// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Animations.MovementAnimationSpeedChange
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.Animations
{
  public class MovementAnimationSpeedChange : StateMachineBehaviour
  {
    private float maxSpeed;

    public override void OnStateEnter(
      Animator animator,
      AnimatorStateInfo stateInfo,
      int layerIndex)
    {
      this.maxSpeed = animator.GetFloat("maxSpeed");
    }

    public override void OnStateUpdate(
      Animator animator,
      AnimatorStateInfo stateInfo,
      int layerIndex)
    {
      float num = animator.GetFloat("speed");
      animator.SetFloat("runAnimSpeed", num / this.maxSpeed);
    }
  }
}
