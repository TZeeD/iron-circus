// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Core.SystemsFactory
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay.Pickup;
using Imi.SharedWithServer.ScEntitas.Systems.Player;
using Imi.SharedWithServer.ScEntitas.Systems.Utility;
using Imi.SteelCircus.ScEntitas.Systems;
using Imi.SteelCircus.ScEntitas.Systems.ViewSystems;
using SharedWithServer.ScEntitas.Systems.Gameplay;

namespace Imi.SteelCircus.Core
{
  public static class SystemsFactory
  {
    public static Entitas.Systems CreateRepredictionSystems(EntitasSetup entitasSetup)
    {
      EntitasSystemsBuilder entitasSystemsBuilder = new EntitasSystemsBuilder();
      entitasSystemsBuilder.With(new PlayerMoveSystem(entitasSetup));
      entitasSystemsBuilder.With(new SkillGraphSystem(entitasSetup));
      entitasSystemsBuilder.With(new BallUpdateSystem(entitasSetup));
      entitasSystemsBuilder.With(new CollisionCleanupSystem(entitasSetup));
      entitasSystemsBuilder.With(new PhysicsTickSystem(entitasSetup));
      entitasSystemsBuilder.With(new StatusEffectSystem(entitasSetup));
      entitasSystemsBuilder.With(new CollisionEventSystem(entitasSetup));
      entitasSystemsBuilder.With(new TriggerLeaveSystem(entitasSetup));
      return entitasSystemsBuilder.Build();
    }

    public static Entitas.Systems CreateArenaLoadingSystems(EntitasSetup entitasSetup) => new EntitasSystemsBuilder().Build();

    public static Entitas.Systems CreateSystemsWithBuilder(EntitasSetup entitasSetup)
    {
      EntitasSystemsBuilder entitasSystemsBuilder = new EntitasSystemsBuilder();
      entitasSystemsBuilder.With(new SetupArenaVariationSystem(entitasSetup));
      entitasSystemsBuilder.With(new ForcefieldUpdateSystem(entitasSetup));
      entitasSystemsBuilder.With(new PlayerMoveSystem(entitasSetup));
      entitasSystemsBuilder.With(new SkillGraphSystem(entitasSetup));
      entitasSystemsBuilder.With(new BallUpdateSystem(entitasSetup));
      entitasSystemsBuilder.With(new RespawnTransformSystem(entitasSetup));
      entitasSystemsBuilder.With(new SetupPointSystem(entitasSetup));
      entitasSystemsBuilder.With(new PlayerResetSystem(entitasSetup));
      entitasSystemsBuilder.With(new StatusEffectSystem(entitasSetup));
      entitasSystemsBuilder.With(new CountdownSystem(entitasSetup));
      entitasSystemsBuilder.With(new CollisionCleanupSystem(entitasSetup));
      entitasSystemsBuilder.With(new PhysicsTickSystem(entitasSetup));
      entitasSystemsBuilder.With(new CollisionEventSystem(entitasSetup));
      entitasSystemsBuilder.With(new TriggerLeaveSystem(entitasSetup));
      entitasSystemsBuilder.With(new PickupConsumedSystem(entitasSetup));
      entitasSystemsBuilder.With(new DestroyEntitySystem(entitasSetup));
      return entitasSystemsBuilder.Build();
    }

    public static Entitas.Systems CreateClientOnlySystems(EntitasSetup entitasSetup)
    {
      Entitas.Systems systems = new Entitas.Systems();
      systems.Add((ISystem) new AnimationSystem(entitasSetup));
      systems.Add((ISystem) new LocalPlayerVisualSmoothingSystem(entitasSetup));
      systems.Add((ISystem) new UpdateBallViewSystem(entitasSetup));
      systems.Add((ISystem) new LinkUnityViewSystem(entitasSetup.Contexts));
      systems.Add((ISystem) new UnityViewTeardownSystem(entitasSetup));
      systems.Add((ISystem) new ForcefieldViewSystem(entitasSetup));
      systems.Add((ISystem) new CameraTargetSystem(entitasSetup));
      return systems;
    }
  }
}
