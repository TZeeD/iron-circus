// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.TriggerLeaveSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Jitter.Dynamics;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class TriggerLeaveSystem : ExecuteGameSystem
  {
    private readonly IGroup<GameEntity> triggerEvents;

    public TriggerLeaveSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.triggerEvents = this.gameContext.GetGroup(GameMatcher.TriggerEvent);
    }

    protected override void GameExecute()
    {
      int currentTick = this.gameContext.globalTime.currentTick;
      foreach (GameEntity entity in this.triggerEvents.GetEntities())
      {
        if (entity.triggerEvent.lastCollisionFrame != currentTick)
        {
          JTriggerPair bodies = entity.triggerEvent.bodies;
          entity.RemoveTriggerEvent();
          entity.isDestroyed = true;
          JRigidbody body1 = bodies.body1;
          JRigidbody body2 = bodies.body2;
          this.gameContext.CreateEntity().AddTriggerExitEvent(body1, body2);
        }
      }
    }
  }
}
