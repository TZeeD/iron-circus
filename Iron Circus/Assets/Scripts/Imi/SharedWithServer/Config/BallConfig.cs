// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.BallConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.GameElements;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  public class BallConfig : GameConfigEntry
  {
    public float ballColliderRadius = 0.15f;
    public float ballPickupRadius = 0.2f;
    [Tooltip("Increased ball pickup radius when ball is moving slowly")]
    public float ballLowSpeedPickupRadius = 0.5f;
    [Tooltip("Speed at which ballLowSpeedPickupRadius is fully applied")]
    public float ballLowSpeedFullEffectThreshold = 1f;
    [Tooltip("Speed at which ballLowSpeedPickupRadius starts being applied")]
    public float ballLowSpeedStartEffectThreshold = 4f;
    [Tooltip("How far the ball has to travel after a throw before it can be picked up again")]
    public float blockPickupTravelDistance = 5f;
    [Tooltip("After a throw, this is the speed below which it must fall before it can be picked up again. This value and the travel distance are on a 'whichever is true first' basis. Meaning that the condition that is true first will cause the ball to be pickable again.")]
    public float blockPickupSpeedThreshold = 5f;
    [Tooltip("duration in seconds for ball to travel to player, when player catches a ball at the edge of their range")]
    public float takeBallInterpolationDuration = 0.5f;
    [Tooltip("slowdown per second while in flight")]
    public float defaultFlightDrag = 0.5f;
    [Tooltip("drag can be lower or higher after a force has been applied, for non-linear slowdown")]
    public float dragAfterForce = 1f;
    [Tooltip("custom interpolation curve for dragAfterForce to defaultFlightDrag")]
    public Curve dragAfterForceCurve;
    [Tooltip("how long to interpolate between dragAfterForce and defaultFlightDrag after force applied (seconds)")]
    public float dragAfterForceDuration = 0.5f;
    [Tooltip("below this velocity (after a bounce), ball will stop and start hovering")]
    public float restThresholdVelocity = 1f;
  }
}
