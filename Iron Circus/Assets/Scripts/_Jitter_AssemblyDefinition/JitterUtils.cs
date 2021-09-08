// Decompiled with JetBrains decompiler
// Type: JitterUtils
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;

public static class JitterUtils
{
  public static JVector Reflect(this JVector inVector, JVector reflectionAxis) => inVector - 2f * JVector.Dot(inVector, reflectionAxis) * reflectionAxis;

  public static void CollideSpheres(
    JVector position1,
    JVector velocity1,
    JVector position2,
    JVector velocity2,
    out JVector resultVelocity1,
    out JVector resultVelocity2)
  {
    JVector vector2_1 = position2 - position1;
    vector2_1.Normalize();
    JVector vector2_2 = vector2_1 * -1f;
    JVector jvector1 = vector2_1 * JVector.Dot(velocity1, vector2_1);
    JVector jvector2 = vector2_2 * JVector.Dot(velocity2, vector2_2);
    JVector jvector3 = jvector1 - velocity1;
    JVector jvector4 = jvector2 - velocity2;
    resultVelocity1 = jvector3 + jvector2;
    resultVelocity2 = jvector4 + jvector1;
  }

  public static JVector Normalized(this JVector vector) => JVector.Normalize(vector);

  public static JQuaternion LookRotation(
    this JVector startLookDir,
    JVector targetLookDir,
    float maxAngle = 360f)
  {
    JQuaternion a = JQuaternion.LookRotation(startLookDir, JVector.Up);
    JQuaternion b = JQuaternion.LookRotation(targetLookDir, JVector.Up);
    float val1 = JQuaternion.Angle(a, b);
    if ((double) val1 < (double) maxAngle)
      return b;
    float num = (double) JVector.Cross(startLookDir, targetLookDir).Y > 0.0 ? 1f : -1f;
    JQuaternion result;
    JQuaternion.CreateFromYawPitchRoll((float) ((double) JMath.Min(val1, maxAngle) * (double) num * (Math.PI / 180.0)), 0.0f, 0.0f, out result);
    return a * result;
  }

  public static JVector RotateTowards(
    this JVector startLookDir,
    JVector targetLookDir,
    float maxAngle = 360f)
  {
    return JMatrix.CreateFromQuaternion(startLookDir.LookRotation(targetLookDir, maxAngle)).Forward() * startLookDir.Length();
  }

  public static JVector ClampLength(JVector vector, float min, float max)
  {
    if (vector.IsNearlyZero())
      return JVector.Zero;
    float val2 = vector.Length();
    if ((double) val2 < (double) min)
      return vector.Normalized() * JMath.Max(min, val2);
    return (double) val2 > (double) max ? vector.Normalized() * JMath.Min(max, val2) : vector;
  }

  public static float JAngle(JQuaternion a, JQuaternion b)
  {
    float dot = JitterUtils.JDot(a, b);
    return JitterUtils.IsEqualUsingDot(dot) ? 0.0f : (float) (Math.Acos((double) Math.Min(Math.Abs(dot), 1f)) * 2.0 * 57.2957801818848);
  }

  public static float JDot(JQuaternion a, JQuaternion b) => (float) ((double) a.X * (double) b.X + (double) a.Y * (double) b.Y + (double) a.Z * (double) b.Z + (double) a.W * (double) b.W);

  public static bool IsEqualUsingDot(float dot) => (double) dot > 0.999998986721039;

  public static JVector NearestPointOnSegment(JVector pos, JVector start, JVector end) => JitterUtils.NearestPointOnSegment(pos, start, end, out float _);

  public static JVector NearestPointOnSegment(
    JVector pos,
    JVector start,
    JVector end,
    out float fract)
  {
    JVector jvector = end - start;
    float num = JMath.Clamp01(JVector.Dot(pos - start, jvector) / JVector.Dot(jvector, jvector));
    fract = num;
    return start + num * jvector;
  }

  public static float DistanceToSegment(JVector pos, JVector start, JVector end) => (JitterUtils.NearestPointOnSegment(pos, start, end) - pos).Length();

  public static JVector Rotate2D(JVector dir, float degrees)
  {
    double a;
    double num1 = Math.Cos(a = Math.PI / 180.0 * (double) degrees);
    double num2 = Math.Sin(a);
    return new JVector((float) ((double) dir.X * num1 - (double) dir.Z * num2), 0.0f, (float) ((double) dir.X * num2 + (double) dir.Z * num1));
  }
}
