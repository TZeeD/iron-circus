// Decompiled with JetBrains decompiler
// Type: PickupSpawnFloorUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SteelCircus.ScriptableObjects;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class PickupSpawnFloorUi : MonoBehaviour
{
  [SerializeField]
  private SimplePickupCountDown countDown;
  [SerializeField]
  private Text text;
  [SerializeField]
  private SpriteRenderer icon;
  [SerializeField]
  private float scaleUpDuration = 0.5f;
  [SerializeField]
  private Sprite rechargeIcon;
  [SerializeField]
  private Sprite healthIcon;
  [SerializeField]
  private Sprite sprintIcon;

  public void SetupUi(PickupType pickupType, float duration)
  {
    this.countDown.StartCountdown(duration);
    this.text.color = SingletonScriptableObject<ColorsConfig>.Instance.ColorForPickupType(pickupType);
    this.icon.color = SingletonScriptableObject<ColorsConfig>.Instance.ColorForPickupType(pickupType);
    this.icon.sprite = this.GetSpriteForPickupType(pickupType);
    this.gameObject.SetActive(true);
    this.StartCoroutine(this.ScaleUiOverTime());
  }

  private IEnumerator ScaleUiOverTime()
  {
    PickupSpawnFloorUi pickupSpawnFloorUi = this;
    float localScale = pickupSpawnFloorUi.transform.localScale.x;
    pickupSpawnFloorUi.transform.localScale = new Vector3(0.0f, 0.0f, 0.0f);
    float t = 0.0f;
    while ((double) t < (double) pickupSpawnFloorUi.scaleUpDuration)
    {
      t += Time.deltaTime;
      float num = localScale * (t / pickupSpawnFloorUi.scaleUpDuration);
      pickupSpawnFloorUi.transform.localScale = new Vector3(num, num, num);
      yield return (object) null;
    }
    pickupSpawnFloorUi.transform.localScale = new Vector3(localScale, localScale, localScale);
  }

  private Sprite GetSpriteForPickupType(PickupType pickupType)
  {
    switch (pickupType)
    {
      case PickupType.RefreshSkills:
        return this.rechargeIcon;
      case PickupType.RegainHealth:
        return this.healthIcon;
      case PickupType.RefreshSprint:
        return this.sprintIcon;
      default:
        return this.healthIcon;
    }
  }
}
