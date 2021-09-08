// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.Collisions.AICollisionSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.Collision.Shapes;
using Jitter.LinearMath;
using System.Collections.Generic;
using System.Text;

namespace Imi.SharedWithServer.Game.AI.Collisions
{
  public class AICollisionSystem
  {
    private List<AICollisionShape> shapes = new List<AICollisionShape>(64);

    private void AddShape(AICollisionShape shape)
    {
      if (this.shapes.Contains(shape))
        return;
      this.shapes.Add(shape);
    }

    public void Expand(float units)
    {
      for (int index = 0; index < this.shapes.Count; ++index)
        this.shapes[index].Expand(units);
    }

    public void CreateArena(
      AICache aiCache,
      float sizeX,
      float sizeZ,
      GameEntity goal1,
      GameEntity goal2)
    {
      JVector topCorner1;
      JVector bottomCorner1;
      aiCache.GetGoalCorners(goal1, out topCorner1, out bottomCorner1);
      JVector topCorner2;
      JVector bottomCorner2;
      aiCache.GetGoalCorners(goal2, out topCorner2, out bottomCorner2);
      bool flag = false;
      if ((double) topCorner2.Z < (double) topCorner1.Z)
      {
        flag = true;
        JVector jvector1 = topCorner2;
        topCorner2 = topCorner1;
        topCorner1 = jvector1;
        JVector jvector2 = bottomCorner2;
        bottomCorner2 = bottomCorner1;
        bottomCorner1 = jvector2;
      }
      float z = 6f;
      float sizeX1 = topCorner1.X - bottomCorner1.X;
      float sizeZ1 = z;
      this.AddShape((AICollisionShape) new AICollisionShapeRectangle(new JVector((float) (((double) topCorner1.X + (double) bottomCorner1.X) * 0.5), 0.0f, topCorner1.Z + sizeZ1 * 0.5f * JMath.Sign(topCorner1.Z)), sizeX1, sizeZ1, true, flag ? goal2 : goal1));
      float sizeX2 = topCorner2.X - bottomCorner2.X;
      float sizeZ2 = z;
      this.AddShape((AICollisionShape) new AICollisionShapeRectangle(new JVector((float) (((double) topCorner2.X + (double) bottomCorner2.X) * 0.5), 0.0f, topCorner2.Z + sizeZ2 * 0.5f * JMath.Sign(topCorner2.Z)), sizeX2, sizeZ2, true, flag ? goal1 : goal2));
      AICollisionShapePolyLine collisionShapePolyLine1 = new AICollisionShapePolyLine();
      collisionShapePolyLine1.AddVertex(bottomCorner2 + new JVector(0.0f, 0.0f, z));
      collisionShapePolyLine1.AddVertex(new JVector(bottomCorner2.X, 0.0f, sizeZ * 0.5f));
      collisionShapePolyLine1.AddVertex(new JVector((float) (-(double) sizeX * 0.5), 0.0f, sizeZ * 0.5f));
      collisionShapePolyLine1.AddVertex(new JVector((float) (-(double) sizeX * 0.5), 0.0f, (float) (-(double) sizeZ * 0.5)));
      collisionShapePolyLine1.AddVertex(new JVector(bottomCorner2.X, 0.0f, (float) (-(double) sizeZ * 0.5)));
      collisionShapePolyLine1.AddVertex(bottomCorner1 + new JVector(0.0f, 0.0f, -z));
      this.AddShape((AICollisionShape) collisionShapePolyLine1);
      AICollisionShapePolyLine collisionShapePolyLine2 = new AICollisionShapePolyLine();
      collisionShapePolyLine2.AddVertex(topCorner1 + new JVector(0.0f, 0.0f, -z));
      collisionShapePolyLine2.AddVertex(new JVector(topCorner1.X, 0.0f, (float) (-(double) sizeZ * 0.5)));
      collisionShapePolyLine2.AddVertex(new JVector(sizeX * 0.5f, 0.0f, (float) (-(double) sizeZ * 0.5)));
      collisionShapePolyLine2.AddVertex(new JVector(sizeX * 0.5f, 0.0f, sizeZ * 0.5f));
      collisionShapePolyLine2.AddVertex(new JVector(topCorner2.X, 0.0f, sizeZ * 0.5f));
      collisionShapePolyLine2.AddVertex(topCorner2 + new JVector(0.0f, 0.0f, z));
      this.AddShape((AICollisionShape) collisionShapePolyLine2);
    }

