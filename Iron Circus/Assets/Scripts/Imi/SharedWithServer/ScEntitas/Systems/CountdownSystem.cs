// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.CountdownSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.ScEntitas.Components;
using System;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class CountdownSystem : ExecuteGameSystem
  {
    private readonly IGroup<GameEntity> group;

    public CountdownSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.group = this.gameContext.GetGroup(GameMatcher.CountdownAction);
    }

    protected override void GameExecute()
    {
      foreach (GameEntity entity in this.group.GetEntities())
        this.UpdateCountdown(entity);
    }

    private void UpdateCountdown(GameEntity gameEntity)
    {
      if ((gameEntity.countdownAction.value.paused == null ? 0 : (gameEntity.countdownAction.value.paused() ? 1 : 0)) != 0)
        return;
      CountdownAction countdownAction = gameEntity.countdownAction.value;
      float num = countdownAction.currentT + this.gameContext.globalTime.fixedSimTimeStep;
      countdownAction.currentT = num;
      Action<float, float> onUpdate = countdownAction.onUpdate;
      if (onUpdate != null)
        onUpdate((double) num >= (double) countdownAction.duration ? 1f : num / countdownAction.duration, this.gameContext.globalTime.fixedSimTimeStep);
      bool flag = countdownAction.earlyExitCondition != null && countdownAction.earlyExitCondition();
      if ((double) num >= (double) countdownAction.duration || flag && countdownAction.executeFinishedActionOnEarlyExit)
      {
        Action onFinished = countdownAction.onFinished;
        if (onFinished != null)
          onFinished();
      }
      if (!((double) countdownAction.currentT >= (double) countdownAction.duration | flag) || !gameEntity.isEnabled)
        return;
      if (countdownAction.destroyEntityWhenDone)
        gameEntity.Destroy();
      else
        gameEntity.RemoveCountdownAction();
    }
  }
}
