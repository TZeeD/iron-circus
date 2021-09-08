// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.ArenaLoadedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace SharedWithServer.Networking.Messages
{
  public class ArenaLoadedMessage : Message
  {
    public string arenaName;
    public uint durationInMs;

    public ArenaLoadedMessage()
      : base(RumpfieldMessageType.ArenaLoaded)
    {
    }

    public ArenaLoadedMessage(string arenaName, uint durationInMs)
      : base(RumpfieldMessageType.ArenaLoaded)
    {
      this.arenaName = arenaName;
      this.durationInMs = durationInMs;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.String(ref this.arenaName);
      messageSerDes.UInt(ref this.durationInMs);
    }
  }
}
