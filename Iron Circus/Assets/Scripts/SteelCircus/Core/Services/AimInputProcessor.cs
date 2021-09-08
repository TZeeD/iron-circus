// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.AimInputProcessor
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class AimInputProcessor
  {
    private const float holdDurationOutsideDeadZone = 0.035f;
    private const float holdDurationInsideDeadZone = 0.3f;
    private const float holdThresholdDelta = 0.1f;
    private const float deadZone = 0.05f;
    private float heldMagnitude;
    private Vector3 heldDirection = Vector3.zero;
    private float heldTimeStamp = -1f;

    public Vector3 Process(Vector3 input)
    {
      Vector3 vector3 = input;
      float magnitude = input.magnitude;
      float realtimeSinceStartup = Time.realtimeSinceStartup;
      if ((double) magnitude < (double) this.heldMagnitude - 0.100000001490116 && ((double) magnitude <= 0.0500000007450581 && (double) realtimeSinceStartup < (double) this.heldTimeStamp + 0.300000011920929 || (double) magnitude > 0.0500000007450581 && (double) realtimeSinceStartup < (double) this.heldTimeStamp + 0.0350000001490116 || (double) Mathf.Abs(realtimeSinceStartup - (this.heldTimeStamp + Time.deltaTime)) < 1.0 / 1000.0))
      {
        vector3 = this.heldDirection;
      }
      else
      {
        this.heldMagnitude = magnitude;
        this.heldDirection = input;
        this.heldTimeStamp = realtimeSinceStartup;
      }
      return vector3;
    }
  }
}
