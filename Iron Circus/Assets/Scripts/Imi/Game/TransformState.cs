// Decompiled with JetBrains decompiler
// Type: Imi.Game.TransformState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game.History;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.Utils.Extensions;
using Jitter.LinearMath;
using System;

namespace Imi.Game
{
  public struct TransformState : ISerDesAble, IEquatable<TransformState>, IHistoryObject
  {
    public static TransformState Default = new TransformState(JVector.Zero, JVector.Zero, JQuaternion.LookForward);
    public static TransformState Invalid = new TransformState(JVector.MaxValue, JVector.MaxValue, JQuaternion.CreateFromMatrix(JMatrix.Zero));
    public JVector position;
    public JVector velocity;
    public JQuaternion rotation;

    public TransformState(JVector position, JVector velocity, JQuaternion rotation)
    {
      this.position = position;
      this.rotation = rotation;
      this.velocity = velocity;
    }

    public void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Float(ref this.position.X);
      messageSerDes.Float(ref this.position.Y);
      messageSerDes.Float(ref this.position.Z);
      messageSerDes.Float(ref this.velocity.X);
      messageSerDes.Float(ref this.velocity.Y);
      messageSerDes.Float(ref this.velocity.Z);
      float angle2D = this.rotation.ToAngle2D();
      messageSerDes.Float(ref angle2D);
      this.rotation = JQuaternion.From2DAngle(angle2D);
    }

    public override string ToString() => string.Format("Pos [{0}], Rot [{1}], Vel [{2}]", (object) this.position, (object) this.rotation, (object) this.velocity);

    public string ToStringRounded()
    {
      JVector jvector1 = new JVector((float) Math.Round((double) this.position.X * 10000.0) / 10000f, (float) Math.Round((double) this.position.Y * 10000.0) / 10000f, (float) Math.Round((double) this.position.Z * 10000.0) / 10000f);
      JVector jvector2 = new JVector((float) Math.Round((double) this.velocity.X * 10000.0) / 10000f, (float) Math.Round((double) this.velocity.Y * 10000.0) / 10000f, (float) Math.Round((double) this.velocity.Z * 10000.0) / 10000f);
      float roll;
      float pitch;
      float yaw;
      this.rotation.ToEulerAngle(out roll, out pitch, out yaw);
      float num1 = (float) Math.Round((double) roll);
      float num2 = (float) Math.Round((double) pitch);
      float num3 = (float) Math.Round((double) yaw);
      return string.Format("Pos [{0}], Rot [{1}, {2}, {3}], Vel [{4}]", (object) jvector1, (object) num1, (object) num2, (object) num3, (object) jvector2);
    }

    public bool Equals(TransformState other) => this.position.Equals(other.position) && this.velocity.Equals(other.velocity) && this.rotation.Equals(other.rotation);

    public override bool Equals(object obj) => obj != null && obj is TransformState other && this.Equals(other);

    public override int GetHashCode() => (this.position.GetHashCode() * 397 ^ this.velocity.GetHashCode()) * 397 ^ this.rotation.GetHashCode();

    public void CopyFrom(GameEntity entity, IHistoryObject copyFromReference) => entity.ToTransformState(ref this);
  }
}
