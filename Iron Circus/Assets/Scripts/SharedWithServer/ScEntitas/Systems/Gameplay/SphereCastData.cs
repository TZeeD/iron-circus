// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEntitas.Systems.Gameplay.SphereCastData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using System;

namespace SharedWithServer.ScEntitas.Systems.Gameplay
{
  [Serializable]
  public struct SphereCastData
  {
    public JVector origin;
    public JVector castDir;
    public float checkDistance;
    public JVector deNormal;
    public JVector deOrigin;
    public JVector deCastDir;
    public float deCheckDistance;
    public JVector contactPosition;
    public JVector contactPoint;
    public JVector reflectedDirection;
    public JVector normal;
    public float reflectedLength;

    public JVector ProjectedPosition => this.contactPosition + this.reflectedDirection * this.reflectedLength;
  }
}
