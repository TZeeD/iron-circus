// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.TickInput
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.Networking.Messages
{
  public struct TickInput
  {
    public int tick;
    public Input input;

    public TickInput(int tick, Input input)
    {
      this.tick = tick;
      this.input = input;
    }

    public void SerializeOrDeserialize(IMessageSerDes serdes)
    {
      serdes.Int(ref this.tick);
      this.input.SerializeOrDeserialize(serdes);
    }
  }
}
