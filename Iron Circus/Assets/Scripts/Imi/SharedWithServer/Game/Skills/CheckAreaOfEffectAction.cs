// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.CheckAreaOfEffectAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class CheckAreaOfEffectAction : SkillAction
  {
    public ConfigValue<AreaOfEffect> aoe;
    [SyncValue]
    public SyncableValue<JVector> position;
    [SyncValue]
    public SyncableValue<JVector> lookDir;
    public SkillVar<UniqueId> hitEntities;
    public bool includeEnemies;
    public bool includeTeammates;
    public bool includeOwner;
    public bool includeBall;
    public Func<GameEntity, bool> filterHit;
    public OutPlug OnHit;
    public OutPlug OnMiss;
    private List<UniqueId> hitList = new List<UniqueId>();

    public CheckAreaOfEffectAction()
    {
      this.OnHit = this.AddOutPlug();
      this.OnMiss = this.AddOutPlug();
    }

    protected override void PerformActionInternal()
    {
      if (this.skillGraph.IsClient())
        this.CheckHit();
      if (!this.skillGraph.IsServer())
        return;
      int num1 = this.skillGraph.GetRttt() / 2;
      Action<int, int, GameEntity, Action> pastPhysicsState = this.skillGraph.GetContext().gamePhysics.checkPastPhysicsState;
      int tick = this.skillGraph.GetTick();
      int num2 = tick;
      int num3 = tick - num1;
      GameEntity owner = this.skillGraph.GetOwner();
      Action action = new Action(this.CheckHit);
      pastPhysicsState(num2, num3, owner, action);
    }

    private void CheckHit()
    {
      bool flag = CheckAreaOfEffectAction.CheckHitStatic(this.skillGraph, this.aoe.Get(), this.position.Get(), this.lookDir.Get(), this.hitList, this.includeOwner, this.includeTeammates, this.includeEnemies, this.includeBall);
      if (this.filterHit != null)
      {
        for (int index = this.hitList.Count - 1; index >= 0; --index)
        {
          GameEntity entityWithUniqueId = this.skillGraph.GetContext().GetFirstEntityWithUniqueId(this.hitList[index]);
          if (entityWithUniqueId != null && this.filterHit(entityWithUniqueId))
            this.hitList.RemoveAt(index);
        }
      }
      this.hitEntities.Set(this.hitList);
      if (flag)
        this.OnHit.Fire(this.skillGraph);
      else
        this.OnMiss.Fire(this.skillGraph);
    }

    public static bool CheckHitStatic(
      SkillGraph skillGraph,
      AreaOfEffect aoe,
      JVector position,
      JVector lookDir,
      List<UniqueId> hitEntities,
      bool includeOwner,
      bool includeTeammates,
      bool includeEnemies,
      bool includeBall)
    {
      hitEntities.Clear();
      GameEntity owner = skillGraph.GetOwner();
      Team team1 = owner.playerTeam.value;
      foreach (GameEntity player in skillGraph.GetPlayers())
      {
        bool flag = owner == player;
        if (!player.IsDead() && !(!includeOwner & flag))
        {
          Team team2 = player.playerTeam.value;
          if ((flag || team2 != team1 || includeTeammates) && (team2 == team1 || includeEnemies) && aoe.IsInRange2D(position, lookDir, player.rigidbody.value))
            hitEntities.Add(player.uniqueId.id);
        }
      }
      if (includeBall)
      {
        GameEntity ballEntity = skillGraph.GetContext().ballEntity;
        if (ballEntity != null && aoe.IsInRange2D(position, lookDir, ballEntity.rigidbody.value))
          hitEntities.Add(ballEntity.uniqueId.id);
      }
      return hitEntities.Count > 0;
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.position.Parse(serializationInfo, ref valueIndex, this.Name + ".position");
      this.lookDir.Parse(serializationInfo, ref valueIndex, this.Name + ".lookDir");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.position.Serialize(target, ref valueIndex);
      this.lookDir.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.position.Deserialize(target, ref valueIndex);
      this.lookDir.Deserialize(target, ref valueIndex);
    }
  }
}
