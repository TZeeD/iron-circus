// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.CompoundShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Jitter.Collision.Shapes
{
  public class CompoundShape : Multishape
  {
    private int currentShape;
    private readonly List<int> currentSubShapes = new List<int>();
    private JBBox mInternalBBox;
    private JVector shifted;

    public CompoundShape(List<CompoundShape.TransformedShape> shapes)
    {
      this.Shapes = new CompoundShape.TransformedShape[shapes.Count];
      shapes.CopyTo(this.Shapes);
      if (!this.TestValidity())
        throw new ArgumentException("Multishapes are not supported!");
      this.UpdateShape(false);
    }

    public CompoundShape(CompoundShape.TransformedShape[] shapes)
    {
      this.Shapes = new CompoundShape.TransformedShape[shapes.Length];
      Array.Copy((Array) shapes, (Array) this.Shapes, shapes.Length);
      if (!this.TestValidity())
        throw new ArgumentException("Multishapes are not supported!");
      this.UpdateShape(false);
    }

    internal CompoundShape()
    {
    }

    public CompoundShape.TransformedShape[] Shapes { get; private set; }

    public JVector Shift => -1f * this.shifted;

    private bool TestValidity()
    {
      for (int index = 0; index < this.Shapes.Length; ++index)
      {
        if (this.Shapes[index].Shape is Multishape)
          return false;
      }
      return true;
    }

    public override void MakeHull(ref List<JVector> triangleList, int generationThreshold)
    {
      List<JVector> triangleList1 = new List<JVector>();
      for (int index1 = 0; index1 < this.Shapes.Length; ++index1)
      {
        this.Shapes[index1].Shape.MakeHull(ref triangleList1, 4);
        for (int index2 = 0; index2 < triangleList1.Count; ++index2)
        {
          JVector result = triangleList1[index2];
          JVector.Transform(ref result, ref this.Shapes[index1].orientation, out result);
          JVector.Add(ref result, ref this.Shapes[index1].position, out result);
          triangleList.Add(result);
        }
        triangleList1.Clear();
      }
    }

    private void DoShifting()
    {
      for (int index = 0; index < this.Shapes.Length; ++index)
        this.shifted += this.Shapes[index].position;
      this.shifted *= 1f / (float) this.Shapes.Length;
      for (int index = 0; index < this.Shapes.Length; ++index)
        this.Shapes[index].position -= this.shifted;
    }

    public override void CalculateMassInertia()
    {
      this.inertia = JMatrix.Zero;
      this.mass = 0.0f;
      for (int index = 0; index < this.Shapes.Length; ++index)
      {
        JMatrix jmatrix = this.Shapes[index].InverseOrientation * this.Shapes[index].Shape.Inertia * this.Shapes[index].Orientation;
        JVector jvector = this.Shapes[index].Position * -1f;
        float mass = this.Shapes[index].Shape.Mass;
        jmatrix.M11 += mass * (float) ((double) jvector.Y * (double) jvector.Y + (double) jvector.Z * (double) jvector.Z);
        jmatrix.M22 += mass * (float) ((double) jvector.X * (double) jvector.X + (double) jvector.Z * (double) jvector.Z);
        jmatrix.M33 += mass * (float) ((double) jvector.X * (double) jvector.X + (double) jvector.Y * (double) jvector.Y);
        jmatrix.M12 += -jvector.X * jvector.Y * mass;
        jmatrix.M21 += -jvector.X * jvector.Y * mass;
        jmatrix.M31 += -jvector.X * jvector.Z * mass;
        jmatrix.M13 += -jvector.X * jvector.Z * mass;
        jmatrix.M32 += -jvector.Y * jvector.Z * mass;
        jmatrix.M23 += -jvector.Y * jvector.Z * mass;
        this.inertia = this.inertia + jmatrix;
        this.mass += mass;
      }
    }

    protected override Multishape CreateWorkingClone() => (Multishape) new CompoundShape()
    {
      Shapes = this.Shapes
    };

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      JVector.Transform(ref direction, ref this.Shapes[this.currentShape].invOrientation, out result);
      this.Shapes[this.currentShape].Shape.SupportMapping(ref direction, out result);
      JVector.Transform(ref result, ref this.Shapes[this.currentShape].orientation, out result);
      JVector.Add(ref result, ref this.Shapes[this.currentShape].position, out result);
    }

    public override void GetBoundingBox(ref JMatrix orientation, out JBBox box)
    {
      box.Min = this.mInternalBBox.Min;
      box.Max = this.mInternalBBox.Max;
      JVector position1 = 0.5f * (box.Max - box.Min);
      JVector position2 = 0.5f * (box.Max + box.Min);
      JVector result1;
      JVector.Transform(ref position2, ref orientation, out result1);
      JMatrix result2;
      JMath.Absolute(ref orientation, out result2);
      JVector result3;
      JVector.Transform(ref position1, ref result2, out result3);
      box.Max = result1 + result3;
      box.Min = result1 - result3;
    }

    public override void SetCurrentShape(int index)
    {
      this.currentShape = this.currentSubShapes[index];
      this.Shapes[this.currentShape].Shape.SupportCenter(out this.geomCen);
      this.geomCen = this.geomCen + this.Shapes[this.currentShape].Position;
    }

    public override int Prepare(ref JBBox box)
    {
      this.currentSubShapes.Clear();
      for (int index = 0; index < this.Shapes.Length; ++index)
      {
        if (this.Shapes[index].boundingBox.Contains(ref box) != JBBox.ContainmentType.Disjoint)
          this.currentSubShapes.Add(index);
      }
      return this.currentSubShapes.Count;
    }

    public override int Prepare(ref JVector rayOrigin, ref JVector rayEnd)
    {
      JBBox smallBox = JBBox.SmallBox;
      smallBox.AddPoint(ref rayOrigin);
      smallBox.AddPoint(ref rayEnd);
      return this.Prepare(ref smallBox);
    }

    public override void UpdateShape(bool skipMassInertia = false)
    {
      this.DoShifting();
      this.UpdateInternalBoundingBox();
      base.UpdateShape(skipMassInertia);
    }

    protected void UpdateInternalBoundingBox()
    {
      this.mInternalBBox.Min = new JVector(float.MaxValue);
      this.mInternalBBox.Max = new JVector(float.MinValue);
      for (int index = 0; index < this.Shapes.Length; ++index)
      {
        this.Shapes[index].UpdateBoundingBox();
        JBBox.CreateMerged(ref this.mInternalBBox, ref this.Shapes[index].boundingBox, out this.mInternalBBox);
      }
    }

    public struct TransformedShape
    {
      internal JVector position;
      internal JMatrix orientation;
      internal JMatrix invOrientation;
      internal JBBox boundingBox;

      public Shape Shape { get; set; }

      public JVector Position
      {
        get => this.position;
        set
        {
          this.position = value;
          this.UpdateBoundingBox();
        }
      }

      public JBBox BoundingBox => this.boundingBox;

      public JMatrix InverseOrientation => this.invOrientation;

      public JMatrix Orientation
      {
        get => this.orientation;
        set
        {
          this.orientation = value;
          JMatrix.Transpose(ref this.orientation, out this.invOrientation);
          this.UpdateBoundingBox();
        }
      }

      public void UpdateBoundingBox()
      {
        this.Shape.GetBoundingBox(ref this.orientation, out this.boundingBox);
        this.boundingBox.Min += this.position;
        this.boundingBox.Max += this.position;
      }

      public TransformedShape(Shape shape, JMatrix orientation, JVector position)
      {
        this.position = position;
        this.orientation = orientation;
        JMatrix.Transpose(ref orientation, out this.invOrientation);
        this.Shape = shape;
        this.boundingBox = new JBBox();
        this.UpdateBoundingBox();
      }
    }
  }
}
