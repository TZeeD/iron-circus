// Decompiled with JetBrains decompiler
// Type: UnlockButtonAnimationHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof (Animator))]
public class UnlockButtonAnimationHelper : MonoBehaviour
{
  [SerializeField]
  private GameObject AnimatedGlowPrefab;

  public void EnableButton() => this.GetComponent<Button>().interactable = true;

  public void PlayUnlockGlowAnimation() => this.StartCoroutine(this.UnlockGlowCoroutine());

  public void PlayChargeAudio1()
  {
  }

  public void PlayChargeAudio2() => AudioController.Play("ChargeShot");

  private IEnumerator UnlockGlowCoroutine()
  {
    // ISSUE: reference to a compiler-generated field
    int num = this.\u003C\u003E1__state;
    UnlockButtonAnimationHelper buttonAnimationHelper = this;
    GameObject unlockAnimator;
    if (num != 0)
    {
      if (num != 1)
        return false;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      AudioController.Play("SkillCooldownComplete");
      unlockAnimator.GetComponent<Animator>().SetTrigger("Play");
      return false;
    }
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E1__state = -1;
    unlockAnimator = Object.Instantiate<GameObject>(buttonAnimationHelper.AnimatedGlowPrefab, buttonAnimationHelper.transform, false);
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E2__current = (object) null;
    // ISSUE: reference to a compiler-generated field
    this.\u003C\u003E1__state = 1;
    return true;
  }
}
