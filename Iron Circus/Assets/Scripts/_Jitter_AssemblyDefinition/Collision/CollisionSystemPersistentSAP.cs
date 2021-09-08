// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.CollisionSystemPersistentSAP
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;
using System.Collections.Generic;

namespace Jitter.Collision
{
  public class CollisionSystemPersistentSAP : CollisionSystem
  {
    private const int AddedObjectsBruteForceIsUsed = 250;
    private int addCounter;
    private readonly List<CollisionSystemPersistentSAP.SweepPoint> axis1 = new List<CollisionSystemPersistentSAP.SweepPoint>();
    private readonly List<CollisionSystemPersistentSAP.SweepPoint> axis2 = new List<CollisionSystemPersistentSAP.SweepPoint>();
    private readonly List<CollisionSystemPersistentSAP.SweepPoint> axis3 = new List<CollisionSystemPersistentSAP.SweepPoint>();
    private readonly Stack<CollisionSystemPersistentSAP.OverlapPair> depricated = new Stack<CollisionSystemPersistentSAP.OverlapPair>();
    private readonly Action<object> detectCallback;
    private readonly Action<object> sortCallback;
    private readonly HashSet<CollisionSystemPersistentSAP.OverlapPair> fullOverlaps = new HashSet<CollisionSystemPersistentSAP.OverlapPair>();
    private bool swapOrder;
    private readonly List<IBroadphaseEntity> activeList = new List<IBroadphaseEntity>();

    public CollisionSystemPersistentSAP()
    {
      this.detectCallback = new Action<object>(this.DetectCallback);
      this.sortCallback = new Action<object>(this.SortCallback);
    }

    private void SortAxis(List<CollisionSystemPersistentSAP.SweepPoint> axis)
    {
      for (int index1 = 1; index1 < axis.Count; ++index1)
      {
        CollisionSystemPersistentSAP.SweepPoint axi1 = axis[index1];
        float num = axi1.Value;
        int index2;
        for (index2 = index1 - 1; index2 >= 0 && (double) axis[index2].Value > (double) num; --index2)
        {
          CollisionSystemPersistentSAP.SweepPoint axi2 = axis[index2];
          if (axi1.Begin && !axi2.Begin && this.CheckBoundingBoxes(axi2.Body, axi1.Body))
          {
            lock (this.fullOverlaps)
              this.fullOverlaps.Add(new CollisionSystemPersistentSAP.OverlapPair(axi2.Body, axi1.Body));
          }
          if (!axi1.Begin && axi2.Begin)
          {
            lock (this.fullOverlaps)
              this.fullOverlaps.Remove(new CollisionSystemPersistentSAP.OverlapPair(axi2.Body, axi1.Body));
          }
          axis[index2 + 1] = axi2;
        }
        axis[index2 + 1] = axi1;
      }
    }

    public override void AddEntity(IBroadphaseEntity body)
    {
      this.bodyList.Add(body);
      this.axis1.Add(new CollisionSystemPersistentSAP.SweepPoint(body, true, 0));
      this.axis1.Add(new CollisionSystemPersistentSAP.SweepPoint(body, false, 0));
      this.axis2.Add(new CollisionSystemPersistentSAP.SweepPoint(body, true, 1));
      this.axis2.Add(new CollisionSystemPersistentSAP.SweepPoint(body, false, 1));
      this.axis3.Add(new CollisionSystemPersistentSAP.SweepPoint(body, true, 2));
      this.axis3.Add(new CollisionSystemPersistentSAP.SweepPoint(body, false, 2));
      ++this.addCounter;
    }

    public override bool RemoveEntity(IBroadphaseEntity body)
    {
      int num1 = 0;
      for (int index = 0; index < this.axis1.Count; ++index)
      {
        if (this.axis1[index].Body == body)
        {
          ++num1;
          this.axis1.RemoveAt(index);
          if (num1 != 2)
            --index;
          else
            break;
        }
      }
      int num2 = 0;
      for (int index = 0; index < this.axis2.Count; ++index)
      {
        if (this.axis2[index].Body == body)
        {
          ++num2;
          this.axis2.RemoveAt(index);
          if (num2 != 2)
            --index;
          else
            break;
        }
      }
      int num3 = 0;
      for (int index = 0; index < this.axis3.Count; ++index)
      {
        if (this.axis3[index].Body == body)
        {
          ++num3;
          this.axis3.RemoveAt(index);
          if (num3 != 2)
            --index;
          else
            break;
        }
      }
      foreach (CollisionSystemPersistentSAP.OverlapPair fullOverlap in this.fullOverlaps)
      {
        if (fullOverlap.Entity1 == body || fullOverlap.Entity2 == body)
          this.depricated.Push(fullOverlap);
      }
      while (this.depricated.Count > 0)
        this.fullOverlaps.Remove(this.depricated.Pop());
      this.bodyList.Remove(body);
      return true;
    }

