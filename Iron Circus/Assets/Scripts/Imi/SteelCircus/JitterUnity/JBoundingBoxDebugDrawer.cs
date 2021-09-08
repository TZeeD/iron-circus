// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.JitterUnity.JBoundingBoxDebugDrawer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter;
using Jitter.LinearMath;
using UnityEngine;

namespace Imi.SteelCircus.JitterUnity
{
  public class JBoundingBoxDebugDrawer : IDebugDrawer
  {
    public Color color = Color.white;
    public float pointSize = 0.5f;
    public int res = 20;
    private readonly JQuaternion noRotation;
    private readonly JQuaternion rotateY90;
    private readonly JQuaternion rotateX180;
    private readonly JQuaternion rotateX90;
    private readonly JQuaternion rotateY90X180;
    private readonly JQuaternion rotateY90X90;
    private JVector[] circleXZ;
    private JVector[] arc180XY;

    public JBoundingBoxDebugDrawer()
    {
      this.RefreshCachedPoints();
      JQuaternion.CreateFromEuler(0.0f, 90f, 0.0f, out this.rotateY90);
      JQuaternion.CreateFromEuler(180f, 0.0f, 0.0f, out this.rotateX180);
      JQuaternion.CreateFromEuler(90f, 0.0f, 0.0f, out this.rotateX90);
      JQuaternion.CreateFromEuler(180f, 90f, 0.0f, out this.rotateY90X180);
      JQuaternion.CreateFromEuler(90f, 90f, 0.0f, out this.rotateY90X90);
    }

    public void RefreshCachedPoints()
    {
      this.CacheCircleXZ();
      this.CacheArc180XY();
    }

    private void CacheCircleXZ()
    {
      this.circleXZ = new JVector[this.res];
      for (int index = 0; index < this.res; ++index)
      {
        float f = (float) ((double) index / (double) this.res * 2.0 * 3.14159274101257);
        this.circleXZ[index] = new JVector(Mathf.Sin(f), 0.0f, Mathf.Cos(f));
      }
    }

    private void CacheArc180XY()
    {
      this.arc180XY = new JVector[this.res / 2 + 1];
      for (int index = 0; index <= this.res / 2; ++index)
      {
        float f = (float) ((double) index / (double) this.res * 2.0 * 3.14159274101257);
        this.arc180XY[index] = new JVector(Mathf.Cos(f), Mathf.Sin(f), 0.0f);
      }
    }

    public void DrawLine(JVector start, JVector end) => Debug.DrawLine(start.ToVector3(), end.ToVector3(), this.color);

    public void DrawPoint(JVector pos)
    {
      Vector3 vector3 = pos.ToVector3();
      Debug.DrawLine(vector3 + Vector3.up * this.pointSize, vector3 - Vector3.up * this.pointSize, this.color);
      Debug.DrawLine(vector3 + Vector3.right * this.pointSize, vector3 - Vector3.right * this.pointSize, this.color);
      Debug.DrawLine(vector3 + Vector3.forward * this.pointSize, vector3 - Vector3.forward * this.pointSize, this.color);
    }

    public void DrawTriangle(JVector pos1, JVector pos2, JVector pos3)
    {
      Vector3 vector3_1 = pos1.ToVector3();
      Vector3 vector3_2 = pos2.ToVector3();
      Vector3 vector3_3 = pos3.ToVector3();
      Debug.DrawLine(vector3_1, vector3_2, this.color);
      Debug.DrawLine(vector3_2, vector3_3, this.color);
      Debug.DrawLine(vector3_3, vector3_1, this.color);
    }

