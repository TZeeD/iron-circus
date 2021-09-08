// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.DynamicTree`1
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Jitter.Collision
{
  public class DynamicTree<T>
  {
    internal const int NullNode = -1;
    private const float SettingsAABBMultiplier = 2f;
    private int _freeList;
    private int _insertionCount;
    private int _nodeCapacity;
    private int _nodeCount;
    private readonly Random rnd = new Random();
    private readonly float settingsRndExtension = 0.1f;
    private readonly ResourcePool<Stack<int>> stackPool = new ResourcePool<Stack<int>>();

    public DynamicTree()
      : this(0.1f)
    {
    }

    public DynamicTree(float rndExtension)
    {
      this.settingsRndExtension = rndExtension;
      this.Root = -1;
      this._nodeCapacity = 16;
      this.Nodes = new DynamicTreeNode<T>[this._nodeCapacity];
      for (int index = 0; index < this._nodeCapacity - 1; ++index)
        this.Nodes[index].ParentOrNext = index + 1;
      this.Nodes[this._nodeCapacity - 1].ParentOrNext = -1;
    }

    public int Root { get; private set; }

    public DynamicTreeNode<T>[] Nodes { get; private set; }

    public int AddProxy(ref JBBox aabb, T userData)
    {
      int leaf = this.AllocateNode();
      this.Nodes[leaf].MinorRandomExtension = (float) this.rnd.NextDouble() * this.settingsRndExtension;
      JVector jvector = new JVector(this.Nodes[leaf].MinorRandomExtension);
      this.Nodes[leaf].AABB.Min = aabb.Min - jvector;
      this.Nodes[leaf].AABB.Max = aabb.Max + jvector;
      this.Nodes[leaf].UserData = userData;
      this.Nodes[leaf].LeafCount = 1;
      this.InsertLeaf(leaf);
      return leaf;
    }

    public void RemoveProxy(int proxyId)
    {
      this.RemoveLeaf(proxyId);
      this.FreeNode(proxyId);
    }

    public bool MoveProxy(int proxyId, ref JBBox aabb, JVector displacement)
    {
      if (this.Nodes[proxyId].AABB.Contains(ref aabb) != JBBox.ContainmentType.Disjoint)
        return false;
      this.RemoveLeaf(proxyId);
      JBBox jbBox = aabb;
      JVector jvector1 = new JVector(this.Nodes[proxyId].MinorRandomExtension);
      jbBox.Min -= jvector1;
      jbBox.Max += jvector1;
      JVector jvector2 = 2f * displacement;
      if ((double) jvector2.X < 0.0)
        jbBox.Min.X += jvector2.X;
      else
        jbBox.Max.X += jvector2.X;
      if ((double) jvector2.Y < 0.0)
        jbBox.Min.Y += jvector2.Y;
      else
        jbBox.Max.Y += jvector2.Y;
      if ((double) jvector2.Z < 0.0)
        jbBox.Min.Z += jvector2.Z;
      else
        jbBox.Max.Z += jvector2.Z;
      this.Nodes[proxyId].AABB = jbBox;
      this.InsertLeaf(proxyId);
      return true;
    }

    public T GetUserData(int proxyId) => this.Nodes[proxyId].UserData;

    public void GetFatAABB(int proxyId, out JBBox fatAABB) => fatAABB = this.Nodes[proxyId].AABB;

    public int ComputeHeight() => this.ComputeHeight(this.Root);

    public void Query(JVector origin, JVector direction, List<int> collisions)
    {
      Stack<int> intStack = this.stackPool.GetNew();
      intStack.Push(this.Root);
      while (intStack.Count > 0)
      {
        int index = intStack.Pop();
        DynamicTreeNode<T> node = this.Nodes[index];
        if (node.AABB.RayIntersect(ref origin, ref direction))
        {
          if (node.IsLeaf())
          {
            collisions.Add(index);
          }
          else
          {
            if (this.Nodes[node.Child1].AABB.RayIntersect(ref origin, ref direction))
              intStack.Push(node.Child1);
            if (this.Nodes[node.Child2].AABB.RayIntersect(ref origin, ref direction))
              intStack.Push(node.Child2);
          }
        }
      }
      this.stackPool.GiveBack(intStack);
    }

    public void Query(List<int> other, List<int> my, DynamicTree<T> tree)
    {
      Stack<int> intStack1 = this.stackPool.GetNew();
      Stack<int> intStack2 = this.stackPool.GetNew();
      intStack1.Push(this.Root);
      intStack2.Push(tree.Root);
      while (intStack1.Count > 0)
      {
        int index1 = intStack1.Pop();
        int index2 = intStack2.Pop();
        if (index1 != -1 && index2 != -1 && tree.Nodes[index2].AABB.Contains(ref this.Nodes[index1].AABB) != JBBox.ContainmentType.Disjoint)
        {
          if (this.Nodes[index1].IsLeaf() && tree.Nodes[index2].IsLeaf())
          {
            my.Add(index1);
            other.Add(index2);
          }
          else if (tree.Nodes[index2].IsLeaf())
          {
            intStack1.Push(this.Nodes[index1].Child1);
            intStack2.Push(index2);
            intStack1.Push(this.Nodes[index1].Child2);
            intStack2.Push(index2);
          }
          else if (this.Nodes[index1].IsLeaf())
          {
            intStack1.Push(index1);
            intStack2.Push(tree.Nodes[index2].Child1);
            intStack1.Push(index1);
            intStack2.Push(tree.Nodes[index2].Child2);
          }
          else
          {
            intStack1.Push(this.Nodes[index1].Child1);
            intStack2.Push(tree.Nodes[index2].Child1);
            intStack1.Push(this.Nodes[index1].Child1);
            intStack2.Push(tree.Nodes[index2].Child2);
            intStack1.Push(this.Nodes[index1].Child2);
            intStack2.Push(tree.Nodes[index2].Child1);
            intStack1.Push(this.Nodes[index1].Child2);
            intStack2.Push(tree.Nodes[index2].Child2);
          }
        }
      }
      this.stackPool.GiveBack(intStack1);
      this.stackPool.GiveBack(intStack2);
    }

    public void Query(List<int> my, ref JBBox aabb)
    {
      Stack<int> intStack = this.stackPool.GetNew();
      intStack.Push(this.Root);
      while (intStack.Count > 0)
      {
        int index = intStack.Pop();
        if (index != -1)
        {
          DynamicTreeNode<T> node = this.Nodes[index];
          if (aabb.Contains(ref node.AABB) != JBBox.ContainmentType.Disjoint)
          {
            if (node.IsLeaf())
            {
              my.Add(index);
            }
            else
            {
              intStack.Push(node.Child1);
              intStack.Push(node.Child2);
            }
          }
        }
      }
      this.stackPool.GiveBack(intStack);
    }

    private int CountLeaves(int nodeId)
    {
      if (nodeId == -1)
        return 0;
      DynamicTreeNode<T> node = this.Nodes[nodeId];
      return node.IsLeaf() ? 1 : this.CountLeaves(node.Child1) + this.CountLeaves(node.Child2);
    }

    private void Validate() => this.CountLeaves(this.Root);

    private int AllocateNode()
    {
      if (this._freeList == -1)
      {
        DynamicTreeNode<T>[] nodes1 = this.Nodes;
        this._nodeCapacity *= 2;
        this.Nodes = new DynamicTreeNode<T>[this._nodeCapacity];
        DynamicTreeNode<T>[] nodes2 = this.Nodes;
        int nodeCount1 = this._nodeCount;
        Array.Copy((Array) nodes1, (Array) nodes2, nodeCount1);
        for (int nodeCount2 = this._nodeCount; nodeCount2 < this._nodeCapacity - 1; ++nodeCount2)
          this.Nodes[nodeCount2].ParentOrNext = nodeCount2 + 1;
        this.Nodes[this._nodeCapacity - 1].ParentOrNext = -1;
        this._freeList = this._nodeCount;
      }
      int freeList = this._freeList;
      this._freeList = this.Nodes[freeList].ParentOrNext;
      this.Nodes[freeList].ParentOrNext = -1;
      this.Nodes[freeList].Child1 = -1;
      this.Nodes[freeList].Child2 = -1;
      this.Nodes[freeList].LeafCount = 0;
      ++this._nodeCount;
      return freeList;
    }

    private void FreeNode(int nodeId)
    {
      this.Nodes[nodeId].ParentOrNext = this._freeList;
      this._freeList = nodeId;
      --this._nodeCount;
    }

    private void InsertLeaf(int leaf)
    {
      ++this._insertionCount;
      if (this.Root == -1)
      {
        this.Root = leaf;
        this.Nodes[this.Root].ParentOrNext = -1;
      }
      else
      {
        JBBox aabb = this.Nodes[leaf].AABB;
        int index1;
        int child1;
        int child2;
        float num1;
        float num2;
        for (index1 = this.Root; !this.Nodes[index1].IsLeaf(); index1 = (double) num1 >= (double) num2 ? child2 : child1)
        {
          child1 = this.Nodes[index1].Child1;
          child2 = this.Nodes[index1].Child2;
          JBBox.CreateMerged(ref this.Nodes[index1].AABB, ref aabb, out this.Nodes[index1].AABB);
          ++this.Nodes[index1].LeafCount;
          float perimeter1 = this.Nodes[index1].AABB.Perimeter;
          JBBox jbBox = new JBBox();
          JBBox.CreateMerged(ref this.Nodes[index1].AABB, ref aabb, out this.Nodes[index1].AABB);
          float perimeter2 = jbBox.Perimeter;
          float num3 = 2f * perimeter2;
          float num4 = (float) (2.0 * ((double) perimeter2 - (double) perimeter1));
          if (this.Nodes[child1].IsLeaf())
          {
            JBBox result = new JBBox();
            JBBox.CreateMerged(ref aabb, ref this.Nodes[child1].AABB, out result);
            num1 = result.Perimeter + num4;
          }
          else
          {
            JBBox result = new JBBox();
            JBBox.CreateMerged(ref aabb, ref this.Nodes[child1].AABB, out result);
            float perimeter3 = this.Nodes[child1].AABB.Perimeter;
            num1 = result.Perimeter - perimeter3 + num4;
          }
          if (this.Nodes[child2].IsLeaf())
          {
            JBBox result = new JBBox();
            JBBox.CreateMerged(ref aabb, ref this.Nodes[child2].AABB, out result);
            num2 = result.Perimeter + num4;
          }
          else
          {
            JBBox result = new JBBox();
            JBBox.CreateMerged(ref aabb, ref this.Nodes[child2].AABB, out result);
            float perimeter4 = this.Nodes[child2].AABB.Perimeter;
            num2 = result.Perimeter - perimeter4 + num4;
          }
          if ((double) num3 >= (double) num1 || (double) num3 >= (double) num2)
            JBBox.CreateMerged(ref aabb, ref this.Nodes[index1].AABB, out this.Nodes[index1].AABB);
          else
            break;
        }
        int parentOrNext = this.Nodes[index1].ParentOrNext;
        int index2 = this.AllocateNode();
        this.Nodes[index2].ParentOrNext = parentOrNext;
        this.Nodes[index2].UserData = default (T);
        JBBox.CreateMerged(ref aabb, ref this.Nodes[index1].AABB, out this.Nodes[index2].AABB);
        this.Nodes[index2].LeafCount = this.Nodes[index1].LeafCount + 1;
        if (parentOrNext != -1)
        {
          if (this.Nodes[parentOrNext].Child1 == index1)
            this.Nodes[parentOrNext].Child1 = index2;
          else
            this.Nodes[parentOrNext].Child2 = index2;
          this.Nodes[index2].Child1 = index1;
          this.Nodes[index2].Child2 = leaf;
          this.Nodes[index1].ParentOrNext = index2;
          this.Nodes[leaf].ParentOrNext = index2;
        }
        else
        {
          this.Nodes[index2].Child1 = index1;
          this.Nodes[index2].Child2 = leaf;
          this.Nodes[index1].ParentOrNext = index2;
          this.Nodes[leaf].ParentOrNext = index2;
          this.Root = index2;
        }
      }
    }

    private void RemoveLeaf(int leaf)
    {
      if (leaf == this.Root)
      {
        this.Root = -1;
      }
      else
      {
        int parentOrNext1 = this.Nodes[leaf].ParentOrNext;
        int parentOrNext2 = this.Nodes[parentOrNext1].ParentOrNext;
        int index1 = this.Nodes[parentOrNext1].Child1 != leaf ? this.Nodes[parentOrNext1].Child1 : this.Nodes[parentOrNext1].Child2;
        if (parentOrNext2 != -1)
        {
          if (this.Nodes[parentOrNext2].Child1 == parentOrNext1)
            this.Nodes[parentOrNext2].Child1 = index1;
          else
            this.Nodes[parentOrNext2].Child2 = index1;
          this.Nodes[index1].ParentOrNext = parentOrNext2;
          this.FreeNode(parentOrNext1);
          for (int index2 = parentOrNext2; index2 != -1; index2 = this.Nodes[index2].ParentOrNext)
          {
            JBBox.CreateMerged(ref this.Nodes[this.Nodes[index2].Child1].AABB, ref this.Nodes[this.Nodes[index2].Child2].AABB, out this.Nodes[index2].AABB);
            --this.Nodes[index2].LeafCount;
          }
        }
        else
        {
          this.Root = index1;
          this.Nodes[index1].ParentOrNext = -1;
          this.FreeNode(parentOrNext1);
        }
      }
    }

    private int ComputeHeight(int nodeId)
    {
      if (nodeId == -1)
        return 0;
      DynamicTreeNode<T> node = this.Nodes[nodeId];
      return 1 + Math.Max(this.ComputeHeight(node.Child1), this.ComputeHeight(node.Child2));
    }
  }
}
