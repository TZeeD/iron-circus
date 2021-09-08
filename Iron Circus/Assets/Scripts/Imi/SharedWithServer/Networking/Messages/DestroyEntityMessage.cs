// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.DestroyEntityMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class DestroyEntityMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.DestroyEntity;
    public ushort uniqueId;

    public DestroyEntityMessage()
      : base(DestroyEntityMessage.Type, true)
    {
    }

    public DestroyEntityMessage(ushort uniqueId)
      : base(DestroyEntityMessage.Type, true)
    {
      this.uniqueId = uniqueId;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes) => messageSerDes.UShort(ref this.uniqueId);
  }
}