    public override void Detect(bool multiThreaded)
    {
      if (this.addCounter > 250)
      {
        this.fullOverlaps.Clear();
        this.DirtySortAxis(this.axis1);
        this.DirtySortAxis(this.axis2);
        this.DirtySortAxis(this.axis3);
      }
      else if (multiThreaded)
      {
        this.threadManager.AddTask(this.sortCallback, (object) this.axis1);
        this.threadManager.AddTask(this.sortCallback, (object) this.axis2);
        this.threadManager.AddTask(this.sortCallback, (object) this.axis3);
        this.threadManager.Execute();
      }
      else
      {
        this.sortCallback((object) this.axis1);
        this.sortCallback((object) this.axis2);
        this.sortCallback((object) this.axis3);
      }
      this.addCounter = 0;
      foreach (CollisionSystemPersistentSAP.OverlapPair fullOverlap in this.fullOverlaps)
      {
        if (!this.CheckBothStaticOrInactive(fullOverlap.Entity1, fullOverlap.Entity2) && this.CheckCollisionMasks(fullOverlap.Entity1, fullOverlap.Entity2) && this.RaisePassedBroadphase(fullOverlap.Entity1, fullOverlap.Entity2))
        {
          if (multiThreaded)
          {
            CollisionSystem.BroadphasePair broadphasePair = CollisionSystem.BroadphasePair.Pool.GetNew();
            if (this.swapOrder)
            {
              broadphasePair.Entity1 = fullOverlap.Entity1;
              broadphasePair.Entity2 = fullOverlap.Entity2;
            }
            else
            {
              broadphasePair.Entity2 = fullOverlap.Entity2;
              broadphasePair.Entity1 = fullOverlap.Entity1;
            }
            this.threadManager.AddTask(this.detectCallback, (object) broadphasePair);
          }
          else if (this.swapOrder)
            this.Detect(fullOverlap.Entity1, fullOverlap.Entity2);
          else
            this.Detect(fullOverlap.Entity2, fullOverlap.Entity1);
          this.swapOrder = !this.swapOrder;
        }
      }
      this.threadManager.Execute();
    }

    private void SortCallback(object obj) => this.SortAxis(obj as List<CollisionSystemPersistentSAP.SweepPoint>);

    private void DetectCallback(object obj)
    {
      CollisionSystem.BroadphasePair broadphasePair = obj as CollisionSystem.BroadphasePair;
      this.Detect(broadphasePair.Entity1, broadphasePair.Entity2);
      CollisionSystem.BroadphasePair.Pool.GiveBack(broadphasePair);
    }

    private int QuickSort(
      CollisionSystemPersistentSAP.SweepPoint sweepPoint1,
      CollisionSystemPersistentSAP.SweepPoint sweepPoint2)
    {
      float num1 = sweepPoint1.Value;
      float num2 = sweepPoint2.Value;
      if ((double) num1 > (double) num2)
        return 1;
      return (double) num2 > (double) num1 ? -1 : 0;
    }

    private void DirtySortAxis(List<CollisionSystemPersistentSAP.SweepPoint> axis)
    {
      axis.Sort(new Comparison<CollisionSystemPersistentSAP.SweepPoint>(this.QuickSort));
      this.activeList.Clear();
      for (int index = 0; index < axis.Count; ++index)
      {
        CollisionSystemPersistentSAP.SweepPoint axi = axis[index];
        if (axi.Begin)
        {
          foreach (IBroadphaseEntity active in this.activeList)
          {
            if (this.CheckBoundingBoxes(active, axi.Body))
              this.fullOverlaps.Add(new CollisionSystemPersistentSAP.OverlapPair(active, axi.Body));
          }
          this.activeList.Add(axi.Body);
        }
        else
          this.activeList.Remove(axi.Body);
      }
    }

    private class SweepPoint
    {
      public readonly int Axis;
      public readonly bool Begin;
      public readonly IBroadphaseEntity Body;

      public SweepPoint(IBroadphaseEntity body, bool begin, int axis)
      {
        this.Body = body;
        this.Begin = begin;
        this.Axis = axis;
      }

      public float Value
      {
        get
        {
          if (this.Begin)
          {
            if (this.Axis == 0)
              return this.Body.BoundingBox.Min.X;
            return this.Axis == 1 ? this.Body.BoundingBox.Min.Y : this.Body.BoundingBox.Min.Z;
          }
          if (this.Axis == 0)
            return this.Body.BoundingBox.Max.X;
          return this.Axis == 1 ? this.Body.BoundingBox.Max.Y : this.Body.BoundingBox.Max.Z;
        }
      }
    }

    private struct OverlapPair
    {
      public IBroadphaseEntity Entity1;
      public IBroadphaseEntity Entity2;

      public OverlapPair(IBroadphaseEntity entity1, IBroadphaseEntity entity2)
      {
        this.Entity1 = entity1;
        this.Entity2 = entity2;
      }

      internal void SetBodies(IBroadphaseEntity entity1, IBroadphaseEntity entity2)
      {
        this.Entity1 = entity1;
        this.Entity2 = entity2;
      }

      public override bool Equals(object obj)
      {
        CollisionSystemPersistentSAP.OverlapPair overlapPair = (CollisionSystemPersistentSAP.OverlapPair) obj;
        if (overlapPair.Entity1.Equals((object) this.Entity1) && overlapPair.Entity2.Equals((object) this.Entity2))
          return true;
        return overlapPair.Entity1.Equals((object) this.Entity2) && overlapPair.Entity2.Equals((object) this.Entity1);
      }

      public override int GetHashCode() => this.Entity1.GetHashCode() + this.Entity2.GetHashCode();
    }
  }
}
