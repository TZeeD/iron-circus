// Decompiled with JetBrains decompiler
// Type: ShaniSpearVisibility
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using UnityEngine;

public class ShaniSpearVisibility : StateMachineBehaviour
{
  public bool showOnStart;
  public bool hideOnStart;
  public bool showOnExit;
  public bool hideOnExit;

  public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
  {
    ObjectTag inDirectChildren = animator.transform.GetComponentInDirectChildren<ObjectTag>();
    if (!((Object) inDirectChildren != (Object) null))
      return;
    if (this.showOnStart)
    {
      inDirectChildren.gameObject.SetActive(true);
      Log.Debug("Show spear on start");
    }
    if (!this.hideOnStart)
      return;
    inDirectChildren.gameObject.SetActive(false);
    Log.Error("Hide spear on start");
  }

  public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
  {
    ObjectTag inDirectChildren = animator.transform.GetComponentInDirectChildren<ObjectTag>();
    if (!((Object) inDirectChildren != (Object) null))
      return;
    if (this.hideOnExit)
    {
      Log.Debug("Hide spear on Exit ");
      inDirectChildren.gameObject.SetActive(false);
    }
    if (!this.showOnExit)
      return;
    Log.Debug("Show spear on Exit");
    inDirectChildren.gameObject.SetActive(true);
  }
}
