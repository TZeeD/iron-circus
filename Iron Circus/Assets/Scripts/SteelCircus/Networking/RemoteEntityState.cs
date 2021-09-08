// Decompiled with JetBrains decompiler
// Type: SteelCircus.Networking.RemoteEntityState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace SteelCircus.Networking
{
  public struct RemoteEntityState : IEquatable<RemoteEntityState>
  {
    public UniqueId uniqueId;
    public JVector position;
    public JVector velocity;
    public JQuaternion rotation;

    public static RemoteEntityState Invalid => new RemoteEntityState(UniqueId.Invalid, JVector.Zero, JVector.Zero, new JQuaternion());

    public RemoteEntityState(
      UniqueId uniqueId,
      JVector position,
      JVector velocity,
      JQuaternion rotation)
    {
      this.uniqueId = uniqueId;
      this.position = position;
      this.velocity = velocity;
      this.rotation = rotation;
    }

    public static RemoteEntityState Lerp(
      RemoteEntityState from,
      RemoteEntityState to,
      float t)
    {
      if (from.uniqueId != to.uniqueId)
        Debug.LogWarning((object) "Interpolating remote entities with different unique Ids!");
      JVector position = JVector.Lerp(from.position, to.position, t);
      JVector velocity = JVector.Lerp(from.velocity, to.velocity, t);
      JVector jvector1 = JVector.Lerp(from.position, to.position, Mathf.Clamp01(t));
      JVector jvector2 = JVector.Lerp(from.velocity, to.velocity, Mathf.Clamp01(t));
      position.Y = jvector1.Y;
      velocity.Y = jvector2.Y;
      JQuaternion jquaternion = Quaternion.Slerp(from.rotation.ToQuaternion(), to.rotation.ToQuaternion(), t).ToJQuaternion();
      return new RemoteEntityState(from.uniqueId, position, velocity, jquaternion);
    }

    public bool Equals(RemoteEntityState other) => this.uniqueId.Equals(other.uniqueId) && this.position.Equals(other.position) && this.velocity.Equals(other.velocity) && this.rotation.Equals(other.rotation);

    public override bool Equals(object obj) => obj != null && obj is RemoteEntityState other && this.Equals(other);

    public override int GetHashCode() => ((this.uniqueId.GetHashCode() * 397 ^ this.position.GetHashCode()) * 397 ^ this.velocity.GetHashCode()) * 397 ^ this.rotation.GetHashCode();
  }
}
