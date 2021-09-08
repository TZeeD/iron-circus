// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.MockInspectorClient
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System.Net;

namespace Imi.SharedWithServer.Utils
{
  public class MockInspectorClient : IInspectorClient
  {
    public void Start(bool server, ulong _playerId, IPAddress serverIp = null, bool _writeLocalFile = false)
    {
    }

    public void Stop()
    {
    }

    public void OnSessionStart(string sessionId)
    {
    }

    public bool IsStarted { get; }

    public void Flush()
    {
    }

    public void TickBegin(int tick, float time)
    {
    }

    public void TickEnd()
    {
    }

    public void OnMispredict(
      int baseline,
      int remoteTick,
      int clientTick,
      int mispredictReason,
      string debugData)
    {
    }

    public void OnJumpToFuture(int currentTick, int remoteTick)
    {
    }

    public void SetInput(ulong playerId, JVector moveDir, int buttonType)
    {
    }

    public void SetTransform(ulong playerId, JVector pos, JVector rotEuler, JVector vel)
    {
    }

    public void SetStateMachines(ulong playerId, SerializedSkillGraphs sm)
    {
    }

    public void SetStatusEffects(ulong playerId, SerializedStatusEffects se)
    {
    }

    public void SetAnimationStates(ulong playerId, AnimationStates ani)
    {
    }

    public void OnInputDuplicate(ulong playerId, int lastKnownInputTick)
    {
    }

    public void SectionBegin(string name, int tick)
    {
    }

    public void SectionEnd(string name)
    {
    }

    public void SendLog(string msg)
    {
    }

    public void ReportMemory()
    {
    }

    public void SendAsync(InspectorClient.DataType type, byte[] data, int dataSize)
    {
    }
  }
}
