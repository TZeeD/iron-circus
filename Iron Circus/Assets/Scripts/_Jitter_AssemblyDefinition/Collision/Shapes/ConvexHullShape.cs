// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.ConvexHullShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System.Collections.Generic;

namespace Jitter.Collision.Shapes
{
  public class ConvexHullShape : Shape
  {
    private JVector shifted;
    private readonly List<JVector> vertices;

    public ConvexHullShape(List<JVector> vertices)
    {
      this.vertices = vertices;
      this.UpdateShape();
    }

    public JVector Shift => -1f * this.shifted;

    public override void CalculateMassInertia() => this.mass = Shape.CalculateMassInertia((Shape) this, out this.shifted, out this.inertia);

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      float num1 = float.MinValue;
      int index1 = 0;
      for (int index2 = 0; index2 < this.vertices.Count; ++index2)
      {
        float num2 = JVector.Dot(this.vertices[index2], direction);
        if ((double) num2 > (double) num1)
        {
          num1 = num2;
          index1 = index2;
        }
      }
      result = this.vertices[index1] - this.shifted;
    }
  }
}
