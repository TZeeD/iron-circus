// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Core.RumpfieldServerConfig
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

namespace Imi.SharedWithServer.Networking.Rumpfield.Core
{
  public struct RumpfieldServerConfig
  {
    public RumpfieldServerConfig(
      int numberOfPeers,
      string gatewayAddress,
      string ip,
      int port,
      ulong protocolId,
      byte[] privateKey,
      int clientDestroyTimeOut)
    {
      this.NumberOfPeers = numberOfPeers;
      this.GatewayAddress = gatewayAddress;
      this.Ip = ip;
      this.Port = port;
      this.ProtocolId = protocolId;
      this.PrivateKey = privateKey;
      this.ClientDestroyTimeOut = clientDestroyTimeOut;
    }

    public int NumberOfPeers { get; }

    public string GatewayAddress { get; }

    public string Ip { get; }

    public int Port { get; }

    public ulong ProtocolId { get; }

    public byte[] PrivateKey { get; }

    public int ClientDestroyTimeOut { get; }
  }
}
