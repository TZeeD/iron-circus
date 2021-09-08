// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.RemoteClientStateMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class RemoteClientStateMessage : Message
  {
    public const RumpfieldMessageType Type = RumpfieldMessageType.RemoteClientState;
    public ulong id;
    public uint index;
    public bool isConnected;
    public uint rtt;

    public RemoteClientStateMessage()
      : base(RumpfieldMessageType.RemoteClientState)
    {
    }

    public RemoteClientStateMessage(ulong id, uint index, uint rtt, bool isConnected)
      : base(RumpfieldMessageType.RemoteClientState)
    {
      this.id = id;
      this.index = index;
      this.rtt = rtt;
      this.isConnected = isConnected;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.id);
      messageSerDes.UInt(ref this.index);
      messageSerDes.UInt(ref this.rtt);
      messageSerDes.Bool(ref this.isConnected);
    }
  }
}
