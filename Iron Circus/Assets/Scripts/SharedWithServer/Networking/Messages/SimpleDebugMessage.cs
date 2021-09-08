// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.SimpleDebugMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using SharedWithServer.ScEvents;

namespace SharedWithServer.Networking.Messages
{
  public class SimpleDebugMessage : Message
  {
    public const RumpfieldMessageType Type = RumpfieldMessageType.SimpleDebug;
    public DebugEventType debugEventType;

    public SimpleDebugMessage()
      : base(RumpfieldMessageType.SimpleDebug, true)
    {
    }

    public SimpleDebugMessage(DebugEventType debugEventType)
      : base(RumpfieldMessageType.SimpleDebug, true)
    {
      this.debugEventType = debugEventType;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      int debugEventType = (int) this.debugEventType;
      messageSerDes.Int(ref debugEventType);
      this.debugEventType = (DebugEventType) debugEventType;
    }
  }
}
