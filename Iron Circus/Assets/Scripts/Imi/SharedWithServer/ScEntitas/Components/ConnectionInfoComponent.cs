// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.ConnectionInfoComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public class ConnectionInfoComponent : ImiComponent
  {
    public float rttMillis;
    public int lastReceivedRemoteTick;
    public float loss;
    public float recvBandwidthKbps;
    public float sentBandwidthKbps;
    public float ackBandwidthKbps;
    public float currentTickRateMillis;
    public int offset;
    public int connectedTicks;
    public int lateMessages;

    public void SetEndpointInfo(float rtt, float packetLoss, float sent, float recv, float ack)
    {
      this.rttMillis = rtt;
      this.loss = packetLoss;
      this.sentBandwidthKbps = sent;
      this.recvBandwidthKbps = recv;
      this.ackBandwidthKbps = ack;
    }

    public void SetServerStatus(int offset, int connectedTicksIncrement, bool wasInputLate)
    {
      this.offset = offset;
      this.connectedTicks += connectedTicksIncrement;
      this.lateMessages = wasInputLate ? 1 : 0;
    }

    public int GetRttt(float timeStep) => (int) Math.Max(Math.Ceiling((double) this.rttMillis / ((double) timeStep * 1000.0)), 1.0);
  }
}
