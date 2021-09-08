// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.LobbyPickOrderMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class LobbyPickOrderMessage : Message
  {
    public UniqueId[] alphaPickOrder;
    public UniqueId[] betaPickOrder;

    public LobbyPickOrderMessage()
      : base(RumpfieldMessageType.LobbyPickOrder)
    {
    }

    public LobbyPickOrderMessage(UniqueId[] newAlphaPickOrder, UniqueId[] newBetaPickOrder)
      : base(RumpfieldMessageType.LobbyPickOrder)
    {
      this.alphaPickOrder = newAlphaPickOrder;
      this.betaPickOrder = newBetaPickOrder;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      if (messageSerDes.IsSerializer())
        this.SerializeUniqueIdArray(messageSerDes);
      else
        this.DeserializeUniqueIdArray(messageSerDes);
    }

    private void SerializeUniqueIdArray(IMessageSerDes messageSerDes)
    {
      byte length1 = (byte) this.alphaPickOrder.Length;
      byte length2 = (byte) this.betaPickOrder.Length;
      messageSerDes.Byte(ref length1);
      messageSerDes.Byte(ref length2);
      for (int index = 0; index < (int) length1; ++index)
        messageSerDes.UniqueId(ref this.alphaPickOrder[index]);
      for (int index = 0; index < (int) length2; ++index)
        messageSerDes.UniqueId(ref this.betaPickOrder[index]);
    }

    private void DeserializeUniqueIdArray(IMessageSerDes messageSerDes)
    {
      byte num1 = 0;
      byte num2 = 0;
      messageSerDes.Byte(ref num1);
      messageSerDes.Byte(ref num2);
      this.alphaPickOrder = new UniqueId[(int) num1];
      this.betaPickOrder = new UniqueId[(int) num2];
      for (int index = 0; index < (int) num1; ++index)
        messageSerDes.UniqueId(ref this.alphaPickOrder[index]);
      for (int index = 0; index < (int) num2; ++index)
        messageSerDes.UniqueId(ref this.betaPickOrder[index]);
    }
  }
}
