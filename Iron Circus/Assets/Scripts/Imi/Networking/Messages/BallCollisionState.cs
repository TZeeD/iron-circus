// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.BallCollisionState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.Networking.Messages
{
  public struct BallCollisionState
  {
    public UniqueId collisionObjectId;
    public JVector position;

    public void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.UniqueId(ref this.collisionObjectId);
      messageSerDes.JVector(ref this.position);
    }
  }
}
