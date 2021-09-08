// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.Shape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Jitter.Collision.Shapes
{
  public abstract class Shape : ISupportMappable
  {
    internal JBBox boundingBox = JBBox.LargeBox;
    internal JVector geomCen = JVector.Zero;
    internal JMatrix inertia = JMatrix.Identity;
    internal float mass = 1f;

    public JMatrix Inertia
    {
      get => this.inertia;
      protected set => this.inertia = value;
    }

    public float Mass
    {
      get => this.mass;
      protected set => this.mass = value;
    }

    public JBBox BoundingBox => this.boundingBox;

    public object Tag { get; set; }

    public abstract void SupportMapping(ref JVector direction, out JVector result);

    public void SupportCenter(out JVector geomCenter) => geomCenter = this.geomCen;

    public event ShapeUpdatedHandler ShapeUpdated;

    protected void RaiseShapeUpdated()
    {
      if (this.ShapeUpdated == null)
        return;
      this.ShapeUpdated();
    }

    public virtual void MakeHull(ref List<JVector> triangleList, int generationThreshold)
    {
      float num1 = 0.0f;
      if (generationThreshold < 0)
        generationThreshold = 4;
      Stack<Shape.ClipTriangle> clipTriangleStack = new Stack<Shape.ClipTriangle>();
      JVector[] jvectorArray = new JVector[6]
      {
        new JVector(-1f, 0.0f, 0.0f),
        new JVector(1f, 0.0f, 0.0f),
        new JVector(0.0f, -1f, 0.0f),
        new JVector(0.0f, 1f, 0.0f),
        new JVector(0.0f, 0.0f, -1f),
        new JVector(0.0f, 0.0f, 1f)
      };
      int[,] numArray = new int[8, 3]
      {
        {
          5,
          1,
          3
        },
        {
          4,
          3,
          1
        },
        {
          3,
          4,
          0
        },
        {
          0,
          5,
          3
        },
        {
          5,
          2,
          1
        },
        {
          4,
          1,
          2
        },
        {
          2,
          0,
          4
        },
        {
          0,
          2,
          5
        }
      };
      for (int index = 0; index < 8; ++index)
        clipTriangleStack.Push(new Shape.ClipTriangle()
        {
          n1 = jvectorArray[numArray[index, 0]],
          n2 = jvectorArray[numArray[index, 1]],
          n3 = jvectorArray[numArray[index, 2]],
          generation = 0
        });
      while (clipTriangleStack.Count > 0)
      {
        Shape.ClipTriangle clipTriangle1 = clipTriangleStack.Pop();
        JVector result1;
        this.SupportMapping(ref clipTriangle1.n1, out result1);
        JVector result2;
        this.SupportMapping(ref clipTriangle1.n2, out result2);
        JVector result3;
        this.SupportMapping(ref clipTriangle1.n3, out result3);
        JVector jvector1 = result2 - result1;
        double num2 = (double) jvector1.LengthSquared();
        jvector1 = result3 - result2;
        float num3 = jvector1.LengthSquared();
        jvector1 = result1 - result3;
        float val2 = jvector1.LengthSquared();
        double num4 = (double) num3;
        if ((double) Math.Max(Math.Max((float) num2, (float) num4), val2) > (double) num1 && clipTriangle1.generation < generationThreshold)
        {
          Shape.ClipTriangle clipTriangle2 = new Shape.ClipTriangle();
          Shape.ClipTriangle clipTriangle3 = new Shape.ClipTriangle();
          Shape.ClipTriangle clipTriangle4 = new Shape.ClipTriangle();
          Shape.ClipTriangle clipTriangle5 = new Shape.ClipTriangle();
          clipTriangle2.generation = clipTriangle1.generation + 1;
          clipTriangle3.generation = clipTriangle1.generation + 1;
          clipTriangle4.generation = clipTriangle1.generation + 1;
          clipTriangle5.generation = clipTriangle1.generation + 1;
          clipTriangle2.n1 = clipTriangle1.n1;
          clipTriangle3.n2 = clipTriangle1.n2;
          clipTriangle4.n3 = clipTriangle1.n3;
          JVector jvector2 = 0.5f * (clipTriangle1.n1 + clipTriangle1.n2);
          jvector2.Normalize();
          clipTriangle2.n2 = jvector2;
          clipTriangle3.n1 = jvector2;
          clipTriangle5.n3 = jvector2;
          JVector jvector3 = 0.5f * (clipTriangle1.n2 + clipTriangle1.n3);
          jvector3.Normalize();
          clipTriangle3.n3 = jvector3;
          clipTriangle4.n2 = jvector3;
          clipTriangle5.n1 = jvector3;
          JVector jvector4 = 0.5f * (clipTriangle1.n3 + clipTriangle1.n1);
          jvector4.Normalize();
          clipTriangle2.n3 = jvector4;
          clipTriangle4.n1 = jvector4;
          clipTriangle5.n2 = jvector4;
          clipTriangleStack.Push(clipTriangle2);
          clipTriangleStack.Push(clipTriangle3);
          clipTriangleStack.Push(clipTriangle4);
          clipTriangleStack.Push(clipTriangle5);
        }
        else
        {
          jvector1 = (result3 - result1) % (result2 - result1);
          if ((double) jvector1.LengthSquared() > 1.19209286539301E-12)
          {
            triangleList.Add(result1);
            triangleList.Add(result2);
            triangleList.Add(result3);
          }
        }
      }
    }

    public virtual void GetBoundingBox(ref JMatrix orientation, out JBBox box)
    {
      JVector result = JVector.Zero;
      result.Set(orientation.M11, orientation.M21, orientation.M31);
      this.SupportMapping(ref result, out result);
      box.Max.X = (float) ((double) orientation.M11 * (double) result.X + (double) orientation.M21 * (double) result.Y + (double) orientation.M31 * (double) result.Z);
      result.Set(orientation.M12, orientation.M22, orientation.M32);
      this.SupportMapping(ref result, out result);
      box.Max.Y = (float) ((double) orientation.M12 * (double) result.X + (double) orientation.M22 * (double) result.Y + (double) orientation.M32 * (double) result.Z);
      result.Set(orientation.M13, orientation.M23, orientation.M33);
      this.SupportMapping(ref result, out result);
      box.Max.Z = (float) ((double) orientation.M13 * (double) result.X + (double) orientation.M23 * (double) result.Y + (double) orientation.M33 * (double) result.Z);
      result.Set(-orientation.M11, -orientation.M21, -orientation.M31);
      this.SupportMapping(ref result, out result);
      box.Min.X = (float) ((double) orientation.M11 * (double) result.X + (double) orientation.M21 * (double) result.Y + (double) orientation.M31 * (double) result.Z);
      result.Set(-orientation.M12, -orientation.M22, -orientation.M32);
      this.SupportMapping(ref result, out result);
      box.Min.Y = (float) ((double) orientation.M12 * (double) result.X + (double) orientation.M22 * (double) result.Y + (double) orientation.M32 * (double) result.Z);
      result.Set(-orientation.M13, -orientation.M23, -orientation.M33);
      this.SupportMapping(ref result, out result);
      box.Min.Z = (float) ((double) orientation.M13 * (double) result.X + (double) orientation.M23 * (double) result.Y + (double) orientation.M33 * (double) result.Z);
    }

    public virtual void UpdateShape(bool skipMassInertia = false)
    {
      this.GetBoundingBox(ref JMatrix.InternalIdentity, out this.boundingBox);
      if (!skipMassInertia)
        this.CalculateMassInertia();
      this.RaiseShapeUpdated();
    }

    public static float CalculateMassInertia(
      Shape shape,
      out JVector centerOfMass,
      out JMatrix inertia)
    {
      float num1 = 0.0f;
      centerOfMass = JVector.Zero;
      inertia = JMatrix.Zero;
      if (shape is Multishape)
        throw new ArgumentException("Can't calculate inertia of multishapes.", nameof (shape));
      List<JVector> triangleList = new List<JVector>();
      shape.MakeHull(ref triangleList, 3);
      float num2 = 0.01666667f;
      float num3 = 0.008333334f;
      JMatrix jmatrix1 = new JMatrix(num2, num3, num3, num3, num2, num3, num3, num3, num2);
      for (int index = 0; index < triangleList.Count; index += 3)
      {
        JVector jvector1 = triangleList[index];
        JVector jvector2 = triangleList[index + 1];
        JVector jvector3 = triangleList[index + 2];
        JMatrix matrix = new JMatrix(jvector1.X, jvector2.X, jvector3.X, jvector1.Y, jvector2.Y, jvector3.Y, jvector1.Z, jvector2.Z, jvector3.Z);
        float scaleFactor = matrix.Determinant();
        JMatrix jmatrix2 = JMatrix.Multiply(matrix * jmatrix1 * JMatrix.Transpose(matrix), scaleFactor);
        JVector jvector4 = 0.25f * (triangleList[index] + triangleList[index + 1] + triangleList[index + 2]);
        float num4 = 0.1666667f * scaleFactor;
        inertia += jmatrix2;
        centerOfMass += num4 * jvector4;
        num1 += num4;
      }
      inertia = JMatrix.Multiply(JMatrix.Identity, inertia.Trace()) - inertia;
      centerOfMass *= 1f / num1;
      float x = centerOfMass.X;
      float y = centerOfMass.Y;
      float z = centerOfMass.Z;
      JMatrix matrix2 = new JMatrix((float) (-(double) num1 * ((double) y * (double) y + (double) z * (double) z)), num1 * x * y, num1 * x * z, num1 * y * x, (float) (-(double) num1 * ((double) z * (double) z + (double) x * (double) x)), num1 * y * z, num1 * z * x, num1 * z * y, (float) (-(double) num1 * ((double) x * (double) x + (double) y * (double) y)));
      JMatrix.Add(ref inertia, ref matrix2, out inertia);
      return num1;
    }

    public virtual void CalculateMassInertia() => this.mass = Shape.CalculateMassInertia(this, out this.geomCen, out this.inertia);

    private struct ClipTriangle
    {
      public JVector n1;
      public JVector n2;
      public JVector n3;
      public int generation;
    }
  }
}
