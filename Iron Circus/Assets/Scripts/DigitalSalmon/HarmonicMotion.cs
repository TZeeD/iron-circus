// Decompiled with JetBrains decompiler
// Type: DigitalSalmon.HarmonicMotion
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace DigitalSalmon
{
  public static class HarmonicMotion
  {
    public static void Calculate(
      ref Vector3 state,
      ref Vector3 velocity,
      Vector3 targetState,
      HarmonicMotion.DampenedSpringMotionParams springMotionParams)
    {
      float x1 = velocity.x;
      float x2 = state.x;
      float x3 = targetState.x;
      HarmonicMotion.Calculate(ref x2, ref x1, x3, springMotionParams);
      float y1 = velocity.y;
      float y2 = state.y;
      float y3 = targetState.y;
      HarmonicMotion.Calculate(ref y2, ref y1, y3, springMotionParams);
      float z1 = velocity.z;
      float z2 = state.z;
      float z3 = targetState.z;
      HarmonicMotion.Calculate(ref z2, ref z1, z3, springMotionParams);
      velocity = new Vector3(x1, y1, z1);
      state = new Vector3(x2, y2, z2);
    }

    public static void Calculate(
      ref Vector2 state,
      ref Vector2 velocity,
      Vector2 targetState,
      HarmonicMotion.DampenedSpringMotionParams springMotionParams)
    {
      float x1 = velocity.x;
      float x2 = state.x;
      float x3 = targetState.x;
      HarmonicMotion.Calculate(ref x2, ref x1, x3, springMotionParams);
      float y1 = velocity.y;
      float y2 = state.y;
      float y3 = targetState.y;
      HarmonicMotion.Calculate(ref y2, ref y1, y3, springMotionParams);
      velocity = new Vector2(x1, y1);
      state = new Vector2(x2, y2);
    }

    public static void Calculate(
      ref float state,
      ref float velocity,
      float targetState,
      HarmonicMotion.DampenedSpringMotionParams springMotionParams)
    {
      float num1 = state - targetState;
      float num2 = velocity;
      state = (float) ((double) num1 * (double) springMotionParams.PosPosCoef + (double) num2 * (double) springMotionParams.PosVelCoef) + targetState;
      velocity = (float) ((double) num1 * (double) springMotionParams.VelPosCoef + (double) num2 * (double) springMotionParams.VelVelCoef);
    }

    public static HarmonicMotion.DampenedSpringMotionParams CalcDampedSpringMotionParams(
      float dampingRatio,
      float angularFrequency,
      float deltaTime)
    {
      if ((double) dampingRatio < 0.0)
        dampingRatio = 0.0f;
      if ((double) angularFrequency < 0.0)
        angularFrequency = 0.0f;
      if ((double) angularFrequency < 9.99999974737875E-05)
        return new HarmonicMotion.DampenedSpringMotionParams()
        {
          PosPosCoef = 1f,
          PosVelCoef = 0.0f,
          VelPosCoef = 0.0f,
          VelVelCoef = 1f
        };
      if ((double) dampingRatio > 1.00010001659393)
      {
        double num1 = -(double) angularFrequency * (double) dampingRatio;
        float num2 = angularFrequency * (float) Math.Sqrt((double) dampingRatio * (double) dampingRatio - 1.0);
        float num3 = (float) num1 - num2;
        float num4 = (float) num1 + num2;
        double num5 = Math.Exp((double) num3 * (double) deltaTime);
        float num6 = (float) Math.Exp((double) num4 * (double) deltaTime);
        float num7 = (float) (1.0 / (2.0 * (double) num2));
        double num8 = (double) num7;
        float num9 = (float) (num5 * num8);
        float num10 = num6 * num7;
        float num11 = num3 * num9;
        float num12 = num4 * num10;
        return new HarmonicMotion.DampenedSpringMotionParams()
        {
          PosPosCoef = num9 * num4 - num12 + num6,
          PosVelCoef = -num9 + num10,
          VelPosCoef = (num11 - num12 + num6) * num4,
          VelVelCoef = -num11 + num12
        };
      }
      if ((double) dampingRatio < 0.999899983406067)
      {
        float num13 = angularFrequency * dampingRatio;
        float num14 = angularFrequency * (float) Math.Sqrt(1.0 - (double) dampingRatio * (double) dampingRatio);
        double num15 = Math.Exp(-(double) num13 * (double) deltaTime);
        float num16 = (float) Math.Cos((double) num14 * (double) deltaTime);
        float num17 = (float) Math.Sin((double) num14 * (double) deltaTime);
        float num18 = 1f / num14;
        float num19 = (float) num15 * num17;
        float num20 = (float) num15 * num16;
        float num21 = (float) num15 * num13 * num17 * num18;
        return new HarmonicMotion.DampenedSpringMotionParams()
        {
          PosPosCoef = num20 + num21,
          PosVelCoef = num19 * num18,
          VelPosCoef = (float) (-(double) num19 * (double) num14 - (double) num13 * (double) num21),
          VelVelCoef = num20 - num21
        };
      }
      float num22 = (float) Math.Exp(-(double) angularFrequency * (double) deltaTime);
      float num23 = deltaTime * num22;
      float num24 = num23 * angularFrequency;
      return new HarmonicMotion.DampenedSpringMotionParams()
      {
        PosPosCoef = num24 + num22,
        PosVelCoef = num23,
        VelPosCoef = -angularFrequency * num24,
        VelVelCoef = -num24 + num22
      };
    }

    public struct DampenedSpringMotionParams
    {
      public float PosPosCoef;
      public float PosVelCoef;
      public float VelPosCoef;
      public float VelVelCoef;
    }
  }
}
