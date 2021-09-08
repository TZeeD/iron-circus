// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.TerrainShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Jitter.Collision.Shapes
{
  public class TerrainShape : Multishape
  {
    private JBBox boundings;
    private float[,] heights;
    private int heightsLength0;
    private int heightsLength1;
    private int minX;
    private int maxX;
    private int minZ;
    private int maxZ;
    private JVector normal = JVector.Up;
    private int numX;
    private int numZ;
    private readonly JVector[] points = new JVector[3];
    private float scaleX;
    private float scaleZ;

    public TerrainShape(float[,] heights, float scaleX, float scaleZ)
    {
      this.heightsLength0 = heights.GetLength(0);
      this.heightsLength1 = heights.GetLength(1);
      this.boundings = JBBox.SmallBox;
      for (int index1 = 0; index1 < this.heightsLength0; ++index1)
      {
        for (int index2 = 0; index2 < this.heightsLength1; ++index2)
        {
          if ((double) heights[index1, index2] > (double) this.boundings.Max.Y)
            this.boundings.Max.Y = heights[index1, index2];
          else if ((double) heights[index1, index2] < (double) this.boundings.Min.Y)
            this.boundings.Min.Y = heights[index1, index2];
        }
      }
      this.boundings.Min.X = 0.0f;
      this.boundings.Min.Z = 0.0f;
      this.boundings.Max.X = (float) this.heightsLength0 * scaleX;
      this.boundings.Max.Z = (float) this.heightsLength1 * scaleZ;
      this.heights = heights;
      this.scaleX = scaleX;
      this.scaleZ = scaleZ;
      this.UpdateShape(false);
    }

    internal TerrainShape()
    {
    }

    public float SphericalExpansion { get; set; } = 0.05f;

    protected override Multishape CreateWorkingClone() => (Multishape) new TerrainShape()
    {
      heights = this.heights,
      scaleX = this.scaleX,
      scaleZ = this.scaleZ,
      boundings = this.boundings,
      heightsLength0 = this.heightsLength0,
      heightsLength1 = this.heightsLength1,
      SphericalExpansion = this.SphericalExpansion
    };

    public override void SetCurrentShape(int index)
    {
      bool flag = false;
      if (index >= this.numX * this.numZ)
      {
        flag = true;
        index -= this.numX * this.numZ;
      }
      int num1 = index % this.numX;
      int num2 = index / this.numX;
      if (flag)
      {
        this.points[0].Set((float) (this.minX + num1) * this.scaleX, this.heights[this.minX + num1, this.minZ + num2], (float) (this.minZ + num2) * this.scaleZ);
        this.points[1].Set((float) (this.minX + num1 + 1) * this.scaleX, this.heights[this.minX + num1 + 1, this.minZ + num2], (float) (this.minZ + num2) * this.scaleZ);
        this.points[2].Set((float) (this.minX + num1) * this.scaleX, this.heights[this.minX + num1, this.minZ + num2 + 1], (float) (this.minZ + num2 + 1) * this.scaleZ);
      }
      else
      {
        this.points[0].Set((float) (this.minX + num1 + 1) * this.scaleX, this.heights[this.minX + num1 + 1, this.minZ + num2], (float) (this.minZ + num2) * this.scaleZ);
        this.points[1].Set((float) (this.minX + num1 + 1) * this.scaleX, this.heights[this.minX + num1 + 1, this.minZ + num2 + 1], (float) (this.minZ + num2 + 1) * this.scaleZ);
        this.points[2].Set((float) (this.minX + num1) * this.scaleX, this.heights[this.minX + num1, this.minZ + num2 + 1], (float) (this.minZ + num2 + 1) * this.scaleZ);
      }
      JVector result = this.points[0];
      JVector.Add(ref result, ref this.points[1], out result);
      JVector.Add(ref result, ref this.points[2], out result);
      JVector.Multiply(ref result, 0.3333333f, out result);
      this.geomCen = result;
      JVector.Subtract(ref this.points[1], ref this.points[0], out result);
      JVector.Subtract(ref this.points[2], ref this.points[0], out this.normal);
      JVector.Cross(ref result, ref this.normal, out this.normal);
    }

    public void CollisionNormal(out JVector normal) => normal = this.normal;

    public override int Prepare(ref JBBox box)
    {
      if ((double) box.Min.X < (double) this.boundings.Min.X)
      {
        this.minX = 0;
      }
      else
      {
        this.minX = (int) Math.Floor(((double) box.Min.X - (double) this.SphericalExpansion) / (double) this.scaleX);
        this.minX = Math.Max(this.minX, 0);
      }
      if ((double) box.Max.X > (double) this.boundings.Max.X)
      {
        this.maxX = this.heightsLength0 - 1;
      }
      else
      {
        this.maxX = (int) Math.Ceiling(((double) box.Max.X + (double) this.SphericalExpansion) / (double) this.scaleX);
        this.maxX = Math.Min(this.maxX, this.heightsLength0 - 1);
      }
      if ((double) box.Min.Z < (double) this.boundings.Min.Z)
      {
        this.minZ = 0;
      }
      else
      {
        this.minZ = (int) Math.Floor(((double) box.Min.Z - (double) this.SphericalExpansion) / (double) this.scaleZ);
        this.minZ = Math.Max(this.minZ, 0);
      }
      if ((double) box.Max.Z > (double) this.boundings.Max.Z)
      {
        this.maxZ = this.heightsLength1 - 1;
      }
      else
      {
        this.maxZ = (int) Math.Ceiling(((double) box.Max.Z + (double) this.SphericalExpansion) / (double) this.scaleZ);
        this.maxZ = Math.Min(this.maxZ, this.heightsLength1 - 1);
      }
      this.numX = this.maxX - this.minX;
      this.numZ = this.maxZ - this.minZ;
      return this.numX * this.numZ * 2;
    }

    public override void CalculateMassInertia()
    {
      this.inertia = JMatrix.Identity;
      this.Mass = 1f;
    }

    public override void GetBoundingBox(ref JMatrix orientation, out JBBox box)
    {
      box = this.boundings;
      box.Min.X -= this.SphericalExpansion;
      box.Min.Y -= this.SphericalExpansion;
      box.Min.Z -= this.SphericalExpansion;
      box.Max.X += this.SphericalExpansion;
      box.Max.Y += this.SphericalExpansion;
      box.Max.Z += this.SphericalExpansion;
      box.Transform(ref orientation);
    }

    public override void MakeHull(ref List<JVector> triangleList, int generationThreshold)
    {
      for (int index1 = 0; index1 < (this.heightsLength0 - 1) * (this.heightsLength1 - 1); ++index1)
      {
        int index2 = index1 % (this.heightsLength0 - 1);
        int index3 = index1 / (this.heightsLength0 - 1);
        triangleList.Add(new JVector((float) index2 * this.scaleX, this.heights[index2, index3], (float) index3 * this.scaleZ));
        triangleList.Add(new JVector((float) (index2 + 1) * this.scaleX, this.heights[index2 + 1, index3], (float) index3 * this.scaleZ));
        triangleList.Add(new JVector((float) index2 * this.scaleX, this.heights[index2, index3 + 1], (float) (index3 + 1) * this.scaleZ));
        triangleList.Add(new JVector((float) (index2 + 1) * this.scaleX, this.heights[index2 + 1, index3], (float) index3 * this.scaleZ));
        triangleList.Add(new JVector((float) (index2 + 1) * this.scaleX, this.heights[index2 + 1, index3 + 1], (float) (index3 + 1) * this.scaleZ));
        triangleList.Add(new JVector((float) index2 * this.scaleX, this.heights[index2, index3 + 1], (float) (index3 + 1) * this.scaleZ));
      }
    }

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      JVector result1;
      JVector.Normalize(ref direction, out result1);
      JVector.Multiply(ref result1, this.SphericalExpansion, out result1);
      int index = 0;
      float num1 = JVector.Dot(ref this.points[0], ref direction);
      float num2 = JVector.Dot(ref this.points[1], ref direction);
      if ((double) num2 > (double) num1)
      {
        num1 = num2;
        index = 1;
      }
      if ((double) JVector.Dot(ref this.points[2], ref direction) > (double) num1)
        index = 2;
      JVector.Add(ref this.points[index], ref result1, out result);
    }

    public override int Prepare(ref JVector rayOrigin, ref JVector rayDelta)
    {
      JBBox smallBox = JBBox.SmallBox;
      JVector result;
      JVector.Normalize(ref rayDelta, out result);
      JVector point = rayOrigin + rayDelta + result * this.SphericalExpansion;
      smallBox.AddPoint(ref rayOrigin);
      smallBox.AddPoint(ref point);
      return this.Prepare(ref smallBox);
    }
  }
}
