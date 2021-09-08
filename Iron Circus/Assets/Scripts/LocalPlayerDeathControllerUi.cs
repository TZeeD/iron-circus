// Decompiled with JetBrains decompiler
// Type: LocalPlayerDeathControllerUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class LocalPlayerDeathControllerUi : MonoBehaviour
{
  [SerializeField]
  private GameObject koPanel;
  [SerializeField]
  private Animator koAnimator;
  [SerializeField]
  private Text byMessage;
  [SerializeField]
  private SimpleCountDown respawnCountDown;

  private IEnumerator ScaleDownDeathUi(float duration)
  {
    yield return (object) new WaitForSeconds(5f);
    Animator koAnimator = this.koPanel.GetComponent<Animator>();
    koAnimator.SetTrigger("scaleDown");
    yield return (object) new WaitForSeconds(duration - 6f);
    koAnimator.SetTrigger("exit");
    yield return (object) new WaitForSeconds(1f);
    this.koPanel.SetActive(false);
  }

  public void DisplayDeathUi(float duration, ulong playerId)
  {
    this.koPanel.SetActive(true);
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);
    this.byMessage.text = "KO-ed by " + entityWithPlayerId.playerUsername.username + "[" + entityWithPlayerId.championConfig.value.displayName + "]";
    this.respawnCountDown.StartCountdown(duration);
    this.StartCoroutine(this.ScaleDownDeathUi(duration));
  }

  public void RemoveDeathUi()
  {
    if (!this.koPanel.gameObject.activeSelf)
      return;
    this.koPanel.GetComponent<Animator>().SetTrigger("exit");
    this.koPanel.SetActive(false);
  }
}
