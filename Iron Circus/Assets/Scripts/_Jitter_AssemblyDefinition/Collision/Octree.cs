// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Octree
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Jitter.Collision
{
  public class Octree
  {
    private Octree.Node[] nodes;
    private ArrayResourcePool<ushort> nodeStackPool;
    private JVector[] positions;
    internal JBBox rootNodeBox;
    private JBBox[] triBoxes;
    internal TriangleVertexIndices[] tris;

    public Octree(List<JVector> positions, List<TriangleVertexIndices> tris)
    {
      this.SetTriangles(positions, tris);
      this.BuildOctree();
    }

    public JBBox RootNodeBox => this.rootNodeBox;

    public int NumTriangles => this.tris.Length;

    public void Clear()
    {
      this.positions = (JVector[]) null;
      this.triBoxes = (JBBox[]) null;
      this.tris = (TriangleVertexIndices[]) null;
      this.nodes = (Octree.Node[]) null;
      this.nodeStackPool.ResetResourcePool();
    }

    public void SetTriangles(List<JVector> positions, List<TriangleVertexIndices> tris)
    {
      this.positions = new JVector[positions.Count];
      positions.CopyTo(this.positions);
      this.tris = new TriangleVertexIndices[tris.Count];
      tris.CopyTo(this.tris);
    }

    public void BuildOctree()
    {
      this.triBoxes = new JBBox[this.tris.Length];
      this.rootNodeBox = new JBBox(new JVector(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity), new JVector(float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity));
      for (int index = 0; index < this.tris.Length; ++index)
      {
        JVector.Min(ref this.positions[this.tris[index].I1], ref this.positions[this.tris[index].I2], out this.triBoxes[index].Min);
        JVector.Min(ref this.positions[this.tris[index].I0], ref this.triBoxes[index].Min, out this.triBoxes[index].Min);
        JVector.Max(ref this.positions[this.tris[index].I1], ref this.positions[this.tris[index].I2], out this.triBoxes[index].Max);
        JVector.Max(ref this.positions[this.tris[index].I0], ref this.triBoxes[index].Max, out this.triBoxes[index].Max);
        JVector.Min(ref this.rootNodeBox.Min, ref this.triBoxes[index].Min, out this.rootNodeBox.Min);
        JVector.Max(ref this.rootNodeBox.Max, ref this.triBoxes[index].Max, out this.rootNodeBox.Max);
      }
      List<Octree.BuildNode> buildNodeList = new List<Octree.BuildNode>();
      buildNodeList.Add(new Octree.BuildNode());
      buildNodeList[0].box = this.rootNodeBox;
      JBBox[] jbBoxArray = new JBBox[8];
      for (int index1 = 0; index1 < this.tris.Length; ++index1)
      {
        int index2 = 0;
        JBBox rootNodeBox = this.rootNodeBox;
        while (rootNodeBox.Contains(ref this.triBoxes[index1]) == JBBox.ContainmentType.Contains)
        {
          int index3 = -1;
          for (int index4 = 0; index4 < 8; ++index4)
          {
            this.CreateAABox(ref rootNodeBox, (Octree.EChild) index4, out jbBoxArray[index4]);
            if (jbBoxArray[index4].Contains(ref this.triBoxes[index1]) == JBBox.ContainmentType.Contains)
            {
              index3 = index4;
              break;
            }
          }
          if (index3 == -1)
          {
            buildNodeList[index2].triIndices.Add(index1);
            break;
          }
          int index5 = -1;
          for (int index6 = 0; index6 < buildNodeList[index2].nodeIndices.Count; ++index6)
          {
            if (buildNodeList[buildNodeList[index2].nodeIndices[index6]].childType == index3)
            {
              index5 = index6;
              break;
            }
          }
          if (index5 == -1)
          {
            Octree.BuildNode buildNode = buildNodeList[index2];
            buildNodeList.Add(new Octree.BuildNode()
            {
              childType = index3,
              box = jbBoxArray[index3]
            });
            index2 = buildNodeList.Count - 1;
            rootNodeBox = jbBoxArray[index3];
            buildNode.nodeIndices.Add(index2);
          }
          else
          {
            index2 = buildNodeList[index2].nodeIndices[index5];
            rootNodeBox = jbBoxArray[index3];
          }
        }
      }
      this.nodes = new Octree.Node[buildNodeList.Count];
      this.nodeStackPool = new ArrayResourcePool<ushort>(buildNodeList.Count);
      for (int index7 = 0; index7 < this.nodes.Length; ++index7)
      {
        this.nodes[index7].nodeIndices = new ushort[buildNodeList[index7].nodeIndices.Count];
        for (int index8 = 0; index8 < this.nodes[index7].nodeIndices.Length; ++index8)
          this.nodes[index7].nodeIndices[index8] = (ushort) buildNodeList[index7].nodeIndices[index8];
        this.nodes[index7].triIndices = new int[buildNodeList[index7].triIndices.Count];
        buildNodeList[index7].triIndices.CopyTo(this.nodes[index7].triIndices);
        this.nodes[index7].box = buildNodeList[index7].box;
      }
      buildNodeList.Clear();
    }

    private void CreateAABox(ref JBBox aabb, Octree.EChild child, out JBBox result)
    {
      JVector result1;
      JVector.Subtract(ref aabb.Max, ref aabb.Min, out result1);
      JVector.Multiply(ref result1, 0.5f, out result1);
      JVector jvector = JVector.Zero;
      switch (child)
      {
        case Octree.EChild.MMM:
          jvector = new JVector(0.0f, 0.0f, 0.0f);
          break;
        case Octree.EChild.XP:
          jvector = new JVector(1f, 0.0f, 0.0f);
          break;
        case Octree.EChild.YP:
          jvector = new JVector(0.0f, 1f, 0.0f);
          break;
        case Octree.EChild.PPM:
          jvector = new JVector(1f, 1f, 0.0f);
          break;
        case Octree.EChild.ZP:
          jvector = new JVector(0.0f, 0.0f, 1f);
          break;
        case Octree.EChild.PMP:
          jvector = new JVector(1f, 0.0f, 1f);
          break;
        case Octree.EChild.MPP:
          jvector = new JVector(0.0f, 1f, 1f);
          break;
        case Octree.EChild.PPP:
          jvector = new JVector(1f, 1f, 1f);
          break;
      }
      result = new JBBox();
      result.Min = new JVector(jvector.X * result1.X, jvector.Y * result1.Y, jvector.Z * result1.Z);
      JVector.Add(ref result.Min, ref aabb.Min, out result.Min);
      JVector.Add(ref result.Min, ref result1, out result.Max);
      float scaleFactor = 1E-05f;
      JVector result2;
      JVector.Multiply(ref result1, scaleFactor, out result2);
      JVector.Subtract(ref result.Min, ref result2, out result.Min);
      JVector.Add(ref result.Max, ref result2, out result.Max);
    }

    private void GatherTriangles(int nodeIndex, ref List<int> tris)
    {
      tris.AddRange((IEnumerable<int>) this.nodes[nodeIndex].triIndices);
      int length = this.nodes[nodeIndex].nodeIndices.Length;
      for (int index = 0; index < length; ++index)
        this.GatherTriangles((int) this.nodes[nodeIndex].nodeIndices[index], ref tris);
    }

    public int GetTrianglesIntersectingtAABox(List<int> triangles, ref JBBox testBox)
    {
      if (this.nodes.Length == 0)
        return 0;
      int index1 = 0;
      int num1 = 1;
      ushort[] numArray = this.nodeStackPool.GetNew();
      numArray[0] = (ushort) 0;
      int num2 = 0;
      while (index1 < num1)
      {
        ushort num3 = numArray[index1];
        ++index1;
        if (this.nodes[(int) num3].box.Contains(ref testBox) != JBBox.ContainmentType.Disjoint)
        {
          for (int index2 = 0; index2 < this.nodes[(int) num3].triIndices.Length; ++index2)
          {
            if (this.triBoxes[this.nodes[(int) num3].triIndices[index2]].Contains(ref testBox) != JBBox.ContainmentType.Disjoint)
            {
              triangles.Add(this.nodes[(int) num3].triIndices[index2]);
              ++num2;
            }
          }
          int length = this.nodes[(int) num3].nodeIndices.Length;
          for (int index3 = 0; index3 < length; ++index3)
            numArray[num1++] = this.nodes[(int) num3].nodeIndices[index3];
        }
      }
      this.nodeStackPool.GiveBack(numArray);
      return num2;
    }

    public int GetTrianglesIntersectingRay(
      List<int> triangles,
      JVector rayOrigin,
      JVector rayDelta)
    {
      if (this.nodes.Length == 0)
        return 0;
      int index1 = 0;
      int num1 = 1;
      ushort[] numArray = this.nodeStackPool.GetNew();
      numArray[0] = (ushort) 0;
      int num2 = 0;
      while (index1 < num1)
      {
        ushort num3 = numArray[index1];
        ++index1;
        if (this.nodes[(int) num3].box.SegmentIntersect(ref rayOrigin, ref rayDelta))
        {
          for (int index2 = 0; index2 < this.nodes[(int) num3].triIndices.Length; ++index2)
          {
            if (this.triBoxes[this.nodes[(int) num3].triIndices[index2]].SegmentIntersect(ref rayOrigin, ref rayDelta))
            {
              triangles.Add(this.nodes[(int) num3].triIndices[index2]);
              ++num2;
            }
          }
          int length = this.nodes[(int) num3].nodeIndices.Length;
          for (int index3 = 0; index3 < length; ++index3)
            numArray[num1++] = this.nodes[(int) num3].nodeIndices[index3];
        }
      }
      this.nodeStackPool.GiveBack(numArray);
      return num2;
    }

    public TriangleVertexIndices GetTriangleVertexIndex(int index) => this.tris[index];

    public JVector GetVertex(int vertex) => this.positions[vertex];

    public void GetVertex(int vertex, out JVector result) => result = this.positions[vertex];

    [Flags]
    private enum EChild
    {
      XP = 1,
      YP = 2,
      ZP = 4,
      PPP = ZP | YP | XP, // 0x00000007
      PPM = YP | XP, // 0x00000003
      PMP = ZP | XP, // 0x00000005
      PMM = XP, // 0x00000001
      MPP = ZP | YP, // 0x00000006
      MPM = YP, // 0x00000002
      MMP = ZP, // 0x00000004
      MMM = 0,
    }

    private struct Node
    {
      public ushort[] nodeIndices;
      public int[] triIndices;
      public JBBox box;
    }

    private class BuildNode
    {
      public JBBox box;
      public int childType;
      public readonly List<int> nodeIndices = new List<int>();
      public readonly List<int> triIndices = new List<int>();
    }
  }
}
