// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.MovementModifier
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using System.Runtime.InteropServices;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [StructLayout(LayoutKind.Explicit)]
  public struct MovementModifier
  {
    [FieldOffset(0)]
    public MovementModifierType type;
    [FieldOffset(4)]
    public JVector velocity;
    [FieldOffset(4)]
    public JVector moveDir;
    [FieldOffset(4)]
    public float speedScale;
    [FieldOffset(4)]
    public float maxSpeed;
    [FieldOffset(8)]
    public float acceleration;
    [FieldOffset(12)]
    public float deceleration;
    [FieldOffset(16)]
    public float thrustPercent;

    public static MovementModifier Override(
      float maxSpeed,
      float acceleration,
      float deceleration,
      float thrustPercent)
    {
      return new MovementModifier()
      {
        type = MovementModifierType.OverrideMovement,
        maxSpeed = maxSpeed,
        acceleration = acceleration,
        deceleration = deceleration,
        thrustPercent = thrustPercent
      };
    }

    public static MovementModifier OverrideMoveDir(JVector moveDir) => new MovementModifier()
    {
      type = MovementModifierType.OverrideMoveDir,
      moveDir = moveDir
    };

    public static MovementModifier AddVelocity(JVector velocity) => new MovementModifier()
    {
      type = MovementModifierType.AddVelocity,
      velocity = velocity
    };

    public static MovementModifier SetVelocity(JVector velocity) => new MovementModifier()
    {
      type = MovementModifierType.SetVelocity,
      velocity = velocity
    };
  }
}
