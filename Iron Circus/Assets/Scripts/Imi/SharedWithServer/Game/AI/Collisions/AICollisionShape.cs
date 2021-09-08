// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.Collisions.AICollisionShape
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.AI.Collisions
{
  public abstract class AICollisionShape
  {
    protected bool isTrigger;
    protected GameEntity entity;

    public AICollisionShape(bool isTrigger = false, GameEntity entity = null)
    {
      this.IsTrigger = isTrigger;
      this.Entity = entity;
    }

    public GameEntity Entity
    {
      get => this.entity;
      set => this.entity = value;
    }

    public bool IsTrigger
    {
      get => this.isTrigger;
      set => this.isTrigger = value;
    }

    public abstract void Expand(float units);

    public abstract override string ToString();

    public abstract bool SegmentIntersection(
      JVector rayStart,
      JVector rayDir,
      out JVector contact,
      out float distance,
      out JVector normal);
  }
}
