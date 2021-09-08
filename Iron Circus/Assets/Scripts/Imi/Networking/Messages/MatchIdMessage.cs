// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.MatchIdMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using System;

namespace Imi.Networking.Messages
{
  public class MatchIdMessage : Message
  {
    public MatchIdMessage(RumpfieldMessageType type)
      : base(type)
    {
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes) => throw new NotImplementedException();
  }
}
