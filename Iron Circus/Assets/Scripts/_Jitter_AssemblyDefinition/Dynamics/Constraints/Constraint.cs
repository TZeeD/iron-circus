// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Constraints.Constraint
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;
using System.Threading;

namespace Jitter.Dynamics.Constraints
{
  public abstract class Constraint : IConstraint, IDebugDrawable, IComparable<Constraint>
  {
    internal JRigidbody body1;
    internal JRigidbody body2;
    private static int instanceCount;
    private int instance;

    public JRigidbody Body1 => this.body1;

    public JRigidbody Body2 => this.body2;

    public Constraint(JRigidbody body1, JRigidbody body2)
    {
      this.body1 = body1;
      this.body2 = body2;
      this.instance = Interlocked.Increment(ref Constraint.instanceCount);
      body1?.Update();
      body2?.Update();
    }

    public abstract void PrepareForIteration(float timestep);

    public abstract void Iterate();

    public int CompareTo(Constraint other)
    {
      if (other.instance < this.instance)
        return -1;
      return other.instance > this.instance ? 1 : 0;
    }

    public virtual void DebugDraw(IDebugDrawer drawer)
    {
    }
  }
}
