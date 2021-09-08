// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEntitas.Systems.Gameplay.SetupArenaVariationSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using SharedWithServer.ScEvents;
using System.Collections.Generic;

namespace SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class SetupArenaVariationSystem : ReactiveGameSystem
  {
    private readonly MatchConfig matchConfig;
    private Events events;

    public SetupArenaVariationSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
      this.matchConfig = entitasSetup.ConfigProvider.matchConfig;
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.MatchState.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity) => entity.hasMatchState && entity.matchState.value == Imi.SharedWithServer.Game.MatchState.Intro;

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity gameEntity in this.gameContext.GetGroup(GameMatcher.Pickup))
        ;
    }
  }
}
