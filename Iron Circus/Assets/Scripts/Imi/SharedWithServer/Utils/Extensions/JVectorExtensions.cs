// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.Extensions.JVectorExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.Utils.Extensions
{
  public static class JVectorExtensions
  {
    public static JVector Multiply(JQuaternion q, JVector v)
    {
      float num1 = q.X * 2f;
      float num2 = q.Y * 2f;
      float num3 = q.Z * 2f;
      float num4 = q.X * num1;
      float num5 = q.Y * num2;
      float num6 = q.Z * num3;
      float num7 = q.X * num2;
      float num8 = q.X * num3;
      float num9 = q.Y * num3;
      float num10 = q.W * num1;
      float num11 = q.W * num2;
      float num12 = q.W * num3;
      JVector jvector;
      jvector.X = (float) ((1.0 - ((double) num5 + (double) num6)) * (double) v.X + ((double) num7 - (double) num12) * (double) v.Y + ((double) num8 + (double) num11) * (double) v.Z);
      jvector.Y = (float) (((double) num7 + (double) num12) * (double) v.X + (1.0 - ((double) num4 + (double) num6)) * (double) v.Y + ((double) num9 - (double) num10) * (double) v.Z);
      jvector.Z = (float) (((double) num8 - (double) num11) * (double) v.X + ((double) num9 + (double) num10) * (double) v.Y + (1.0 - ((double) num4 + (double) num5)) * (double) v.Z);
      return jvector;
    }

    public static JVector GetForwardVector(JQuaternion q) => JVectorExtensions.Multiply(q, JVector.Forward);

    public static JVector GetBackwardVector(JQuaternion q) => JVectorExtensions.Multiply(q, JVector.Backward);

    public static JVector GetLeftVector(JQuaternion q) => JVectorExtensions.Multiply(q, JVector.Left);

    public static JVector GetRightVector(JQuaternion q) => JVectorExtensions.Multiply(q, JVector.Right);

    public static JVector GetUpVector(JQuaternion q) => JVectorExtensions.Multiply(q, JVector.Up);

    public static JVector GetDownVector(JQuaternion q) => JVectorExtensions.Multiply(q, JVector.Down);

    public static JVector GetAverageVector3(params JVector[] vectors)
    {
      JVector zero = JVector.Zero;
      if (vectors.Length == 0)
        return zero;
      for (int index = 0; index < vectors.Length; ++index)
        zero += vectors[index];
      return new JVector(zero.X / zero.Length(), zero.Y / zero.Length(), zero.Z / zero.Length());
    }

    public static JVector OverwriteIfThreshold(
      this JVector origin,
      JVector vector,
      float threshold)
    {
      return (double) vector.LengthSquared() > (double) threshold ? vector : origin;
    }
  }
}
