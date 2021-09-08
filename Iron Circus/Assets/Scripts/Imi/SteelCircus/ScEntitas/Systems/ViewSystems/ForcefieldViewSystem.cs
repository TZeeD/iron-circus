// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.ViewSystems.ForcefieldViewSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using SteelCircus.GameElements;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems.ViewSystems
{
  public class ForcefieldViewSystem : ReactiveGameSystem
  {
    public ForcefieldViewSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.MatchState.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity)
    {
      if (!entity.hasMatchState)
        return false;
      return entity.matchState.value == Imi.SharedWithServer.Game.MatchState.StartPoint || entity.matchState.value == Imi.SharedWithServer.Game.MatchState.GetReady || entity.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress;
    }

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity entity in entities)
      {
        if (entity.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress)
        {
          this.DisableForcefields();
          Debug.Log((object) "DisableForceFieldView");
        }
        else
        {
          Debug.Log((object) "EnableForceFieldView");
          this.EnableForcefields();
        }
      }
    }

    private void EnableForcefields()
    {
      foreach (GameEntity entity in this.gameContext.GetGroup(GameMatcher.Forcefield).GetEntities())
      {
        if (entity.forcefield.deactivateDuringPoint)
          entity.unityView.gameObject.GetComponent<DeactivateableForcefield>().Activate();
      }
    }

    private void DisableForcefields()
    {
      foreach (GameEntity entity in this.gameContext.GetGroup(GameMatcher.Forcefield).GetEntities())
      {
        if (entity.forcefield.deactivateDuringPoint)
          entity.unityView.gameObject.GetComponent<DeactivateableForcefield>().Deactivate();
      }
    }
  }
}
