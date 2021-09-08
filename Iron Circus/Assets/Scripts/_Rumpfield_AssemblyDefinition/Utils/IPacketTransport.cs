// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Utils.IPacketTransport
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem;

namespace Imi.SharedWithServer.Networking.Rumpfield.Utils
{
  public interface IPacketTransport
  {
    void AddChannelTransport(IChannelTransport transport);

    byte[] ToByteArray();

    void FillWithByteArray(byte[] buffer);

    IChannelTransport GetTransport(int index);

    int GetChannelTransportCount();
  }
}
