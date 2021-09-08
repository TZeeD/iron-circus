// Decompiled with JetBrains decompiler
// Type: Sandbox.Wiktor.MenuScripts.LowHealthHazeUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.ScriptableObjects;
using SharedWithServer.ScEvents;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

namespace Sandbox.Wiktor.MenuScripts
{
  public class LowHealthHazeUi : MonoBehaviour
  {
    [SerializeField]
    private Image haze;
    [SerializeField]
    private float hazePulseDuration = 1f;
    [SerializeField]
    private float hazeBlinkDuration = 1f;
    [SerializeField]
    private float hazeFrom;
    [SerializeField]
    private int hazeBlinkCount = 3;
    private bool playHaze;
    private bool stateAllowsPlayHaze;
    private Color hazeColor;
    private int currentHp;

    private void Start()
    {
      this.hazeColor = this.haze.color;
      Events.Global.OnEventPlayerHealthChanged += new Events.EventPlayerHealthChanged(this.OnPlayerHealthChanged);
      Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
      Events.Global.OnEventPickupConsumed += new Events.EventPickupConsumed(this.OnPickupConsumed);
    }

    private void OnGameStateChangedEvent(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      this.SetHazeColor(0.0f);
      switch (matchState)
      {
        case Imi.SharedWithServer.Game.MatchState.Intro:
          this.stateAllowsPlayHaze = false;
          break;
        case Imi.SharedWithServer.Game.MatchState.GetReady:
          this.stateAllowsPlayHaze = false;
          break;
        case Imi.SharedWithServer.Game.MatchState.StartPoint:
          this.stateAllowsPlayHaze = true;
          break;
        case Imi.SharedWithServer.Game.MatchState.PointInProgress:
          this.stateAllowsPlayHaze = true;
          break;
        case Imi.SharedWithServer.Game.MatchState.Goal:
          this.stateAllowsPlayHaze = false;
          break;
        case Imi.SharedWithServer.Game.MatchState.MatchOver:
          this.stateAllowsPlayHaze = false;
          break;
        case Imi.SharedWithServer.Game.MatchState.VictoryScreen:
          this.stateAllowsPlayHaze = false;
          break;
        case Imi.SharedWithServer.Game.MatchState.VictoryPose:
          this.stateAllowsPlayHaze = false;
          break;
      }
    }

    private void OnPlayerHealthChanged(
      ulong playerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead)
    {
      if (!Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId).isLocalEntity)
        return;
      if (currentHealth == 1)
      {
        this.hazeColor = SingletonScriptableObject<ColorsConfig>.Instance.characterFlashDamage;
        this.SetHazeColor(0.0f);
        this.playHaze = true;
      }
      else
      {
        this.playHaze = false;
        this.SetHazeColor(0.0f);
        if (currentHealth < this.currentHp)
          this.PlayBlinkHaze(this.hazeBlinkDuration, this.hazeBlinkCount, SingletonScriptableObject<ColorsConfig>.Instance.characterFlashDamage);
        else if (currentHealth > this.currentHp)
          this.PlayBlinkHaze(this.hazeBlinkDuration, this.hazeBlinkCount, SingletonScriptableObject<ColorsConfig>.Instance.characterFlashHeal);
      }
      this.currentHp = currentHealth;
    }

    private void Update()
    {
      if (!this.playHaze || !this.stateAllowsPlayHaze)
        return;
      this.hazeColor.a = (Mathf.PingPong(Time.time, this.hazePulseDuration) + this.hazeFrom) / this.hazePulseDuration;
      this.haze.color = this.hazeColor;
    }

    public void PlayBlinkHaze(float duration, int blinkCount, Color blinkColor)
    {
      if (!this.stateAllowsPlayHaze)
        return;
      this.hazeColor = blinkColor;
      this.SetHazeColor(0.0f);
      this.StartCoroutine(this.PlayBlinkHaze(duration, blinkCount));
    }

    private IEnumerator PlayBlinkHaze(float duration, int blinkCount)
    {
      bool tempPlayHaze = this.playHaze;
      this.playHaze = false;
      this.SetHazeColor(0.0f);
      for (int k = 0; k < blinkCount; ++k)
      {
        float i;
        for (i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
        {
          this.SetHazeColor(i / duration);
          yield return (object) null;
        }
        for (i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
        {
          this.SetHazeColor((float) (1.0 - (double) i / (double) duration));
          yield return (object) null;
        }
      }
      this.hazeColor = SingletonScriptableObject<ColorsConfig>.Instance.characterFlashDamage;
      this.SetHazeColor(0.0f);
      this.playHaze = tempPlayHaze;
    }

    private void SetHazeColor(float alpha)
    {
      this.hazeColor.a = alpha;
      this.haze.color = this.hazeColor;
    }

    private void OnDestroy()
    {
      Events.Global.OnEventPlayerHealthChanged -= new Events.EventPlayerHealthChanged(this.OnPlayerHealthChanged);
      Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
      Events.Global.OnEventPickupConsumed -= new Events.EventPickupConsumed(this.OnPickupConsumed);
    }

    private void OnPickupConsumed(UniqueId id, UniqueId playerUniqueId)
    {
      GameEntity entityWithUniqueId = Contexts.sharedInstance.game.GetFirstEntityWithUniqueId(playerUniqueId);
      if (entityWithUniqueId == null || !entityWithUniqueId.isLocalEntity)
        return;
      GameEntity gameEntity = Contexts.sharedInstance.game.GetEntitiesWithUniqueId(id).SingleEntity<GameEntity>();
      if (gameEntity.pickup.activeType == PickupType.RefreshSkills)
      {
        this.PlayBlinkHaze(this.hazeBlinkDuration, this.hazeBlinkCount, SingletonScriptableObject<ColorsConfig>.Instance.characterFlashSkillPickup);
      }
      else
      {
        if (gameEntity.pickup.activeType != PickupType.RegainHealth)
          return;
        this.PlayBlinkHaze(this.hazeBlinkDuration, this.hazeBlinkCount, SingletonScriptableObject<ColorsConfig>.Instance.characterFlashHeal);
      }
    }
  }
}
