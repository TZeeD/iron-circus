// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.RoundShapeBase
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter.Collision.Shapes
{
  public abstract class RoundShapeBase : Shape, ISupports2DRaycast
  {
    protected float radius = 1f;

    public bool Raycast2D(
      ref JMatrix orientation,
      ref JMatrix invOrientation,
      ref JVector position,
      ref JVector origin,
      ref JVector direction,
      out float fraction,
      out JVector normal)
    {
      fraction = float.MaxValue;
      normal = JVector.Zero;
      JVector result1;
      JVector.TransposedTransform(ref direction, ref orientation, out result1);
      JVector position1 = origin - position;
      JVector result2;
      JVector.TransposedTransform(ref position1, ref orientation, out result2);
      result1.Y = 0.0f;
      result2.Y = 0.0f;
      float num1 = 1f / this.radius;
      JVector jvector1 = result2 * num1;
      JVector jvector2 = result1 * num1;
      float num2 = (float) ((double) jvector2.X * (double) jvector2.X + (double) jvector2.Z * (double) jvector2.Z);
      float num3 = (float) (2.0 * (double) jvector1.X * (double) jvector2.X + 2.0 * (double) jvector1.Z * (double) jvector2.Z);
      float num4 = (float) ((double) jvector1.X * (double) jvector1.X + (double) jvector1.Z * (double) jvector1.Z - 1.0);
      float number = (float) ((double) num3 * (double) num3 - 4.0 * (double) num2 * (double) num4);
      if ((double) number < 0.0 || (double) num2 <= 1.19209286539301E-12)
        return false;
      float val1 = (float) ((-(double) num3 + (double) JMath.Sqrt(number)) / (2.0 * (double) num2));
      float val2 = (float) ((-(double) num3 - (double) JMath.Sqrt(number)) / (2.0 * (double) num2));
      if ((double) val1 < 0.0 && (double) val2 < 0.0)
        return false;
      fraction = (double) val1 >= 0.0 ? ((double) val2 >= 0.0 ? JMath.Min(val1, val2) : val1) : val2;
      JVector position2 = fraction * jvector2 + jvector1;
      JVector.Transform(ref position2, ref orientation, out normal);
      normal.Normalize();
      return true;
    }
  }
}
