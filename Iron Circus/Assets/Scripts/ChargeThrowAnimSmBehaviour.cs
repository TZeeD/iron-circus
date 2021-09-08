// Decompiled with JetBrains decompiler
// Type: ChargeThrowAnimSmBehaviour
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class ChargeThrowAnimSmBehaviour : StateMachineBehaviour
{
  public override void OnStateUpdate(
    Animator animator,
    AnimatorStateInfo stateInfo,
    int layerIndex)
  {
    float normalizedTime = animator.GetFloat("throwCharge");
    if ((double) normalizedTime <= 1.40129846432482E-45)
      return;
    animator.Play(stateInfo.fullPathHash, layerIndex, normalizedTime);
  }
}
