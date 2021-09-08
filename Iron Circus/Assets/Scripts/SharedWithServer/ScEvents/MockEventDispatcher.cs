// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEvents.MockEventDispatcher
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.ScEvents;
using Imi.SharedWithServer.Game;

namespace SharedWithServer.ScEvents
{
  public class MockEventDispatcher : AEventDispatcher
  {
    public override void AddListener(
      GameplayEventType type,
      AEventDispatcher.GenericGameEventHandler<GameplayEvent> eventHandler)
    {
    }

    public override void RemoveListener(
      GameplayEventType type,
      AEventDispatcher.GenericGameEventHandler<GameplayEvent> eventHandler)
    {
    }

    public override void EnqueueEvent(GameplayEvent evt)
    {
    }

    public override void Process()
    {
    }

    public override Events GetEventsReference() => Events.Global;

    public override void RaiseTrackingEvent(
      ulong playerId,
      Statistics statistics,
      float value = 1f,
      StatisticsMode mode = StatisticsMode.Add)
    {
    }

    public override void EnqueueBallThrow(ulong id, Team team, double timestamp = -1.0)
    {
    }

    public override void EnqueueBallPickup(
      ulong id,
      Team team,
      float velocityMagnitude,
      double timestamp = -1.0)
    {
    }

    public override void EnqueueBallToBoundsCollision(double timestamp = -1.0)
    {
    }

    public override void EnqueueBallDrop(ulong id, double timestamp = -1.0)
    {
    }

    public override void EnqueuePass(ulong from, ulong to, Team team, double timestamp = -1.0)
    {
    }

    public override void EnqueueTackleEvent(ulong getOwnerId, double timestamp = -1.0)
    {
    }

    public override void EnqueueTackleHitEvent(ulong id, ulong tackledPlayer, double timestamp = -1.0)
    {
    }

    public override void EnqueueBallSteal(
      ulong stealingPlayerId,
      ulong ballStealedPlayerId,
      double timestamp = -1.0)
    {
    }

    public override void EnqueueTackleDodged(ulong id, ulong dodgedPlayer, double timestamp = -1.0)
    {
    }

    public override void EnqueueDodgeEvent(ulong id, double timestamp = -1.0)
    {
    }

    public override void EnqueueScoreEvent(
      ulong id,
      Team team,
      bool hasOwner,
      bool ownGoal,
      float distanceToGoal,
      bool someoneDeadOpponents,
      double timestamp = -1.0)
    {
    }

    public override void EnqueueDamageDone(ulong id, ulong toId, int damage, double timestamp = -1.0)
    {
    }

    public override void EnqueueDeathKillEvent(ulong id, ulong instigator, double timestamp = -1.0)
    {
    }

    public override void EnqueueStunEvent(
      ulong playerIdValue,
      ulong getOwnerId,
      float stunDuration,
      double timestamp = -1.0)
    {
    }

    public override void EnqueueBallToBumperCollision(
      UniqueId bumperId,
      BumperType bumperType,
      double timestamp = -1.0)
    {
    }

    public override void EnqueueBallToPlayerCollision(ulong id, Team team, double timestamp = -1.0)
    {
    }

    public override void EnqueuePickupCollected(ulong id, double timestamp = -1.0)
    {
    }
  }
}