    public void DebugDrawBox(JVector size, JMatrix orientation, JVector position)
    {
      JVector jvector1 = JVector.Multiply(size, 0.5f);
      JVector jvector2 = this.TransformPoint(new JVector(jvector1.X, jvector1.Y, jvector1.Z), orientation, position);
      JVector jvector3 = this.TransformPoint(new JVector(-jvector1.X, jvector1.Y, jvector1.Z), orientation, position);
      JVector jvector4 = this.TransformPoint(new JVector(-jvector1.X, -jvector1.Y, jvector1.Z), orientation, position);
      JVector jvector5 = this.TransformPoint(new JVector(jvector1.X, -jvector1.Y, jvector1.Z), orientation, position);
      JVector jvector6 = this.TransformPoint(new JVector(jvector1.X, jvector1.Y, -jvector1.Z), orientation, position);
      JVector jvector7 = this.TransformPoint(new JVector(-jvector1.X, jvector1.Y, -jvector1.Z), orientation, position);
      JVector jvector8 = this.TransformPoint(new JVector(-jvector1.X, -jvector1.Y, -jvector1.Z), orientation, position);
      JVector jvector9 = this.TransformPoint(new JVector(jvector1.X, -jvector1.Y, -jvector1.Z), orientation, position);
      this.DrawLine(jvector2, jvector3);
      this.DrawLine(jvector3, jvector4);
      this.DrawLine(jvector4, jvector5);
      this.DrawLine(jvector5, jvector2);
      this.DrawLine(jvector6, jvector7);
      this.DrawLine(jvector7, jvector8);
      this.DrawLine(jvector8, jvector9);
      this.DrawLine(jvector9, jvector6);
      this.DrawLine(jvector2, jvector6);
      this.DrawLine(jvector3, jvector7);
      this.DrawLine(jvector4, jvector8);
      this.DrawLine(jvector5, jvector9);
    }

    public void DrawAABB(JBBox box)
    {
      JVector min = box.Min;
      JVector max = box.Max;
      JVector jvector1 = new JVector(max.X, max.Y, max.Z);
      JVector jvector2 = new JVector(min.X, max.Y, max.Z);
      JVector jvector3 = new JVector(min.X, min.Y, max.Z);
      JVector jvector4 = new JVector(max.X, min.Y, max.Z);
      JVector jvector5 = new JVector(max.X, max.Y, min.Z);
      JVector jvector6 = new JVector(min.X, max.Y, min.Z);
      JVector jvector7 = new JVector(min.X, min.Y, min.Z);
      JVector jvector8 = new JVector(max.X, min.Y, min.Z);
      this.DrawLine(jvector1, jvector2);
      this.DrawLine(jvector2, jvector3);
      this.DrawLine(jvector3, jvector4);
      this.DrawLine(jvector4, jvector1);
      this.DrawLine(jvector5, jvector6);
      this.DrawLine(jvector6, jvector7);
      this.DrawLine(jvector7, jvector8);
      this.DrawLine(jvector8, jvector5);
      this.DrawLine(jvector1, jvector5);
      this.DrawLine(jvector2, jvector6);
      this.DrawLine(jvector3, jvector7);
      this.DrawLine(jvector4, jvector8);
    }

    public void DrawCylinder(float height, float radius, JMatrix orientation, JVector position)
    {
      JVector jvector1 = JVector.Up * -height;
      JVector jvector2 = JVector.Up * height;
      this.DrawCircleXZ(radius, JVector.Up * height, orientation, position);
      this.DrawCircleXZ(radius, JVector.Up * -height, orientation, position);
      this.DrawLine(this.TransformPoint(jvector1 + JVector.Forward * radius, orientation, position), this.TransformPoint(jvector2 + JVector.Forward * radius, orientation, position));
      this.DrawLine(this.TransformPoint(jvector1 - JVector.Forward * radius, orientation, position), this.TransformPoint(jvector2 - JVector.Forward * radius, orientation, position));
      this.DrawLine(this.TransformPoint(jvector1 - JVector.Right * radius, orientation, position), this.TransformPoint(jvector2 - JVector.Right * radius, orientation, position));
      this.DrawLine(this.TransformPoint(jvector1 + JVector.Right * radius, orientation, position), this.TransformPoint(jvector2 + JVector.Right * radius, orientation, position));
    }

