// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.TriangleMeshShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System.Collections.Generic;

namespace Jitter.Collision.Shapes
{
  public class TriangleMeshShape : Multishape
  {
    private JVector normal = JVector.Up;
    private readonly Octree octree;
    private readonly List<int> potentialTriangles = new List<int>();
    private readonly JVector[] vecs = new JVector[3];

    public TriangleMeshShape(Octree octree)
    {
      this.octree = octree;
      this.UpdateShape(false);
    }

    internal TriangleMeshShape()
    {
    }

    public float SphericalExpansion { get; set; } = 0.05f;

    public bool FlipNormals { get; set; }

    protected override Multishape CreateWorkingClone() => (Multishape) new TriangleMeshShape(this.octree)
    {
      SphericalExpansion = this.SphericalExpansion
    };

    public override int Prepare(ref JBBox box)
    {
      this.potentialTriangles.Clear();
      JBBox testBox = box;
      testBox.Min.X -= this.SphericalExpansion;
      testBox.Min.Y -= this.SphericalExpansion;
      testBox.Min.Z -= this.SphericalExpansion;
      testBox.Max.X += this.SphericalExpansion;
      testBox.Max.Y += this.SphericalExpansion;
      testBox.Max.Z += this.SphericalExpansion;
      this.octree.GetTrianglesIntersectingtAABox(this.potentialTriangles, ref testBox);
      return this.potentialTriangles.Count;
    }

    public override void MakeHull(ref List<JVector> triangleList, int generationThreshold)
    {
      JBBox largeBox = JBBox.LargeBox;
      List<int> triangles = new List<int>();
      this.octree.GetTrianglesIntersectingtAABox(triangles, ref largeBox);
      for (int index = 0; index < triangles.Count; ++index)
      {
        triangleList.Add(this.octree.GetVertex(this.octree.GetTriangleVertexIndex(index).I0));
        triangleList.Add(this.octree.GetVertex(this.octree.GetTriangleVertexIndex(index).I1));
        triangleList.Add(this.octree.GetVertex(this.octree.GetTriangleVertexIndex(index).I2));
      }
    }

    public override int Prepare(ref JVector rayOrigin, ref JVector rayDelta)
    {
      this.potentialTriangles.Clear();
      JVector result;
      JVector.Normalize(ref rayDelta, out result);
      JVector rayDelta1 = rayDelta + result * this.SphericalExpansion;
      this.octree.GetTrianglesIntersectingRay(this.potentialTriangles, rayOrigin, rayDelta1);
      return this.potentialTriangles.Count;
    }

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      JVector result1;
      JVector.Normalize(ref direction, out result1);
      JVector jvector = result1 * this.SphericalExpansion;
      float num1 = JVector.Dot(ref this.vecs[0], ref direction);
      int index = 0;
      float num2 = JVector.Dot(ref this.vecs[1], ref direction);
      if ((double) num2 > (double) num1)
      {
        num1 = num2;
        index = 1;
      }
      if ((double) JVector.Dot(ref this.vecs[2], ref direction) > (double) num1)
        index = 2;
      result = this.vecs[index] + jvector;
    }

    public override void GetBoundingBox(ref JMatrix orientation, out JBBox box)
    {
      box = this.octree.rootNodeBox;
      box.Min.X -= this.SphericalExpansion;
      box.Min.Y -= this.SphericalExpansion;
      box.Min.Z -= this.SphericalExpansion;
      box.Max.X += this.SphericalExpansion;
      box.Max.Y += this.SphericalExpansion;
      box.Max.Z += this.SphericalExpansion;
      box.Transform(ref orientation);
    }

    public override void SetCurrentShape(int index)
    {
      this.vecs[0] = this.octree.GetVertex(this.octree.tris[this.potentialTriangles[index]].I0);
      this.vecs[1] = this.octree.GetVertex(this.octree.tris[this.potentialTriangles[index]].I1);
      this.vecs[2] = this.octree.GetVertex(this.octree.tris[this.potentialTriangles[index]].I2);
      JVector result = this.vecs[0];
      JVector.Add(ref result, ref this.vecs[1], out result);
      JVector.Add(ref result, ref this.vecs[2], out result);
      JVector.Multiply(ref result, 0.3333333f, out result);
      this.geomCen = result;
      JVector.Subtract(ref this.vecs[1], ref this.vecs[0], out result);
      JVector.Subtract(ref this.vecs[2], ref this.vecs[0], out this.normal);
      JVector.Cross(ref result, ref this.normal, out this.normal);
      if (!this.FlipNormals)
        return;
      this.normal.Negate();
    }

    public void CollisionNormal(out JVector normal) => normal = this.normal;
  }
}
