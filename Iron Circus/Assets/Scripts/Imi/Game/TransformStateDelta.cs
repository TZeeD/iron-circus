// Decompiled with JetBrains decompiler
// Type: Imi.Game.TransformStateDelta
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.Game
{
  public struct TransformStateDelta
  {
    private TransformState state;
    private bool positionIsDirty;
    private bool velocityIsDirty;
    private bool rotationIsDirty;

    public TransformState State => this.state;

    public bool PositionIsDirty => this.positionIsDirty;

    public bool VelocityIsDirty => this.velocityIsDirty;

    public bool RotationIsDirty => this.rotationIsDirty;

    public TransformStateDelta(
      TransformState state,
      bool positionIsDirty,
      bool velocityIsDirty,
      bool rotationIsDirty)
    {
      this.state = state;
      this.positionIsDirty = positionIsDirty;
      this.velocityIsDirty = velocityIsDirty;
      this.rotationIsDirty = rotationIsDirty;
    }

    public void SerializeOrDeserialize(IMessageSerDes serDes, bool forceY = false)
    {
      serDes.Bool(ref this.positionIsDirty);
      if (this.positionIsDirty)
      {
        serDes.Float(ref this.state.position.X);
        if (forceY)
          serDes.Float(ref this.state.position.Y);
        else
          this.state.position.Y = 0.0f;
        serDes.Float(ref this.state.position.Z);
      }
      serDes.Bool(ref this.velocityIsDirty);
      if (this.velocityIsDirty)
      {
        serDes.Float(ref this.state.velocity.X);
        this.state.velocity.Y = 0.0f;
        serDes.Float(ref this.state.velocity.Z);
      }
      serDes.Bool(ref this.rotationIsDirty);
      if (!this.rotationIsDirty)
        return;
      float angle2D = this.state.rotation.ToAngle2D();
      serDes.Float(ref angle2D);
      this.state.rotation = JQuaternion.From2DAngle(angle2D);
    }

    public override string ToString() => string.Format("Pos [{0}, {1}], Rot [{2}, {3}], Vel [{4}, {5}]", (object) this.positionIsDirty, (object) this.state.position, (object) this.rotationIsDirty, (object) this.state.rotation, (object) this.velocityIsDirty, (object) this.state.velocity);

    public static TransformStateDelta GetDelta(
      TransformState from,
      TransformState to)
    {
      bool positionIsDirty = false;
      bool velocityIsDirty = false;
      bool rotationIsDirty = false;
      if (from.position != to.position)
        positionIsDirty = true;
      if (from.velocity != to.velocity)
        velocityIsDirty = true;
      if (!from.rotation.Equals(to.rotation))
        rotationIsDirty = true;
      return new TransformStateDelta(to, positionIsDirty, velocityIsDirty, rotationIsDirty);
    }

    public static TransformState Merge(
      TransformState oldState,
      TransformStateDelta delta)
    {
      TransformState state = delta.State;
      JVector position = delta.positionIsDirty ? state.position : oldState.position;
      JVector jvector = delta.velocityIsDirty ? state.velocity : oldState.velocity;
      JQuaternion jquaternion = delta.rotationIsDirty ? state.rotation : oldState.rotation;
      JVector velocity = jvector;
      JQuaternion rotation = jquaternion;
      return new TransformState(position, velocity, rotation);
    }
  }
}
