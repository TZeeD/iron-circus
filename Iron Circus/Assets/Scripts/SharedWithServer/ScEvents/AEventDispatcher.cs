// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEvents.AEventDispatcher
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.ScEvents;
using Imi.SharedWithServer.Game;

namespace SharedWithServer.ScEvents
{
  public abstract class AEventDispatcher
  {
    public abstract void AddListener(
      GameplayEventType type,
      AEventDispatcher.GenericGameEventHandler<GameplayEvent> eventHandler);

    public abstract void RemoveListener(
      GameplayEventType type,
      AEventDispatcher.GenericGameEventHandler<GameplayEvent> eventHandler);

    public abstract void EnqueueEvent(GameplayEvent evt);

    public abstract void Process();

    public abstract Events GetEventsReference();

    public abstract void RaiseTrackingEvent(
      ulong playerId,
      Statistics statistics,
      float value = 1f,
      StatisticsMode mode = StatisticsMode.Add);

    public abstract void EnqueueBallThrow(ulong id, Team team, double timestamp = -1.0);

    public abstract void EnqueueBallPickup(
      ulong id,
      Team team,
      float velocityMagnitude,
      double timestamp = -1.0);

    public abstract void EnqueueBallDrop(ulong id, double timestamp = -1.0);

    public abstract void EnqueuePass(ulong from, ulong to, Team team, double timestamp = -1.0);

    public abstract void EnqueueTackleEvent(ulong id, double timestamp = -1.0);

    public abstract void EnqueueTackleHitEvent(ulong id, ulong tackledPlayer, double timestamp = -1.0);

    public abstract void EnqueueBallSteal(
      ulong stealingPlayerId,
      ulong ballStealedPlayerId,
      double timestamp = -1.0);

    public abstract void EnqueueTackleDodged(ulong id, ulong dodgedPlayer, double timestamp = -1.0);

    public abstract void EnqueueDodgeEvent(ulong id, double timestamp = -1.0);

    public abstract void EnqueueScoreEvent(
      ulong id,
      Team team,
      bool hasOwner,
      bool ownGoal,
      float distanceToGoal,
      bool someoneDeadOpponents,
      double timestamp = -1.0);

    public abstract void EnqueueDamageDone(ulong id, ulong toId, int damage, double timestamp = -1.0);

    public abstract void EnqueueDeathKillEvent(ulong id, ulong instigator, double timestamp = -1.0);

    public abstract void EnqueueStunEvent(
      ulong playerIdValue,
      ulong getOwnerId,
      float stunDuration,
      double timestamp = -1.0);

    public abstract void EnqueueBallToBoundsCollision(double timestamp = -1.0);

    public abstract void EnqueueBallToBumperCollision(
      UniqueId bumperId,
      BumperType bumperType,
      double timestamp = -1.0);

    public abstract void EnqueueBallToPlayerCollision(ulong id, Team team, double timestamp = -1.0);

    public abstract void EnqueuePickupCollected(ulong id, double timestamp = -1.0);

    public delegate void GenericGameEventHandler<T>(T evt) where T : GameplayEvent;
  }
}
