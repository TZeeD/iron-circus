// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.ServerStatusHeader
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public struct ServerStatusHeader
  {
    public int serverTick;
    public int serverBaseline;
    public sbyte clientToServerOffset;
    public bool wasLastInputLate;

    public ServerStatusHeader(
      int serverTick,
      int serverBaseline,
      sbyte clientToServerOffset,
      bool wasLastInputLate)
    {
      this.serverTick = serverTick;
      this.serverBaseline = serverBaseline;
      this.clientToServerOffset = clientToServerOffset;
      this.wasLastInputLate = wasLastInputLate;
    }

    public void SerializeOrDeserialize(IMessageSerDes serDes)
    {
      serDes.VarInt(ref this.serverTick);
      serDes.VarInt(ref this.serverBaseline);
      serDes.SByte(ref this.clientToServerOffset);
      serDes.Bool(ref this.wasLastInputLate);
    }
  }
}
