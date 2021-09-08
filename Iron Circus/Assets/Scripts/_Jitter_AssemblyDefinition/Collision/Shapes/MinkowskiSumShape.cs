// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.MinkowskiSumShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Jitter.Collision.Shapes
{
  public class MinkowskiSumShape : Shape
  {
    private readonly List<Shape> shapes = new List<Shape>();
    private JVector shifted;

    public MinkowskiSumShape()
    {
    }

    public MinkowskiSumShape(IEnumerable<Shape> shapes) => this.AddShapes(shapes);

    public void AddShapes(IEnumerable<Shape> shapes)
    {
      foreach (Shape shape in shapes)
      {
        if (shape is Multishape)
          throw new Exception("Multishapes not supported by MinkowskiSumShape.");
        this.shapes.Add(shape);
      }
      this.UpdateShape();
    }

    public void AddShape(Shape shape, bool skipMassInertia)
    {
      if (shape is Multishape)
        throw new Exception("Multishapes not supported by MinkowskiSumShape.");
      this.shapes.Add(shape);
      this.UpdateShape(skipMassInertia);
    }

    public bool Remove(Shape shape)
    {
      if (this.shapes.Count == 1)
        throw new Exception("There must be at least one shape.");
      int num = this.shapes.Remove(shape) ? 1 : 0;
      this.UpdateShape();
      return num != 0;
    }

    public JVector Shift() => -1f * this.shifted;

    public override void CalculateMassInertia() => this.mass = Shape.CalculateMassInertia((Shape) this, out this.shifted, out this.inertia);

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      JVector result1 = JVector.Zero;
      for (int index = 0; index < this.shapes.Count; ++index)
      {
        JVector result2;
        this.shapes[index].SupportMapping(ref direction, out result2);
        JVector.Add(ref result2, ref result1, out result1);
      }
      JVector.Subtract(ref result1, ref this.shifted, out result);
    }

    public void ClearShapes() => this.shapes.Clear();
  }
}
