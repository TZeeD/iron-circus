// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Core.IConnection
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.reliable.core;
using Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem;
using Imi.SharedWithServer.Networking.Rumpfield.Utils;

namespace Imi.SharedWithServer.Networking.Rumpfield.Core
{
  public interface IConnection
  {
    int GetIndex();

    void SetIndex(int index);

    ulong GetId();

    void SetId(ulong id);

    RumpfieldState GetState();

    void SetState(RumpfieldState state);

    double GetLastTickTime();

    ReliableEndpoint GetEndpoint();

    int SendMessage(QualityOfService qos, RMessage message);

    RMessage RecvMessage();

    void ProcessPacket(ushort sequence, byte[] data, int size);

    void Tick(double time);

    void Send(double time);

    void Reset();

    void ResetChannels();

    void Connect(int index);

    void Disconnect();
  }
}
