// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.Multishape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System.Collections.Generic;

namespace Jitter.Collision.Shapes
{
  public abstract class Multishape : Shape
  {
    internal bool isClone;
    private Stack<Multishape> workingCloneStack = new Stack<Multishape>();

    public bool IsClone => this.isClone;

    public abstract void SetCurrentShape(int index);

    public abstract int Prepare(ref JBBox box);

    public abstract int Prepare(ref JVector rayOrigin, ref JVector rayDelta);

    protected abstract Multishape CreateWorkingClone();

    public Multishape RequestWorkingClone()
    {
      Multishape multishape;
      lock (this.workingCloneStack)
      {
        if (this.workingCloneStack.Count == 0)
        {
          multishape = this.CreateWorkingClone();
          multishape.workingCloneStack = this.workingCloneStack;
          this.workingCloneStack.Push(multishape);
        }
        multishape = this.workingCloneStack.Pop();
        multishape.isClone = true;
      }
      return multishape;
    }

    public override void UpdateShape(bool skipMassInertia = false)
    {
      lock (this.workingCloneStack)
        this.workingCloneStack.Clear();
      base.UpdateShape(skipMassInertia);
    }

    public void ReturnWorkingClone()
    {
      lock (this.workingCloneStack)
        this.workingCloneStack.Push(this);
    }

    public override void GetBoundingBox(ref JMatrix orientation, out JBBox box)
    {
      JBBox box1 = JBBox.LargeBox;
      int num = this.Prepare(ref box1);
      box = JBBox.SmallBox;
      for (int index = 0; index < num; ++index)
      {
        this.SetCurrentShape(index);
        base.GetBoundingBox(ref orientation, out box1);
        JBBox.CreateMerged(ref box, ref box1, out box);
      }
    }

    public override void MakeHull(ref List<JVector> triangleList, int generationThreshold)
    {
    }

    public override void CalculateMassInertia()
    {
      this.geomCen = JVector.Zero;
      this.inertia = JMatrix.Identity;
      JVector result;
      JVector.Subtract(ref this.boundingBox.Max, ref this.boundingBox.Min, out result);
      this.mass = result.X * result.Y * result.Z;
      this.inertia.M11 = (float) (0.0833333358168602 * (double) this.mass * ((double) result.Y * (double) result.Y + (double) result.Z * (double) result.Z));
      this.inertia.M22 = (float) (0.0833333358168602 * (double) this.mass * ((double) result.X * (double) result.X + (double) result.Z * (double) result.Z));
      this.inertia.M33 = (float) (0.0833333358168602 * (double) this.mass * ((double) result.X * (double) result.X + (double) result.Y * (double) result.Y));
    }
  }
}
