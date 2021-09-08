// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.UpdateSkillConfigMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace SharedWithServer.Networking.Messages
{
  public class UpdateSkillConfigMessage : Message
  {
    public string configName;
    public byte[] data;

    public UpdateSkillConfigMessage()
      : base(RumpfieldMessageType.UpdateSkillConfig)
    {
    }

    public UpdateSkillConfigMessage(string configName, byte[] data)
      : base(RumpfieldMessageType.UpdateSkillConfig)
    {
      this.configName = configName;
      this.data = data;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.String(ref this.configName);
      messageSerDes.ByteArray(ref this.data);
    }
  }
}
