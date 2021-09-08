// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.TransformComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public class TransformComponent : ImiComponent
  {
    public JVector position;
    public JQuaternion rotation;

    public JVector Forward => this.rotation.Forward();

    public JVector Position2D => new JVector(this.position.X, 0.0f, this.position.Z);

    public JMatrix ToMatrix() => JMatrix.CreateFromQuaternion(this.rotation);

    public float Distance2D(TransformComponent other) => (other.Position2D - this.Position2D).Length();

    public float Distance2D(JVector position)
    {
      position.Y = 0.0f;
      return (position - this.Position2D).Length();
    }

    public JVector Vector2DTo(JVector target)
    {
      JVector jvector = this.VectorTo(target);
      jvector.Y = 0.0f;
      return jvector;
    }

    public JVector Vector2DTo(TransformComponent target)
    {
      JVector jvector = this.VectorTo(target.position);
      jvector.Y = 0.0f;
      return jvector;
    }

    public JVector VectorTo(TransformComponent target) => this.VectorTo(target.position);

    public JVector VectorTo(JVector target) => target - this.position;
  }
}
