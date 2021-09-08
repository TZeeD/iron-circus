// Decompiled with JetBrains decompiler
// Type: Imi.ScEntitas.PreMatchSelectedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.ScEntitas
{
  public class PreMatchSelectedMessage : Message
  {
    public PlayerChampionData data;

    public PreMatchSelectedMessage()
      : base(RumpfieldMessageType.PreMatchSelected)
    {
    }

    public PreMatchSelectedMessage(PlayerChampionData data)
      : base(RumpfieldMessageType.PreMatchSelected)
    {
      this.data = data;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes) => this.data.SerializeOrDeserialize(messageSerDes);
  }
}
