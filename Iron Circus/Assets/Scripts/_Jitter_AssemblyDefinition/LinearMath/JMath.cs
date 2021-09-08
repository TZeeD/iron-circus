// Decompiled with JetBrains decompiler
// Type: Jitter.LinearMath.JMath
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;

namespace Jitter.LinearMath
{
  public sealed class JMath
  {
    public const float Pi = 3.141593f;
    public const float PiOver2 = 1.570796f;
    public const float Deg2Rad = 0.01745329f;
    public const float Rad2Deg = 57.29578f;
    public const float Epsilon = 1.192093E-12f;

    public static float Sqrt(float number) => (float) Math.Sqrt((double) number);

    public static float Pow(float number, float exp) => (float) Math.Pow((double) number, (double) exp);

    public static float Max(float val1, float val2) => (double) val1 <= (double) val2 ? val2 : val1;

    public static float Min(float val1, float val2) => (double) val1 >= (double) val2 ? val2 : val1;

    public static int Max(int val1, int val2) => val1 <= val2 ? val2 : val1;

    public static int Min(int val1, int val2) => val1 >= val2 ? val2 : val1;

    public static float Abs(float val) => (double) val < 0.0 ? -val : val;

    public static float Sign(float val) => (double) val >= 0.0 ? 1f : -1f;

    public static float Max(float val1, float val2, float val3)
    {
      float num = (double) val1 > (double) val2 ? val1 : val2;
      return (double) num <= (double) val3 ? val3 : num;
    }

    public static float Clamp(float value, float min, float max)
    {
      value = (double) value > (double) max ? max : value;
      value = (double) value < (double) min ? min : value;
      return value;
    }

    public static float Clamp01(float value) => JMath.Clamp(value, 0.0f, 1f);

    public static void Absolute(ref JMatrix matrix, out JMatrix result)
    {
      result.M11 = Math.Abs(matrix.M11);
      result.M12 = Math.Abs(matrix.M12);
      result.M13 = Math.Abs(matrix.M13);
      result.M21 = Math.Abs(matrix.M21);
      result.M22 = Math.Abs(matrix.M22);
      result.M23 = Math.Abs(matrix.M23);
      result.M31 = Math.Abs(matrix.M31);
      result.M32 = Math.Abs(matrix.M32);
      result.M33 = Math.Abs(matrix.M33);
    }

    public static float Lerp(float a, float b, float t) => (b - a) * t + a;
  }
}
