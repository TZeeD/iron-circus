// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.GJKCollide
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter.Collision
{
  public sealed class GJKCollide
  {
    private const int MaxIterations = 15;
    private static readonly ResourcePool<GJKCollide.VoronoiSimplexSolver> simplexSolverPool = new ResourcePool<GJKCollide.VoronoiSimplexSolver>();

    private static void SupportMapTransformed(
      ISupportMappable support,
      ref JMatrix orientation,
      ref JVector position,
      ref JVector direction,
      out JVector result)
    {
      result.X = (float) ((double) direction.X * (double) orientation.M11 + (double) direction.Y * (double) orientation.M12 + (double) direction.Z * (double) orientation.M13);
      result.Y = (float) ((double) direction.X * (double) orientation.M21 + (double) direction.Y * (double) orientation.M22 + (double) direction.Z * (double) orientation.M23);
      result.Z = (float) ((double) direction.X * (double) orientation.M31 + (double) direction.Y * (double) orientation.M32 + (double) direction.Z * (double) orientation.M33);
      support.SupportMapping(ref result, out result);
      float num1 = (float) ((double) result.X * (double) orientation.M11 + (double) result.Y * (double) orientation.M21 + (double) result.Z * (double) orientation.M31);
      float num2 = (float) ((double) result.X * (double) orientation.M12 + (double) result.Y * (double) orientation.M22 + (double) result.Z * (double) orientation.M32);
      float num3 = (float) ((double) result.X * (double) orientation.M13 + (double) result.Y * (double) orientation.M23 + (double) result.Z * (double) orientation.M33);
      result.X = position.X + num1;
      result.Y = position.Y + num2;
      result.Z = position.Z + num3;
    }

    public static bool Pointcast(
      ISupportMappable support,
      ref JMatrix orientation,
      ref JVector position,
      ref JVector point)
    {
      JVector result1;
      GJKCollide.SupportMapTransformed(support, ref orientation, ref position, ref point, out result1);
      JVector.Subtract(ref point, ref result1, out result1);
      JVector jvector1;
      support.SupportCenter(out jvector1);
      JVector.Transform(ref jvector1, ref orientation, out jvector1);
      JVector.Add(ref position, ref jvector1, out jvector1);
      JVector.Subtract(ref point, ref jvector1, out jvector1);
      JVector p = point;
      JVector jvector2;
      JVector.Subtract(ref p, ref result1, out jvector2);
      float num1 = jvector2.LengthSquared();
      float num2 = 0.0001f;
      int num3 = 15;
      GJKCollide.VoronoiSimplexSolver voronoiSimplexSolver = GJKCollide.simplexSolverPool.GetNew();
      voronoiSimplexSolver.Reset();
      for (; (double) num1 > (double) num2 && num3-- != 0; num1 = !voronoiSimplexSolver.Closest(out jvector2) ? 0.0f : jvector2.LengthSquared())
      {
        JVector result2;
        GJKCollide.SupportMapTransformed(support, ref orientation, ref position, ref jvector2, out result2);
        JVector result3;
        JVector.Subtract(ref p, ref result2, out result3);
        if ((double) JVector.Dot(ref jvector2, ref result3) > 0.0)
        {
          if ((double) JVector.Dot(ref jvector2, ref jvector1) >= -1.42108539188611E-24)
          {
            GJKCollide.simplexSolverPool.GiveBack(voronoiSimplexSolver);
            return false;
          }
          voronoiSimplexSolver.Reset();
        }
        if (!voronoiSimplexSolver.InSimplex(result3))
          voronoiSimplexSolver.AddVertex(result3, p, result2);
      }
      GJKCollide.simplexSolverPool.GiveBack(voronoiSimplexSolver);
      return true;
    }

    public static bool ClosestPoints(
      ISupportMappable support1,
      ISupportMappable support2,
      ref JMatrix orientation1,
      ref JMatrix orientation2,
      ref JVector position1,
      ref JVector position2,
      out JVector p1,
      out JVector p2,
      out JVector normal)
    {
      GJKCollide.VoronoiSimplexSolver voronoiSimplexSolver = GJKCollide.simplexSolverPool.GetNew();
      voronoiSimplexSolver.Reset();
      p1 = p2 = JVector.Zero;
      JVector direction1 = position1 - position2;
      JVector direction2 = JVector.Negate(direction1);
      JVector result1;
      GJKCollide.SupportMapTransformed(support1, ref orientation1, ref position1, ref direction2, out result1);
      JVector result2;
      GJKCollide.SupportMapTransformed(support2, ref orientation2, ref position2, ref direction1, out result2);
      JVector v = result1 - result2;
      normal = JVector.Zero;
      int num1 = 15;
      float num2 = v.LengthSquared();
      float num3 = 1E-05f;
      while ((double) num2 > (double) num3 && num1-- != 0)
      {
        JVector direction3 = JVector.Negate(v);
        GJKCollide.SupportMapTransformed(support1, ref orientation1, ref position1, ref direction3, out result1);
        GJKCollide.SupportMapTransformed(support2, ref orientation2, ref position2, ref v, out result2);
        JVector w = result1 - result2;
        if (!voronoiSimplexSolver.InSimplex(w))
          voronoiSimplexSolver.AddVertex(w, result1, result2);
        if (voronoiSimplexSolver.Closest(out v))
        {
          num2 = v.LengthSquared();
          normal = v;
        }
        else
          num2 = 0.0f;
      }
      voronoiSimplexSolver.ComputePoints(out p1, out p2);
      if ((double) normal.LengthSquared() > 1.42108539188611E-24)
        normal.Normalize();
      GJKCollide.simplexSolverPool.GiveBack(voronoiSimplexSolver);
      return true;
    }

    public static bool Raycast(
      ISupportMappable support,
      ref JMatrix orientation,
      ref JMatrix invOrientation,
      ref JVector position,
      ref JVector origin,
      ref JVector direction,
      out float fraction,
      out JVector normal)
    {
      GJKCollide.VoronoiSimplexSolver voronoiSimplexSolver = GJKCollide.simplexSolverPool.GetNew();
      voronoiSimplexSolver.Reset();
      normal = JVector.Zero;
      fraction = float.MaxValue;
      float scaleFactor = 0.0f;
      JVector jvector1 = direction;
      JVector result1 = origin;
      JVector result2;
      GJKCollide.SupportMapTransformed(support, ref orientation, ref position, ref jvector1, out result2);
      JVector jvector2;
      JVector.Subtract(ref result1, ref result2, out jvector2);
      int num1 = 15;
      float num2 = jvector2.LengthSquared();
      for (float num3 = 1E-08f; (double) num2 > (double) num3 && num1-- != 0; num2 = !voronoiSimplexSolver.Closest(out jvector2) ? 0.0f : jvector2.LengthSquared())
      {
        JVector result3;
        GJKCollide.SupportMapTransformed(support, ref orientation, ref position, ref jvector2, out result3);
        JVector result4;
        JVector.Subtract(ref result1, ref result3, out result4);
        float num4 = JVector.Dot(ref jvector2, ref result4);
        if ((double) num4 > 0.0)
        {
          float num5 = JVector.Dot(ref jvector2, ref jvector1);
          if ((double) num5 >= -1.19209286539301E-12)
          {
            GJKCollide.simplexSolverPool.GiveBack(voronoiSimplexSolver);
            return false;
          }
          scaleFactor -= num4 / num5;
          JVector.Multiply(ref jvector1, scaleFactor, out result1);
          JVector.Add(ref origin, ref result1, out result1);
          JVector.Subtract(ref result1, ref result3, out result4);
          normal = jvector2;
        }
        if (!voronoiSimplexSolver.InSimplex(result4))
          voronoiSimplexSolver.AddVertex(result4, result1, result3);
      }
      JVector p2;
      voronoiSimplexSolver.ComputePoints(out JVector _, out p2);
      p2 -= origin;
      fraction = p2.Length() / direction.Length();
      if ((double) normal.LengthSquared() > 1.42108539188611E-24)
        normal.Normalize();
      GJKCollide.simplexSolverPool.GiveBack(voronoiSimplexSolver);
      return true;
    }

    private class UsageBitfield
    {
      public bool UsedVertexA { get; set; }

      public bool UsedVertexB { get; set; }

      public bool UsedVertexC { get; set; }

      public bool UsedVertexD { get; set; }

      public void Reset() => this.UsedVertexA = this.UsedVertexB = this.UsedVertexC = this.UsedVertexD = false;
    }

    private class SubSimplexClosestResult
    {
      public JVector ClosestPointOnSimplex { get; set; }

      public GJKCollide.UsageBitfield UsedVertices { get; } = new GJKCollide.UsageBitfield();

      public float[] BarycentricCoords { get; } = new float[4];

      public bool Degenerate { get; set; }

      public bool IsValid => (double) this.BarycentricCoords[0] >= 0.0 && (double) this.BarycentricCoords[1] >= 0.0 && (double) this.BarycentricCoords[2] >= 0.0 && (double) this.BarycentricCoords[3] >= 0.0;

      public void Reset()
      {
        this.Degenerate = false;
        this.SetBarycentricCoordinates();
        this.UsedVertices.Reset();
      }

      public void SetBarycentricCoordinates() => this.SetBarycentricCoordinates(0.0f, 0.0f, 0.0f, 0.0f);

      public void SetBarycentricCoordinates(float a, float b, float c, float d)
      {
        this.BarycentricCoords[0] = a;
        this.BarycentricCoords[1] = b;
        this.BarycentricCoords[2] = c;
        this.BarycentricCoords[3] = d;
      }
    }

    private class VoronoiSimplexSolver
    {
      private const int VertexA = 0;
      private const int VertexB = 1;
      private const int VertexC = 2;
      private const int VertexD = 3;
      private const int VoronoiSimplexMaxVerts = 5;
      private const bool CatchDegenerateTetrahedron = true;
      private GJKCollide.SubSimplexClosestResult _cachedBC = new GJKCollide.SubSimplexClosestResult();
      private JVector _cachedPA;
      private JVector _cachedPB;
      private JVector _cachedV;
      private bool _cachedValidClosest;
      private JVector _lastW;
      private bool _needsUpdate;
      private readonly JVector[] _simplexPointsP = new JVector[5];
      private readonly JVector[] _simplexPointsQ = new JVector[5];
      private readonly JVector[] _simplexVectorW = new JVector[5];
      private GJKCollide.SubSimplexClosestResult tempResult = new GJKCollide.SubSimplexClosestResult();

      public void RemoveVertex(int index)
      {
        --this.NumVertices;
        this._simplexVectorW[index] = this._simplexVectorW[this.NumVertices];
        this._simplexPointsP[index] = this._simplexPointsP[this.NumVertices];
        this._simplexPointsQ[index] = this._simplexPointsQ[this.NumVertices];
      }

      public void ReduceVertices(GJKCollide.UsageBitfield usedVerts)
      {
        if (this.NumVertices >= 4 && !usedVerts.UsedVertexD)
          this.RemoveVertex(3);
        if (this.NumVertices >= 3 && !usedVerts.UsedVertexC)
          this.RemoveVertex(2);
        if (this.NumVertices >= 2 && !usedVerts.UsedVertexB)
          this.RemoveVertex(1);
        if (this.NumVertices < 1 || usedVerts.UsedVertexA)
          return;
        this.RemoveVertex(0);
      }

      public bool UpdateClosestVectorAndPoints()
      {
        if (this._needsUpdate)
        {
          this._cachedBC.Reset();
          this._needsUpdate = false;
          switch (this.NumVertices)
          {
            case 0:
              this._cachedValidClosest = false;
              break;
            case 1:
              this._cachedPA = this._simplexPointsP[0];
              this._cachedPB = this._simplexPointsQ[0];
              this._cachedV = this._cachedPA - this._cachedPB;
              this._cachedBC.Reset();
              this._cachedBC.SetBarycentricCoordinates(1f, 0.0f, 0.0f, 0.0f);
              this._cachedValidClosest = this._cachedBC.IsValid;
              break;
            case 2:
              JVector jvector1 = this._simplexVectorW[0];
              JVector jvector2 = this._simplexVectorW[1];
              JVector vector2 = jvector1 * -1f;
              JVector jvector3 = jvector1;
              JVector vector1 = jvector2 - jvector3;
              float num1 = JVector.Dot(vector1, vector2);
              float b;
              if ((double) num1 > 0.0)
              {
                float num2 = vector1.LengthSquared();
                JVector jvector4;
                if ((double) num1 < (double) num2)
                {
                  b = num1 / num2;
                  jvector4 = vector2 - b * vector1;
                  this._cachedBC.UsedVertices.UsedVertexA = true;
                  this._cachedBC.UsedVertices.UsedVertexB = true;
                }
                else
                {
                  b = 1f;
                  jvector4 = vector2 - vector1;
                  this._cachedBC.UsedVertices.UsedVertexB = true;
                }
              }
              else
              {
                b = 0.0f;
                this._cachedBC.UsedVertices.UsedVertexA = true;
              }
              this._cachedBC.SetBarycentricCoordinates(1f - b, b, 0.0f, 0.0f);
              this._cachedPA = this._simplexPointsP[0] + b * (this._simplexPointsP[1] - this._simplexPointsP[0]);
              this._cachedPB = this._simplexPointsQ[0] + b * (this._simplexPointsQ[1] - this._simplexPointsQ[0]);
              this._cachedV = this._cachedPA - this._cachedPB;
              this.ReduceVertices(this._cachedBC.UsedVertices);
              this._cachedValidClosest = this._cachedBC.IsValid;
              break;
            case 3:
              this.ClosestPtPointTriangle(new JVector(), this._simplexVectorW[0], this._simplexVectorW[1], this._simplexVectorW[2], ref this._cachedBC);
              this._cachedPA = this._simplexPointsP[0] * this._cachedBC.BarycentricCoords[0] + this._simplexPointsP[1] * this._cachedBC.BarycentricCoords[1] + this._simplexPointsP[2] * this._cachedBC.BarycentricCoords[2] + this._simplexPointsP[3] * this._cachedBC.BarycentricCoords[3];
              this._cachedPB = this._simplexPointsQ[0] * this._cachedBC.BarycentricCoords[0] + this._simplexPointsQ[1] * this._cachedBC.BarycentricCoords[1] + this._simplexPointsQ[2] * this._cachedBC.BarycentricCoords[2] + this._simplexPointsQ[3] * this._cachedBC.BarycentricCoords[3];
              this._cachedV = this._cachedPA - this._cachedPB;
              this.ReduceVertices(this._cachedBC.UsedVertices);
              this._cachedValidClosest = this._cachedBC.IsValid;
              break;
            case 4:
              if (this.ClosestPtPointTetrahedron(new JVector(), this._simplexVectorW[0], this._simplexVectorW[1], this._simplexVectorW[2], this._simplexVectorW[3], ref this._cachedBC))
              {
                this._cachedPA = this._simplexPointsP[0] * this._cachedBC.BarycentricCoords[0] + this._simplexPointsP[1] * this._cachedBC.BarycentricCoords[1] + this._simplexPointsP[2] * this._cachedBC.BarycentricCoords[2] + this._simplexPointsP[3] * this._cachedBC.BarycentricCoords[3];
                this._cachedPB = this._simplexPointsQ[0] * this._cachedBC.BarycentricCoords[0] + this._simplexPointsQ[1] * this._cachedBC.BarycentricCoords[1] + this._simplexPointsQ[2] * this._cachedBC.BarycentricCoords[2] + this._simplexPointsQ[3] * this._cachedBC.BarycentricCoords[3];
                this._cachedV = this._cachedPA - this._cachedPB;
                this.ReduceVertices(this._cachedBC.UsedVertices);
                this._cachedValidClosest = this._cachedBC.IsValid;
                break;
              }
              if (this._cachedBC.Degenerate)
              {
                this._cachedValidClosest = false;
                break;
              }
              this._cachedValidClosest = true;
              this._cachedV.X = this._cachedV.Y = this._cachedV.Z = 0.0f;
              break;
            default:
              this._cachedValidClosest = false;
              break;
          }
        }
        return this._cachedValidClosest;
      }

      public bool ClosestPtPointTriangle(
        JVector p,
        JVector a,
        JVector b,
        JVector c,
        ref GJKCollide.SubSimplexClosestResult result)
      {
        result.UsedVertices.Reset();
        JVector vector1_1 = b - a;
        JVector vector1_2 = c - a;
        JVector vector2_1 = p - a;
        float num1 = JVector.Dot(vector1_1, vector2_1);
        float num2 = JVector.Dot(vector1_2, vector2_1);
        if ((double) num1 <= 0.0 && (double) num2 <= 0.0)
        {
          result.ClosestPointOnSimplex = a;
          result.UsedVertices.UsedVertexA = true;
          result.SetBarycentricCoordinates(1f, 0.0f, 0.0f, 0.0f);
          return true;
        }
        JVector vector2_2 = p - b;
        float num3 = JVector.Dot(vector1_1, vector2_2);
        float num4 = JVector.Dot(vector1_2, vector2_2);
        if ((double) num3 >= 0.0 && (double) num4 <= (double) num3)
        {
          result.ClosestPointOnSimplex = b;
          result.UsedVertices.UsedVertexB = true;
          result.SetBarycentricCoordinates(0.0f, 1f, 0.0f, 0.0f);
          return true;
        }
        float num5 = (float) ((double) num1 * (double) num4 - (double) num3 * (double) num2);
        if ((double) num5 <= 0.0 && (double) num1 >= 0.0 && (double) num3 <= 0.0)
        {
          float b1 = num1 / (num1 - num3);
          result.ClosestPointOnSimplex = a + b1 * vector1_1;
          result.UsedVertices.UsedVertexA = true;
          result.UsedVertices.UsedVertexB = true;
          result.SetBarycentricCoordinates(1f - b1, b1, 0.0f, 0.0f);
          return true;
        }
        JVector vector2_3 = p - c;
        float num6 = JVector.Dot(vector1_1, vector2_3);
        float num7 = JVector.Dot(vector1_2, vector2_3);
        if ((double) num7 >= 0.0 && (double) num6 <= (double) num7)
        {
          result.ClosestPointOnSimplex = c;
          result.UsedVertices.UsedVertexC = true;
          result.SetBarycentricCoordinates(0.0f, 0.0f, 1f, 0.0f);
          return true;
        }
        float num8 = (float) ((double) num6 * (double) num2 - (double) num1 * (double) num7);
        if ((double) num8 <= 0.0 && (double) num2 >= 0.0 && (double) num7 <= 0.0)
        {
          float c1 = num2 / (num2 - num7);
          result.ClosestPointOnSimplex = a + c1 * vector1_2;
          result.UsedVertices.UsedVertexA = true;
          result.UsedVertices.UsedVertexC = true;
          result.SetBarycentricCoordinates(1f - c1, 0.0f, c1, 0.0f);
          return true;
        }
        float num9 = (float) ((double) num3 * (double) num7 - (double) num6 * (double) num4);
        if ((double) num9 <= 0.0 && (double) num4 - (double) num3 >= 0.0 && (double) num6 - (double) num7 >= 0.0)
        {
          float c2 = (float) (((double) num4 - (double) num3) / ((double) num4 - (double) num3 + ((double) num6 - (double) num7)));
          result.ClosestPointOnSimplex = b + c2 * (c - b);
          result.UsedVertices.UsedVertexB = true;
          result.UsedVertices.UsedVertexC = true;
          result.SetBarycentricCoordinates(0.0f, 1f - c2, c2, 0.0f);
          return true;
        }
        float num10 = (float) (1.0 / ((double) num9 + (double) num8 + (double) num5));
        float b2 = num8 * num10;
        float c3 = num5 * num10;
        result.ClosestPointOnSimplex = a + vector1_1 * b2 + vector1_2 * c3;
        result.UsedVertices.UsedVertexA = true;
        result.UsedVertices.UsedVertexB = true;
        result.UsedVertices.UsedVertexC = true;
        result.SetBarycentricCoordinates(1f - b2 - c3, b2, c3, 0.0f);
        return true;
      }

      public int PointOutsideOfPlane(JVector p, JVector a, JVector b, JVector c, JVector d)
      {
        JVector vector2 = JVector.Cross(b - a, c - a);
        float num1 = JVector.Dot(p - a, vector2);
        float num2 = JVector.Dot(d - a, vector2);
        if ((double) num2 * (double) num2 < 9.99999905104687E-09)
          return -1;
        return (double) num1 * (double) num2 >= 0.0 ? 0 : 1;
      }

      public bool ClosestPtPointTetrahedron(
        JVector p,
        JVector a,
        JVector b,
        JVector c,
        JVector d,
        ref GJKCollide.SubSimplexClosestResult finalResult)
      {
        this.tempResult.Reset();
        finalResult.ClosestPointOnSimplex = p;
        finalResult.UsedVertices.Reset();
        finalResult.UsedVertices.UsedVertexA = true;
        finalResult.UsedVertices.UsedVertexB = true;
        finalResult.UsedVertices.UsedVertexC = true;
        finalResult.UsedVertices.UsedVertexD = true;
        int num1 = this.PointOutsideOfPlane(p, a, b, c, d);
        int num2 = this.PointOutsideOfPlane(p, a, c, d, b);
        int num3 = this.PointOutsideOfPlane(p, a, d, b, c);
        int num4 = this.PointOutsideOfPlane(p, b, d, c, a);
        if (num1 < 0 || num2 < 0 || num3 < 0 || num4 < 0)
        {
          finalResult.Degenerate = true;
          return false;
        }
        if (num1 == 0 && num2 == 0 && num3 == 0 && num4 == 0)
          return false;
        float num5 = float.MaxValue;
        if (num1 != 0)
        {
          this.ClosestPtPointTriangle(p, a, b, c, ref this.tempResult);
          JVector closestPointOnSimplex = this.tempResult.ClosestPointOnSimplex;
          float num6 = (closestPointOnSimplex - p).LengthSquared();
          if ((double) num6 < (double) num5)
          {
            num5 = num6;
            finalResult.ClosestPointOnSimplex = closestPointOnSimplex;
            finalResult.UsedVertices.Reset();
            finalResult.UsedVertices.UsedVertexA = this.tempResult.UsedVertices.UsedVertexA;
            finalResult.UsedVertices.UsedVertexB = this.tempResult.UsedVertices.UsedVertexB;
            finalResult.UsedVertices.UsedVertexC = this.tempResult.UsedVertices.UsedVertexC;
            finalResult.SetBarycentricCoordinates(this.tempResult.BarycentricCoords[0], this.tempResult.BarycentricCoords[1], this.tempResult.BarycentricCoords[2], 0.0f);
          }
        }
        if (num2 != 0)
        {
          this.ClosestPtPointTriangle(p, a, c, d, ref this.tempResult);
          JVector closestPointOnSimplex = this.tempResult.ClosestPointOnSimplex;
          float num7 = (closestPointOnSimplex - p).LengthSquared();
          if ((double) num7 < (double) num5)
          {
            num5 = num7;
            finalResult.ClosestPointOnSimplex = closestPointOnSimplex;
            finalResult.UsedVertices.Reset();
            finalResult.UsedVertices.UsedVertexA = this.tempResult.UsedVertices.UsedVertexA;
            finalResult.UsedVertices.UsedVertexC = this.tempResult.UsedVertices.UsedVertexB;
            finalResult.UsedVertices.UsedVertexD = this.tempResult.UsedVertices.UsedVertexC;
            finalResult.SetBarycentricCoordinates(this.tempResult.BarycentricCoords[0], 0.0f, this.tempResult.BarycentricCoords[1], this.tempResult.BarycentricCoords[2]);
          }
        }
        if (num3 != 0)
        {
          this.ClosestPtPointTriangle(p, a, d, b, ref this.tempResult);
          JVector closestPointOnSimplex = this.tempResult.ClosestPointOnSimplex;
          float num8 = (closestPointOnSimplex - p).LengthSquared();
          if ((double) num8 < (double) num5)
          {
            num5 = num8;
            finalResult.ClosestPointOnSimplex = closestPointOnSimplex;
            finalResult.UsedVertices.Reset();
            finalResult.UsedVertices.UsedVertexA = this.tempResult.UsedVertices.UsedVertexA;
            finalResult.UsedVertices.UsedVertexD = this.tempResult.UsedVertices.UsedVertexB;
            finalResult.UsedVertices.UsedVertexB = this.tempResult.UsedVertices.UsedVertexC;
            finalResult.SetBarycentricCoordinates(this.tempResult.BarycentricCoords[0], this.tempResult.BarycentricCoords[2], 0.0f, this.tempResult.BarycentricCoords[1]);
          }
        }
        if (num4 != 0)
        {
          this.ClosestPtPointTriangle(p, b, d, c, ref this.tempResult);
          JVector closestPointOnSimplex = this.tempResult.ClosestPointOnSimplex;
          if ((double) (closestPointOnSimplex - p).LengthSquared() < (double) num5)
          {
            finalResult.ClosestPointOnSimplex = closestPointOnSimplex;
            finalResult.UsedVertices.Reset();
            finalResult.UsedVertices.UsedVertexB = this.tempResult.UsedVertices.UsedVertexA;
            finalResult.UsedVertices.UsedVertexD = this.tempResult.UsedVertices.UsedVertexB;
            finalResult.UsedVertices.UsedVertexC = this.tempResult.UsedVertices.UsedVertexC;
            finalResult.SetBarycentricCoordinates(0.0f, this.tempResult.BarycentricCoords[0], this.tempResult.BarycentricCoords[2], this.tempResult.BarycentricCoords[1]);
          }
        }
        if (!finalResult.UsedVertices.UsedVertexA || !finalResult.UsedVertices.UsedVertexB || !finalResult.UsedVertices.UsedVertexC)
          return true;
        int num9 = finalResult.UsedVertices.UsedVertexD ? 1 : 0;
        return true;
      }

      public bool FullSimplex => this.NumVertices == 4;

      public int NumVertices { get; private set; }

      public void Reset()
      {
        this._cachedValidClosest = false;
        this.NumVertices = 0;
        this._needsUpdate = true;
        this._lastW = new JVector(1E+30f, 1E+30f, 1E+30f);
        this._cachedBC.Reset();
      }

      public void AddVertex(JVector w, JVector p, JVector q)
      {
        this._lastW = w;
        this._needsUpdate = true;
        this._simplexVectorW[this.NumVertices] = w;
        this._simplexPointsP[this.NumVertices] = p;
        this._simplexPointsQ[this.NumVertices] = q;
        ++this.NumVertices;
      }

      public bool Closest(out JVector v)
      {
        int num = this.UpdateClosestVectorAndPoints() ? 1 : 0;
        v = this._cachedV;
        return num != 0;
      }

      public float MaxVertex
      {
        get
        {
          int numVertices = this.NumVertices;
          float num1 = 0.0f;
          for (int index = 0; index < numVertices; ++index)
          {
            float num2 = this._simplexVectorW[index].LengthSquared();
            if ((double) num1 < (double) num2)
              num1 = num2;
          }
          return num1;
        }
      }

      public int GetSimplex(out JVector[] pBuf, out JVector[] qBuf, out JVector[] yBuf)
      {
        int numVertices = this.NumVertices;
        pBuf = new JVector[numVertices];
        qBuf = new JVector[numVertices];
        yBuf = new JVector[numVertices];
        for (int index = 0; index < numVertices; ++index)
        {
          yBuf[index] = this._simplexVectorW[index];
          pBuf[index] = this._simplexPointsP[index];
          qBuf[index] = this._simplexPointsQ[index];
        }
        return numVertices;
      }

      public bool InSimplex(JVector w)
      {
        if (w == this._lastW)
          return true;
        int numVertices = this.NumVertices;
        for (int index = 0; index < numVertices; ++index)
        {
          if (this._simplexVectorW[index] == w)
            return true;
        }
        return false;
      }

      public void BackupClosest(out JVector v) => v = this._cachedV;

      public bool EmptySimplex => this.NumVertices == 0;

      public void ComputePoints(out JVector p1, out JVector p2)
      {
        this.UpdateClosestVectorAndPoints();
        p1 = this._cachedPA;
        p2 = this._cachedPB;
      }
    }
  }
}
