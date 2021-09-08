// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.ViewSystems.LinkUnityViewSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems.ViewSystems
{
  public class LinkUnityViewSystem : ReactiveSystem<GameEntity>
  {
    private readonly GameContext context;

    public LinkUnityViewSystem(Contexts contexts)
      : base((IContext<GameEntity>) contexts.game)
    {
      this.context = contexts.game;
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> gameContext)
    {
      return gameContext.CreateCollector<GameEntity>(GameMatcher.UnityView.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity) => entity.hasUnityView;

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity entity in entities)
      {
        GameObject gameObject = entity.unityView.gameObject;
        if ((Object) gameObject != (Object) null && (Object) gameObject.GetComponent<EntityLink>() == (Object) null)
          gameObject.Link((IEntity) entity, (IContext) this.context);
      }
    }
  }
}