    public void CreateBumper(GameEntity bumper)
    {
      JVector position = bumper.rigidbody.value.Position;
      position.Y = 0.0f;
      float radius = ((CapsuleShape) bumper.rigidbody.value.Shape).Radius;
      this.AddShape((AICollisionShape) new AICollisionShapeCircle(position, radius, entity: bumper));
    }

    public override string ToString()
    {
      StringBuilder stringBuilder = new StringBuilder();
      foreach (AICollisionShape shape in this.shapes)
      {
        stringBuilder.Append(shape.GetType().Name + "\n");
        stringBuilder.Append(shape.ToString() + "\n");
      }
      return stringBuilder.ToString();
    }

    public JVector BounceRay(
      JVector rayStart,
      JVector rayDir,
      out JVector rayDirAfterBounces,
      out JVector firstContact,
      out float firstContactDistance,
      out JVector firstContactNormal,
      List<GameEntity> intersectedTriggers)
    {
      intersectedTriggers.Clear();
      firstContact = firstContactNormal = JVector.Zero;
      firstContactDistance = 0.0f;
      JVector rayStart1 = rayStart;
      int num = 3;
      for (int index = 0; index < num; ++index)
      {
        JVector contact;
        float distance;
        JVector normal;
        if (this.SegmentIntersection(rayStart1, rayDir, out contact, out distance, out normal, intersectedTriggers, false))
        {
          rayDir += -2f * JVector.Dot(rayDir, normal) * normal;
          rayDir *= 1f - distance;
          rayStart1 = contact + rayDir.Normalized() * 0.005f;
          if (index == 0)
          {
            firstContact = contact;
            firstContactDistance = distance;
            firstContactNormal = normal;
          }
        }
        else
        {
          rayDirAfterBounces = rayDir;
          return rayStart1 + rayDir;
        }
      }
      rayDirAfterBounces = rayDir;
      return rayStart1;
    }

    public bool SegmentIntersection(
      JVector rayStart,
      JVector rayDir,
      out JVector contact,
      out float distance,
      out JVector normal,
      List<GameEntity> intersectedTriggers,
      bool clearTriggerList = true)
    {
      if (clearTriggerList)
        intersectedTriggers.Clear();
      bool flag = false;
      contact = normal = JVector.Zero;
      distance = 1E+10f;
      for (int index = this.shapes.Count - 1; index >= 0; --index)
      {
        AICollisionShape shape = this.shapes[index];
        JVector contact1;
        float distance1;
        JVector normal1;
        if (!shape.IsTrigger && shape.SegmentIntersection(rayStart, rayDir, out contact1, out distance1, out normal1))
        {
          flag = true;
          if ((double) distance1 < (double) distance)
          {
            distance = distance1;
            normal = normal1;
            contact = contact1;
          }
        }
      }
      if (flag)
        rayDir *= distance;
      for (int index = this.shapes.Count - 1; index >= 0; --index)
      {
        AICollisionShape shape = this.shapes[index];
        if (shape.IsTrigger && shape.SegmentIntersection(rayStart, rayDir, out JVector _, out float _, out JVector _))
        {
          GameEntity entity = shape.Entity;
          if (entity != null && !intersectedTriggers.Contains(entity))
            intersectedTriggers.Add(entity);
        }
      }
      return flag;
    }
  }
}
