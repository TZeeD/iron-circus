// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.SkillInfo.SkillHudHealthContainerUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.SkillInfo
{
  public class SkillHudHealthContainerUi : MonoBehaviour
  {
    [SerializeField]
    private GameObject healthPointPrefab;
    [SerializeField]
    private GridLayoutGroup healthGridLayout;
    public HealthPoint[] HealthPoints;
    private int currentHp;
    private int maxHp;

    private void Start() => this.healthGridLayout = this.GetComponent<GridLayoutGroup>();

    public void InitializeChampionHealthPoints(ChampionConfig config, int currentHealth)
    {
      this.maxHp = config.maxHealth;
      this.AdjustUiForMaxHealth(this.maxHp);
      this.HealthPoints = new HealthPoint[this.maxHp];
      for (int index = 0; index < config.maxHealth; ++index)
      {
        GameObject gameObject = Object.Instantiate<GameObject>(this.healthPointPrefab);
        gameObject.transform.SetParent(this.transform);
        this.HealthPoints[index] = gameObject.GetComponent<HealthPoint>();
        gameObject.GetComponent<RectTransform>().localScale = new Vector3(1f, 1f, 1f);
      }
      this.SetHealthUi(currentHealth, this.maxHp);
    }

    private void AdjustUiForMaxHealth(int maxHealth) => this.healthGridLayout.cellSize = new Vector2(270f / (float) maxHealth, this.healthGridLayout.cellSize.y);

    public void SetHealthUi(int currentHealth, int maxHealth)
    {
      if (this.currentHp == currentHealth || this.HealthPoints.Length == 0)
        return;
      this.currentHp = currentHealth;
      for (int index = 0; index < this.HealthPoints.Length; ++index)
        this.HealthPoints[this.maxHp - (index + 1)].SetHealthPointActive(this.maxHp - index <= this.currentHp);
      if (currentHealth == 1)
        this.HealthPoints[0].PingPongHealthPoint();
      else
        this.HealthPoints[0].StopPingPongHealthPoint();
    }
  }
}
