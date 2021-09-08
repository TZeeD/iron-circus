// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.SkillInfo.HealthPoint
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.SkillInfo
{
  public class HealthPoint : MonoBehaviour
  {
    [SerializeField]
    private GameObject healthPoint;
    [SerializeField]
    private Image healthPointFilled;
    [SerializeField]
    private Image healthPointBackground;
    private bool playHealthPointPingPong;

    private void Start() => this.healthPointFilled.color = SingletonScriptableObject<ColorsConfig>.Instance.healhPointColor;

    public void SetHealthPointActive(bool active)
    {
      this.healthPoint.SetActive(active);
      this.healthPointFilled.gameObject.SetActive(active);
    }

    public void PingPongHealthPoint() => this.playHealthPointPingPong = true;

    public void StopPingPongHealthPoint()
    {
      this.playHealthPointPingPong = false;
      this.healthPointFilled.color = SingletonScriptableObject<ColorsConfig>.Instance.healhPointColor;
    }

    private void Update()
    {
      if (!this.playHealthPointPingPong)
        return;
      this.healthPointFilled.color = Color.Lerp(Color.clear, SingletonScriptableObject<ColorsConfig>.Instance.characterFlashDamage, Mathf.PingPong(Time.time, 1f) / 1f);
    }
  }
}
