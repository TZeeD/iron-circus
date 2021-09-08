// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.LobbyPickTimesMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class LobbyPickTimesMessage : Message
  {
    public int[,] AlphaPlayerPickTimes;
    public int[,] BetaPlayerPickTimes;

    public LobbyPickTimesMessage()
      : base(RumpfieldMessageType.LobbyPickTimes)
    {
    }

    public LobbyPickTimesMessage(int[,] alphaPlayerPickTimes, int[,] betaPlayerPickTimes)
      : base(RumpfieldMessageType.LobbyPickTimes)
    {
      this.AlphaPlayerPickTimes = alphaPlayerPickTimes;
      this.BetaPlayerPickTimes = betaPlayerPickTimes;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      if (messageSerDes.IsSerializer())
        this.Serialize2DFloatArray(messageSerDes);
      else
        this.Deserialize2DFloatArray(messageSerDes);
    }

    private void Serialize2DFloatArray(IMessageSerDes messageSerDes)
    {
      byte length1 = (byte) this.AlphaPlayerPickTimes.GetLength(0);
      byte length2 = (byte) this.BetaPlayerPickTimes.GetLength(0);
      messageSerDes.Byte(ref length1);
      messageSerDes.Byte(ref length2);
      for (int index = 0; index < (int) length1; ++index)
      {
        messageSerDes.Int(ref this.AlphaPlayerPickTimes.Address(index, 0));
        messageSerDes.Int(ref this.AlphaPlayerPickTimes.Address(index, 1));
      }
      for (int index = 0; index < (int) length2; ++index)
      {
        messageSerDes.Int(ref this.BetaPlayerPickTimes.Address(index, 0));
        messageSerDes.Int(ref this.BetaPlayerPickTimes.Address(index, 1));
      }
    }

    private void Deserialize2DFloatArray(IMessageSerDes messageSerDes)
    {
      byte num1 = 0;
      byte num2 = 0;
      messageSerDes.Byte(ref num1);
      messageSerDes.Byte(ref num2);
      this.AlphaPlayerPickTimes = new int[(int) num1, 2];
      this.BetaPlayerPickTimes = new int[(int) num2, 2];
      for (int index = 0; index < (int) num1; ++index)
      {
        messageSerDes.Int(ref this.AlphaPlayerPickTimes.Address(index, 0));
        messageSerDes.Int(ref this.AlphaPlayerPickTimes.Address(index, 1));
      }
      for (int index = 0; index < (int) num2; ++index)
      {
        messageSerDes.Int(ref this.BetaPlayerPickTimes.Address(index, 0));
        messageSerDes.Int(ref this.BetaPlayerPickTimes.Address(index, 1));
      }
    }
  }
}
