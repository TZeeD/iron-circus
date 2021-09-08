// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.MatchStateMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class MatchStateMessage : Message
  {
    private const RumpfieldMessageType Type = RumpfieldMessageType.GameState;
    public float cutsceneDuration;
    public float remainingMatchTime;
    public MatchState matchState;

    public MatchStateMessage()
      : base(RumpfieldMessageType.GameState, true)
    {
    }

    public MatchStateMessage(
      MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
      : base(RumpfieldMessageType.GameState, true)
    {
      this.matchState = matchState;
      this.cutsceneDuration = cutsceneDuration;
      this.remainingMatchTime = remainingMatchTime;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      this.SerializeOrDeserializeGameState(messageSerDes);
      messageSerDes.Float(ref this.cutsceneDuration);
      messageSerDes.Float(ref this.remainingMatchTime);
    }

    private void SerializeOrDeserializeGameState(IMessageSerDes messageSerDes)
    {
      byte matchState = (byte) this.matchState;
      messageSerDes.Byte(ref matchState);
      this.matchState = (MatchState) matchState;
    }
  }
}
