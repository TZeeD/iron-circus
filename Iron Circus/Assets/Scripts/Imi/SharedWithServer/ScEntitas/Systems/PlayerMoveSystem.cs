// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.PlayerMoveSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class PlayerMoveSystem : ExecuteGameSystem
  {
    protected readonly IGroup<GameEntity> players;

    public PlayerMoveSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.players = this.gameContext.GetGroup(GameMatcher.Player);
    }

    protected override void GameExecute()
    {
      foreach (GameEntity player in this.players)
      {
        if (player.isLocalEntity)
        {
          JVector jvector = JVector.Zero;
          if (this.CanMove(player))
            jvector = player.input.GetInput(this.gameContext.globalTime.currentTick).moveDir;
          this.UpdateOrientation(player, jvector);
          PlayerMoveSystem.UpdateVelocity(player, jvector, this.gameContext.globalTime.fixedSimTimeStep);
          JVector position = player.transform.position;
          position.Y = 0.0f;
          player.TransformReplacePosition(position);
        }
      }
    }

    private bool CanMove(GameEntity player)
    {
      if (!this.gameContext.hasMatchState || player.IsMoveBlocked() || player.HasModifier(StatusModifier.BlockTranslate))
        return false;
      return this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress || this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.Goal || this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.GetReady || this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.StartPoint;
    }

    private void UpdateOrientation(GameEntity player, JVector inputMoveDir)
    {
      if ((double) inputMoveDir.LengthSquared() <= 0.0)
        return;
      ChampionConfig championConfig = player.championConfig.value;
      if (championConfig.useTurnSpeed)
        player.TransformRotateTowards(inputMoveDir, championConfig.turnSpeed * this.gameContext.globalTime.fixedSimTimeStep);
      else
        player.TransformRotateTowards(inputMoveDir);
    }

    public static void UpdateVelocity(GameEntity player, JVector input, float deltaT)
    {
      ChampionConfig championConfig = player.championConfig.value;
      float maxSpeed = championConfig.maxSpeed;
      float acceleration = championConfig.acceleration;
      float deceleration = championConfig.deceleration;
      float num1 = championConfig.controlsThrusterContribution;
      List<MovementModifier> modifier = player.movement.modifier;
      for (int index = 0; index < modifier.Count; ++index)
      {
        MovementModifier movementModifier = modifier[index];
        switch (movementModifier.type)
        {
          case MovementModifierType.OverrideMovement:
            maxSpeed = movementModifier.maxSpeed;
            acceleration = movementModifier.acceleration;
            deceleration = movementModifier.deceleration;
            num1 = movementModifier.thrustPercent;
            break;
          case MovementModifierType.SetVelocity:
            player.ReplaceVelocityOverride(movementModifier.velocity);
            return;
          case MovementModifierType.OverrideMoveDir:
            input = movementModifier.moveDir;
            break;
        }
      }
      float num2 = player.SpeedScale();
      float num3 = maxSpeed * num2;
      JVector vector = player.velocityOverride.value;
      JVector jvector1 = input * num3;
      float num4 = vector.Length();
      float num5 = jvector1.Length();
      double num6 = (double) num5 - (double) num4;
      float num7 = (jvector1 - vector).Length();
      float num8 = JMath.Abs((float) num6);
      bool flag = num6 > 0.0;
      float num9 = JMath.Clamp01(((double) num8 > 1.0 / 1000.0 ? (flag ? acceleration : deceleration) / num8 : 1f) * deltaT);
      JVector jvector2 = (input.IsNearlyZero() ? vector.Normalized() : input.Normalized()) * (float) ((1.0 - (double) num9) * (double) num4 + (double) num9 * (double) num5);
      float t = JMath.Clamp01(((double) num7 > 1.0 / 1000.0 ? (flag ? acceleration : deceleration) / num7 : 1f) * deltaT);
      JVector jvector3 = JVector.Lerp(vector, jvector1, t);
      double num10 = (double) num1;
      JVector newValue = JVector.Lerp(jvector2, jvector3, (float) num10);
      player.ReplaceVelocityOverride(newValue);
    }
  }
}
