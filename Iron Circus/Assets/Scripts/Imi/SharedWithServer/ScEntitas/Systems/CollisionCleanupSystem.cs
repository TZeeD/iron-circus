// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.CollisionCleanupSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class CollisionCleanupSystem : ExecuteGameSystem
  {
    private readonly IGroup<GameEntity> collisionEvents;
    private readonly IGroup<GameEntity> triggerEvents;

    public CollisionCleanupSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.collisionEvents = this.gameContext.GetGroup(GameMatcher.CollisionEvent);
      this.triggerEvents = this.gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AnyOf(GameMatcher.TriggerEnterEvent, GameMatcher.TriggerStayEvent, GameMatcher.TriggerExitEvent));
    }

    protected override void GameExecute()
    {
      this.gameContext.collisionEvents.collisions.Clear();
      this.gameContext.collisionEvents.triggerEnter.Clear();
      this.gameContext.collisionEvents.triggerStay.Clear();
      foreach (Entity entity in this.collisionEvents.GetEntities())
        entity.Destroy();
      foreach (GameEntity entity in this.triggerEvents.GetEntities())
      {
        if (entity.hasTriggerEnterEvent)
          entity.RemoveTriggerEnterEvent();
        if (entity.hasTriggerStayEvent)
          entity.RemoveTriggerStayEvent();
        if (entity.hasTriggerExitEvent)
          entity.RemoveTriggerExitEvent();
        entity.Destroy();
      }
    }
  }
}
