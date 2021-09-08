// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.PassedNarrowphaseHandler
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Jitter.Collision
{
  public delegate bool PassedNarrowphaseHandler(
    JRigidbody body1,
    JRigidbody body2,
    ref JVector point,
    ref JVector normal,
    float penetration);
}
