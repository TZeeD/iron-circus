// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.RoundCageActiveState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Utils.Extensions;
using Imi.SteelCircus.JitterUnity;
using Jitter;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SteelCircus.FX.Skills;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SharedWithServer.Game.Skills
{
  public class RoundCageActiveState : SkillState
  {
    public ConfigValue<float> maxRadius;
    public ConfigValue<float> minRadius;
    public ConfigValue<float> shrinkDuration;
    public ConfigValue<float> wallThickness;
    public ConfigValue<GameObject> prefab;
    [SyncValue]
    public SyncableValue<JVector> position;
    [SyncValue]
    private SyncableValue<JVector> cachedPosition;
    [SyncValue]
    private SyncableValue<bool> receivedServer;
    [SyncValue]
    private SyncableValue<float> timeActive;
    private GameObject model;
    private const int NumSides = 15;
    private const float WallHeight = 4f;
    private JRigidbody[] colliders = new JRigidbody[15];
    private bool createdOnClient;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.position.Parse(serializationInfo, ref valueIndex, this.Name + ".position");
      this.cachedPosition.Parse(serializationInfo, ref valueIndex, this.Name + ".cachedPosition");
      this.receivedServer.Parse(serializationInfo, ref valueIndex, this.Name + ".receivedServer");
      this.timeActive.Parse(serializationInfo, ref valueIndex, this.Name + ".timeActive");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.position.Serialize(target, ref valueIndex);
      this.cachedPosition.Serialize(target, ref valueIndex);
      this.receivedServer.Serialize(target, ref valueIndex);
      this.timeActive.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.position.Deserialize(target, ref valueIndex);
      this.cachedPosition.Deserialize(target, ref valueIndex);
      this.receivedServer.Deserialize(target, ref valueIndex);
      this.timeActive.Deserialize(target, ref valueIndex);
    }

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    private float GetCurrentRadius() => MathExtensions.Interpolate(this.maxRadius.Get(), this.minRadius.Get(), JMath.Clamp01(this.timeActive.Get() / this.shrinkDuration.Get()));

    protected override void EnterDerived()
    {
      this.timeActive.Set(0.0f);
      JVector jvector = this.position.Get();
      if (!this.skillGraph.IsRepredicting())
      {
        float currentRadius = this.GetCurrentRadius();
        foreach (GameEntity player in this.skillGraph.GetPlayers())
        {
          if (player.rigidbody.value.CollisionMask != 0)
          {
            JVector vector = player.transform.position - jvector;
            float colliderRadius = player.championConfig.value.colliderRadius;
            if ((double) vector.Length() - (double) colliderRadius < (double) currentRadius)
            {
              float num = currentRadius - this.wallThickness.Get() - colliderRadius;
              JVector newPosition = jvector + vector.Normalized() * num;
              player.TransformReplacePosition(newPosition);
            }
          }
        }
      }
      if (!this.skillGraph.IsServer())
        return;
      this.cachedPosition.Set(jvector);
      this.receivedServer.Set(true);
      this.CreateCage();
    }

    private void CreateCage()
    {
      World world = this.skillGraph.GetContext().gamePhysics.world;
      JVector vector = this.cachedPosition.Get();
      if (this.colliders[0] == null)
      {
        for (int index = 0; index < 15; ++index)
          this.colliders[index] = new JRigidbody((Shape) new BoxShape(JVector.One))
          {
            IsKinematic = true,
            CollisionLayer = 1024,
            CollisionMask = 12
          };
      }
      for (int index = 0; index < 15; ++index)
      {
        JRigidbody collider = this.colliders[index];
        world.AddBody(collider);
      }
      if ((UnityEngine.Object) this.model == (UnityEngine.Object) null)
      {
        this.model = UnityEngine.Object.Instantiate<GameObject>(this.prefab.Get());
        this.model.transform.position = vector.ToVector3();
        float num = this.GetCurrentRadius() * 2f;
        this.model.transform.localScale = new Vector3(num, 1f, num);
        this.model.GetComponent<IVfx>().SetOwner(this.skillGraph.GetOwner());
      }
      this.UpdateCage();
    }

    protected override void TickDerived()
    {
      this.timeActive.Set(this.timeActive.Get() + this.skillGraph.GetFixedTimeStep());
      if (this.receivedServer.Get() && !this.createdOnClient)
      {
        this.CreateCage();
        this.createdOnClient = true;
      }
      this.UpdateCage();
    }

    private void UpdateCage()
    {
      float currentRadius = this.GetCurrentRadius();
      if ((UnityEngine.Object) this.model != (UnityEngine.Object) null)
      {
        float num = currentRadius * 2f;
        this.model.transform.localScale = new Vector3(num, 1f, num);
      }
      if (this.colliders[0] == null)
        return;
      float z = this.wallThickness.Get();
      JVector jvector1 = this.cachedPosition.Get();
      float num1 = 0.418879f;
      float x = 2f * currentRadius * (float) Math.Sin((double) num1 / 2.0);
      float num2 = currentRadius * (float) Math.Cos((double) num1 / 2.0);
      for (int index = 0; index < 15; ++index)
      {
        ((BoxShape) this.colliders[index].Shape).Size = new JVector(x, 4f, z);
        JMatrix fromAxisAngle = JMatrix.CreateFromAxisAngle(JVector.Up, (float) index * num1);
        JVector jvector2 = JVector.Transform(JVector.Forward, fromAxisAngle) * (num2 - z / 2f) + JVector.Up * 2f;
        this.colliders[index].Position = jvector1 + jvector2;
        this.colliders[index].Orientation = fromAxisAngle;
      }
    }

    protected override void ExitDerived()
    {
      this.createdOnClient = false;
      this.receivedServer.Set(false);
      World world = this.skillGraph.GetContext().gamePhysics.world;
      for (int index = 0; index < 15; ++index)
      {
        if (this.colliders[index] != null)
          world.RemoveBody(this.colliders[index]);
      }
      if (!((UnityEngine.Object) this.model != (UnityEngine.Object) null))
        return;
      UnityEngine.Object.Destroy((UnityEngine.Object) this.model);
    }
  }
}
