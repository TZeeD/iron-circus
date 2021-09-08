// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.IslandManager
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Dynamics;
using Jitter.Dynamics.Constraints;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Jitter.Collision
{
  internal class IslandManager : ReadOnlyCollection<CollisionIsland>
  {
    public static ResourcePool<CollisionIsland> Pool = new ResourcePool<CollisionIsland>();
    private readonly List<CollisionIsland> islands;
    private readonly Queue<JRigidbody> leftSearchQueue = new Queue<JRigidbody>();
    private readonly Queue<JRigidbody> rightSearchQueue = new Queue<JRigidbody>();
    private readonly Stack<Arbiter> rmStackArb = new Stack<Arbiter>();
    private readonly Stack<Constraint> rmStackCstr = new Stack<Constraint>();
    private readonly Stack<JRigidbody> rmStackRb = new Stack<JRigidbody>();
    private readonly List<JRigidbody> visitedBodiesLeft = new List<JRigidbody>();
    private readonly List<JRigidbody> visitedBodiesRight = new List<JRigidbody>();

    public IslandManager()
      : base((IList<CollisionIsland>) new List<CollisionIsland>())
    {
      this.islands = this.Items as List<CollisionIsland>;
    }

    public void ArbiterCreated(Arbiter arbiter)
    {
      this.AddConnection(arbiter.body1, arbiter.body2);
      arbiter.body1.arbiters.Add(arbiter);
      arbiter.body2.arbiters.Add(arbiter);
      if (arbiter.body1.island != null)
      {
        arbiter.body1.island.arbiter.Add(arbiter);
      }
      else
      {
        if (arbiter.body2.island == null)
          return;
        arbiter.body2.island.arbiter.Add(arbiter);
      }
    }

    public void ArbiterRemoved(Arbiter arbiter)
    {
      arbiter.body1.arbiters.Remove(arbiter);
      arbiter.body2.arbiters.Remove(arbiter);
      if (arbiter.body1.island != null)
        arbiter.body1.island.arbiter.Remove(arbiter);
      else if (arbiter.body2.island != null)
        arbiter.body2.island.arbiter.Remove(arbiter);
      this.RemoveConnection(arbiter.body1, arbiter.body2);
    }

    public void ConstraintCreated(Constraint constraint)
    {
      this.AddConnection(constraint.body1, constraint.body2);
      constraint.body1.constraints.Add(constraint);
      if (constraint.body2 != null)
        constraint.body2.constraints.Add(constraint);
      if (constraint.body1.island != null)
      {
        constraint.body1.island.constraints.Add(constraint);
      }
      else
      {
        if (constraint.body2 == null || constraint.body2.island == null)
          return;
        constraint.body2.island.constraints.Add(constraint);
      }
    }

    public void ConstraintRemoved(Constraint constraint)
    {
      constraint.body1.constraints.Remove(constraint);
      if (constraint.body2 != null)
        constraint.body2.constraints.Remove(constraint);
      if (constraint.body1.island != null)
        constraint.body1.island.constraints.Remove(constraint);
      else if (constraint.body2 != null && constraint.body2.island != null)
        constraint.body2.island.constraints.Remove(constraint);
      this.RemoveConnection(constraint.body1, constraint.body2);
    }

    public void MakeBodyStatic(JRigidbody body)
    {
      foreach (JRigidbody connection in body.connections)
        this.rmStackRb.Push(connection);
      while (this.rmStackRb.Count > 0)
        this.RemoveConnection(body, this.rmStackRb.Pop());
      body.connections.Clear();
      if (body.island != null)
      {
        body.island.bodies.Remove(body);
        if (body.island.bodies.Count == 0)
        {
          body.island.ClearLists();
          IslandManager.Pool.GiveBack(body.island);
        }
      }
      body.island = (CollisionIsland) null;
    }

    public void RemoveBody(JRigidbody body)
    {
      foreach (Arbiter arbiter in body.arbiters)
        this.rmStackArb.Push(arbiter);
      while (this.rmStackArb.Count > 0)
        this.ArbiterRemoved(this.rmStackArb.Pop());
      foreach (Constraint constraint in body.constraints)
        this.rmStackCstr.Push(constraint);
      while (this.rmStackCstr.Count > 0)
        this.ConstraintRemoved(this.rmStackCstr.Pop());
      body.arbiters.Clear();
      body.constraints.Clear();
      if (body.island == null)
        return;
      body.island.ClearLists();
      IslandManager.Pool.GiveBack(body.island);
      this.islands.Remove(body.island);
      body.island = (CollisionIsland) null;
    }

    public void RemoveAll()
    {
      foreach (CollisionIsland island in this.islands)
      {
        foreach (JRigidbody body in island.bodies)
        {
          body.arbiters.Clear();
          body.constraints.Clear();
          body.connections.Clear();
          body.island = (CollisionIsland) null;
        }
        island.ClearLists();
      }
      this.islands.Clear();
    }

    private void AddConnection(JRigidbody body1, JRigidbody body2)
    {
      if (body1.isStatic)
      {
        if (body2.island != null)
          return;
        CollisionIsland collisionIsland = IslandManager.Pool.GetNew();
        collisionIsland.islandManager = this;
        body2.island = collisionIsland;
        body2.island.bodies.Add(body2);
        this.islands.Add(collisionIsland);
      }
      else if (body2 == null || body2.isStatic)
      {
        if (body1.island != null)
          return;
        CollisionIsland collisionIsland = IslandManager.Pool.GetNew();
        collisionIsland.islandManager = this;
        body1.island = collisionIsland;
        body1.island.bodies.Add(body1);
        this.islands.Add(collisionIsland);
      }
      else
      {
        this.MergeIslands(body1, body2);
        body1.connections.Add(body2);
        body2.connections.Add(body1);
      }
    }

    private void RemoveConnection(JRigidbody body1, JRigidbody body2)
    {
      if (body1.isStatic)
        body2.connections.Remove(body1);
      else if (body2 == null || body2.isStatic)
      {
        body1.connections.Remove(body2);
      }
      else
      {
        body1.connections.Remove(body2);
        body2.connections.Remove(body1);
        this.SplitIslands(body1, body2);
      }
    }

    private void SplitIslands(JRigidbody body0, JRigidbody body1)
    {
      this.leftSearchQueue.Enqueue(body0);
      this.rightSearchQueue.Enqueue(body1);
      this.visitedBodiesLeft.Add(body0);
      this.visitedBodiesRight.Add(body1);
      body0.marker = 1;
      body1.marker = 2;
      while (this.leftSearchQueue.Count > 0 && this.rightSearchQueue.Count > 0)
      {
        JRigidbody jrigidbody1 = this.leftSearchQueue.Dequeue();
        if (!jrigidbody1.isStatic)
        {
          for (int index = 0; index < jrigidbody1.connections.Count; ++index)
          {
            JRigidbody connection = jrigidbody1.connections[index];
            if (connection.marker == 0)
            {
              this.leftSearchQueue.Enqueue(connection);
              this.visitedBodiesLeft.Add(connection);
              connection.marker = 1;
            }
            else if (connection.marker == 2)
            {
              this.leftSearchQueue.Clear();
              this.rightSearchQueue.Clear();
              goto label_48;
            }
          }
        }
        JRigidbody jrigidbody2 = this.rightSearchQueue.Dequeue();
        if (!jrigidbody2.isStatic)
        {
          for (int index = 0; index < jrigidbody2.connections.Count; ++index)
          {
            JRigidbody connection = jrigidbody2.connections[index];
            if (connection.marker == 0)
            {
              this.rightSearchQueue.Enqueue(connection);
              this.visitedBodiesRight.Add(connection);
              connection.marker = 2;
            }
            else if (connection.marker == 1)
            {
              this.leftSearchQueue.Clear();
              this.rightSearchQueue.Clear();
              goto label_48;
            }
          }
        }
      }
      CollisionIsland collisionIsland = IslandManager.Pool.GetNew();
      collisionIsland.islandManager = this;
      this.islands.Add(collisionIsland);
      if (this.leftSearchQueue.Count == 0)
      {
        for (int index = 0; index < this.visitedBodiesLeft.Count; ++index)
        {
          JRigidbody jrigidbody = this.visitedBodiesLeft[index];
          body1.island.bodies.Remove(jrigidbody);
          collisionIsland.bodies.Add(jrigidbody);
          jrigidbody.island = collisionIsland;
          foreach (Arbiter arbiter in jrigidbody.arbiters)
          {
            body1.island.arbiter.Remove(arbiter);
            collisionIsland.arbiter.Add(arbiter);
          }
          foreach (Constraint constraint in jrigidbody.constraints)
          {
            body1.island.constraints.Remove(constraint);
            collisionIsland.constraints.Add(constraint);
          }
        }
        this.rightSearchQueue.Clear();
      }
      else if (this.rightSearchQueue.Count == 0)
      {
        for (int index = 0; index < this.visitedBodiesRight.Count; ++index)
        {
          JRigidbody jrigidbody = this.visitedBodiesRight[index];
          body0.island.bodies.Remove(jrigidbody);
          collisionIsland.bodies.Add(jrigidbody);
          jrigidbody.island = collisionIsland;
          foreach (Arbiter arbiter in jrigidbody.arbiters)
          {
            body0.island.arbiter.Remove(arbiter);
            collisionIsland.arbiter.Add(arbiter);
          }
          foreach (Constraint constraint in jrigidbody.constraints)
          {
            body0.island.constraints.Remove(constraint);
            collisionIsland.constraints.Add(constraint);
          }
        }
        this.leftSearchQueue.Clear();
      }
label_48:
      for (int index = 0; index < this.visitedBodiesLeft.Count; ++index)
        this.visitedBodiesLeft[index].marker = 0;
      for (int index = 0; index < this.visitedBodiesRight.Count; ++index)
        this.visitedBodiesRight[index].marker = 0;
      this.visitedBodiesLeft.Clear();
      this.visitedBodiesRight.Clear();
    }

    private void MergeIslands(JRigidbody body0, JRigidbody body1)
    {
      if (body0.island != body1.island)
      {
        if (body0.island == null)
        {
          body0.island = body1.island;
          body0.island.bodies.Add(body0);
        }
        else if (body1.island == null)
        {
          body1.island = body0.island;
          body1.island.bodies.Add(body1);
        }
        else
        {
          JRigidbody jrigidbody1;
          JRigidbody jrigidbody2;
          if (body0.island.bodies.Count > body1.island.bodies.Count)
          {
            jrigidbody1 = body1;
            jrigidbody2 = body0;
          }
          else
          {
            jrigidbody1 = body0;
            jrigidbody2 = body1;
          }
          CollisionIsland island = jrigidbody1.island;
          IslandManager.Pool.GiveBack(island);
          this.islands.Remove(island);
          foreach (JRigidbody body in island.bodies)
          {
            body.island = jrigidbody2.island;
            jrigidbody2.island.bodies.Add(body);
          }
          foreach (Arbiter arbiter in island.arbiter)
            jrigidbody2.island.arbiter.Add(arbiter);
          foreach (Constraint constraint in island.constraints)
            jrigidbody2.island.constraints.Add(constraint);
          island.ClearLists();
        }
      }
      else
      {
        if (body0.island != null)
          return;
        CollisionIsland collisionIsland = IslandManager.Pool.GetNew();
        collisionIsland.islandManager = this;
        body0.island = body1.island = collisionIsland;
        body0.island.bodies.Add(body0);
        body0.island.bodies.Add(body1);
        this.islands.Add(collisionIsland);
      }
    }
  }
}
