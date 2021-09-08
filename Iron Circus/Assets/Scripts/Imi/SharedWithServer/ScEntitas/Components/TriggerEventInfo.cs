// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.TriggerEventInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public struct TriggerEventInfo
  {
    public JCollision collision;
    public int firstCollisionFrame;
    public int lastCollisionFrame;

    public JRigidbody Body1 => this.collision.body1;

    public JRigidbody Body2 => this.collision.body2;

    public JVector Normal => this.collision.normal;

    public float Penetration => this.collision.penetration;
  }
}
