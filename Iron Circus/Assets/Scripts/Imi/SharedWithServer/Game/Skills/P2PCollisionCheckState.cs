// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.P2PCollisionCheckState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class P2PCollisionCheckState : SkillState
  {
    public SkillVar<UniqueId> result;
    public Action onHitDelegate;
    public OutPlug OnHit;
    private List<UniqueId> hitEntities = new List<UniqueId>();

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickOnlyLocalEntity;

    public P2PCollisionCheckState() => this.OnHit = this.AddOutPlug();

    protected override void TickDerived()
    {
      if (this.skillGraph.IsClient() && this.skillGraph.GetOwner().isLocalEntity)
        this.CheckHit();
      if (!this.skillGraph.IsServer())
        return;
      int rttt = this.skillGraph.GetRttt();
      int tick = this.skillGraph.GetTick();
      int num = tick - rttt;
      this.skillGraph.GetContext().gamePhysics.checkPastPhysicsState(tick, num, this.skillGraph.GetOwner(), new Action(this.CheckHit));
    }

    private void CheckHit()
    {
      GameEntity owner = this.skillGraph.GetOwner();
      JRigidbody rb1 = owner.rigidbody.value;
      this.hitEntities.Clear();
      foreach (GameEntity player in this.skillGraph.GetPlayers())
      {
        if ((long) player.playerId.value != (long) owner.playerId.value && player.playerTeam.value != owner.playerTeam.value && this.CheckRoundColliderOverlapping(rb1, player.rigidbody.value))
          this.hitEntities.Add(player.uniqueId.id);
      }
      GameEntity ballEntity = this.skillGraph.GetContext().ballEntity;
      if (this.CheckRoundColliderOverlapping(ballEntity.rigidbody.value, owner.rigidbody.value))
      {
        bool flag = false;
        if (ballEntity.hasBallOwner)
        {
          GameEntity player = this.skillGraph.GetPlayer(ballEntity.ballOwner.playerId);
          flag = player != null && player.playerTeam.value == owner.playerTeam.value;
        }
        if (!flag)
          this.hitEntities.Add(ballEntity.uniqueId.id);
      }
      this.result.Set(this.hitEntities);
      if (this.hitEntities.Count <= 0)
        return;
      Action onHitDelegate = this.onHitDelegate;
      if (onHitDelegate != null)
        onHitDelegate();
      this.OnHit.Fire(this.skillGraph);
    }

    private bool CheckRoundColliderOverlapping(JRigidbody rb1, JRigidbody rb2)
    {
      float radius1 = this.GetRadius(rb1);
      float radius2 = this.GetRadius(rb2);
      JVector position1 = rb1.Position;
      JVector position2 = rb2.Position;
      return this.CheckCircleOverlap(position1, radius1, position2, radius2);
    }

    private bool CheckCircleOverlap(JVector p1, float r1, JVector p2, float r2)
    {
      p1.Y = p2.Y = 0.0f;
      double num1 = (double) (p1 - p2).Length();
      float num2 = 0.01f;
      double num3 = (double) (r1 + r2 + num2);
      return num1 <= num3;
    }

    private float GetRadius(JRigidbody rb)
    {
      if (rb.Shape is SphereShape)
        return ((SphereShape) rb.Shape).Radius;
      if (rb.Shape is CylinderShape)
        return ((CylinderShape) rb.Shape).Radius;
      if (rb.Shape is CapsuleShape)
        return ((CapsuleShape) rb.Shape).Radius;
      throw new Exception("Collider type is not supported for collision check in StateMachine");
    }

    private bool CheckCapsule2D(
      JVector capsuleStart,
      JVector capsuleEnd,
      float capsuleRadius,
      JVector otherPosition,
      float otherRadius)
    {
      return (double) this.DistFromLineSegment(capsuleStart, capsuleEnd, otherPosition) < (double) otherRadius + (double) capsuleRadius;
    }

    private float DistFromLineSegment(JVector segmentStart, JVector segmentEnd, JVector p)
    {
      JVector vector1 = (segmentEnd - segmentStart).Normalized();
      return (segmentStart + JVector.Dot(vector1, p - segmentStart) * vector1 - p).Length();
    }
  }
}
