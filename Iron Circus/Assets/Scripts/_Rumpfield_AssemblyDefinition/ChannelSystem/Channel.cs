// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem.Channel
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.Rumpfield.Utils;

namespace Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem
{
  public abstract class Channel
  {
    public abstract void Reset();

    public abstract bool HasMessageToSend();

    public abstract bool CanSendMessage();

    public abstract int SendMessage(RMessage message);

    public abstract RMessage RecvMessage();

    public abstract void Tick(double timestamp);

    public abstract void ToPacketData(ushort sequence, IChannelTransport channelTransport);

    public abstract void ProcessPacketData(ushort sequence, IChannelTransport channeltransport);

    public abstract void ProcessPacketAck(ushort ackSequence);
  }
}
