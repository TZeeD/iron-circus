// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Debug.NetworkedDebugUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using SharedWithServer.ScEvents;

namespace SharedWithServer.Debug
{
  public class NetworkedDebugUtils
  {
    private GameContext context;
    private Events events;

    public NetworkedDebugUtils(GameContext context, Events events)
    {
      this.context = context;
      this.events = events;
    }

    ~NetworkedDebugUtils()
    {
    }

    private void BurstMode()
    {
    }

    private void AddMatchTime()
    {
      if (!this.context.isRemainingMatchTime || !this.context.remainingMatchTimeEntity.hasCountdownAction)
        return;
      this.context.remainingMatchTimeEntity.countdownAction.value.duration += 30f;
    }

    private void EndMatch()
    {
      if (!this.context.isRemainingMatchTime || !this.context.remainingMatchTimeEntity.hasCountdownAction)
        return;
      this.context.remainingMatchTimeEntity.countdownAction.value.currentT = this.context.remainingMatchTimeEntity.countdownAction.value.duration - 2f;
    }

    private void DropBall()
    {
      if (this.context.ballEntity == null)
        return;
      GameEntity ballEntity = this.context.ballEntity;
      if (ballEntity.hasBallOwner)
        ballEntity.RemoveBallOwner();
      ballEntity.transform.position = JVector.Zero;
    }
  }
}