    public void DrawSphere(float radius, JMatrix orientation, JVector position)
    {
      this.DrawCircleXZ(radius, JVector.Zero, orientation, position);
      this.DrawCircleXZ(this.rotateX90, radius, JVector.Zero, orientation, position);
      this.DrawCircleXZ(this.rotateY90X90, radius, JVector.Zero, orientation, position);
    }

    public void DrawCapsule(float height, float radius, JMatrix orientation, JVector position)
    {
      this.DrawCylinder(height, radius, orientation, position);
      this.DrawArc180XY(this.noRotation, radius, JVector.Up * height, orientation, position);
      this.DrawArc180XY(this.rotateY90, radius, JVector.Up * height, orientation, position);
      this.DrawArc180XY(this.rotateX180, radius, JVector.Up * -height, orientation, position);
      this.DrawArc180XY(this.rotateY90X180, radius, JVector.Up * -height, orientation, position);
    }

    private void DrawCircleXZ(
      JQuaternion rotate,
      float radius,
      JVector offset,
      JMatrix orientation,
      JVector position)
    {
      int length = this.circleXZ.Length;
      JMatrix fromQuaternion = JMatrix.CreateFromQuaternion(rotate);
      for (int index = 0; index < length; ++index)
      {
        JVector result1 = this.circleXZ[index];
        JVector result2 = this.circleXZ[(index + 1) % length];
        JVector.Transform(ref result1, ref fromQuaternion, out result1);
        JVector.Transform(ref result2, ref fromQuaternion, out result2);
        this.DrawLine(this.TransformPoint(result1 * radius + offset, orientation, position), this.TransformPoint(result2 * radius + offset, orientation, position));
      }
    }

    private void DrawCircleXZ(float radius, JVector offset, JMatrix orientation, JVector position)
    {
      int length = this.circleXZ.Length;
      for (int index = 0; index < length; ++index)
      {
        JVector jvector1 = this.circleXZ[index];
        JVector jvector2 = this.circleXZ[(index + 1) % length];
        this.DrawLine(this.TransformPoint(jvector1 * radius + offset, orientation, position), this.TransformPoint(jvector2 * radius + offset, orientation, position));
      }
    }

    private void DrawArc180XY(
      JQuaternion rotate,
      float radius,
      JVector offset,
      JMatrix orientation,
      JVector position)
    {
      int length = this.arc180XY.Length;
      JMatrix fromQuaternion = JMatrix.CreateFromQuaternion(rotate);
      for (int index = 0; index < length - 1; ++index)
      {
        JVector result1 = this.arc180XY[index];
        JVector result2 = this.arc180XY[index + 1];
        JVector.Transform(ref result1, ref fromQuaternion, out result1);
        JVector.Transform(ref result2, ref fromQuaternion, out result2);
        this.DrawLine(this.TransformPoint(result1 * radius + offset, orientation, position), this.TransformPoint(result2 * radius + offset, orientation, position));
      }
    }

    private void DrawArcYZ(
      int res,
      float angle,
      float angleOffset,
      float radius,
      JVector offset,
      JMatrix orientation,
      JVector position)
    {
      float num1 = angle / 360f;
      float num2 = angleOffset / 180f;
      for (int index = 0; index < res; ++index)
      {
        float f1 = (float) (((double) index / (double) res + (double) num2) * 2.0 * 3.14159274101257) * num1;
        float f2 = (float) (((double) (index + 1 % res) / (double) res + (double) num2) * 2.0 * 3.14159274101257) * num1;
        this.DrawLine(this.TransformPoint(new JVector(0.0f, Mathf.Sin(f1) * radius, Mathf.Cos(f1) * radius) + offset, orientation, position), this.TransformPoint(new JVector(0.0f, Mathf.Sin(f2) * radius, Mathf.Cos(f2) * radius) + offset, orientation, position));
      }
    }

    private JVector TransformPoint(JVector pt, JMatrix orientation, JVector position)
    {
      JVector.Transform(ref pt, ref orientation, out pt);
      JVector.Add(ref pt, ref position, out pt);
      return pt;
    }
  }
}
