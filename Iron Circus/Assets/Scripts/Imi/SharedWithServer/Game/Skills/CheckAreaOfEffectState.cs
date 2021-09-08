﻿// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.CheckAreaOfEffectState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class CheckAreaOfEffectState : SkillState
  {
    public ConfigValue<AreaOfEffect> aoe;
    [SyncValue]
    public SyncableValue<JVector> position;
    [SyncValue]
    public SyncableValue<JVector> lookDir;
    public SkillVar<UniqueId> hitEntities;
    public SkillVar<UniqueId> hitEnterEntities;
    public SkillVar<UniqueId> hitExitEntities;
    public float repeatedHitCooldown = -1f;
    public bool includeEnemies;
    public bool includeTeammates;
    public bool includeOwner;
    public bool includeBall;
    public bool singleHitPerEntity;
    public Action onHitDelegate;
    public OutPlug OnHit;
    public OutPlug OnEnterHit;
    public OutPlug OnExitHit;
    public Func<GameEntity, bool> filterHit;
    private List<UniqueId> lastEntitiesInRange = new List<UniqueId>();
    private List<UniqueId> currentEntitiesInRange = new List<UniqueId>();
    private List<UniqueId> hitList = new List<UniqueId>();
    private List<UniqueId> hitEnterList = new List<UniqueId>();
    private List<UniqueId> hitExitList = new List<UniqueId>();
    private List<UniqueId> excludeEntitiesList = new List<UniqueId>();
    private List<float> excludeCooldowns = new List<float>();

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

    public CheckAreaOfEffectState()
    {
      this.OnHit = this.AddOutPlug();
      this.OnEnterHit = this.AddOutPlug();
      this.OnExitHit = this.AddOutPlug();
    }

    protected override void EnterDerived()
    {
      this.lastEntitiesInRange.Clear();
      this.excludeEntitiesList.Clear();
      this.excludeCooldowns.Clear();
    }

    protected override void TickDerived()
    {
      if (this.skillGraph.IsClient())
        this.CheckHit();
      if (!this.skillGraph.IsServer())
        return;
      int rttt = this.skillGraph.GetRttt();
      Action<int, int, GameEntity, Action> pastPhysicsState = this.skillGraph.GetContext().gamePhysics.checkPastPhysicsState;
      int tick = this.skillGraph.GetTick();
      int num1 = tick;
      int num2 = tick - rttt;
      GameEntity owner = this.skillGraph.GetOwner();
      Action action = new Action(this.CheckHit);
      pastPhysicsState(num1, num2, owner, action);
    }

    private void CheckHit()
    {
      CheckAreaOfEffectAction.CheckHitStatic(this.skillGraph, this.aoe.Get(), (JVector) this.position, (JVector) this.lookDir, this.currentEntitiesInRange, this.includeOwner, this.includeTeammates, this.includeEnemies, this.includeBall);
      if (this.filterHit != null)
      {
        for (int index = this.currentEntitiesInRange.Count - 1; index >= 0; --index)
        {
          GameEntity entityWithUniqueId = this.skillGraph.GetContext().GetFirstEntityWithUniqueId(this.currentEntitiesInRange[index]);
          if (entityWithUniqueId != null && this.filterHit(entityWithUniqueId))
            this.currentEntitiesInRange.RemoveAt(index);
        }
      }
      if (this.hitEnterEntities != null)
      {
        this.hitEnterList.Clear();
        foreach (UniqueId uniqueId in this.currentEntitiesInRange)
        {
          if (!this.lastEntitiesInRange.Contains(uniqueId))
            this.hitEnterList.Add(uniqueId);
        }
        this.hitEnterEntities.Set(this.hitEnterList);
        if (this.hitEnterList.Count > 0)
          this.OnEnterHit.Fire(this.skillGraph);
      }
      if (this.hitExitEntities != null)
      {
        this.hitExitList.Clear();
        foreach (UniqueId uniqueId in this.lastEntitiesInRange)
        {
          if (!this.currentEntitiesInRange.Contains(uniqueId))
            this.hitExitList.Add(uniqueId);
        }
        this.hitExitEntities.Set(this.hitExitList);
        if (this.hitExitList.Count > 0)
          this.OnExitHit.Fire(this.skillGraph);
      }
      if (this.hitEntities != null)
      {
        this.hitList.Clear();
        bool flag = (double) this.repeatedHitCooldown > 0.0;
        if (flag)
        {
          for (int index = this.excludeEntitiesList.Count - 1; index >= 0; --index)
          {
            this.excludeCooldowns[index] -= this.skillGraph.GetFixedTimeStep();
            if ((double) this.excludeCooldowns[index] <= 0.0)
            {
              this.excludeCooldowns.RemoveAt(index);
              this.excludeEntitiesList.RemoveAt(index);
            }
          }
        }
        foreach (UniqueId uniqueId in this.currentEntitiesInRange)
        {
          if (!this.excludeEntitiesList.Contains(uniqueId))
          {
            this.hitList.Add(uniqueId);
            if (this.singleHitPerEntity | flag)
              this.excludeEntitiesList.Add(uniqueId);
            if (flag)
              this.excludeCooldowns.Add(this.repeatedHitCooldown);
          }
        }
        this.hitEntities.Set(this.hitList);
        if (this.hitList.Count > 0)
        {
          Action onHitDelegate = this.onHitDelegate;
          if (onHitDelegate != null)
            onHitDelegate();
          this.OnHit.Fire(this.skillGraph);
        }
      }
      List<UniqueId> lastEntitiesInRange = this.lastEntitiesInRange;
      this.lastEntitiesInRange = this.currentEntitiesInRange;
      this.currentEntitiesInRange = lastEntitiesInRange;
    }

    protected override void ExitDerived()
    {
      if (this.hitExitEntities == null || this.currentEntitiesInRange.Count <= 0)
        return;
      this.hitExitEntities.Set(this.currentEntitiesInRange);
      this.OnExitHit.Fire(this.skillGraph);
    }
  }
}
