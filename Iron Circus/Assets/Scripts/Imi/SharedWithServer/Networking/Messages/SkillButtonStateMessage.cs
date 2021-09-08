// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SkillButtonStateMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class SkillButtonStateMessage : Message
  {
    public int index;
    public bool isDown;

    public SkillButtonStateMessage()
      : base(RumpfieldMessageType.SkillButtonState)
    {
    }

    public SkillButtonStateMessage(int index, bool isDown)
      : base(RumpfieldMessageType.SkillButtonState)
    {
      this.index = index;
      this.isDown = isDown;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Int(ref this.index);
      messageSerDes.Bool(ref this.isDown);
    }
  }
}
