// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Floor.Player.PlayerFloorHealthDisplay
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SteelCircus.ScriptableObjects;
using SharedWithServer.ScEvents;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.UI.Floor.Player
{
  public class PlayerFloorHealthDisplay : MonoBehaviour
  {
    [SerializeField]
    private GameObject healthPointPrefab;
    public float healthPointAngleSpread = 15f;
    public Color healthPointActiveFill;
    public Color healthPointActiveOutline;
    public Color healthPointLowBlinkOn;
    public Color healthPointLowBlinkOff;
    public float healthPointLowBlinkFrequency = 0.5f;
    public Color healthPointInactiveFill;
    public Color healthPointInactiveOutline;
    private int currentHP;
    private int maxHP;
    private List<Transform> hpIcons = new List<Transform>();
    private List<Material> hpIconMaterials = new List<Material>();
    private Team team;
    private ColorsConfig colorsConfig;
    private Imi.SteelCircus.GameElements.Player player;
    private static readonly int fillID = Shader.PropertyToID("_Color");
    private static readonly int outlineID = Shader.PropertyToID("_Color2");

    public event Action<PlayerFloorHealthDisplay> onMaxHPChanged;

    public int CurrentHP => this.currentHP;

    public int MaxHP => this.maxHP;

    private void Awake() => Events.Global.OnEventPlayerHealthChanged += new Events.EventPlayerHealthChanged(this.OnPlayerHealthChanged);

    private void OnDestroy() => Events.Global.OnEventPlayerHealthChanged -= new Events.EventPlayerHealthChanged(this.OnPlayerHealthChanged);

    private void Update() => this.BlinkIfLastHP();

    private void BuildHPIcons()
    {
      foreach (Component hpIcon in this.hpIcons)
        UnityEngine.Object.Destroy((UnityEngine.Object) hpIcon.gameObject);
      this.hpIcons.Clear();
      this.hpIconMaterials.Clear();
      for (int index = 0; index < this.maxHP; ++index)
      {
        GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.healthPointPrefab, this.transform);
        Material material = gameObject.GetComponentInChildren<Renderer>().material;
        this.SetHPActive(material, this.maxHP - index <= this.currentHP);
        gameObject.transform.localEulerAngles = new Vector3(0.0f, this.healthPointAngleSpread * (float) index, 0.0f);
        this.hpIcons.Add(gameObject.transform);
        this.hpIconMaterials.Add(material);
      }
    }

    public void SetMaxHealth(int maxHP)
    {
      if (this.maxHP == maxHP)
        return;
      this.maxHP = maxHP;
      this.BuildHPIcons();
      if (this.onMaxHPChanged == null)
        return;
      this.onMaxHPChanged(this);
    }

    public void Setup(ColorsConfig colorsConfig, Team team, Imi.SteelCircus.GameElements.Player player)
    {
      this.team = team;
      this.colorsConfig = colorsConfig;
      this.player = player;
      this.SetMaxHealth(player.MaxHealth);
      this.SetCurrentHealth(player.CurrentHealth);
    }

    private void OnPlayerHealthChanged(
      ulong playerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead)
    {
      if ((long) playerId != (long) this.player.PlayerId)
        return;
      if (this.maxHP != maxHealth)
        this.SetMaxHealth(maxHealth);
      this.SetCurrentHealth(currentHealth);
    }

    public void SetCurrentHealth(int hp, bool animate = true)
    {
      if (hp == this.currentHP)
        return;
      this.currentHP = hp;
      for (int index = 0; index < this.hpIconMaterials.Count; ++index)
        this.SetHPActive(this.hpIconMaterials[index], this.maxHP - index <= this.currentHP);
      this.BlinkIfLastHP();
    }

    private void BlinkIfLastHP()
    {
      if (this.currentHP != 1)
        return;
      this.Blink(this.hpIconMaterials[this.hpIconMaterials.Count - 1]);
    }

    private void Blink(Material mat)
    {
      Color color = Color.Lerp(this.healthPointLowBlinkOn, this.healthPointLowBlinkOff, Mathf.Pow(Time.time % this.healthPointLowBlinkFrequency / this.healthPointLowBlinkFrequency, 3f));
      mat.SetColor(PlayerFloorHealthDisplay.fillID, color);
      mat.SetColor(PlayerFloorHealthDisplay.outlineID, color);
    }

    private void SetHPActive(Material mat, bool active)
    {
      mat.SetColor(PlayerFloorHealthDisplay.fillID, active ? this.healthPointActiveFill : this.healthPointInactiveFill);
      mat.SetColor(PlayerFloorHealthDisplay.outlineID, active ? this.healthPointActiveOutline : this.healthPointInactiveOutline);
    }
  }
}
