// Decompiled with JetBrains decompiler
// Type: DisableMatchingOnSubmit
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

public class DisableMatchingOnSubmit : MonoBehaviour
{
  public Button[] disabledButtonsOnSubmit;

  private void Start()
  {
  }

  private void Update()
  {
  }

  public void DisableButtons()
  {
    foreach (Button button in this.disabledButtonsOnSubmit)
    {
      if (button.interactable)
      {
        button.animationTriggers.disabledTrigger = "DisabledTemp";
        button.interactable = false;
      }
    }
  }

  public void EnableButtons()
  {
    foreach (Button button in this.disabledButtonsOnSubmit)
    {
      if (button.GetComponent<Animator>().GetCurrentAnimatorStateInfo(0).IsName("DisabledTemp"))
      {
        button.interactable = true;
        button.animationTriggers.disabledTrigger = "Matching";
      }
    }
  }
}
