﻿// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEntitas.Systems.Gameplay.SphereCastResult
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.Dynamics;
using Jitter.LinearMath;

namespace SharedWithServer.ScEntitas.Systems.Gameplay
{
  public struct SphereCastResult
  {
    public bool collided;
    public JRigidbody collRb;
    public float penetration;
    public JVector contactPoint;
    public JVector normal;
    public float collisionFraction;
    public JVector contactPosition;
    public JVector reflectedDirection;
    public JVector resultPosition;
    public float reflectedLength;
  }
}
