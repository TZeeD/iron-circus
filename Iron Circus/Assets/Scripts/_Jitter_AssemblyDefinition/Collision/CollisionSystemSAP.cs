// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.CollisionSystemSAP
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;
using System.Collections.Generic;

namespace Jitter.Collision
{
  public class CollisionSystemSAP : CollisionSystem
  {
    private readonly List<IBroadphaseEntity> active = new List<IBroadphaseEntity>();
    private readonly Action<object> detectCallback;
    private bool swapOrder;
    private readonly CollisionSystemSAP.IBroadphaseEntityXCompare xComparer;

    public CollisionSystemSAP()
    {
      this.xComparer = new CollisionSystemSAP.IBroadphaseEntityXCompare();
      this.detectCallback = new Action<object>(this.DetectCallback);
    }

    public override bool RemoveEntity(IBroadphaseEntity body) => this.bodyList.Remove(body);

    public override void AddEntity(IBroadphaseEntity body)
    {
      if (this.bodyList.Contains(body))
        throw new ArgumentException("The body was already added to the collision system.", nameof (body));
      this.bodyList.Add(body);
    }

    public override void Detect(bool multiThreaded)
    {
      this.bodyList.Sort((IComparer<IBroadphaseEntity>) this.xComparer);
      this.active.Clear();
      if (multiThreaded)
      {
        for (int index = 0; index < this.bodyList.Count; ++index)
          this.AddToActiveMultithreaded(this.bodyList[index], false);
        this.threadManager.Execute();
      }
      else
      {
        for (int index = 0; index < this.bodyList.Count; ++index)
          this.AddToActive(this.bodyList[index], false);
      }
    }

    private void AddToActive(IBroadphaseEntity body, bool addToList)
    {
      float x = body.BoundingBox.Min.X;
      int count = this.active.Count;
      int index = 0;
      while (index != count)
      {
        IBroadphaseEntity broadphaseEntity = this.active[index];
        if ((double) broadphaseEntity.BoundingBox.Max.X < (double) x)
        {
          --count;
          this.active.RemoveAt(index);
        }
        else
        {
          if (!this.CheckBothStaticOrInactive(body, broadphaseEntity) && this.CheckCollisionMasks(body, broadphaseEntity) && this.CheckBoundingBoxes(body, broadphaseEntity) && this.RaisePassedBroadphase(broadphaseEntity, body))
          {
            if (this.swapOrder)
              this.Detect(body, broadphaseEntity);
            else
              this.Detect(broadphaseEntity, body);
            this.swapOrder = !this.swapOrder;
          }
          ++index;
        }
      }
      this.active.Add(body);
    }

    private void AddToActiveMultithreaded(IBroadphaseEntity body, bool addToList)
    {
      float x = body.BoundingBox.Min.X;
      int count = this.active.Count;
      int index = 0;
      while (index != count)
      {
        IBroadphaseEntity broadphaseEntity = this.active[index];
        if ((double) broadphaseEntity.BoundingBox.Max.X < (double) x)
        {
          --count;
          this.active.RemoveAt(index);
        }
        else
        {
          if (!this.CheckBothStaticOrInactive(body, broadphaseEntity) && this.CheckCollisionMasks(body, broadphaseEntity) && this.CheckBoundingBoxes(body, broadphaseEntity) && this.RaisePassedBroadphase(broadphaseEntity, body))
          {
            CollisionSystem.BroadphasePair broadphasePair = CollisionSystem.BroadphasePair.Pool.GetNew();
            if (this.swapOrder)
            {
              broadphasePair.Entity1 = body;
              broadphasePair.Entity2 = broadphaseEntity;
            }
            else
            {
              broadphasePair.Entity2 = body;
              broadphasePair.Entity1 = broadphaseEntity;
            }
            this.swapOrder = !this.swapOrder;
            this.threadManager.AddTask(this.detectCallback, (object) broadphasePair);
          }
          ++index;
        }
      }
      this.active.Add(body);
    }

    private void DetectCallback(object obj)
    {
      CollisionSystem.BroadphasePair broadphasePair = obj as CollisionSystem.BroadphasePair;
      this.Detect(broadphasePair.Entity1, broadphasePair.Entity2);
      CollisionSystem.BroadphasePair.Pool.GiveBack(broadphasePair);
    }

    private int Compare(IBroadphaseEntity body1, IBroadphaseEntity body2)
    {
      float num = body1.BoundingBox.Min.X - body2.BoundingBox.Min.X;
      if ((double) num < 0.0)
        return -1;
      return (double) num <= 0.0 ? 0 : 1;
    }

    private class IBroadphaseEntityXCompare : IComparer<IBroadphaseEntity>
    {
      public int Compare(IBroadphaseEntity body1, IBroadphaseEntity body2)
      {
        float num = body1.BoundingBox.Min.X - body2.BoundingBox.Min.X;
        if ((double) num < 0.0)
          return -1;
        return (double) num <= 0.0 ? 0 : 1;
      }
    }
  }
}
