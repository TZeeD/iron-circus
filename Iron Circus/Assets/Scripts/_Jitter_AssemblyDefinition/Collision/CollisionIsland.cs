// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.CollisionIsland
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.DataStructures;
using Jitter.Dynamics;
using Jitter.Dynamics.Constraints;
using System.Collections.Generic;

namespace Jitter.Collision
{
  public class CollisionIsland
  {
    internal HashSet<Jitter.Dynamics.Arbiter> arbiter = new HashSet<Jitter.Dynamics.Arbiter>();
    internal HashSet<JRigidbody> bodies = new HashSet<JRigidbody>();
    internal HashSet<Constraint> constraints = new HashSet<Constraint>();
    internal IslandManager islandManager;

    public CollisionIsland()
    {
      this.Bodies = new ReadOnlyHashset<JRigidbody>(this.bodies);
      this.Arbiter = new ReadOnlyHashset<Jitter.Dynamics.Arbiter>(this.arbiter);
      this.Constraints = new ReadOnlyHashset<Constraint>(this.constraints);
    }

    public ReadOnlyHashset<JRigidbody> Bodies { get; }

    public ReadOnlyHashset<Jitter.Dynamics.Arbiter> Arbiter { get; }

    public ReadOnlyHashset<Constraint> Constraints { get; }

    public bool IsActive()
    {
      HashSet<JRigidbody>.Enumerator enumerator = this.bodies.GetEnumerator();
      enumerator.MoveNext();
      return enumerator.Current != null && enumerator.Current.isActive;
    }

    public void SetStatus(bool active)
    {
      foreach (JRigidbody body in this.bodies)
      {
        body.IsActive = active;
        if (active && !body.IsActive)
          body.inactiveTime = 0.0f;
      }
    }

    internal void ClearLists()
    {
      this.arbiter.Clear();
      this.bodies.Clear();
      this.constraints.Clear();
    }
  }
}
