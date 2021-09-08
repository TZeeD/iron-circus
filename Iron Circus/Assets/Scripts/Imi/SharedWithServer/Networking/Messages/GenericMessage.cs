// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.GenericMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class GenericMessage : Message
  {
    public byte[] buffer32;
    public const int Size = 32767;

    public GenericMessage()
      : base(RumpfieldMessageType.Generic)
    {
      this.buffer32 = new byte[(int) short.MaxValue];
      for (int index = 0; index < (int) short.MaxValue; ++index)
        this.buffer32[index] = byte.MaxValue;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      for (int index = 0; index < (int) short.MaxValue; ++index)
        messageSerDes.Byte(ref this.buffer32[index]);
    }
  }
}
