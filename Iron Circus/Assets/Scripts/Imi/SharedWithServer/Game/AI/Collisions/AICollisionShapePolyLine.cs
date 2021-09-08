// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.Collisions.AICollisionShapePolyLine
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using System.Collections.Generic;
using System.Text;

namespace Imi.SharedWithServer.Game.AI.Collisions
{
  public class AICollisionShapePolyLine : AICollisionShape
  {
    protected List<JVector> vertices = new List<JVector>(16);
    protected List<JVector> normals = new List<JVector>(16);

    public AICollisionShapePolyLine(bool isTrigger = false, GameEntity entity = null)
      : base(isTrigger, entity)
    {
    }

    protected void Clear()
    {
      this.vertices.Clear();
      this.normals.Clear();
    }

    public void AddVertex(JVector position)
    {
      this.vertices.Add(position);
      this.RecalculateNormals();
    }

    public override void Expand(float units)
    {
      for (int index = 0; index < this.vertices.Count; ++index)
      {
        if (index > 0)
          this.vertices[index] += this.normals[index - 1] * units;
        if (index < this.normals.Count)
          this.vertices[index] += this.normals[index] * units;
      }
    }

    public override string ToString()
    {
      StringBuilder stringBuilder = new StringBuilder();
      stringBuilder.Append("Polyline:\n");
      for (int index = 0; index < this.vertices.Count; ++index)
      {
        stringBuilder.Append(string.Format("vertex: {0}\n", (object) this.vertices[index]));
        if (index < this.normals.Count)
          stringBuilder.Append(string.Format("normal: {0}\n", (object) this.normals[index]));
      }
      return stringBuilder.ToString();
    }

    protected void RecalculateNormals()
    {
      this.normals.Clear();
      for (int index = 0; index < this.vertices.Count - 1; ++index)
      {
        JVector vertex = this.vertices[index];
        JVector jvector1 = this.vertices[index + 1] - vertex;
        JVector jvector2 = new JVector(-jvector1.Z, 0.0f, jvector1.X);
        jvector2.Normalize();
        this.normals.Add(jvector2);
      }
    }

    public override bool SegmentIntersection(
      JVector rayStart,
      JVector rayDir,
      out JVector contact,
      out float distance,
      out JVector normal)
    {
      contact = normal = JVector.Zero;
      distance = 1E+10f;
      bool flag = false;
      JVector vertex = this.vertices[0];
      int count = this.vertices.Count;
      for (int index = 1; index < count; ++index)
      {
        JVector normal1 = this.normals[index - 1];
        JVector segmentA = vertex;
        vertex = this.vertices[index];
        JVector contact1;
        float distance1;
        if (this.IntersectSingleSegment(rayStart, rayDir, segmentA, vertex, out contact1, out distance1))
        {
          flag = true;
          if ((double) distance1 < (double) distance)
          {
            distance = distance1;
            contact = contact1;
            normal = normal1;
          }
        }
      }
      return flag;
    }

    protected bool IntersectSingleSegment(
      JVector rayOrigin,
      JVector rayDir,
      JVector segmentA,
      JVector segmentB,
      out JVector contact,
      out float distance)
    {
      contact = JVector.Zero;
      distance = 0.0f;
      JVector jvector = segmentB - segmentA;
      float f = (float) (((double) rayOrigin.Z * (double) jvector.X - (double) segmentA.Z * (double) jvector.X - (double) rayOrigin.X * (double) jvector.Z + (double) segmentA.X * (double) jvector.Z) / ((double) rayDir.X * (double) jvector.Z - (double) rayDir.Z * (double) jvector.X));
      if ((double) f < 0.0 || (double) f > 1.0 || float.IsNaN(f))
        return false;
      float num = (double) jvector.X != 0.0 && (double) JMath.Abs(jvector.X) > (double) JMath.Abs(jvector.Z) || (double) jvector.Z == 0.0 ? (rayOrigin.X + f * rayDir.X - segmentA.X) / jvector.X : (rayOrigin.Z + f * rayDir.Z - segmentA.Z) / jvector.Z;
      if ((double) num < 0.0 || (double) num > 1.0)
        return false;
      distance = f;
      contact = rayOrigin + f * rayDir;
      return true;
    }
  }
}
