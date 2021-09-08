// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Features.GameplayElementsFeature
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay.Pickup;

namespace Imi.SharedWithServer.ScEntitas.Features
{
  public sealed class GameplayElementsFeature : Entitas.Systems
  {
    public static GameplayElementsFeature.Builder Build() => new GameplayElementsFeature.Builder();

    public class Builder : FeatureBuilder<GameplayElementsFeature>
    {
      private BallUpdateSystem ballUpdateSystem;
      private ProjectileMoveSystem projectileMoveSystem;
      private GoalCollisionSystem goalCollisionSystem;
      private PickupConsumedSystem pickupConsumedSystem;
      private PickupBehaviourSystem pickupBehaviourSystem;

      public GameplayElementsFeature.Builder With(
        ProjectileMoveSystem projectileMoveSystem)
      {
        this.projectileMoveSystem = projectileMoveSystem;
        return this;
      }

      public GameplayElementsFeature.Builder With(
        BallUpdateSystem ballUpdateSystem)
      {
        this.ballUpdateSystem = ballUpdateSystem;
        return this;
      }

      public GameplayElementsFeature.Builder With(
        GoalCollisionSystem goalCollisionSystem)
      {
        this.goalCollisionSystem = goalCollisionSystem;
        return this;
      }

      public GameplayElementsFeature.Builder With(
        PickupConsumedSystem pickupConsumedSystem)
      {
        this.pickupConsumedSystem = pickupConsumedSystem;
        return this;
      }

      public override GameplayElementsFeature Create()
      {
        this.AddIfNotNull((ISystem) this.projectileMoveSystem);
        this.AddIfNotNull((ISystem) this.pickupBehaviourSystem);
        this.AddIfNotNull((ISystem) this.ballUpdateSystem);
        this.AddIfNotNull((ISystem) this.goalCollisionSystem);
        this.AddIfNotNull((ISystem) this.pickupConsumedSystem);
        return this.feature;
      }

      public GameplayElementsFeature.Builder With(
        PickupBehaviourSystem pickupBehaviourSystem)
      {
        this.pickupBehaviourSystem = pickupBehaviourSystem;
        return this;
      }
    }
  }
}
