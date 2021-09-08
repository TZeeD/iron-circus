// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.Pickup.PickupConsumedSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay.Pickup
{
  public class PickupConsumedSystem : GameSystem, ICleanupSystem, ISystem
  {
    private readonly IGroup<GameEntity> group;

    public PickupConsumedSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.group = this.gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.PickupConsumed, GameMatcher.Player));
    }

    public void Cleanup()
    {
      foreach (GameEntity entity in this.group.GetEntities())
        entity.RemovePickupConsumed();
    }
  }
}
