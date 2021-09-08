// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.CollisionSystemBrute
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;

namespace Jitter.Collision
{
  public class CollisionSystemBrute : CollisionSystem
  {
    private readonly Action<object> detectCallback;
    private bool swapOrder;

    public CollisionSystemBrute() => this.detectCallback = new Action<object>(this.DetectCallback);

    public override bool RemoveEntity(IBroadphaseEntity body) => this.bodyList.Remove(body);

    public override void AddEntity(IBroadphaseEntity body)
    {
      if (this.bodyList.Contains(body))
        throw new ArgumentException("The body was already added to the collision system.", nameof (body));
      this.bodyList.Add(body);
    }

    public override void Detect(bool multiThreaded)
    {
      int count = this.bodyList.Count;
      if (multiThreaded)
      {
        for (int index1 = 0; index1 < count; ++index1)
        {
          for (int index2 = index1 + 1; index2 < count; ++index2)
          {
            if (!this.CheckBothStaticOrInactive(this.bodyList[index1], this.bodyList[index2]) && this.CheckCollisionMasks(this.bodyList[index1], this.bodyList[index2]) && this.CheckBoundingBoxes(this.bodyList[index1], this.bodyList[index2]) && this.RaisePassedBroadphase(this.bodyList[index1], this.bodyList[index2]))
            {
              CollisionSystem.BroadphasePair broadphasePair = CollisionSystem.BroadphasePair.Pool.GetNew();
              if (this.swapOrder)
              {
                broadphasePair.Entity1 = this.bodyList[index1];
                broadphasePair.Entity2 = this.bodyList[index2];
              }
              else
              {
                broadphasePair.Entity2 = this.bodyList[index2];
                broadphasePair.Entity1 = this.bodyList[index1];
              }
              this.swapOrder = !this.swapOrder;
              this.threadManager.AddTask(this.detectCallback, (object) broadphasePair);
            }
          }
        }
        this.threadManager.Execute();
      }
      else
      {
        for (int index3 = 0; index3 < count; ++index3)
        {
          for (int index4 = index3 + 1; index4 < count; ++index4)
          {
            if (!this.CheckBothStaticOrInactive(this.bodyList[index3], this.bodyList[index4]) && this.CheckCollisionMasks(this.bodyList[index3], this.bodyList[index4]) && this.CheckBoundingBoxes(this.bodyList[index3], this.bodyList[index4]) && this.RaisePassedBroadphase(this.bodyList[index3], this.bodyList[index4]))
            {
              if (this.swapOrder)
                this.Detect(this.bodyList[index3], this.bodyList[index4]);
              else
                this.Detect(this.bodyList[index4], this.bodyList[index3]);
              this.swapOrder = !this.swapOrder;
            }
          }
        }
      }
    }

    private void DetectCallback(object obj)
    {
      CollisionSystem.BroadphasePair broadphasePair = obj as CollisionSystem.BroadphasePair;
      this.Detect(broadphasePair.Entity1, broadphasePair.Entity2);
      CollisionSystem.BroadphasePair.Pool.GiveBack(broadphasePair);
    }
  }
}
