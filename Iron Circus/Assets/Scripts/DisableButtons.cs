// Decompiled with JetBrains decompiler
// Type: DisableButtons
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class DisableButtons : StateMachineBehaviour
{
  private void Start()
  {
  }

  private void Update()
  {
  }

  public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
  {
    if (!stateInfo.IsName("Matching"))
      return;
    DisableMatchingOnSubmit component = animator.gameObject.GetComponent<DisableMatchingOnSubmit>();
    if (!((Object) component != (Object) null))
      return;
    component.DisableButtons();
  }

  public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
  {
    if (!stateInfo.IsName("Matching"))
      return;
    DisableMatchingOnSubmit component = animator.gameObject.GetComponent<DisableMatchingOnSubmit>();
    if (!((Object) component != (Object) null))
      return;
    component.EnableButtons();
  }
}
