// Decompiled with JetBrains decompiler
// Type: SteelCircus.GameElements.PickupSpawnpointUnityBehaviourBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.GameElements;
using SharedWithServer.ScEvents;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;

namespace SteelCircus.GameElements
{
  public abstract class PickupSpawnpointUnityBehaviourBase : MonoBehaviour
  {
    [ReadOnly]
    public GameObject pickupGo;
    protected float timeLeft = -1f;
    protected Pickup pickup;
    protected GameUniqueId id;
    protected Dictionary<PickupType, GameObject> PickupViews;
    protected bool runCooldown;

    protected void InitializeBase()
    {
      this.pickup = this.GetComponent<Pickup>();
      this.id = this.GetComponent<GameUniqueId>();
      Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChanged);
      Events.Global.OnEventPickupConsumed += new Events.EventPickupConsumed(this.OnPickupConsumed);
      Events.Global.OnEventPickupReset += new Events.EventPickupReset(this.OnResetPickup);
      Events.Global.OnEventPickupWillSpawn += new Events.EventPickupWillSpawn(this.OnPickupWillSpawn);
    }

    private void OnResetPickup(UniqueId uniqueId)
    {
      if ((int) uniqueId.Value() != this.id.GetId())
        return;
      Log.Debug(string.Format("PickupResetMessage received. Pickup Id: {0} Spawnpoint Id: {1}", (object) uniqueId, (object) this.id.GetId()));
      this.timeLeft = this.pickup.respawnDuration;
      this.OnUpdate();
    }

    protected abstract void OnUpdate();

    private void OnGameStateChanged(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneduration,
      float remainingmatchtime)
    {
      if (matchState == Imi.SharedWithServer.Game.MatchState.GetReady)
        this.timeLeft = !this.pickup.isActiveOnStart ? this.pickup.respawnDuration : -1f;
      if (matchState == Imi.SharedWithServer.Game.MatchState.PointInProgress)
        this.runCooldown = true;
      else
        this.runCooldown = false;
    }

    private void OnPickupWillSpawn(UniqueId uniqueId, PickupType pickupType, float duration) => this.timeLeft = duration;

    private void OnPickupConsumed(UniqueId uniqueId, UniqueId playerUniqueId)
    {
      Log.Debug(string.Format("PickupConsumedMessage received. Pickup Id: {0} Spawnpoint Id: {1}", (object) uniqueId, (object) this.id.GetId()));
      if ((int) uniqueId.Value() != this.id.GetId())
        return;
      this.timeLeft = this.pickup.respawnDuration;
    }

    protected abstract void CreatePickupViews();

    public abstract void ActivatePickupView(GameEntity entity);

    public abstract void DeactivatePickupView(PickupType type);

    public abstract void ShowPickupCountdown(UniqueId uId, PickupType type, float timeLeft);

    protected void CleanUpBase()
    {
      Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChanged);
      Events.Global.OnEventPickupConsumed -= new Events.EventPickupConsumed(this.OnPickupConsumed);
      Events.Global.OnEventPickupWillSpawn -= new Events.EventPickupWillSpawn(this.OnPickupWillSpawn);
    }
  }
}
