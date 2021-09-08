// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.AverageFpsMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace SharedWithServer.Networking.Messages
{
  public class AverageFpsMessage : Message
  {
    public const RumpfieldMessageType Type = RumpfieldMessageType.AverageFps;
    public float averageFps;
    public string deviceName;

    public AverageFpsMessage()
      : base(RumpfieldMessageType.AverageFps)
    {
    }

    public AverageFpsMessage(float averageFps, string deviceName)
      : base(RumpfieldMessageType.AverageFps)
    {
      this.averageFps = averageFps;
      this.deviceName = deviceName;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Float(ref this.averageFps);
      messageSerDes.String(ref this.deviceName);
    }
  }
}
